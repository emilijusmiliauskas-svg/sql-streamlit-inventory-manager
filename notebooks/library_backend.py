import pandas as pd
from sqlalchemy import create_engine, text, exc
from typing import List, Dict, Any, Union

# ====================================================================
# 1. Configuration and Engine Setup
# ====================================================================
DB_CONFIG = {
    "host": "127.0.0.1",
    "user": "root",
    "password": "AtlasderAnatomie",
    "db": "private_library_db",
    "port": 3306
}

CONNECTION_STRING = f"mysql+pymysql://{DB_CONFIG['user']}:{DB_CONFIG['password']}@" \
                    f"{DB_CONFIG['host']}:{DB_CONFIG['port']}/{DB_CONFIG['db']}"

try:
    engine = create_engine(CONNECTION_STRING)
    print("Database Engine created successfully.")
except Exception as e:
    print(f"Error creating database engine: {e}")
    engine = None

# ====================================================================
# 2. General Utility Function
# ====================================================================
def fetch_as_dataframe(query: str, params: dict = None) -> pd.DataFrame:
    if engine is None: return pd.DataFrame()
    try:
        with engine.connect() as connection:
            result = connection.execute(text(query), params if params else {})
            df = pd.DataFrame(result.fetchall(), columns=result.keys())
            return df
    except exc.SQLAlchemyError as e:
        print(f"Database Error: {e}")
        return pd.DataFrame()

# ====================================================================
# 3. AUTHENTICATION (Plain-Text Password)
# ====================================================================
def authenticate_user_credentials(email: str, password: str) -> Union[Dict[str, Any], None]:
    query = "SELECT user_id, first_name, family_name, is_owner, password FROM users WHERE email=:email;"
    df = fetch_as_dataframe(query, {"email": email})
    if df.empty: return None

    user = df.iloc[0]
    if user["password"] == password:
        return {
            "user_id": user["user_id"],
            "full_name": f"{user['first_name']} {user['family_name']}",
            "is_owner": bool(user["is_owner"])
        }
    return None

# ====================================================================
# 4. USER MANAGEMENT (CRUD)
# ====================================================================
def get_all_users() -> pd.DataFrame:
    query = "SELECT user_id, first_name, family_name, email, password, phone_number, is_owner FROM users ORDER BY family_name;"
    return fetch_as_dataframe(query)

def add_new_user(first_name: str, family_name: str, email: str, phone_number: str, is_owner: bool, password: str) -> bool:
    if engine is None: return False
    try:
        with engine.connect() as conn:
            transaction = conn.begin()
            query = """
            INSERT INTO users (first_name, family_name, email, phone_number, is_owner, password)
            VALUES (:first_name, :family_name, :email, :phone_number, :is_owner, :password)
            """
            conn.execute(text(query), {
                "first_name": first_name,
                "family_name": family_name,
                "email": email,
                "phone_number": phone_number,
                "is_owner": 1 if is_owner else 0,
                "password": password
            })
            transaction.commit()
            return True
    except exc.SQLAlchemyError as e:
        print(f"Database Error (Add User): {e}")
        if 'transaction' in locals(): transaction.rollback()
        return False

def update_user_details(user_id: int, first_name: str, family_name: str, email: str, phone_number: str, is_owner: bool) -> bool:
    if engine is None: return False
    try:
        with engine.connect() as conn:
            transaction = conn.begin()
            query = """
            UPDATE users
            SET first_name=:first_name, family_name=:family_name, email=:email, phone_number=:phone_number, is_owner=:is_owner
            WHERE user_id=:user_id
            """
            conn.execute(text(query), {
                "user_id": user_id,
                "first_name": first_name,
                "family_name": family_name,
                "email": email,
                "phone_number": phone_number,
                "is_owner": 1 if is_owner else 0
            })
            transaction.commit()
            return True
    except exc.SQLAlchemyError as e:
        print(f"Database Error (Update User): {e}")
        if 'transaction' in locals(): transaction.rollback()
        return False

def delete_user(user_id: int) -> bool:
    if engine is None: return False
    try:
        with engine.connect() as conn:
            transaction = conn.begin()
            conn.execute(text("DELETE FROM users WHERE user_id=:user_id"), {"user_id": user_id})
            transaction.commit()
            return True
    except exc.SQLAlchemyError as e:
        print(f"Database Error (Delete User): {e}")
        if 'transaction' in locals(): transaction.rollback()
        return False

# ====================================================================
# 5. AUTHORS / GENRES
# ====================================================================
def get_authors_list() -> pd.DataFrame:
    query = "SELECT author_id, CONCAT(first_name, ' ', family_name) AS full_name FROM authors ORDER BY family_name;"
    return fetch_as_dataframe(query)

def get_genres_list() -> pd.DataFrame:
    query = "SELECT genre_id, name FROM genres ORDER BY name;"
    return fetch_as_dataframe(query)

def get_borrowers_list() -> pd.DataFrame:
    query = "SELECT user_id, CONCAT(first_name, ' ', family_name) AS full_name FROM users WHERE is_owner=0 ORDER BY family_name;"
    return fetch_as_dataframe(query)

# ====================================================================
# 6. DASHBOARD METRICS
# ====================================================================
def get_owner_dashboard_metrics() -> dict:
    if engine is None: return {}
    queries = {
        "total_users": "SELECT COUNT(user_id) FROM users;",
        "total_books": "SELECT COUNT(book_id) FROM books;",
        "total_loans": "SELECT COUNT(loan_id) FROM loans WHERE return_date IS NULL;",
        "total_overdue": "SELECT COUNT(loan_id) FROM loans WHERE return_date IS NULL AND due_date<CURRENT_DATE();",
        "total_fees_due": "SELECT COALESCE(SUM(total_amount_due - amount_paid),0) FROM fees WHERE is_settled=0;"
    }
    metrics = {}
    try:
        with engine.connect() as conn:
            for key, q in queries.items():
                res = conn.execute(text(q)).fetchone()
                metrics[key] = res[0] if res and res[0] is not None else 0
        return metrics
    except exc.SQLAlchemyError as e:
        print(f"Database Error (Owner Metrics): {e}")
        return {}

def get_borrower_active_status(user_id: int) -> dict:
    if engine is None: return {}
    queries = {
        "active_loans_count": "SELECT COUNT(loan_id) FROM loans WHERE borrower_id=:user_id AND return_date IS NULL;",
        "outstanding_fees_sum": """
            SELECT COALESCE(SUM(f.total_amount_due - f.amount_paid),0)
            FROM fees f
            JOIN loans l ON f.loan_id=l.loan_id
            WHERE l.borrower_id=:user_id AND f.is_settled=0;
        """,
        "next_due_date": "SELECT MIN(due_date) FROM loans WHERE borrower_id=:user_id AND return_date IS NULL;"
    }
    status = {}
    try:
        with engine.connect() as conn:
            for key, q in queries.items():
                res = conn.execute(text(q), {"user_id": user_id}).fetchone()
                status[key] = res[0] if res and res[0] is not None else (0 if "count" in key or "sum" in key else None)
        return status
    except exc.SQLAlchemyError as e:
        print(f"Database Error (Borrower Status): {e}")
        return {}

# ====================================================================
# 7. BOOK INVENTORY
# ====================================================================
def get_full_catalog() -> pd.DataFrame:
    query = """
    SELECT b.book_id, b.title, b.isbn, b.publication_year, b.language,
        GROUP_CONCAT(DISTINCT CONCAT(a.first_name,' ',a.family_name) ORDER BY ba.is_primary DESC SEPARATOR ', ') AS authors,
        GROUP_CONCAT(DISTINCT g.name ORDER BY g.name ASC SEPARATOR ', ') AS genres
    FROM books b
    LEFT JOIN book_authors ba ON b.book_id=ba.book_id
    LEFT JOIN authors a ON ba.author_id=a.author_id
    LEFT JOIN book_genres bg ON b.book_id=bg.book_id
    LEFT JOIN genres g ON bg.genre_id=g.genre_id
    GROUP BY b.book_id
    ORDER BY b.title ASC;
    """
    return fetch_as_dataframe(query)

def search_catalog(term: str) -> pd.DataFrame:
    term = f"%{term}%"
    query = """
    SELECT b.book_id, b.title, b.isbn, b.publication_year,
        GROUP_CONCAT(DISTINCT CONCAT(a.first_name,' ',a.family_name) SEPARATOR ', ') AS authors,
        GROUP_CONCAT(DISTINCT g.name SEPARATOR ', ') AS genres
    FROM books b
    LEFT JOIN book_authors ba ON b.book_id=ba.book_id
    LEFT JOIN authors a ON ba.author_id=a.author_id
    LEFT JOIN book_genres bg ON b.book_id=bg.book_id
    LEFT JOIN genres g ON bg.genre_id=g.genre_id
    WHERE b.title LIKE :term OR b.isbn LIKE :term OR CONCAT(a.first_name,' ',a.family_name) LIKE :term OR g.name LIKE :term OR b.publication_year LIKE :term
    GROUP BY b.book_id
    ORDER BY b.title ASC;
    """
    return fetch_as_dataframe(query, {"term": term})

def add_new_book(title: str, isbn: str, year: str, language: str, author_ids: List[int], genre_ids: List[int], primary_author_id: int) -> bool:
    if engine is None: return False
    try:
        with engine.connect() as conn:
            transaction = conn.begin()
            result = conn.execute(text("INSERT INTO books (title,isbn,publication_year,language) VALUES (:title,:isbn,:year,:language)"),
                                  {"title": title, "isbn": isbn, "year": year, "language": language})
            new_book_id = result.lastrowid

            if author_ids:
                values = [(new_book_id, a_id, 1 if a_id==primary_author_id else 0) for a_id in author_ids]
                conn.execute(text("INSERT INTO book_authors (book_id,author_id,is_primary) VALUES (:book_id,:author_id,:is_primary)"), values)

            if genre_ids:
                values = [(new_book_id, g_id) for g_id in genre_ids]
                conn.execute(text("INSERT INTO book_genres (book_id,genre_id) VALUES (:book_id,:genre_id)"), values)

            transaction.commit()
            return True
    except exc.SQLAlchemyError as e:
        print(f"Database Error (Add Book): {e}")
        if 'transaction' in locals(): transaction.rollback()
        return False

def delete_book(book_id: int) -> bool:
    if engine is None: return False
    try:
        with engine.connect() as conn:
            transaction = conn.begin()
            conn.execute(text("DELETE FROM book_authors WHERE book_id=:book_id"), {"book_id": book_id})
            conn.execute(text("DELETE FROM book_genres WHERE book_id=:book_id"), {"book_id": book_id})
            conn.execute(text("DELETE FROM books WHERE book_id=:book_id"), {"book_id": book_id})
            transaction.commit()
            return True
    except exc.SQLAlchemyError as e:
        print(f"Database Error (Delete Book): {e}")
        if 'transaction' in locals(): transaction.rollback()
        return False

# ====================================================================
# 8. LOAN MANAGEMENT
# ====================================================================
def get_all_active_loans() -> pd.DataFrame:
    query = """
    SELECT l.loan_id, b.title AS book_title, CONCAT(u.first_name,' ',u.family_name) AS borrower_name,
        l.loan_date, l.due_date,
        CASE WHEN l.due_date<CURRENT_DATE() THEN 'Overdue' ELSE 'On Time' END AS status
    FROM loans l
    JOIN books b ON l.book_id=b.book_id
    JOIN users u ON l.borrower_id=u.user_id
    WHERE l.return_date IS NULL
    ORDER BY l.due_date ASC;
    """
    return fetch_as_dataframe(query)

def get_my_active_loans(user_id: int) -> pd.DataFrame:
    query = """
    SELECT b.title AS book_title, l.loan_date, l.due_date,
        CASE WHEN l.due_date<CURRENT_DATE() THEN 'OVERDUE' ELSE 'Active' END AS status
    FROM loans l
    JOIN books b ON l.book_id=b.book_id
    WHERE l.borrower_id=:user_id AND l.return_date IS NULL
    ORDER BY l.due_date ASC;
    """
    return fetch_as_dataframe(query, {"user_id": user_id})

def log_new_loan(book_id: int, borrower_id: int, due_date: str) -> bool:
    if engine is None: return False
    try:
        with engine.connect() as conn:
            transaction = conn.begin()
            conn.execute(text("INSERT INTO loans (book_id,borrower_id,due_date) VALUES (:book_id,:borrower_id,:due_date)"),
                         {"book_id": book_id, "borrower_id": borrower_id, "due_date": due_date})
            transaction.commit()
            return True
    except exc.SQLAlchemyError as e:
        print(f"Database Error (New Loan): {e}")
        if 'transaction' in locals(): transaction.rollback()
        return False

def log_book_return_and_fee_check(loan_id: int, rate_per_day: float = 0.30) -> str:
    if engine is None: return "Error: DB not initialized."
    try:
        with engine.connect() as conn:
            transaction = conn.begin()
            conn.execute(text("UPDATE loans SET return_date=CURRENT_DATE() WHERE loan_id=:loan_id"), {"loan_id": loan_id})
            res = conn.execute(text("SELECT DATEDIFF(CURRENT_DATE(),due_date) FROM loans WHERE loan_id=:loan_id AND CURRENT_DATE()>due_date"),
                               {"loan_id": loan_id}).fetchone()
            if res and res[0]>0:
                days = res[0]
                amount = days*rate_per_day
                conn.execute(text("INSERT INTO fees (loan_id,rate_per_day,total_amount_due) VALUES (:loan_id,:rate,:amount)"),
                             {"loan_id": loan_id, "rate": rate_per_day, "amount": amount})
                transaction.commit()
                return f"Returned overdue by {days} days. Fee ${amount:.2f} created."
            transaction.commit()
            return "Returned successfully and on time."
    except exc.SQLAlchemyError as e:
        if 'transaction' in locals(): transaction.rollback()
        return f"Error processing return: {e}"

# ====================================================================
# 9. FEES MANAGEMENT
# ====================================================================
def get_all_outstanding_fees() -> pd.DataFrame:
    query = """
    SELECT f.fee_id, CONCAT(u.first_name,' ',u.family_name) AS borrower_name,
        b.title AS book_title, f.total_amount_due - f.amount_paid AS balance_due,
        l.due_date, l.return_date
    FROM fees f
    JOIN loans l ON f.loan_id=l.loan_id
    JOIN users u ON l.borrower_id=u.user_id
    JOIN books b ON l.book_id=b.book_id
    WHERE f.is_settled=0
    ORDER BY balance_due DESC;
    """
    return fetch_as_dataframe(query)

def mark_fee_as_settled(fee_id: int) -> bool:
    if engine is None: return False
    try:
        with engine.connect() as conn:
            transaction = conn.begin()
            conn.execute(text("UPDATE fees SET amount_paid=total_amount_due, is_settled=1 WHERE fee_id=:fee_id"), {"fee_id": fee_id})
            transaction.commit()
            return True
    except exc.SQLAlchemyError as e:
        if 'transaction' in locals(): transaction.rollback()
        print(f"Database Error (Mark Fee): {e}")
        return False

def get_my_fees(user_id: int) -> pd.DataFrame:
    query = """
    SELECT f.fee_id, b.title AS book_title, f.total_amount_due, f.amount_paid,
        f.total_amount_due - f.amount_paid AS balance,
        CASE WHEN f.is_settled=0 THEN 'OUTSTANDING' ELSE 'SETTLED' END AS status
    FROM fees f
    JOIN loans l ON f.loan_id=l.loan_id
    JOIN books b ON l.book_id=b.book_id
    WHERE l.borrower_id=:user_id
    ORDER BY status ASC, balance DESC;
    """
    return fetch_as_dataframe(query, {"user_id": user_id})

# ====================================================================
# 10. ANALYTICS
# ====================================================================
def get_top_borrowers(limit: int=10) -> pd.DataFrame:
    query = """
    SELECT CONCAT(u.first_name,' ',u.family_name) AS borrower_name, COUNT(l.loan_id) AS total_completed_loans
    FROM loans l
    JOIN users u ON l.borrower_id=u.user_id
    WHERE l.return_date IS NOT NULL
    GROUP BY u.user_id
    ORDER BY total_completed_loans DESC
    LIMIT :limit;
    """
    return fetch_as_dataframe(query, {"limit": limit})

def get_most_popular_books(limit: int=10) -> pd.DataFrame:
    query = """
    SELECT b.title AS book_title, COUNT(l.loan_id) AS total_loans
    FROM loans l
    JOIN books b ON l.book_id=b.book_id
    GROUP BY b.book_id
    ORDER BY total_loans DESC
    LIMIT :limit;
    """
    return fetch_as_dataframe(query, {"limit": limit})

def get_loan_distribution_by_genre() -> pd.DataFrame:
    query = """
    SELECT g.name AS genre_name, COUNT(l.loan_id) AS total_loans
    FROM loans l
    JOIN books b ON l.book_id=b.book_id
    JOIN book_genres bg ON b.book_id=bg.book_id
    JOIN genres g ON bg.genre_id=g.genre_id
    GROUP BY g.genre_id
    ORDER BY total_loans DESC;
    """
    return fetch_as_dataframe(query)

def get_loan_duration_analysis() -> pd.DataFrame:
    query = "SELECT AVG(DATEDIFF(return_date,loan_date)) AS average_loan_duration_days FROM loans WHERE return_date IS NOT NULL;"
    return fetch_as_dataframe(query)

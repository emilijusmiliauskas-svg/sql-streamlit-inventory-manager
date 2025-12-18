import streamlit as st
from datetime import date
from library_backend import * 
import re 

st.markdown("""
<style>

    /* Sidebar background */
    [data-testid="stSidebar"] {
        background-color: #a67f84 !important;
    }

    /* Sidebar text */
    [data-testid="stSidebar"] * {
        color: #FFFFFF !important;
    }

    /* Sidebar links and buttons */
    [data-testid="stSidebar"] a, 
    [data-testid="stSidebar"] button, 
    [data-testid="stSidebar"] span {
        color: #FFFFFF !important;
    }

    /* Remove background hover coloring */
    [data-testid="stSidebar"] a:hover {
        background-color: #222222 !important;
    }

    /* Menu items in st.navigation (Streamlit 1.32+) */
    .st-emotion-cache-1xw8zd0, /* selected menu item */
    .st-emotion-cache-10trblm, /* unselected menu item */
    .st-emotion-cache-q5s32i { /* menu item container */
        background-color: #000000 !important;
        color: #FFFFFF !important;
    }

</style>
""", unsafe_allow_html=True)



# --- Utility for Column Name Cleanup ---
def clean_column_name(name):
    """Converts snake_case or camelCase to Human Readable Title Case."""
    if name == 'user_id': return 'User ID'
    if name == 'book_id': return 'Book ID'
    if name == 'isbn': return 'ISBN'
    if name == 'is_owner': return 'Is Owner'
    if name == 'fee_id': return 'Fee ID'
    if name == name.lower():
        return ' '.join(word.capitalize() for word in name.split('_'))
    return re.sub(r'([A-Z])', r' \1', name).title()


# ------------------------------------------------------------------
# --- Custom CSS for Theming and Readability (FINAL VERSION) ---
# ------------------------------------------------------------------
def set_background_and_style():
    """Injects CSS for background, metric cards, and theme consistency."""
    BACKGROUND_IMAGE_URL = 'https://plus.unsplash.com/premium_photo-1677600125542-24af9a1cfc21?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    
    st.markdown(
        f"""
        <style>
        /* 1. Global Background */
        .stApp {{
            background-image: url({BACKGROUND_IMAGE_URL});
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }}
        
        /* 2. Content & Sidebar Readability Backgrounds */
        .main > div {{
            background-color: rgba(255, 255, 255, 0.9); 
            padding: 20px;
            border-radius: 10px;
        }}
        /* Sidebar background fix (Needs dark text due to background-color: rgba(255, 255, 255, 0.95)) */
        .st-emotion-cache-vk3wp0 {{ 
            background-color: rgba(255, 255, 255, 0.95);
            padding: 10px;
            border-radius: 10px;
        }}
        
        /* 3. --- TEXT COLOR FIXES --- */
        
        /* Forces all main content text/headers to BLACK for readability over the light BG */
        h1, h2, h3, h4, h5, p, label, .stMarkdown, .stText, .stException, .stAlert p {{
            color: black !important;
        }}
        
        /* **CRITICAL FIX A: SIDEBAR TEXT COLOR** We know the sidebar background is light gray/white (due to opacity fix), so text must be black. */
        .st-emotion-cache-1cyn8d1, .st-emotion-cache-1gsv4h7, .stRadio label, .stButton button, .stSidebar h1, .stSidebar h2, .stSidebar h3, .stSidebar p {{
            color: black !important;
        }}
        
        /* **CRITICAL FIX B: BUTTON TEXT COLOR (The black buttons)** Streamlit in dark mode makes primary buttons dark/black, so the text MUST be white. */
        .stButton button {{
            color: white !important; 
        }}
        
        /* METRIC VALUE FIX (Metric values must be black for readability on light cards) */
        [data-testid="stMetricValue"] {{
            color: black !important; 
        }}
        
        /* 4. METRIC CARD STYLING */
        [data-testid="stMetric"] {{
            background-color: #f0f2f6; 
            padding: 10px 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-left: none !important; 
            border-bottom: 2px solid #DDDDDD; 
        }}
        
        </style>
        """,
        unsafe_allow_html=True
    )
# ---------------------------------------------


# ----------------------------
# LOGIN PAGE
# ----------------------------
def login_page():

    st.markdown("""
    <style>
    h1 {
        color: #a67f84 !important;
    }
    div[data-testid="stTextInput"] {
        width: 50% !important;
    }
    </style>
    """, unsafe_allow_html=True)

    st.title("Liane's Library")

    email = st.text_input("Email")
    password = st.text_input("Password", type="password")



    if st.button("Login"):
        user = authenticate_user_credentials(email, password)
        if user:
            st.session_state.is_logged_in = True
            st.session_state.user_id = user['user_id']
            st.session_state.user_name = user['full_name']
            st.session_state.user_role = "Owner" if user['is_owner'] else "Borrower"
            st.success(f"Welcome, {st.session_state.user_name}!")
            st.rerun()
        else:
            st.error("Invalid email or password.")

# ----------------------------
# LOGOUT
# ----------------------------
def logout():
    for key in ["is_logged_in", "user_id", "user_name", "user_role"]:
        if key in st.session_state:
            del st.session_state[key]
    st.rerun()

# ----------------------------
# DISPLAY DASHBOARD
# ----------------------------
def display_dashboard():
    st.title(f"Welcome, {st.session_state.user_name}") # Hand emoticon removed

    if st.session_state.user_role == 'Owner':
        st.header("Owner Dashboard Metrics")
        metrics = get_owner_dashboard_metrics()
        
        col1, col2, col3, col4, col5 = st.columns(5)
        
        with col1:
            st.metric("Total Users", metrics.get('total_users', 0))

        with col2:
            st.metric("Total Books", metrics.get('total_books', 0))

        with col3:
            st.metric("Active Loans", metrics.get('total_loans', 0))
        
        with col4:
            st.metric("Overdue Loans", metrics.get('total_overdue', 0), delta="🚨 Action Required")

        with col5:
            st.metric("Outstanding Fees", f"${metrics.get('total_fees_due', 0):.2f}", delta="Collect!")
        
        st.subheader("Actionable Loans")
        
        df_loans = get_all_active_loans()
        df_loans.columns = [clean_column_name(col) for col in df_loans.columns]
        st.dataframe(df_loans, use_container_width=True)

    else:  # Borrower
        st.header("My Loan Status")
        status = get_borrower_active_status(st.session_state.user_id)
        
        fees_due = status.get('outstanding_fees_sum', 0)
        next_due = status.get('next_due_date')
        next_due_str = next_due.strftime("%Y-%m-%d") if isinstance(next_due, date) else "N/A"
        
        col1, col2, col3 = st.columns(3)
        col1.metric("Books Currently on Loan", status.get('active_loans_count', 0))
        col2.metric("Next Book Due", next_due_str)
        col3.metric("My Outstanding Fees", f"${fees_due:.2f}", delta="Pay Now" if fees_due > 0 else None)
        
        st.subheader("My Active Loans")
        df_active = get_my_active_loans(st.session_state.user_id)
        df_active.columns = [clean_column_name(col) for col in df_active.columns]
        st.dataframe(df_active, use_container_width=True)
        
        st.subheader("My Fee History")
        df_fees = get_my_fees(st.session_state.user_id)
        df_fees.columns = [clean_column_name(col) for col in df_fees.columns]
        st.dataframe(df_fees, use_container_width=True)


# ----------------------------
# DISPLAY CATALOG MANAGEMENT
# ----------------------------
def display_catalog_management():
    st.title("Book Catalog")
    
    authors_df = get_authors_list()
    genres_df = get_genres_list()
    
    author_map = dict(zip(authors_df['full_name'], authors_df['author_id'])) if not authors_df.empty else {}
    genre_map = dict(zip(genres_df['name'], genres_df['genre_id'])) if not genres_df.empty else {}

    search_term = st.text_input("Search Catalog (Title, ISBN, Author, or Genre)", key="catalog_search")
    df = search_catalog(search_term) if search_term else get_full_catalog()
    
    df.columns = [clean_column_name(col) for col in df.columns]
    st.dataframe(df, use_container_width=True)

    if st.session_state.user_role == 'Owner':
        st.header("Owner: Book Modification")
        tab1, tab2, tab3, tab4 = st.tabs(["➕ Add New Book", "❌ Delete Book", "📚 Manage Authors/Genres", "Placeholder: Update Book"])

        with tab1:
            st.subheader("Add New Book (Full Schema)")
            with st.form("add_book_form"):
                title = st.text_input("Title *")
                isbn = st.text_input("ISBN")
                selected_author_names = st.multiselect("Authors *", authors_df['full_name'].tolist() if not authors_df.empty else [], key="add_authors")
                primary_author_name = st.selectbox("Primary Author (for display) *", selected_author_names, key="add_primary") if selected_author_names else None
                selected_genre_names = st.multiselect("Genres *", genres_df['name'].tolist() if not genres_df.empty else [], key="add_genres")
                colA, colB = st.columns(2)
                year = colA.text_input("Publication Year (e.g., 2023)")
                language = colB.text_input("Language", "English")
                submitted = st.form_submit_button("Add Book to Catalog")
                if submitted:
                    author_ids = [author_map[name] for name in selected_author_names] if selected_author_names else []
                    genre_ids = [genre_map[name] for name in selected_genre_names] if selected_genre_names else []
                    primary_author_id = author_map.get(primary_author_name)
                    if title and author_ids and genre_ids and primary_author_id:
                        if add_new_book(title, isbn, year, language, author_ids, genre_ids, primary_author_id):
                            st.success(f"Successfully added '{title}'.")
                            st.rerun()
                        else:
                            st.error("Failed to add book. Check database connection or unique constraints.")
                    else:
                        st.error("Title, Authors, Primary Author, and Genres are required.")

        with tab2:
            st.subheader("Delete Book")
            book_id_to_delete = st.number_input("Book ID to Delete", min_value=1, format="%d", key="delete_id")
            if st.button(f"Permanently Delete Book {book_id_to_delete}"):
                if delete_book(book_id_to_delete):
                    st.success(f"Book ID {book_id_to_delete} deleted. (Links to authors/genres removed)")
                else:
                    st.error("Failed to delete book. Check for active loans!")

        with tab3:
            st.subheader("📚 Manage Authors and Genres")
            
            sub_col1, sub_col2 = st.columns(2)
            
            with sub_col1:
                st.markdown("##### ➕ Add New Author")
                with st.form("add_author_form", clear_on_submit=True):
                    auth_fname = st.text_input("First Name")
                    auth_lname = st.text_input("Family Name *")
                    auth_submitted = st.form_submit_button("Create Author")
                    if auth_submitted:
                        if auth_lname:
                            if add_new_author(auth_fname, auth_lname):
                                st.success(f"Author {auth_fname} {auth_lname} created!")
                                st.rerun()
                            else:
                                st.error("Failed to add author (check for uniqueness/DB error).")
                        else:
                            st.warning("Family Name is required.")

            with sub_col2:
                st.markdown("##### ➕ Add New Genre")
                with st.form("add_genre_form", clear_on_submit=True):
                    genre_name = st.text_input("Genre Name *")
                    genre_submitted = st.form_submit_button("Create Genre")
                    if genre_submitted:
                        if genre_name:
                            if add_new_genre(genre_name):
                                st.success(f"Genre '{genre_name}' created!")
                                st.rerun()
                            else:
                                st.error("Failed to add genre (check for uniqueness/DB error).")
                        else:
                            st.warning("Genre Name is required.")

            st.markdown("---")
            st.markdown("##### Current Lists")
            col_list_a, col_list_g = st.columns(2)
            with col_list_a:
                st.write("Authors:")
                authors_df.columns = [clean_column_name(col) for col in authors_df.columns]
                st.dataframe(authors_df, use_container_width=True)
            with col_list_g:
                st.write("Genres:")
                genres_df.columns = [clean_column_name(col) for col in genres_df.columns]
                st.dataframe(genres_df, use_container_width=True)
        
        with tab4: 
            st.subheader("Update Book (Future Implementation)")
            st.info("The logic for updating linked book details is complex and not yet implemented.")


# ----------------------------
# DISPLAY LOAN OPERATIONS
# ----------------------------
def display_loan_operations():
    st.title("Loan Operations & History")
    if st.session_state.user_role == 'Owner':
        st.header("Owner: Loan Management")
        borrowers_df = get_borrowers_list()
        borrower_map = dict(zip(borrowers_df['full_name'], borrowers_df['user_id'])) if not borrowers_df.empty else {}
        tab1, tab2 = st.tabs(["➕ Log New Loan", "↩️ Log Book Return (Fee Check)"])
        with tab1:
            st.subheader("Log New Loan")
            with st.form("new_loan_form"):
                book_id = st.number_input("Book ID to Loan", min_value=1, format="%d")
                selected_borrower_name = st.selectbox("Borrower Name", borrowers_df['full_name'].tolist() if not borrowers_df.empty else [], key="loan_borrower")
                
                default_due_date = date.today()
                due_date = st.date_input("Due Date", value=default_due_date)
                
                submitted = st.form_submit_button("Create Loan Record")
                if submitted:
                    borrower_id = borrower_map.get(selected_borrower_name)
                    if borrower_id and log_new_loan(book_id, borrower_id, str(due_date)):
                        st.success(f"Loan created for Book ID {book_id} to {selected_borrower_name}.")
                        st.rerun()
                    else:
                        st.error("Failed to create loan. Check IDs.")
        with tab2:
            st.subheader("Log Book Return (Calculates Fees)")
            loan_id_to_return = st.number_input("Loan ID to Mark as Returned", min_value=1, format="%d")
            rate = st.number_input("Fee Rate Per Day ($)", value=0.30, step=0.01) 
            if st.button(f"Process Return for Loan ID {loan_id_to_return}"):
                result = log_book_return_and_fee_check(loan_id_to_return, rate)
                if "Error" in result:
                    st.error(result)
                else:
                    st.success(result)
                    st.rerun()
        st.subheader("All Active Loans (For Review)")
        df_loans = get_all_active_loans()
        df_loans.columns = [clean_column_name(col) for col in df_loans.columns]
        st.dataframe(df_loans, use_container_width=True)
    else:
        st.info("Only library owners can manage loans. Borrowers can view their own loans on the Dashboard.")

# ----------------------------
# DISPLAY USER MANAGEMENT
# ----------------------------
def display_user_management():
    st.title("User Management (Owner Only)")
    if st.session_state.user_role != 'Owner':
        st.warning("You must be the Owner to access this section.")
        return

    st.header("Current Users")
    df_users = get_all_users()
    df_users.columns = [clean_column_name(col) for col in df_users.columns]
    st.dataframe(df_users, use_container_width=True)

    st.header("User Operations")
    tab1, tab2, tab3 = st.tabs(["➕ Add New User", "📝 Update User Details", "❌ Delete User"]) 

    with tab1:
        st.subheader("Add New User")
        with st.form("add_user_form"):
            new_first_name = st.text_input("First Name *", key="new_fname_big")
            new_family_name = st.text_input("Family Name *", key="new_lname_big")
            new_email = st.text_input("Email *", key="new_email_big")
            new_password = st.text_input("Temporary Password *", type="password", key="new_password_big") 
            new_phone = st.text_input("Phone Number", key="new_phone_big")
            new_is_owner = st.checkbox("Is Library Owner?", key="new_isowner_big")
            
            submitted = st.form_submit_button("Create User Account")
            if submitted:
                if new_first_name and new_family_name and new_email and new_password:
                    if add_new_user(new_first_name, new_family_name, new_email, new_phone, new_is_owner, new_password):
                        st.success(f"User {new_first_name} {new_family_name} added successfully.")
                        st.rerun()
                    else:
                        st.error("Failed to add user. Check if email is already in use.")
                else:
                    st.error("All starred fields (including Password) are required.")

    with tab2:
        st.subheader("Update User Details (Excluding Password)")
        user_id_to_update = st.number_input("User ID to Update", min_value=1, format="%d", key="update_uid_big")
        
        with st.form("update_user_form"):
            u_first_name = st.text_input("New First Name", key="u_fname_big")
            u_family_name = st.text_input("New Family Name", key="u_lname_big")
            u_email = st.text_input("New Email", key="u_email_big")
            u_phone = st.text_input("New Phone Number", key="u_phone_big")
            u_is_owner = st.checkbox("Is Library Owner?", key="u_isowner_big")
            
            submitted = st.form_submit_button("Update User")
            if submitted and user_id_to_update:
                if update_user_details(user_id_to_update, u_first_name, u_family_name, u_email, u_phone, u_is_owner):
                    st.success(f"User ID {user_id_to_update} updated successfully.")
                    st.rerun()
                else:
                    st.error("Failed to update user. Check constraints.")
    
    with tab3:
        st.subheader("Delete User")
        user_id_to_delete = st.number_input("User ID to Delete", min_value=1, format="%d", key="delete_uid_big")
        
        if st.button(f"Permanently Delete User {user_id_to_delete}"):
            if delete_user(user_id_to_delete):
                st.success(f"User ID {user_id_to_delete} deleted.")
                st.rerun()
            else:
                st.error("Failed to delete user. The user may have active or past loans.")

# # ----------------------------
# DISPLAY FEES MANAGEMENT (FIXED KEY ERROR)
# ----------------------------
def display_fee_management():
    """Allows Owner to view outstanding fees and mark them as settled."""
    st.title("Fees and Fines Management (Owner Only)")
    if st.session_state.user_role != 'Owner':
        st.warning("You must be the Owner to access this section.")
        return

    st.header("Outstanding Fees")
    df_outstanding = get_all_outstanding_fees()
    
    # --- FIX START ---
    # 1. Initialize fee_ids list
    fee_ids = []
    
    if df_outstanding.empty:
        st.info("No outstanding fees at this time!")
    else:
        # 2. Extract IDs using the original column name ('fee_id') BEFORE renaming columns.
        # This resolves the KeyError conflict with the clean_column_name function.
        fee_ids = df_outstanding['fee_id'].tolist()
        
        # 3. Rename columns for display AFTER ID extraction
        df_outstanding.columns = [clean_column_name(col) for col in df_outstanding.columns]
        st.dataframe(df_outstanding, use_container_width=True)
    # --- FIX END ---
        
    st.subheader("Process Payment")
    with st.form("fee_payment_form"):
        # The selectbox uses the extracted list of database IDs
        fee_id = st.selectbox("Select Fee ID to Settle", fee_ids, key='fee_to_settle') if fee_ids else None
        
        if st.form_submit_button("Mark Fee as Paid/Settled") and fee_id:
            # mark_fee_as_settled uses the original ID passed via the selectbox
            if mark_fee_as_settled(fee_id):
                st.success(f"Fee ID {fee_id} marked as settled.")
                st.rerun()
            else:
                st.error("Failed to settle fee.")

# ----------------------------
# DISPLAY ANALYTICS
# ----------------------------
def display_analytics():
    st.title("Library Analytics (Owner Only)")
    if st.session_state.user_role != 'Owner':
        st.warning("You must be the Owner to view this section.")
        return

    st.header("Top Performers and Metrics")
    col1, col2 = st.columns(2)
    with col1:
        st.subheader("Top Borrowers")
        limit = st.slider("Limit for Top Borrowers", 1, 20, 5, key='top_borrowers_limit')
        df_top_borrowers = get_top_borrowers(limit)
        df_top_borrowers.columns = [clean_column_name(col) for col in df_top_borrowers.columns]
        st.dataframe(df_top_borrowers, use_container_width=True)
    with col2:
        st.subheader("Most Popular Books")
        limit = st.slider("Limit for Popular Books", 1, 20, 5, key='popular_books_limit')
        df_popular = get_most_popular_books(limit)
        df_popular.columns = [clean_column_name(col) for col in df_popular.columns]
        st.dataframe(df_popular, use_container_width=True)

    st.header("Collection Distribution")
    df_genres = get_loan_distribution_by_genre()
    df_genres.columns = [clean_column_name(col) for col in df_genres.columns]
    st.dataframe(df_genres, use_container_width=True)
    if not df_genres.empty:
        st.bar_chart(df_genres.set_index('Genre Name'))

    st.header("Operational Insights")
    df_duration = get_loan_duration_analysis()
    df_duration.columns = [clean_column_name(col) for col in df_duration.columns]
    if not df_duration.empty:
        avg_days = df_duration['Average Loan Duration Days'].iloc[0]
        st.info(f"The average duration for a completed loan is **{avg_days:.2f} days**.")
    st.dataframe(df_duration, use_container_width=True)

# ----------------------------
# MAIN APP
# ----------------------------
def main():
    st.set_page_config(
        layout="wide", 
        page_title="Private Library System", 
        initial_sidebar_state="expanded")
    
    # Inject background CSS and metric styles on every run
    set_background_and_style()

    if "is_logged_in" not in st.session_state or not st.session_state.is_logged_in:
        login_page()
        return

    if "user_role" not in st.session_state:
        st.session_state.user_role = "Borrower"

    st.sidebar.title("Navigation")
    st.sidebar.markdown(f"**Logged in as:** **{st.session_state.user_name}** ({st.session_state.user_role})")
    if st.sidebar.button("Logout"):
        logout()

    pages = {
        "📊 Dashboard": display_dashboard,
        "📚 Book Catalog": display_catalog_management,
    }
    if st.session_state.user_role == 'Owner':
        pages["🔄 Loans & Returns"] = display_loan_operations
        pages["🧑‍💻 User Management"] = display_user_management
        pages["💵 Fees & Fines"] = display_fee_management
        pages["📈 Analytics & Reports"] = display_analytics

    selection = st.sidebar.radio("Go to", list(pages.keys()))
    pages[selection]()

if __name__ == "__main__":
    main()
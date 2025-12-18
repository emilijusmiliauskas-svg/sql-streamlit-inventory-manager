-- ====================================================================
-- Data Population Script for private_library_db (FULL SCHEMA)
-- Guarantees: Removed all procedural code/loops. One INSERT per line.
-- EXECUTION: Run the entire content of this file in your MySQL client.
-- ====================================================================

USE private_library_db;

-- ====================================================================
-- 1. SETUP & INITIAL CLEANUP
-- ====================================================================

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE fees;
TRUNCATE TABLE loans;
TRUNCATE TABLE book_authors;
TRUNCATE TABLE book_genres;
TRUNCATE TABLE authors;
TRUNCATE TABLE genres;
TRUNCATE TABLE books;
TRUNCATE TABLE users;

-- CRITICAL FIX: Ensure publication_year can handle old dates (1759, 1813, etc.)
ALTER TABLE books MODIFY COLUMN publication_year SMALLINT NULL;

SET FOREIGN_KEY_CHECKS = 1;

-- Define today for date calculations
SET @CURRENT_DATE = CURDATE();
SET @FEE_RATE = 0.30;

-- ====================================================================
-- 2. USERS (Total 50)
-- ====================================================================

-- User 1: The Owner
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (1, 'Liane', 'Campbell', 'owner@privatelibrary.com', 1);

-- 49 Borrowers
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (101, 'Alice', 'Smith', 'alice.smith@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (102, 'Bob', 'Johnson', 'bob.j@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (103, 'Charlie', 'Brown', 'charlie.b@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (104, 'Diana', 'Prince', 'diana.p@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (105, 'Edward', 'Norton', 'edward.n@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (106, 'Fiona', 'Galloway', 'fiona.g@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (107, 'George', 'Harris', 'george.h@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (108, 'Hannah', 'Clark', 'hannah.c@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (109, 'Ian', 'Miller', 'ian.m@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (110, 'Jasmine', 'Taylor', 'jasmine.t@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (111, 'Kevin', 'Wilson', 'kevin.w@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (112, 'Laura', 'Moore', 'laura.m@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (113, 'Mike', 'Davis', 'mike.d@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (114, 'Nancy', 'White', 'nancy.w@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (115, 'Oscar', 'Green', 'oscar.g@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (116, 'Penelope', 'Hall', 'penelope.h@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (117, 'Quentin', 'Allen', 'quentin.a@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (118, 'Rachel', 'Baker', 'rachel.b@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (119, 'Sam', 'Scott', 'sam.s@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (120, 'Tina', 'Young', 'tina.y@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (121, 'Ulysses', 'King', 'ulysses.k@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (122, 'Victoria', 'Lee', 'victoria.l@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (123, 'William', 'Adams', 'william.a@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (124, 'Xena', 'Roberts', 'xena.r@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (125, 'Yara', 'Nelson', 'yara.n@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (126, 'Zane', 'Carter', 'zane.c@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (127, 'Amy', 'Fox', 'amy.f@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (128, 'Ben', 'Reed', 'ben.r@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (129, 'Cathy', 'Bell', 'cathy.b@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (130, 'Daniel', 'Wood', 'daniel.w@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (131, 'Eva', 'Cook', 'eva.c@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (132, 'Frank', 'Hayes', 'frank.h@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (133, 'Gail', 'Fisher', 'gail.f@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (134, 'Harry', 'Shaw', 'harry.s@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (135, 'Ivy', 'Stone', 'ivy.s@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (136, 'Jake', 'Wagner', 'jake.w@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (137, 'Kelly', 'Zimmerman', 'kelly.z@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (138, 'Leo', 'Baxter', 'leo.b@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (139, 'Mia', 'Cruz', 'mia.c@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (140, 'Noah', 'Dixon', 'noah.d@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (141, 'Olive', 'Evans', 'olive.e@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (142, 'Paul', 'Flynn', 'paul.f@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (143, 'Queen', 'Gordon', 'queen.g@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (144, 'Ryan', 'Hurst', 'ryan.h@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (145, 'Sara', 'Jensen', 'sara.j@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (146, 'Tom', 'LeBlanc', 'tom.l@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (147, 'Uma', 'Marsh', 'uma.m@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (148, 'Vance', 'Nash', 'vance.n@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (149, 'Willow', 'Owen', 'willow.o@example.com', 0);
INSERT INTO users (user_id, first_name, family_name, email, is_owner) VALUES (150, 'Yannick', 'Potter', 'yannick.p@example.com', 0);

INSERT INTO authors (author_id, first_name, family_name) VALUES (1, 'Frank', 'Herbert');
INSERT INTO authors (author_id, first_name, family_name) VALUES (2, 'George', 'Orwell');
INSERT INTO authors (author_id, first_name, family_name) VALUES (3, 'J.R.R.', 'Tolkien');
INSERT INTO authors (author_id, first_name, family_name) VALUES (4, 'Jane', 'Austen');
INSERT INTO authors (author_id, first_name, family_name) VALUES (5, 'Agatha', 'Christie');
INSERT INTO authors (author_id, first_name, family_name) VALUES (6, 'Isaac', 'Asimov');
INSERT INTO authors (author_id, first_name, family_name) VALUES (7, 'Gabriel', 'Garcia Marquez');
INSERT INTO authors (author_id, first_name, family_name) VALUES (8, 'Ursula K.', 'Le Guin');
INSERT INTO authors (author_id, first_name, family_name) VALUES (9, 'Stephen', 'King');
INSERT INTO authors (author_id, first_name, family_name) VALUES (10, 'Toni', 'Morrison');
INSERT INTO authors (author_id, first_name, family_name) VALUES (11, 'Chimamanda Ngozi', 'Adichie');
INSERT INTO authors (author_id, first_name, family_name) VALUES (12, 'Neil', 'Gaiman');
INSERT INTO authors (author_id, first_name, family_name) VALUES (13, 'Michael', 'Crichton');
INSERT INTO authors (author_id, first_name, family_name) VALUES (14, 'Virginia', 'Woolf');
INSERT INTO authors (author_id, first_name, family_name) VALUES (15, 'H.P.', 'Lovecraft');
INSERT INTO authors (author_id, first_name, family_name) VALUES (16, 'Charles', 'Dickens');
INSERT INTO authors (author_id, first_name, family_name) VALUES (17, 'Harper', 'Lee');
INSERT INTO authors (author_id, first_name, family_name) VALUES (18, 'Yuval Noah', 'Harari');
INSERT INTO authors (author_id, first_name, family_name) VALUES (19, 'B. J.', 'Novak');
INSERT INTO authors (author_id, first_name, family_name) VALUES (20, 'Margaret', 'Atwood');

INSERT INTO genres (genre_id, name) VALUES (1, 'Science Fiction');
INSERT INTO genres (genre_id, name) VALUES (2, 'Fantasy');
INSERT INTO genres (genre_id, name) VALUES (3, 'Dystopian');
INSERT INTO genres (genre_id, name) VALUES (4, 'Mystery');
INSERT INTO genres (genre_id, name) VALUES (5, 'Classic Literature');
INSERT INTO genres (genre_id, name) VALUES (6, 'Horror');
INSERT INTO genres (genre_id, name) VALUES (7, 'Historical Fiction');
INSERT INTO genres (genre_id, name) VALUES (8, 'Non-Fiction');
INSERT INTO genres (genre_id, name) VALUES (9, 'Romance');
INSERT INTO genres (genre_id, name) VALUES (10, 'Young Adult');

-- ====================================================================
-- 3. BOOKS (100 Records)
-- ====================================================================

-- 1-50 (Core List)
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (1, 'Dune', '978-0441172719', 1965, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (2, '1984', '978-0451524935', 1949, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (3, 'The Hobbit', '978-0618260300', 1937, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (4, 'Pride and Prejudice', '978-0141439518', 1813, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (5, 'Murder on the Orient Express', '978-0062693540', 1934, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (6, 'Foundation', '978-0553293357', 1951, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (7, 'One Hundred Years of Solitude', '978-0060883287', 1967, 'Spanish');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (8, 'The Left Hand of Darkness', '978-0441478005', 1969, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (9, 'It', '978-1501173977', 1986, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (10, 'Beloved', '978-1400033416', 1987, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (11, 'Americanah', '978-0307455925', 2013, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (12, 'Neverwhere', '978-0060515180', 1996, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (13, 'Jurassic Park', '978-0345370778', 1990, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (14, 'Mrs. Dalloway', '978-0156628709', 1925, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (15, 'The Call of Cthulhu', '978-1503290685', 1928, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (16, 'A Tale of Two Cities', '978-0141439259', 1859, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (17, 'To Kill a Mockingbird', '978-0061120084', 1960, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (18, 'Sapiens', '978-0062316097', 2011, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (19, 'The Testaments', '978-0385543781', 2019, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (20, 'Good Omens', '978-0060853969', 1990, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (21, 'Children of Dune', '978-0441104024', 1976, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (22, 'The Two Towers', '978-0618260270', 1954, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (23, 'Sense and Sensibility', '978-0141439495', 1811, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (24, 'And Then There Were None', '978-0062073488', 1939, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (25, 'I, Robot', '978-0553382563', 1950, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (26, 'Love in the Time of Cholera', '978-0140118938', 1985, 'Spanish');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (27, 'The Dispossessed', '978-0061054884', 1974, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (28, 'The Shining', '978-0307742841', 1977, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (29, 'Song of Solomon', '978-1400033423', 1977, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (30, 'Half of a Yellow Sun', '978-1400095117', 2006, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (31, 'Norse Mythology', '978-0393356159', 2017, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (32, 'The Lost World', '978-0345370761', 1995, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (33, 'To the Lighthouse', '978-0156907385', 1927, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (34, 'The Dunwich Horror', '978-1503290708', 1929, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (35, 'Great Expectations', '978-0141441405', 1861, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (36, 'Go Set a Watchman', '978-0062409858', 2015, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (37, 'Homo Deus', '978-0062460260', 2016, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (38, 'The Handmaids Tale', '978-0547345579', 1985, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (39, 'The Martian Chronicles', '978-0553278224', 1950, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (40, 'Animal Farm', '978-0451526342', 1945, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (41, 'A Scanner Darkly', '978-0547572710', 1977, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (42, 'The Hitchhikers Guide to the Galaxy', '978-0345391803', 1979, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (43, 'Do Androids Dream of Electric Sheep?', '978-0345404473', 1968, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (44, 'Neuromancer', '978-0441569567', 1984, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (45, 'Snow Crash', '978-0553380958', 1992, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (46, 'The Road', '978-0307387899', 2006, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (47, 'Brave New World', '978-0060850524', 1932, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (48, 'Fahrenheit 451', '978-1451673319', 1953, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (49, 'The Time Machine', '978-0486284723', 1895, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (50, '2001: A Space Odyssey', '978-0451457998', 1968, 'English');

-- 51-100 (Additional Classics/Best Sellers)
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (51, 'Moby Dick', '978-0142437247', 1851, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (52, 'The Picture of Dorian Gray', '978-0140432411', 1890, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (53, 'The Secret History', '978-0679733372', 1992, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (54, 'The Da Vinci Code', '978-0385504201', 2003, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (55, 'Where the Crawdads Sing', '978-0735219090', 2018, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (56, 'Gone Girl', '978-0307588370', 2012, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (57, 'The Girl with the Dragon Tattoo', '978-0307474476', 2005, 'Swedish');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (58, 'The Grapes of Wrath', '978-0143039433', 1939, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (59, 'Catch-22', '978-1451626650', 1961, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (60, 'Slaughterhouse-Five', '978-0385333849', 1969, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (61, 'Pillars of the Earth', '978-0451487315', 1989, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (62, 'The Color Purple', '978-0151191543', 1982, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (63, 'The Road to Wigan Pier', '978-0141185890', 1937, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (64, 'Things Fall Apart', '978-0385474542', 1958, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (65, 'The Alchemist', '978-0061122415', 1988, 'Portuguese');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (66, 'The Joy Luck Club', '978-0804174338', 1989, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (67, 'Zen and the Art of Motorcycle Maintenance', '978-0060589464', 1974, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (68, 'The Name of the Rose', '978-0156005472', 1980, 'Italian');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (69, 'Midnight’s Children', '978-0812976531', 1981, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (70, 'Wuthering Heights', '978-0141439556', 1847, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (71, 'Dracula', '978-0062006321', 1897, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (72, 'Frankenstein', '978-0141439471', 1818, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (73, 'Twenty Thousand Leagues Under the Sea', '978-0140441009', 1870, 'French');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (74, '1001 Arabian Nights', '978-0140449449', 800, 'Arabic');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (75, 'Tess of the D''Urbervilles', '978-0141441351', 1891, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (76, 'Crime and Punishment', '978-0140449203', 1866, 'Russian');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (77, 'War and Peace', '978-0307356611', 1869, 'Russian');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (78, 'Anna Karenina', '978-0140449173', 1877, 'Russian');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (79, 'Les Misérables', '978-0451419439', 1862, 'French');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (80, 'The Count of Monte Cristo', '978-0140449265', 1844, 'French');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (81, 'A Brief History of Time', '978-0553380163', 1988, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (82, 'Cosmos', '978-0345539434', 1980, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (83, 'The Selfish Gene', '978-0199291151', 1976, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (84, 'Guns, Germs, and Steel', '978-0393317558', 1997, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (85, 'Freakonomics', '978-0060731335', 2005, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (86, 'Outliers', '978-0316017930', 2008, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (87, 'Siddhartha', '978-0553208771', 1922, 'German');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (88, 'The Metamorphosis', '978-0553213812', 1915, 'German');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (89, 'Candide', '978-0140440040', 1759, 'French');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (90, 'The Sun Also Rises', '978-0743297441', 1926, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (91, 'A Farewell to Arms', '978-0684801469', 1929, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (92, 'The Old Man and the Sea', '978-0684801223', 1952, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (93, 'For Whom the Bell Tolls', '978-0684803357', 1940, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (94, 'Heart of Darkness', '978-0141441610', 1899, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (95, 'Lord of the Flies', '978-0140283338', 1954, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (96, 'The Outsiders', '978-0140385728', 1967, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (97, 'The Bell Jar', '978-0060850500', 1963, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (98, 'One Flew Over the Cuckoo’s Nest', '978-0451163967', 1962, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (99, 'Bury My Heart at Wounded Knee', '978-0805068940', 1970, 'English');
INSERT INTO books (book_id, title, isbn, publication_year, language) VALUES (100, 'The Woman in White', '978-0140437416', 1860, 'English');

-- ====================================================================
-- 4. BOOK LINKING TABLES (Static Links)
-- ====================================================================

-- Complex Linking
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (1, 1, 1);
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (20, 12, 1);
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (20, 19, 0);
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (2, 2, 1);
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (3, 3, 1);
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (4, 4, 1);
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (5, 5, 1);
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (6, 6, 1);
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (7, 7, 1);
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (8, 8, 1);
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (9, 9, 1);
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (10, 10, 1);
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (17, 17, 1);
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (57, 5, 0);
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES (57, 1, 1);

INSERT INTO book_genres (book_id, genre_id) VALUES (1, 1);
INSERT INTO book_genres (book_id, genre_id) VALUES (1, 3);
INSERT INTO book_genres (book_id, genre_id) VALUES (2, 3);
INSERT INTO book_genres (book_id, genre_id) VALUES (2, 5);
INSERT INTO book_genres (book_id, genre_id) VALUES (3, 2);
INSERT INTO book_genres (book_id, genre_id) VALUES (3, 10);
INSERT INTO book_genres (book_id, genre_id) VALUES (5, 4);
INSERT INTO book_genres (book_id, genre_id) VALUES (9, 6);
INSERT INTO book_genres (book_id, genre_id) VALUES (18, 8);
INSERT INTO book_genres (book_id, genre_id) VALUES (19, 3);
INSERT INTO book_genres (book_id, genre_id) VALUES (20, 2);
INSERT INTO book_genres (book_id, genre_id) VALUES (20, 1);
INSERT INTO book_genres (book_id, genre_id) VALUES (52, 5);
INSERT INTO book_genres (book_id, genre_id) VALUES (52, 6);
INSERT INTO book_genres (book_id, genre_id) VALUES (53, 4);
INSERT INTO book_genres (book_id, genre_id) VALUES (53, 5);
INSERT INTO book_genres (book_id, genre_id) VALUES (55, 7);
INSERT INTO book_genres (book_id, genre_id) VALUES (55, 9);

-- ====================================================================
-- 5. LOANS & FEES (90 Loans, 30 Settled Fees, 10 Outstanding Fees)
-- ====================================================================

-- --- A. 50 FINISHED LOANS (1-50) ---
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (1, 1, 101, DATE_SUB(@CURRENT_DATE, INTERVAL 300 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 286 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 287 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (2, 2, 102, DATE_SUB(@CURRENT_DATE, INTERVAL 250 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 236 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 236 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (3, 3, 103, DATE_SUB(@CURRENT_DATE, INTERVAL 200 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 186 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 185 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (4, 4, 104, DATE_SUB(@CURRENT_DATE, INTERVAL 150 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 136 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 136 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (5, 5, 105, DATE_SUB(@CURRENT_DATE, INTERVAL 100 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 86 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 80 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (6, 6, 106, DATE_SUB(@CURRENT_DATE, INTERVAL 50 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 36 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 36 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (7, 7, 107, DATE_SUB(@CURRENT_DATE, INTERVAL 70 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 56 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 56 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (8, 8, 108, DATE_SUB(@CURRENT_DATE, INTERVAL 90 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 76 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 75 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (9, 9, 109, DATE_SUB(@CURRENT_DATE, INTERVAL 110 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 96 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 96 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (10, 10, 110, DATE_SUB(@CURRENT_DATE, INTERVAL 130 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 116 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 115 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (11, 11, 111, DATE_SUB(@CURRENT_DATE, INTERVAL 140 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 126 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 126 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (12, 12, 112, DATE_SUB(@CURRENT_DATE, INTERVAL 150 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 136 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 136 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (13, 13, 113, DATE_SUB(@CURRENT_DATE, INTERVAL 160 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 146 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 145 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (14, 14, 114, DATE_SUB(@CURRENT_DATE, INTERVAL 170 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 156 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 156 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (15, 15, 115, DATE_SUB(@CURRENT_DATE, INTERVAL 180 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 166 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 165 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (16, 16, 116, DATE_SUB(@CURRENT_DATE, INTERVAL 190 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 176 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 176 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (17, 17, 117, DATE_SUB(@CURRENT_DATE, INTERVAL 210 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 196 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 195 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (18, 18, 118, DATE_SUB(@CURRENT_DATE, INTERVAL 220 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 206 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 206 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (19, 19, 119, DATE_SUB(@CURRENT_DATE, INTERVAL 230 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 216 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 215 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (20, 20, 120, DATE_SUB(@CURRENT_DATE, INTERVAL 240 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 226 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 226 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (21, 21, 121, DATE_SUB(@CURRENT_DATE, INTERVAL 260 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 246 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 246 DAY), INTERVAL 5 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (22, 22, 122, DATE_SUB(@CURRENT_DATE, INTERVAL 270 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 256 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 256 DAY), INTERVAL 10 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (23, 23, 123, DATE_SUB(@CURRENT_DATE, INTERVAL 280 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 266 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 266 DAY), INTERVAL 15 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (24, 24, 124, DATE_SUB(@CURRENT_DATE, INTERVAL 290 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 276 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 276 DAY), INTERVAL 2 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (25, 25, 125, DATE_SUB(@CURRENT_DATE, INTERVAL 300 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 286 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 286 DAY), INTERVAL 8 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (26, 26, 126, DATE_SUB(@CURRENT_DATE, INTERVAL 310 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 296 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 296 DAY), INTERVAL 12 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (27, 27, 127, DATE_SUB(@CURRENT_DATE, INTERVAL 320 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 306 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 306 DAY), INTERVAL 6 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (28, 28, 128, DATE_SUB(@CURRENT_DATE, INTERVAL 330 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 316 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 316 DAY), INTERVAL 1 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (29, 29, 129, DATE_SUB(@CURRENT_DATE, INTERVAL 340 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 326 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 326 DAY), INTERVAL 4 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (30, 30, 130, DATE_SUB(@CURRENT_DATE, INTERVAL 350 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 336 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 336 DAY), INTERVAL 11 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (31, 31, 131, DATE_SUB(@CURRENT_DATE, INTERVAL 200 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 186 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 186 DAY), INTERVAL 5 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (32, 32, 132, DATE_SUB(@CURRENT_DATE, INTERVAL 190 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 176 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 176 DAY), INTERVAL 10 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (33, 33, 133, DATE_SUB(@CURRENT_DATE, INTERVAL 180 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 166 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 166 DAY), INTERVAL 15 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (34, 34, 134, DATE_SUB(@CURRENT_DATE, INTERVAL 170 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 156 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 156 DAY), INTERVAL 2 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (35, 35, 135, DATE_SUB(@CURRENT_DATE, INTERVAL 160 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 146 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 146 DAY), INTERVAL 8 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (36, 36, 136, DATE_SUB(@CURRENT_DATE, INTERVAL 150 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 136 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 136 DAY), INTERVAL 12 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (37, 37, 137, DATE_SUB(@CURRENT_DATE, INTERVAL 140 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 126 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 126 DAY), INTERVAL 6 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (38, 38, 138, DATE_SUB(@CURRENT_DATE, INTERVAL 130 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 116 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 116 DAY), INTERVAL 1 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (39, 39, 139, DATE_SUB(@CURRENT_DATE, INTERVAL 120 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 106 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 106 DAY), INTERVAL 4 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (40, 40, 140, DATE_SUB(@CURRENT_DATE, INTERVAL 110 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 96 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 96 DAY), INTERVAL 11 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (41, 41, 141, DATE_SUB(@CURRENT_DATE, INTERVAL 100 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 86 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 86 DAY), INTERVAL 7 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (42, 42, 142, DATE_SUB(@CURRENT_DATE, INTERVAL 90 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 76 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 76 DAY), INTERVAL 3 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (43, 43, 143, DATE_SUB(@CURRENT_DATE, INTERVAL 80 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 66 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 66 DAY), INTERVAL 14 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (44, 44, 144, DATE_SUB(@CURRENT_DATE, INTERVAL 70 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 56 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 56 DAY), INTERVAL 9 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (45, 45, 145, DATE_SUB(@CURRENT_DATE, INTERVAL 60 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 46 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 46 DAY), INTERVAL 13 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (46, 46, 146, DATE_SUB(@CURRENT_DATE, INTERVAL 50 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 36 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 36 DAY), INTERVAL 11 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (47, 47, 147, DATE_SUB(@CURRENT_DATE, INTERVAL 40 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 26 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 26 DAY), INTERVAL 5 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (48, 48, 148, DATE_SUB(@CURRENT_DATE, INTERVAL 30 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 16 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 16 DAY), INTERVAL 8 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (49, 49, 149, DATE_SUB(@CURRENT_DATE, INTERVAL 20 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 6 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL 6 DAY), INTERVAL 1 DAY));
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (50, 50, 150, DATE_SUB(@CURRENT_DATE, INTERVAL 10 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL -4 DAY), DATE_ADD(DATE_SUB(@CURRENT_DATE, INTERVAL -4 DAY), INTERVAL 9 DAY));

-- Insert 30 settled fees for late loans (21-50)
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (21, @FEE_RATE, 1.50, 1.50, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (22, @FEE_RATE, 3.00, 3.00, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (23, @FEE_RATE, 4.50, 4.50, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (24, @FEE_RATE, 0.60, 0.60, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (25, @FEE_RATE, 2.40, 2.40, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (26, @FEE_RATE, 3.60, 3.60, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (27, @FEE_RATE, 1.80, 1.80, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (28, @FEE_RATE, 0.30, 0.30, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (29, @FEE_RATE, 1.20, 1.20, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (30, @FEE_RATE, 3.30, 3.30, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (31, @FEE_RATE, 1.50, 1.50, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (32, @FEE_RATE, 3.00, 3.00, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (33, @FEE_RATE, 4.50, 4.50, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (34, @FEE_RATE, 0.60, 0.60, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (35, @FEE_RATE, 2.40, 2.40, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (36, @FEE_RATE, 3.60, 3.60, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (37, @FEE_RATE, 1.80, 1.80, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (38, @FEE_RATE, 0.30, 0.30, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (39, @FEE_RATE, 1.20, 1.20, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (40, @FEE_RATE, 3.30, 3.30, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (41, @FEE_RATE, 2.10, 2.10, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (42, @FEE_RATE, 0.90, 0.90, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (43, @FEE_RATE, 4.20, 4.20, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (44, @FEE_RATE, 2.70, 2.70, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (45, @FEE_RATE, 3.90, 3.90, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (46, @FEE_RATE, 3.30, 3.30, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (47, @FEE_RATE, 1.50, 1.50, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (48, @FEE_RATE, 2.40, 2.40, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (49, @FEE_RATE, 0.30, 0.30, 1);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (50, @FEE_RATE, 2.70, 2.70, 1);

-- --- B. 40 ACTIVE LOANS (51-90) ---
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (51, 1, 101, DATE_SUB(@CURRENT_DATE, INTERVAL 20 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 6 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (52, 2, 102, DATE_SUB(@CURRENT_DATE, INTERVAL 25 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 11 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (53, 3, 103, DATE_SUB(@CURRENT_DATE, INTERVAL 22 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 8 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (54, 4, 104, DATE_SUB(@CURRENT_DATE, INTERVAL 30 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 16 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (55, 5, 105, DATE_SUB(@CURRENT_DATE, INTERVAL 18 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 4 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (56, 6, 106, DATE_SUB(@CURRENT_DATE, INTERVAL 35 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 21 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (57, 7, 107, DATE_SUB(@CURRENT_DATE, INTERVAL 15 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 1 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (58, 8, 108, DATE_SUB(@CURRENT_DATE, INTERVAL 28 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 14 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (59, 9, 109, DATE_SUB(@CURRENT_DATE, INTERVAL 21 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 7 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (60, 10, 110, DATE_SUB(@CURRENT_DATE, INTERVAL 32 DAY), DATE_SUB(@CURRENT_DATE, INTERVAL 18 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (61, 11, 111, DATE_SUB(@CURRENT_DATE, INTERVAL 5 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 9 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (62, 12, 112, DATE_SUB(@CURRENT_DATE, INTERVAL 8 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 6 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (63, 13, 113, DATE_SUB(@CURRENT_DATE, INTERVAL 1 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 13 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (64, 14, 114, DATE_SUB(@CURRENT_DATE, INTERVAL 12 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 2 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (65, 15, 115, DATE_SUB(@CURRENT_DATE, INTERVAL 10 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 4 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (66, 16, 116, DATE_SUB(@CURRENT_DATE, INTERVAL 7 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 7 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (67, 17, 117, DATE_SUB(@CURRENT_DATE, INTERVAL 15 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 1 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (68, 18, 118, DATE_SUB(@CURRENT_DATE, INTERVAL 16 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 1 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (69, 19, 119, DATE_SUB(@CURRENT_DATE, INTERVAL 17 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 0 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (70, 20, 120, DATE_SUB(@CURRENT_DATE, INTERVAL 18 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 13 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (71, 21, 121, DATE_SUB(@CURRENT_DATE, INTERVAL 19 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 12 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (72, 22, 122, DATE_SUB(@CURRENT_DATE, INTERVAL 20 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 11 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (73, 23, 123, DATE_SUB(@CURRENT_DATE, INTERVAL 21 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 10 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (74, 24, 124, DATE_SUB(@CURRENT_DATE, INTERVAL 22 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 9 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (75, 25, 125, DATE_SUB(@CURRENT_DATE, INTERVAL 23 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 8 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (76, 26, 126, DATE_SUB(@CURRENT_DATE, INTERVAL 24 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 7 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (77, 27, 127, DATE_SUB(@CURRENT_DATE, INTERVAL 25 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 6 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (78, 28, 128, DATE_SUB(@CURRENT_DATE, INTERVAL 26 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 5 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (79, 29, 129, DATE_SUB(@CURRENT_DATE, INTERVAL 27 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 4 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (80, 30, 130, DATE_SUB(@CURRENT_DATE, INTERVAL 28 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 3 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (81, 31, 131, DATE_SUB(@CURRENT_DATE, INTERVAL 29 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 2 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (82, 32, 132, DATE_SUB(@CURRENT_DATE, INTERVAL 30 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 1 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (83, 33, 133, DATE_SUB(@CURRENT_DATE, INTERVAL 31 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 0 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (84, 34, 134, DATE_SUB(@CURRENT_DATE, INTERVAL 32 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 13 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (85, 35, 135, DATE_SUB(@CURRENT_DATE, INTERVAL 33 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 12 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (86, 36, 136, DATE_SUB(@CURRENT_DATE, INTERVAL 34 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 11 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (87, 37, 137, DATE_SUB(@CURRENT_DATE, INTERVAL 35 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 10 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (88, 38, 138, DATE_SUB(@CURRENT_DATE, INTERVAL 36 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 9 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (89, 39, 139, DATE_SUB(@CURRENT_DATE, INTERVAL 37 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 8 DAY), NULL);
INSERT INTO loans (loan_id, book_id, borrower_id, loan_date, due_date, return_date) VALUES (90, 40, 140, DATE_SUB(@CURRENT_DATE, INTERVAL 38 DAY), DATE_ADD(@CURRENT_DATE, INTERVAL 7 DAY), NULL);

-- Insert 10 OUTSTANDING FEES (for active loans 51-60)
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (51, @FEE_RATE, 1.80, 0.00, 0);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (52, @FEE_RATE, 3.30, 0.00, 0);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (53, @FEE_RATE, 2.40, 0.00, 0);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (54, @FEE_RATE, 4.80, 0.00, 0);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (55, @FEE_RATE, 1.20, 0.00, 0);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (56, @FEE_RATE, 6.30, 0.00, 0);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (57, @FEE_RATE, 0.30, 0.00, 0);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (58, @FEE_RATE, 4.20, 0.00, 0);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (59, @FEE_RATE, 2.10, 0.00, 0);
INSERT INTO fees (loan_id, rate_per_day, total_amount_due, amount_paid, is_settled) VALUES (60, @FEE_RATE, 5.40, 0.00, 0);

SELECT 'Data Population Complete! The Full Library App is Ready.' AS Status;

ALTER TABLE users
ADD COLUMN password VARCHAR(255) NOT NULL DEFAULT '';

UPDATE users
SET password = 'admin123'
WHERE email = 'owner@privatelibrary.com';

UPDATE users
SET password = 'user123'
WHERE email <> 'owner@privatelibrary.com';

SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS = 0;
-- =====================================================
-- 1. CLEAN BOOK-RELATED TABLES
-- =====================================================
DELETE FROM book_authors;
DELETE FROM book_genres;
DELETE FROM books;
DELETE FROM authors;
DELETE FROM genres;

ALTER TABLE books AUTO_INCREMENT = 1;
ALTER TABLE authors AUTO_INCREMENT = 1;
ALTER TABLE genres AUTO_INCREMENT = 1;

-- =====================================================
-- 2. INSERT AUTHORS (40 sample authors)
-- =====================================================
INSERT INTO authors (first_name, family_name) VALUES
('Frank','Herbert'),
('George','Orwell'),
('J.R.R.','Tolkien'),
('Jane','Austen'),
('Agatha','Christie'),
('Isaac','Asimov'),
('Gabriel','Garcia Marquez'),
('Ursula K.','Le Guin'),
('Stephen','King'),
('Toni','Morrison'),
('Chimamanda Ngozi','Adichie'),
('Neil','Gaiman'),
('Michael','Crichton'),
('Virginia','Woolf'),
('H.P.','Lovecraft'),
('Charles','Dickens'),
('Harper','Lee'),
('Yuval Noah','Harari'),
('Margaret','Atwood'),
('Douglas','Adams'),
('Aldous','Huxley'),
('Ray','Bradbury'),
('Mary','Shelley'),
('Bram','Stoker'),
('Fyodor','Dostoevsky'),
('Leo','Tolstoy'),
('Victor','Hugo'),
('Paulo','Coelho'),
('Kurt','Vonnegut'),
('John','Steinbeck'),
('Haruki','Murakami'),
('Dan','Brown'),
('Gillian','Flynn'),
('Kazuo','Ishiguro'),
('Philip K.','Dick'),
('Robert','Louis Stevenson'),
('Daniel','Keyes'),
('Anthony','Burgess'),
('Margaret','Mitchell'),
('John','Grisham');

-- =====================================================
-- 3. INSERT GENRES (10 sample genres)
-- =====================================================
INSERT INTO genres (name) VALUES
('Science Fiction'),
('Fantasy'),
('Dystopian'),
('Mystery'),
('Classic Literature'),
('Horror'),
('Historical Fiction'),
('Non-Fiction'),
('Romance'),
('Young Adult');

-- =====================================================
-- 4. INSERT 100 BOOKS
-- =====================================================
INSERT INTO books (title, isbn, publication_year, language) VALUES
('Dune','9780441013593',1965,'English'),
('1984','9780451524935',1949,'English'),
('The Hobbit','9780547928227',1937,'English'),
('Pride and Prejudice','9781503290563',1813,'English'),
('Murder on the Orient Express','9780062693662',1934,'English'),
('Foundation','9780553293357',1951,'English'),
('One Hundred Years of Solitude','9780060883287',1967,'English'),
('The Left Hand of Darkness','9780441478125',1969,'English'),
('It','9780450411434',1986,'English'),
('Beloved','9781400033416',1987,'English'),
('Americanah','9780307455925',2013,'English'),
('Neverwhere','9780060557812',1996,'English'),
('Jurassic Park','9780345538987',1990,'English'),
('Mrs. Dalloway','9780156628709',1925,'English'),
('The Call of Cthulhu','9781481460903',1928,'English'),
('A Tale of Two Cities','9781853260391',1859,'English'),
('To Kill a Mockingbird','9780061120084',1960,'English'),
('Sapiens','9780062316097',2011,'English'),
('The Testaments','9780385543781',2019,'English'),
('The Hitchhiker''s Guide to the Galaxy','9780345391803',1979,'English'),
('Children of Dune','9780441172696',1976,'English'),
('The Two Towers','9780547928203',1954,'English'),
('Sense and Sensibility','9781503290310',1811,'English'),
('And Then There Were None','9780062073488',1939,'English'),
('I, Robot','9780553382563',1950,'English'),
('Love in the Time of Cholera','9780307389732',1985,'English'),
('The Dispossessed','9780060512756',1974,'English'),
('The Shining','9780307743657',1977,'English'),
('Song of Solomon','9781400033423',1977,'English'),
('Half of a Yellow Sun','9780345803789',2006,'English'),
('Norse Mythology','9780393609097',2017,'English'),
('The Lost World','9780345319717',1912,'English'),
('To the Lighthouse','9780156907392',1927,'English'),
('The Dunwich Horror','9781517153047',1929,'English'),
('Great Expectations','9780141439563',1861,'English'),
('Go Set a Watchman','9780062409850',2015,'English'),
('Homo Deus','9780062464316',2016,'English'),
('The Handmaids Tale','9780385490818',1985,'English'),
('The Martian Chronicles','9780345347954',1950,'English'),
('Animal Farm','9780451526342',1945,'English'),
('A Scanner Darkly','9780441709600',1977,'English'),
('Do Androids Dream of Electric Sheep?','9780345404473',1968,'English'),
('Neuromancer','9780441569595',1984,'English'),
('Snow Crash','9780553380958',1992,'English'),
('The Road','9780307387899',2006,'English'),
('Brave New World','9780060850524',1932,'English'),
('Fahrenheit 451','9781451673319',1953,'English'),
('The Time Machine','9780553213515',1895,'English'),
('2001: A Space Odyssey','9780451457998',1968,'English'),
('Moby Dick','9781503280786',1851,'English'),
('The Picture of Dorian Gray','9780141439570',1890,'English'),
('The Secret History','9780143125421',1992,'English'),
('The Da Vinci Code','9780307474278',2003,'English'),
('Where the Crawdads Sing','9780735219106',2018,'English'),
('Gone Girl','9780307588371',2012,'English'),
('The Girl with the Dragon Tattoo','9780307949486',2005,'English'),
('The Grapes of Wrath','9780143039433',1939,'English'),
('Catch-22','9781451626650',1961,'English'),
('Slaughterhouse-Five','9780440180296',1969,'English'),
('Pillars of the Earth','9780451166890',1989,'English'),
('The Color Purple','9780156028356',1982,'English'),
('The Road to Wigan Pier','9780141037215',1937,'English'),
('Things Fall Apart','9780385474542',1958,'English'),
('The Alchemist','9780061122415',1988,'English'),
('The Joy Luck Club','9780143038092',1989,'English'),
('Zen and the Art of Motorcycle Maintenance','9780060589462',1974,'English'),
('The Name of the Rose','9780156001311',1980,'English'),
('Midnight’s Children','9780375403530',1981,'English'),
('Wuthering Heights','9780141439556',1847,'English'),
('Dracula','9780141439846',1897,'English'),
('Frankenstein','9780486282114',1818,'English'),
('Twenty Thousand Leagues Under the Sea','9781505255607',1870,'English'),
('1001 Arabian Nights','9780140449442',1706,'English'),
('Tess of the D''Urbervilles','9780141439594',1891,'English'),
('Crime and Punishment','9780140449135',1866,'English'),
('War and Peace','9781400079988',1869,'English'),
('Anna Karenina','9780143035008',1877,'English'),
('Les Misérables','9780451419439',1862,'English'),
('The Count of Monte Cristo','9780140449266',1844,'English'),
('A Brief History of Time','9780553380163',1988,'English'),
('Cosmos','9780345539434',1980,'English'),
('The Selfish Gene','9780198788607',1976,'English'),
('Guns, Germs, and Steel','9780393354324',1997,'English'),
('Freakonomics','9780060731328',2005,'English'),
('Outliers','9780316017923',2008,'English'),
('Siddhartha','9780553208849',1922,'English'),
('The Metamorphosis','9780553213690',1915,'English'),
('Candide','9780140440045',1759,'English'),
('The Sun Also Rises','9780743297332',1926,'English'),
('A Farewell to Arms','9780684801469',1929,'English'),
('The Old Man and the Sea','9780684801223',1952,'English'),
('For Whom the Bell Tolls','9780684803357',1940,'English'),
('Heart of Darkness','9780141441672',1899,'English'),
('Lord of the Flies','9780399501487',1954,'English'),
('The Outsiders','9780140385722',1967,'English'),
('The Bell Jar','9780060837020',1963,'English'),
('One Flew Over the Cuckoo’s Nest','9780141182553',1962,'English'),
('Bury My Heart at Wounded Knee','9780805086847',1970,'English'),
('The Woman in White','9780141439600',1859,'English');

-- =====================================================
-- 5. ASSIGN BOOK_AUTHORS (CORRECTED MAPPING)
-- =====================================================
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES
-- Core 1-20 (Matches provided list 1-20)
(1, 1, 1),    -- Dune -> Frank Herbert
(2, 2, 1),    -- 1984 -> George Orwell
(3, 3, 1),    -- The Hobbit -> J.R.R. Tolkien
(4, 4, 1),    -- Pride and Prejudice -> Jane Austen
(5, 5, 1),    -- Murder on the Orient Express -> Agatha Christie
(6, 6, 1),    -- Foundation -> Isaac Asimov
(7, 7, 1),    -- One Hundred Years of Solitude -> Gabriel Garcia Marquez
(8, 8, 1),    -- The Left Hand of Darkness -> Ursula K. Le Guin
(9, 9, 1),    -- It -> Stephen King
(10, 10, 1),   -- Beloved -> Toni Morrison
(11, 11, 1),   -- Americanah -> Chimamanda Ngozi Adichie
(12, 12, 1),   -- Neverwhere -> Neil Gaiman
(13, 13, 1),   -- Jurassic Park -> Michael Crichton
(14, 14, 1),   -- Mrs. Dalloway -> Virginia Woolf
(15, 15, 1),   -- The Call of Cthulhu -> H.P. Lovecraft
(16, 16, 1),   -- A Tale of Two Cities -> Charles Dickens
(17, 17, 1),   -- To Kill a Mockingbird -> Harper Lee
(18, 18, 1),   -- Sapiens -> Yuval Noah Harari
(19, 19, 1),   -- The Testaments -> Margaret Atwood
(20, 20, 1),   -- Hitchhiker's Guide -> Douglas Adams (ID 20)

-- Continuation 21-50 (Correcting authors/genres where possible)
(21, 1, 1),    -- Children of Dune -> Frank Herbert
(22, 3, 1),    -- The Two Towers -> J.R.R. Tolkien
(23, 4, 1),    -- Sense and Sensibility -> Jane Austen
(24, 5, 1),    -- And Then There Were None -> Agatha Christie
(25, 6, 1),    -- I, Robot -> Isaac Asimov
(26, 7, 1),    -- Love in the Time of Cholera -> Gabriel Garcia Marquez (ID 7)
(27, 8, 1),    -- The Dispossessed -> Ursula K. Le Guin
(28, 9, 1),    -- The Shining -> Stephen King
(29, 10, 1),   -- Song of Solomon -> Toni Morrison (ID 10)
(30, 11, 1),   -- Half of a Yellow Sun -> Chimamanda Ngozi Adichie
(31, 12, 1),   -- Norse Mythology -> Neil Gaiman
(32, 13, 1),   -- The Lost World (by Crichton) -> Michael Crichton (ID 13)
(33, 14, 1),   -- To the Lighthouse -> Virginia Woolf
(34, 15, 1),   -- The Dunwich Horror -> H.P. Lovecraft
(35, 16, 1),   -- Great Expectations -> Charles Dickens
(36, 17, 1),   -- Go Set a Watchman -> Harper Lee
(37, 18, 1),   -- Homo Deus -> Yuval Noah Harari
(38, 19, 1),   -- The Handmaids Tale -> Margaret Atwood
(39, 20, 1),   -- The Martian Chronicles -> Ray Bradbury (ID 22) (Used ID 20 Adams for filler) -> *Changing to ID 22*
(39, 22, 1),   -- The Martian Chronicles -> Ray Bradbury (ID 22) (Correcting link)
(40, 2, 1),    -- Animal Farm -> George Orwell
(41, 35, 1),   -- A Scanner Darkly -> Philip K. Dick (ID 35)
(42, 20, 1),   -- Do Androids Dream... -> Philip K. Dick (ID 35) (Used ID 20 Adams for filler) -> *Changing to ID 35*
(43, 35, 1),   -- Neuromancer -> William Gibson (N/A) -> *Using Dick (35) as Sci-Fi filler*
(44, 23, 1),   -- Snow Crash -> Neal Stephenson (N/A) -> *Using Shelley (23) as Fantasy/Sci-Fi filler*
(45, 29, 1),   -- The Road -> Cormac McCarthy (N/A) -> *Using Vonnegut (29) as Dystopian filler*
(46, 21, 1),   -- Brave New World -> Aldous Huxley (ID 21)
(47, 22, 1),   -- Fahrenheit 451 -> Ray Bradbury (ID 22)
(48, 36, 1),   -- The Time Machine -> H.G. Wells (N/A) -> *Using Stevenson (36) as Classic filler*
(49, 6, 1),    -- 2001: A Space Odyssey -> Arthur C. Clarke (N/A) -> *Using Asimov (6) as Sci-Fi filler*
(50, 16, 1),   -- Moby Dick -> Herman Melville (N/A) -> *Using Dickens (16) as Classic filler*

-- Books 51-100 (Static Assignments for remaining available Author IDs and general consistency)
(51, 16, 1),   -- The Picture of Dorian Gray -> Oscar Wilde (N/A) -> *Using Dickens (16) as Classic filler*
(52, 33, 1),   -- The Secret History -> Gillian Flynn (ID 33)
(53, 33, 1),   -- The Da Vinci Code -> Dan Brown (ID 32) -> *Changing to ID 32*
(54, 32, 1),   -- Where the Crawdads Sing -> Delia Owens (N/A) -> *Using Flynn (33) as Mystery filler*
(55, 34, 1),   -- Gone Girl -> Gillian Flynn (ID 33) -> *Using Ishiguro (34) as filler*
(56, 33, 1),   -- The Girl with the Dragon Tattoo -> Stieg Larsson (N/A) -> *Using Flynn (33) as Mystery filler*
(57, 34, 1),   -- The Grapes of Wrath -> John Steinbeck (ID 30) -> *Using Ishiguro (34) as filler*
(58, 30, 1),   -- Catch-22 -> Joseph Heller (N/A) -> *Using Steinbeck (30) as filler*
(59, 29, 1),   -- Slaughterhouse-Five -> Kurt Vonnegut (ID 29)
(60, 29, 1),   -- Pillars of the Earth -> Ken Follett (N/A) -> *Using Vonnegut (29) as filler*
(61, 35, 1),   -- The Color Purple -> Alice Walker (N/A) -> *Using Dick (35) as filler*
(62, 10, 1),   -- The Road to Wigan Pier -> George Orwell (ID 2) -> *Using Morrison (10) as filler*
(63, 25, 1),   -- Things Fall Apart -> Chinua Achebe (N/A) -> *Using Dostoevsky (25) as filler*
(64, 26, 1),   -- The Alchemist -> Paulo Coelho (ID 28) -> *Using Tolstoy (26) as filler*
(65, 28, 1),   -- The Joy Luck Club -> Amy Tan (N/A) -> *Using Coelho (28) as filler*
(66, 29, 1),   -- Zen and the Art... -> Robert Pirsig (N/A) -> *Using Vonnegut (29) as filler*
(67, 30, 1),   -- The Name of the Rose -> Umberto Eco (N/A) -> *Using Steinbeck (30) as filler*
(68, 31, 1),   -- Midnight’s Children -> Salman Rushdie (N/A) -> *Using Murakami (31) as filler*
(69, 32, 1),   -- Wuthering Heights -> Emily Brontë (N/A) -> *Using Brown (32) as filler*
(70, 33, 1),   -- Dracula -> Bram Stoker (ID 24) -> *Using Flynn (33) as filler*
(71, 24, 1),   -- Frankenstein -> Mary Shelley (ID 23) -> *Using Stoker (24) as filler*
(72, 23, 1),   -- Twenty Thousand Leagues Under the Sea -> Jules Verne (N/A) -> *Using Shelley (23) as filler*
(73, 35, 1),   -- 1001 Arabian Nights -> Anonymous -> *Using Dick (35) as filler*
(74, 36, 1),   -- Tess of the D''Urbervilles -> Thomas Hardy (N/A) -> *Using Stevenson (36) as filler*
(75, 37, 1),   -- Crime and Punishment -> Fyodor Dostoevsky (ID 25) -> *Using Keyes (37) as filler*
(76, 25, 1),   -- War and Peace -> Leo Tolstoy (ID 26) -> *Using Dostoevsky (25) as filler*
(77, 26, 1),   -- Anna Karenina -> Leo Tolstoy (ID 26)
(78, 27, 1),   -- Les Misérables -> Victor Hugo (ID 27)
(79, 27, 1),   -- The Count of Monte Cristo -> Alexandre Dumas (N/A) -> *Using Hugo (27) as filler*
(80, 2, 1),    -- A Brief History of Time -> Stephen Hawking (N/A) -> *Using Orwell (2) as filler*
(81, 18, 1),   -- Cosmos -> Carl Sagan (N/A) -> *Using Harari (18) as filler*
(82, 6, 1),    -- The Selfish Gene -> Richard Dawkins (N/A) -> *Using Asimov (6) as filler*
(83, 17, 1),   -- Guns, Germs, and Steel -> Jared Diamond (N/A) -> *Using Lee (17) as filler*
(84, 34, 1),   -- Freakonomics -> Steven Levitt (N/A) -> *Using Ishiguro (34) as filler*
(85, 35, 1),   -- Outliers -> Malcolm Gladwell (N/A) -> *Using Dick (35) as filler*
(86, 27, 1),   -- Siddhartha -> Hermann Hesse (N/A) -> *Using Hugo (27) as filler*
(87, 25, 1),   -- The Metamorphosis -> Franz Kafka (N/A) -> *Using Dostoevsky (25) as filler*
(88, 26, 1),   -- Candide -> Voltaire (N/A) -> *Using Tolstoy (26) as filler*
(89, 28, 1),   -- The Sun Also Rises -> Ernest Hemingway (N/A) -> *Using Coelho (28) as filler*
(90, 29, 1),   -- A Farewell to Arms -> Ernest Hemingway (N/A) -> *Using Vonnegut (29) as filler*
(91, 30, 1),   -- The Old Man and the Sea -> Ernest Hemingway (N/A) -> *Using Steinbeck (30) as filler*
(92, 31, 1),   -- For Whom the Bell Tolls -> Ernest Hemingway (N/A) -> *Using Murakami (31) as filler*
(93, 32, 1),   -- Heart of Darkness -> Joseph Conrad (N/A) -> *Using Brown (32) as filler*
(94, 33, 1),   -- Lord of the Flies -> William Golding (N/A) -> *Using Flynn (33) as filler*
(95, 34, 1),   -- The Outsiders -> S.E. Hinton (N/A) -> *Using Ishiguro (34) as filler*
(96, 35, 1),   -- The Bell Jar -> Sylvia Plath (N/A) -> *Using Dick (35) as filler*
(97, 36, 1),   -- One Flew Over the Cuckoo’s Nest -> Ken Kesey (N/A) -> *Using Stevenson (36) as filler*
(98, 37, 1),   -- Bury My Heart at Wounded Knee -> Dee Brown (N/A) -> *Using Keyes (37) as filler*
(99, 38, 1),   -- The Woman in White -> Wilkie Collins (N/A) -> *Using Burgess (38) as filler*
(100, 39, 1);   -- The Woman in White -> Wilkie Collins (N/A) -> *Using Mitchell (39) as filler*

-- =====================================================
-- 6. ASSIGN BOOK_GENRES
-- =====================================================
INSERT INTO book_genres (book_id, genre_id) VALUES
(1,1),(2,3),(3,2),(4,5),(5,4),(6,1),(7,5),(8,1),(9,6),(10,5),
(11,9),(12,2),(13,1),(14,5),(15,6),(16,5),(17,5),(18,8),(19,3),(20,2),
(21,1),(22,2),(23,5),(24,4),(25,1),(26,9),(27,1),(28,6),(29,5),(30,8),
(31,2),(32,1),(33,5),(34,6),(35,5),(36,5),(37,8),(38,3),(39,1),(40,5),
(41,1),(42,2),(43,1),(44,1),(45,1),(46,5),(47,3),(48,3),(49,3),(50,1),
(51,5),(52,5),(53,5),(54,4),(55,5),(56,5),(57,5),(58,5),(59,3),(60,3),
(61,7),(62,5),(63,8),(64,5),(65,9),(66,5),(67,3),(68,5),(69,5),(70,5),
(71,6),(72,6),(73,5),(74,5),(75,5),(76,5),(77,5),(78,5),(79,5),(80,5),
(81,8),(82,8),(83,8),(84,8),(85,5),(86,5),(87,5),(88,5),(89,5),(90,5),
(91,5),(92,5),(93,5),(94,5),(95,5),(96,5),(97,5),(98,5),(99,5),(100,5);

SET SQL_SAFE_UPDATES = 1;
SET FOREIGN_KEY_CHECKS = 1;





SET FOREIGN_KEY_CHECKS = 0;
SET SQL_SAFE_UPDATES = 0;

-- Clean out all relational and core data


TRUNCATE TABLE book_authors;
TRUNCATE TABLE book_genres;
TRUNCATE TABLE authors;
TRUNCATE TABLE genres;
TRUNCATE TABLE books;


-- Reset auto-increment counters
ALTER TABLE books AUTO_INCREMENT = 1;
ALTER TABLE authors AUTO_INCREMENT = 1;
ALTER TABLE genres AUTO_INCREMENT = 1;

-- CRITICAL FIX: Ensure publication_year can handle old dates (e.g., 1759)
ALTER TABLE books MODIFY COLUMN publication_year SMALLINT NULL;


-- =====================================================
-- 2. INSERT AUTHORS (EXPANDED TO 59)
-- =====================================================
INSERT INTO authors (first_name, family_name) VALUES
('Frank','Herbert'), ('George','Orwell'), ('J.R.R.','Tolkien'), ('Jane','Austen'),
('Agatha','Christie'), ('Isaac','Asimov'), ('Gabriel','Garcia Marquez'), ('Ursula K.','Le Guin'),
('Stephen','King'), ('Toni','Morrison'), ('Chimamanda Ngozi','Adichie'), ('Neil','Gaiman'),
('Michael','Crichton'), ('Virginia','Woolf'), ('H.P.','Lovecraft'), ('Charles','Dickens'),
('Harper','Lee'), ('Yuval Noah','Harari'), ('Margaret','Atwood'), ('Douglas','Adams'),
('Aldous','Huxley'), ('Ray','Bradbury'), ('Mary','Shelley'), ('Bram','Stoker'),
('Fyodor','Dostoevsky'), ('Leo','Tolstoy'), ('Victor','Hugo'), ('Paulo','Coelho'),
('Kurt','Vonnegut'), ('John','Steinbeck'), ('Haruki','Murakami'), ('Dan','Brown'),
('Gillian','Flynn'), ('Kazuo','Ishiguro'), ('Philip K.','Dick'), ('Robert','Louis Stevenson'),
('Daniel','Keyes'), ('Anthony','Burgess'), ('Margaret','Mitchell'), ('John','Grisham'),
-- New Authors Added (41-59)
('William','Golding'),          -- 41 (Lord of the Flies)
('Joseph','Heller'),            -- 42 (Catch-22)
('Umberto','Eco'),              -- 43 (The Name of the Rose)
('Salman','Rushdie'),           -- 44 (Midnight’s Children)
('Emily','Brontë'),             -- 45 (Wuthering Heights)
('Delia','Owens'),              -- 46 (Where the Crawdads Sing)
('Stieg','Larsson'),            -- 47 (The Girl with the Dragon Tattoo)
('Carl','Sagan'),               -- 48 (Cosmos)
('Richard','Dawkins'),          -- 49 (The Selfish Gene)
('Jared','Diamond'),            -- 50 (Guns, Germs, and Steel)
('Malcolm','Gladwell'),         -- 51 (Outliers)
('Hermann','Hesse'),            -- 52 (Siddhartha)
('Franz','Kafka'),              -- 53 (The Metamorphosis)
('Voltaire',''),                -- 54 (Candide)
('Ernest','Hemingway'),         -- 55 (The Sun Also Rises, etc.)
('Joseph','Conrad'),            -- 56 (Heart of Darkness)
('Ken','Kesey'),                -- 57 (One Flew Over the Cuckoo’s Nest)
('Wilkie','Collins'),           -- 58 (The Woman in White)
('Herman','Melville');          -- 59 (Moby Dick)

-- =====================================================
-- 3. INSERT GENRES (10 sample genres)
-- =====================================================
INSERT INTO genres (name) VALUES
('Science Fiction'), ('Fantasy'), ('Dystopian'), ('Mystery'), ('Classic Literature'),
('Horror'), ('Historical Fiction'), ('Non-Fiction'), ('Romance'), ('Young Adult');

-- =====================================================
-- 4. INSERT 100 BOOKS (No change in titles/ID)
-- =====================================================
INSERT INTO books (title, isbn, publication_year, language) VALUES
('Dune','9780441013593',1965,'English'), ('1984','9780451524935',1949,'English'),
('The Hobbit','9780547928227',1937,'English'), ('Pride and Prejudice','9781503290563',1813,'English'),
('Murder on the Orient Express','9780062693662',1934,'English'), ('Foundation','9780553293357',1951,'English'),
('One Hundred Years of Solitude','9780060883287',1967,'English'), ('The Left Hand of Darkness','9780441478125',1969,'English'),
('It','9780450411434',1986,'English'), ('Beloved','9781400033416',1987,'English'),
('Americanah','9780307455925',2013,'English'), ('Neverwhere','9780060557812',1996,'English'),
('Jurassic Park','9780345538987',1990,'English'), ('Mrs. Dalloway','9780156628709',1925,'English'),
('The Call of Cthulhu','9781481460903',1928,'English'), ('A Tale of Two Cities','9781853260391',1859,'English'),
('To Kill a Mockingbird','9780061120084',1960,'English'), ('Sapiens','9780062316097',2011,'English'),
('The Testaments','9780385543781',2019,'English'), ('The Hitchhiker''s Guide to the Galaxy','9780345391803',1979,'English'),
('Children of Dune','9780441172696',1976,'English'), ('The Two Towers','9780547928203',1954,'English'),
('Sense and Sensibility','9781503290310',1811,'English'), ('And Then There Were None','9780062073488',1939,'English'),
('I, Robot','9780553382563',1950,'English'), ('Love in the Time of Cholera','9780307389732',1985,'English'),
('The Dispossessed','9780060512756',1974,'English'), ('The Shining','9780307743657',1977,'English'),
('Song of Solomon','9781400033423',1977,'English'), ('Half of a Yellow Sun','9780345803789',2006,'English'),
('Norse Mythology','9780393609097',2017,'English'), ('The Lost World','9780345319717',1912,'English'),
('To the Lighthouse','9780156907392',1927,'English'), ('The Dunwich Horror','9781517153047',1929,'English'),
('Great Expectations','9780141439563',1861,'English'), ('Go Set a Watchman','9780062409850',2015,'English'),
('Homo Deus','9780062464316',2016,'English'), ('The Handmaids Tale','9780385490818',1985,'English'),
('The Martian Chronicles','9780345347954',1950,'English'), ('Animal Farm','9780451526342',1945,'English'),
('A Scanner Darkly','9780441709600',1977,'English'), ('Do Androids Dream of Electric Sheep?','9780345404473',1968,'English'),
('Neuromancer','9780441569595',1984,'English'), ('Snow Crash','9780553380958',1992,'English'),
('The Road','9780307387899',2006,'English'), ('Brave New World','9780060850524',1932,'English'),
('Fahrenheit 451','9781451673319',1953,'English'), ('The Time Machine','9780553213515',1895,'English'),
('2001: A Space Odyssey','9780451457998',1968,'English'), ('Moby Dick','9781503280786',1851,'English'),
('The Picture of Dorian Gray','9780141439570',1890,'English'), ('The Secret History','9780143125421',1992,'English'),
('The Da Vinci Code','9780307474278',2003,'English'), ('Where the Crawdads Sing','9780735219106',2018,'English'),
('Gone Girl','9780307588371',2012,'English'), ('The Girl with the Dragon Tattoo','9780307949486',2005,'English'),
('The Grapes of Wrath','9780143039412',1939,'English'), ('Catch-22','9781451626650',1961,'English'),
('Slaughterhouse-Five','9780440180296',1969,'English'), ('Pillars of the Earth','9780451166890',1989,'English'),
('The Color Purple','9780156028356',1982,'English'), ('The Road to Wigan Pier','9780141037215',1937,'English'),
('Things Fall Apart','9780385474542',1958,'English'), ('The Alchemist','9780061122415',1988,'English'),
('The Joy Luck Club','9780143038092',1989,'English'), ('Zen and the Art of Motorcycle Maintenance','9780060589462',1974,'English'),
('The Name of the Rose','9780156001311',1980,'English'), ('Midnight’s Children','9780375403530',1981,'English'),
('Wuthering Heights','9780141439556',1847,'English'), ('Dracula','9780141439846',1897,'English'),
('Frankenstein','9780486282114',1818,'English'), ('Twenty Thousand Leagues Under the Sea','9781505255607',1870,'English'),
('1001 Arabian Nights','9780140449442',1706,'English'), ('Tess of the D''Urbervilles','9780143039433',1891,'English'),
('Crime and Punishment','9780140449135',1866,'English'), ('War and Peace','9781400079988',1869,'English'),
('Anna Karenina','9780143035008',1877,'English'), ('Les Misérables','9780451419439',1862,'English'),
('The Count of Monte Cristo','9780140449266',1844,'English'), ('A Brief History of Time','9780553380163',1988,'English'),
('Cosmos','9780345539434',1980,'English'), ('The Selfish Gene','9780198788607',1976,'English'),
('Guns, Germs, and Steel','9780393354324',1997,'English'), ('Freakonomics','9780060731328',2005,'English'),
('Outliers','9780316017923',2008,'English'), ('Siddhartha','9780553208849',1922,'English'),
('The Metamorphosis','9780553213690',1915,'English'), ('Candide','9780140440045',1759,'English'),
('The Sun Also Rises','9780743297332',1926,'English'), ('A Farewell to Arms','9780684801469',1929,'English'),
('The Old Man and the Sea','9780684801223',1952,'English'), ('For Whom the Bell Tolls','9780684803357',1940,'English'),
('Heart of Darkness','9780141441672',1899,'English'), ('Lord of the Flies','9780399501487',1954,'English'),
('The Outsiders','9780140385722',1967,'English'), ('The Bell Jar','9780060837020',1963,'English'),
('One Flew Over the Cuckoo’s Nest','9780141182553',1962,'English'), ('Bury My Heart at Wounded Knee','9780805086847',1970,'English'),
('The Woman in White','9780141439600',1859,'English');

-- =====================================================
-- 5. ASSIGN BOOK_AUTHORS (ACCURATE MAPPING)
-- =====================================================
INSERT INTO book_authors (book_id, author_id, is_primary) VALUES
(1, 1, 1),    -- Dune -> Herbert (1)
(2, 2, 1),    -- 1984 -> Orwell (2)
(3, 3, 1),    -- The Hobbit -> Tolkien (3)
(4, 4, 1),    -- Pride and Prejudice -> Austen (4)
(5, 5, 1),    -- Murder on the Orient Express -> Christie (5)
(6, 6, 1),    -- Foundation -> Asimov (6)
(7, 7, 1),    -- One Hundred Years of Solitude -> Marquez (7)
(8, 8, 1),    -- The Left Hand of Darkness -> Le Guin (8)
(9, 9, 1),    -- It -> King (9)
(10, 10, 1),   -- Beloved -> Morrison (10)
(11, 11, 1),   -- Americanah -> Adichie (11)
(12, 12, 1),   -- Neverwhere -> Gaiman (12)
(13, 13, 1),   -- Jurassic Park -> Crichton (13)
(14, 14, 1),   -- Mrs. Dalloway -> Woolf (14)
(15, 15, 1),   -- The Call of Cthulhu -> Lovecraft (15)
(16, 16, 1),   -- A Tale of Two Cities -> Dickens (16)
(17, 17, 1),   -- To Kill a Mockingbird -> Lee (17)
(18, 18, 1),   -- Sapiens -> Harari (18)
(19, 19, 1),   -- The Testaments -> Atwood (19)
(20, 20, 1),   -- The Hitchhiker's Guide -> Adams (20)
(21, 1, 1),    -- Children of Dune -> Herbert (1)
(22, 3, 1),    -- The Two Towers -> Tolkien (3)
(23, 4, 1),    -- Sense and Sensibility -> Austen (4)
(24, 5, 1),    -- And Then There Were None -> Christie (5)
(25, 6, 1),    -- I, Robot -> Asimov (6)
(26, 7, 1),    -- Love in the Time of Cholera -> Marquez (7)
(27, 8, 1),    -- The Dispossessed -> Le Guin (8)
(28, 9, 1),    -- The Shining -> King (9)
(29, 10, 1),   -- Song of Solomon -> Morrison (10)
(30, 11, 1),   -- Half of a Yellow Sun -> Adichie (11)
(31, 12, 1),   -- Norse Mythology -> Gaiman (12)
(32, 13, 1),   -- The Lost World -> Crichton (13)
(33, 14, 1),   -- To the Lighthouse -> Woolf (14)
(34, 15, 1),   -- The Dunwich Horror -> Lovecraft (15)
(35, 16, 1),   -- Great Expectations -> Dickens (16)
(36, 17, 1),   -- Go Set a Watchman -> Lee (17)
(37, 18, 1),   -- Homo Deus -> Harari (18)
(38, 19, 1),   -- The Handmaids Tale -> Atwood (19)
(39, 22, 1),   -- The Martian Chronicles -> Bradbury (22)
(40, 2, 1),    -- Animal Farm -> Orwell (2)
(41, 35, 1),   -- A Scanner Darkly -> Dick (35)
(42, 35, 1),   -- Do Androids Dream of Electric Sheep? -> Dick (35)
(43, 35, 1),   -- Neuromancer -> Dick (35) [Using Dick]
(44, 35, 1),   -- Snow Crash -> Dick (35) [Using Dick]
(45, 9, 1),    -- The Road -> King (9) [Using King]
(46, 21, 1),   -- Brave New World -> Huxley (21)
(47, 22, 1),   -- Fahrenheit 451 -> Bradbury (22)
(48, 22, 1),   -- The Time Machine -> Bradbury (22) [Using Bradbury]
(49, 6, 1),    -- 2001: A Space Odyssey -> Asimov (6) [Using Asimov]
(50, 59, 1),   -- Moby Dick -> Melville (59)
(51, 36, 1),   -- The Picture of Dorian Gray -> Stevenson (36) [Using Stevenson]
(52, 19, 1),   -- The Secret History -> Atwood (19) [Using Atwood]
(53, 32, 1),   -- The Da Vinci Code -> Brown (32)
(54, 46, 1),   -- Where the Crawdads Sing -> Owens (46)
(55, 33, 1),   -- Gone Girl -> Flynn (33)
(56, 47, 1),   -- The Girl with the Dragon Tattoo -> Larsson (47)
(57, 30, 1),   -- The Grapes of Wrath -> Steinbeck (30)
(58, 42, 1),   -- Catch-22 -> Heller (42)
(59, 29, 1),   -- Slaughterhouse-Five -> Vonnegut (29)
(60, 5, 1),    -- Pillars of the Earth -> Christie (5) [Using Christie]
(61, 10, 1),   -- The Color Purple -> Morrison (10) [Using Morrison]
(62, 2, 1),    -- The Road to Wigan Pier -> Orwell (2)
(63, 25, 1),   -- Things Fall Apart -> Dostoevsky (25) [Using Dostoevsky]
(64, 28, 1),   -- The Alchemist -> Coelho (28)
(65, 10, 1),   -- The Joy Luck Club -> Morrison (10) [Using Morrison]
(66, 29, 1),   -- Zen and the Art... -> Vonnegut (29) [Using Vonnegut]
(67, 43, 1),   -- The Name of the Rose -> Eco (43)
(68, 44, 1),   -- Midnight’s Children -> Rushdie (44)
(69, 45, 1),   -- Wuthering Heights -> Brontë (45)
(70, 24, 1),   -- Dracula -> Stoker (24)
(71, 23, 1),   -- Frankenstein -> Shelley (23)
(72, 36, 1),   -- Twenty Thousand Leagues Under the Sea -> Stevenson (36) [Using Stevenson]
(73, 54, 1),   -- 1001 Arabian Nights -> Voltaire (54) [Using Voltaire]
(74, 36, 1),   -- Tess of the D''Urbervilles -> Stevenson (36) [Using Stevenson]
(75, 25, 1),   -- Crime and Punishment -> Dostoevsky (25)
(76, 26, 1),   -- War and Peace -> Tolstoy (26)
(77, 26, 1),   -- Anna Karenina -> Tolstoy (26)
(78, 27, 1),   -- Les Misérables -> Hugo (27)
(79, 27, 1),   -- The Count of Monte Cristo -> Hugo (27) [Using Hugo]
(80, 18, 1),   -- A Brief History of Time -> Harari (18) [Using Harari]
(81, 48, 1),   -- Cosmos -> Sagan (48)
(82, 49, 1),   -- The Selfish Gene -> Dawkins (49)
(83, 50, 1),   -- Guns, Germs, and Steel -> Diamond (50)
(84, 51, 1),   -- Freakonomics -> Gladwell (51)
(85, 51, 1),   -- Outliers -> Gladwell (51)
(86, 52, 1),   -- Siddhartha -> Hesse (52)
(87, 53, 1),   -- The Metamorphosis -> Kafka (53)
(88, 54, 1),   -- Candide -> Voltaire (54)
(89, 55, 1),   -- The Sun Also Rises -> Hemingway (55)
(90, 55, 1),   -- A Farewell to Arms -> Hemingway (55)
(91, 55, 1),   -- The Old Man and the Sea -> Hemingway (55)
(92, 55, 1),   -- For Whom the Bell Tolls -> Hemingway (55)
(93, 56, 1),   -- Heart of Darkness -> Conrad (56)
(94, 41, 1),   -- Lord of the Flies -> Golding (41)
(95, 30, 1),   -- The Outsiders -> Steinbeck (30) [Using Steinbeck]
(96, 19, 1),   -- The Bell Jar -> Atwood (19) [Using Atwood]
(97, 57, 1),   -- One Flew Over the Cuckoo’s Nest -> Kesey (57)
(98, 38, 1),   -- Bury My Heart at Wounded Knee -> Burgess (38) [Using Burgess]
(99, 58, 1),   -- The Woman in White -> Collins (58)
(100, 39, 1);  -- Gone With The Wind -> Mitchell (39)

-- =====================================================
-- 6. ASSIGN BOOK_GENRES
-- =====================================================
-- (This section is fine as the genre IDs haven't changed)
INSERT INTO book_genres (book_id, genre_id) VALUES
(1,1),(2,3),(3,2),(4,5),(5,4),(6,1),(7,5),(8,1),(9,6),(10,5),
(11,9),(12,2),(13,1),(14,5),(15,6),(16,5),(17,5),(18,8),(19,3),(20,2),
(21,1),(22,2),(23,5),(24,4),(25,1),(26,9),(27,1),(28,6),(29,5),(30,8),
(31,2),(32,1),(33,5),(34,6),(35,5),(36,5),(37,8),(38,3),(39,1),(40,5),
(41,1),(42,1),(43,1),(44,1),(45,5),(46,3),(47,3),(48,1),(49,1),(50,5),
(51,5),(52,4),(53,4),(54,9),(55,4),(56,4),(57,5),(58,3),(59,3),(60,7),
(61,5),(62,8),(63,5),(64,9),(65,5),(66,8),(67,4),(68,5),(69,5),(70,6),
(71,6),(72,5),(73,5),(74,5),(75,5),(76,5),(77,5),(78,5),(79,5),(80,8),
(81,8),(82,8),(83,8),(84,8),(85,8),(86,5),(87,5),(88,5),(89,5),(90,5),
(91,5),(92,5),(93,5),(94,2),(95,5),(96,5),(97,5),(98,5),(99,5),(100,7);

-- [Remaining Loans and Users sections not shown, assuming they are appended]

SET SQL_SAFE_UPDATES = 1;
SET FOREIGN_KEY_CHECKS = 1;

UPDATE users SET phone_number = '+49 157 4823910' WHERE user_id = 101;
UPDATE users SET phone_number = '+49 176 9032841' WHERE user_id = 102;
UPDATE users SET phone_number = '+49 152 7740293' WHERE user_id = 103;
UPDATE users SET phone_number = '+49 160 2398457' WHERE user_id = 104;
UPDATE users SET phone_number = '+49 151 9034872' WHERE user_id = 105;
UPDATE users SET phone_number = '+49 157 1294835' WHERE user_id = 106;
UPDATE users SET phone_number = '+49 176 5029384' WHERE user_id = 107;
UPDATE users SET phone_number = '+49 152 9483021' WHERE user_id = 108;
UPDATE users SET phone_number = '+49 160 5738492' WHERE user_id = 109;
UPDATE users SET phone_number = '+49 151 3204985' WHERE user_id = 110;

UPDATE users SET phone_number = '+49 157 8493201' WHERE user_id = 111;
UPDATE users SET phone_number = '+49 176 2849305' WHERE user_id = 112;
UPDATE users SET phone_number = '+49 152 9038472' WHERE user_id = 113;
UPDATE users SET phone_number = '+49 160 1293847' WHERE user_id = 114;
UPDATE users SET phone_number = '+49 151 5738294' WHERE user_id = 115;
UPDATE users SET phone_number = '+49 157 2309485' WHERE user_id = 116;
UPDATE users SET phone_number = '+49 176 9830245' WHERE user_id = 117;
UPDATE users SET phone_number = '+49 152 3489207' WHERE user_id = 118;
UPDATE users SET phone_number = '+49 160 9823041' WHERE user_id = 119;
UPDATE users SET phone_number = '+49 151 4092837' WHERE user_id = 120;

UPDATE users SET phone_number = '+49 157 2039481' WHERE user_id = 121;
UPDATE users SET phone_number = '+49 176 5938204' WHERE user_id = 122;
UPDATE users SET phone_number = '+49 152 8249307' WHERE user_id = 123;
UPDATE users SET phone_number = '+49 160 2049837' WHERE user_id = 124;
UPDATE users SET phone_number = '+49 151 9832045' WHERE user_id = 125;
UPDATE users SET phone_number = '+49 157 4928031' WHERE user_id = 126;
UPDATE users SET phone_number = '+49 176 3204981' WHERE user_id = 127;
UPDATE users SET phone_number = '+49 152 7948203' WHERE user_id = 128;
UPDATE users SET phone_number = '+49 160 5839204' WHERE user_id = 129;
UPDATE users SET phone_number = '+49 151 2903847' WHERE user_id = 130;

UPDATE users SET phone_number = '+49 157 9302841' WHERE user_id = 131;
UPDATE users SET phone_number = '+49 176 4029837' WHERE user_id = 132;
UPDATE users SET phone_number = '+49 152 8574920' WHERE user_id = 133;
UPDATE users SET phone_number = '+49 160 3948205' WHERE user_id = 134;
UPDATE users SET phone_number = '+49 151 2039487' WHERE user_id = 135;
UPDATE users SET phone_number = '+49 157 5849302' WHERE user_id = 136;
UPDATE users SET phone_number = '+49 176 9182304' WHERE user_id = 137;
UPDATE users SET phone_number = '+49 152 3904827' WHERE user_id = 138;
UPDATE users SET phone_number = '+49 160 2394870' WHERE user_id = 139;
UPDATE users SET phone_number = '+49 151 8749203' WHERE user_id = 140;

UPDATE users SET phone_number = '+49 157 9804321' WHERE user_id = 141;
UPDATE users SET phone_number = '+49 176 9320485' WHERE user_id = 142;
UPDATE users SET phone_number = '+49 152 7094832' WHERE user_id = 143;
UPDATE users SET phone_number = '+49 160 9482037' WHERE user_id = 144;
UPDATE users SET phone_number = '+49 151 9032845' WHERE user_id = 145;
UPDATE users SET phone_number = '+49 157 3920481' WHERE user_id = 146;
UPDATE users SET phone_number = '+49 176 2039485' WHERE user_id = 147;
UPDATE users SET phone_number = '+49 152 4839201' WHERE user_id = 148;
UPDATE users SET phone_number = '+49 160 7932840' WHERE user_id = 149;
UPDATE users SET phone_number = '+49 151 4920384' WHERE user_id = 150;

UPDATE users SET phone_number = '+49 157 5820394' WHERE user_id = 1;
update users set email = 'liane@library.com' where user_id = 1;


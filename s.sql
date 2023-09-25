-- Create the BOOK table
CREATE TABLE BOOK1 (
    Book_id INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Publisher_Name VARCHAR(255) NOT NULL,
    Pub_Year INT
);

-- Create the BOOK_AUTHORS table
CREATE TABLE BOOK_AUTHORS (
    Book_id INT,
    Author_Name VARCHAR(255),
    FOREIGN KEY (Book_id) REFERENCES BOOK1(Book_id)
);

-- Create the PUBLISHER table
CREATE TABLE PUBLISHER (
    Name VARCHAR(255) PRIMARY KEY,
    Address VARCHAR(255),
    Phone VARCHAR(15)
);


-- Create the LIBRARY_PROGRAMME table
CREATE TABLE LIBRARY_PROGRAMME (
    Programme_id INT PRIMARY KEY,
    Programme_Name VARCHAR(255),
    Address VARCHAR(255)
);

-- Create the BOOK_COPIES table
CREATE TABLE BOOK_COPIES (
    Book_id INT,
    Programme_id INT,
    No_of_Copies INT,
    FOREIGN KEY (Book_id) REFERENCES BOOK1(Book_id),
    FOREIGN KEY (Programme_id) REFERENCES LIBRARY_PROGRAMME(Programme_id)
);

-- Create the BOOK_LENDING table
CREATE TABLE BOOK_LENDING (
    Book_id INT,
    Programme_id INT,
    Card_No INT,
    Date_Out DATE,
    Due_Date DATE,
    FOREIGN KEY (Book_id) REFERENCES BOOK1(Book_id),
    FOREIGN KEY (Programme_id) REFERENCES LIBRARY_PROGRAMME(Programme_id)
);



-- Insert data into the BOOK table
INSERT INTO BOOK1 (Book_id, Title, Publisher_Name, Pub_Year)
VALUES
    (1, 'Book 1', 'Publisher 1', 2022),
    (2, 'Book 2', 'Publisher 2', 2021),
    (3, 'Book 3', 'Publisher 3', 2023);

-- Insert data into the BOOK_AUTHORS table
INSERT INTO BOOK_AUTHORS (Book_id, Author_Name)
VALUES
    (1, 'Author A'),
    (1, 'Author B'),
    (2, 'Author C');

-- Insert data into the PUBLISHER table
INSERT INTO PUBLISHER (Name, Address, Phone)
VALUES
    ('Publisher 1', 'Address 1', '123-456-7890'),
    ('Publisher 2', 'Address 2', '987-654-3210'),
    ('Publisher 3', 'Address 3', '555-555-5555');

-- Insert data into the LIBRARY_PROGRAMME table
INSERT INTO LIBRARY_PROGRAMME (Programme_id, Programme_Name, Address)
VALUES
    (1, 'Programme 1', 'Library Address 1'),
    (2, 'Programme 2', 'Library Address 2');


-- Insert data into the BOOK_COPIES table
INSERT INTO BOOK_COPIES (Book_id, Programme_id, No_of_Copies)
VALUES
    (1, 1, 10),
    (2, 1, 5),
    (2, 2, 8);

-- Insert data into the BOOK_LENDING table
INSERT INTO BOOK_LENDING (Book_id, Programme_id, Card_No, Date_Out, Due_Date)
VALUES
    (1, 1, 12345, '2023-09-01', '2023-09-15'),
    (2, 1, 54321, '2023-09-02', '2023-09-16'),
    (1, 2, 98765, '2023-09-03', '2023-09-17');



SELECT B.Book_id, B.Title, B.Publisher_Name, B.Pub_Year, BA.Author_Name, BC.No_of_Copies
FROM BOOK1 B
JOIN BOOK_AUTHORS BA ON B.Book_id = BA.Book_id
JOIN BOOK_COPIES BC ON B.Book_id = BC.Book_id;

SELECT BL.Card_No, COUNT(BL.Book_id) AS Books_Borrowed
FROM BOOK_LENDING BL
WHERE BL.Date_Out BETWEEN '2023-01-01' AND '2023-11-30'
GROUP BY BL.Card_No
HAVING COUNT(BL.Book_id) > 0;


-- First, delete the book from BOOK_LENDING and BOOK_COPIES tables
DELETE FROM BOOK_LENDING WHERE Book_id = 'XYZ123';
DELETE FROM BOOK_COPIES WHERE Book_id = 'XYZ123';

-- Then, delete the book from BOOK_AUTHORS
DELETE FROM BOOK_AUTHORS WHERE Book_id = 'XYZ123';

-- Finally, delete the book from the BOOK table
DELETE FROM BOOK1 WHERE Book_id = 'XYZ123';

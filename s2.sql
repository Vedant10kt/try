-- Create the SALESMAN table
CREATE TABLE SALESMAN1 (
    Salesman_id INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50),
    Commission DECIMAL(10, 2)
);

-- Create the CUSTOMER table
CREATE TABLE CUSTOMER1 (
    Customer_id INT PRIMARY KEY,
    Cust_Name VARCHAR(50),
    City VARCHAR(50),
    Grade INT,
    Salesman_id INT,
    FOREIGN KEY (Salesman_id) REFERENCES SALESMAN1(Salesman_id)
);

-- Create the ORDERS table
CREATE TABLE ORDERS1 (
    Ord_No INT PRIMARY KEY,
    Purchase_Amt DECIMAL(10, 2),
    Ord_Date DATE,
    Customer_id INT,
    Salesman_id INT,
    FOREIGN KEY (Customer_id) REFERENCES CUSTOMER1(Customer_id),
    FOREIGN KEY (Salesman_id) REFERENCES SALESMAN1(Salesman_id)
);


-- Insert data into SALESMAN table
INSERT INTO SALESMAN1 (Salesman_id, Name, City, Commission)
VALUES
    (1001, 'John Smith', 'New York', 0.10),
    (1002, 'Jane Doe', 'Los Angeles', 0.12),
    (1003, 'David Johnson', 'Chicago', 0.08);

-- Insert data into CUSTOMER table
INSERT INTO CUSTOMER1 (Customer_id, Cust_Name, City, Grade, Salesman_id)
VALUES
    (2001, 'ABC Corp', 'New York', 'A', 1001),
    (2002, 'XYZ Inc', 'Los Angeles', 'B', 1002),
    (2003, 'LMN Ltd', 'Chicago', 'C', 1003);

-- Insert data into ORDERS table
INSERT INTO ORDERS1 (Ord_No, Purchase_Amt, Ord_Date, Customer_id, Salesman_id)
VALUES
    (3001, 1000.00, '2023-09-15', 2001, 1001),
    (3002, 750.50, '2023-09-16', 2001, 1001),
    (3003, 500.25, '2023-09-17', 2002, 1002);


SELECT COUNT(*) AS Above_Average_Grades_Customers
FROM CUSTOMER1 C
WHERE C.Grade > (SELECT AVG(Grade) FROM CUSTOMER1 WHERE City = 'Bangalore');


SELECT S.Name AS Salesman_Name, S.Salesman_id, COUNT(*) AS Customer_Count
FROM SALESMAN1 S
JOIN CUSTOMER1 C ON S.Salesman_id = C.Salesman_id
GROUP BY S.Salesman_id, S.Name
HAVING COUNT(*) > 1;

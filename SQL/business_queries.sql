/*
Business Queries
Salon Management Database

These queries demonstrate:
- Joins
- Aggregation
- CASE statements
- Subqueries
- Business reporting
*/

-- Show all customers and whether they hold a membership (quick lookup for business)
SELECT
    CustomerName AS 'Customer Name',
    TelNo AS 'Telephone Number',
    Email AS 'Email Address',
    CASE
        WHEN Membership.CustomerID IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS 'Member'
FROM Customer
LEFT JOIN Membership
ON Customer.CustomerID = Membership.CustomerID;

-- Find the customer with the highest number of bookings (find most loyal customer)
SELECT
    CustomerName AS 'Customer Name',
    TelNo AS 'Telephone Number',
    Email AS 'Email Address',
    COUNT(Booking.CustomerID) AS 'Total Visits'
FROM Customer
JOIN Booking
ON Customer.CustomerID = Booking.CustomerID
GROUP BY
    Customer.CustomerID,
    Customer.CustomerName,
    Customer.TelNo,
    Customer.Email
ORDER BY COUNT(Booking.CustomerID) DESC
LIMIT 1;

-- Find the customer who has spent the most money (to 2 d.p.; units £)
SELECT
    CustomerName AS 'Customer Name',
    SUM(Treatment.TreatmentCost) AS 'Total Amount Spent'
FROM Customer
JOIN Booking
ON Customer.CustomerID = Booking.CustomerID
JOIN Treatment
ON Booking.SpaTreatmentID = Treatment.SpaTreatmentID
GROUP BY
    Customer.CustomerID,
    Customer.CustomerName
ORDER BY 
  ROUND(SUM(Treatment.TreatmentCost), 2) DESC
LIMIT 1;

-- Compare customer spending under different membership plans
SELECT
    CustomerName AS 'Customer Name',
    SUM(Treatment.TreatmentCost) AS 'Current Spend',
    ROUND((SUM(Treatment.TreatmentCost) * 0.95) + 5, 2) AS 'Total Amount Spent (Bronze)',
    ROUND((SUM(Treatment.TreatmentCost) * 0.80) + 10, 2) AS 'Total Amount Spent (Silver)',
    ROUND((SUM(Treatment.TreatmentCost) * 0.75) + 15, 2) AS 'Total Amount Spent (Gold)'
FROM Customer
JOIN Booking
ON Customer.CustomerID = Booking.CustomerID
JOIN Treatment
ON Booking.SpaTreatmentID = Treatment.SpaTreatmentID
WHERE Customer.CustomerID NOT IN
(
    SELECT CustomerID
    FROM Membership
)
GROUP BY
    Customer.CustomerID,
    Customer.CustomerName;

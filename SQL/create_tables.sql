/*
Salon Management Database
Database schema for managing:
- Customers
- Memberships
- Treatments
- Bookings

Skills demonstrated:
- Database Design
- SQL
- Primary Keys
- Foreign Keys
- Relational Databases
*/

-- creates customer data table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    TelNo VARCHAR(15) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

-- creates membership data table
CREATE TABLE Membership (
    CustomerID INT PRIMARY KEY NOT NULL,
    MembershipLevel VARCHAR(20) NOT NULL,
    MembershipFee DECIMAL(10,2) NOT NULL,
    MembershipStartDate DATE NOT NULL,
    FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID)
);

--created treatment data table
CREATE TABLE Treatment (
    SpaTreatmentID VARCHAR(20) PRIMARY KEY NOT NULL,
    SpaCategory VARCHAR(50) NOT NULL,
    Description VARCHAR(255) NOT NULL,
    TreatmentTime TIME NOT NULL,
    TreatmentCost DECIMAL(10,2) NOT NULL
);

-- creates booking data table
CREATE TABLE Booking (
    CustomerID INT NOT NULL,
    SpaTreatmentID VARCHAR(20) NOT NULL,
    BookingDate DATE NOT NULL,
    BookingTime TIME NOT NULL,

    PRIMARY KEY (
        CustomerID,
        SpaTreatmentID,
        BookingDate
    ),

    FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID),

    FOREIGN KEY (SpaTreatmentID)
        REFERENCES Treatment(SpaTreatmentID)
);

-- created lookup table
CREATE TABLE Lookup (
    MembershipLevel VARCHAR(20) PRIMARY KEY,
    CostAdjustment DECIMAL(10,2),
    MembershipFee DECIMAL(10,2)
);

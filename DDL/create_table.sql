CREATE TABLE Department_Info (
    Department VARCHAR(50) PRIMARY KEY,
    Staff_count INT NOT NULL CHECK (Staff_count >= 0)
);


CREATE TABLE Supervisor (
    Supervisor_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Shift_time VARCHAR(20) NOT NULL CHECK (Shift_time IN ('morning', 'evening', 'night')),
    Salary DECIMAL(10,2) NOT NULL CHECK (Salary >= 0),
    FOREIGN KEY (Department) REFERENCES Department_Info(Department)
);


CREATE TABLE Equipment_Info (
    Equipment_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Type VARCHAR(50) NOT NULL CHECK (Type IN ('machine', 'tool', 'sensor', 'vehicle', 'irrigation')),
    Purchased_Date DATE NOT NULL
);


CREATE TABLE Gardening_Staff_Info (
    Staff_ID INT PRIMARY KEY,
    Supervisor_ID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    FOREIGN KEY (Supervisor_ID) REFERENCES Supervisor(Supervisor_ID)
);



CREATE TABLE Equipment_Assignment (
    Equipment_ID INT NOT NULL,
    Supervisor_ID INT NOT NULL,
    Staff_ID INT NOT NULL,
    PRIMARY KEY (Equipment_ID, Supervisor_ID, Staff_ID),
    FOREIGN KEY (Equipment_ID) REFERENCES Equipment_Info(Equipment_ID),
    FOREIGN KEY (Supervisor_ID) REFERENCES Supervisor(Supervisor_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Gardening_Staff_Info(Staff_ID)
);


CREATE TABLE Equipment_Maintenance (
    Maintenance_ID INT PRIMARY KEY,
    Equipment_ID INT NOT NULL,
    Condition_State VARCHAR(20) NOT NULL CHECK (Condition_State IN ('Good', 'Fair', 'Poor', 'Needs Repair', 'Out of Service', 'Under Maintenance')),
    uses_frequency VARCHAR(15) NOT NULL CHECK (uses_frequency IN ('Daily', 'Weekly', 'Monthly', 'Quarterly', 'Rarely')),
    Maintenance_cost DECIMAL(10,2) NOT NULL CHECK (Maintenance_cost >= 0),
    Last_maintanance_Date DATE NOT NULL,
    FOREIGN KEY (Equipment_ID) REFERENCES Equipment_Info(Equipment_ID)
);



CREATE TABLE Duty_Info (
    Duty_Type VARCHAR(50) PRIMARY KEY,
    Shift_Time VARCHAR(20) NOT NULL CHECK (Shift_Time IN ('morning', 'evening', 'night'))
);



CREATE TABLE Gardening_Staff_Duty (
    Staff_ID INT NOT NULL,
    Duty_Type VARCHAR(50) NOT NULL,
    Assigned_Area VARCHAR(50) NOT NULL CHECK (Assigned_Area IN (
        'Lecture Theatre area',
        'CEP Area',
        'Administrative Block area',
        'Lab Area',
        'Sports Complex area',
        'Cafeteria Zone',
        'Hor-Men (Old) area',
        'Hor-Men (New) Area',
        'Hor_women Area',
        'Library Complex',
        'Lotus Point Area',
        'Main Gate Area',
        'Parking Area',
        'Faculty Quarters',
        'Guest House',
        'Medical Center',
        'Garden Area',
        'Main Road',
        'Internal Roads',
        'Boundary Wall Area',
        'Security Post Area',
        'Recreation Area',
        'Open Lawn',
        'Tree Plantation Zone',
        'Flower Garden',
        'Vegetable Garden',
        'Greenhouse Area',
        'Compost Area'
    )),
    Shift_Time VARCHAR(20) NOT NULL CHECK (Shift_Time IN ('morning', 'evening', 'night')),
    PRIMARY KEY (Staff_ID, Duty_Type, Assigned_Area),
    FOREIGN KEY (Staff_ID) REFERENCES Gardening_Staff_Info(Staff_ID),
    FOREIGN KEY (Duty_Type) REFERENCES Duty_Info(Duty_Type)
);



CREATE TABLE Inspects_campus_boundary (
    Boundary_ID INT PRIMARY KEY,
    Supervisor_ID INT NOT NULL,
    Condition_State VARCHAR(20) NOT NULL CHECK (Condition_State IN ('Excellent', 'Good', 'Fair', 'Poor', 'Needs Trimming', 'Overgrown', 'Sparse Coverage', 'Damaged', 'Diseased', 'Requires Replanting')),
    Last_inspection_Date DATE NOT NULL,
    FOREIGN KEY (Supervisor_ID) REFERENCES Supervisor(Supervisor_ID)
);




CREATE TABLE Fertilizer (
    Fertilizer_Name VARCHAR(50) PRIMARY KEY,
    Manager_ID INT NOT NULL,
    Quantity DECIMAL(10,2) NOT NULL CHECK (Quantity >= 0),
    Selling_Quantity DECIMAL(10,2) NOT NULL CHECK (Selling_Quantity >= 0),
    Selling_price DECIMAL(10,2) NOT NULL CHECK (Selling_price >= 0),
    Expiry_Date DATE NOT NULL,
    FOREIGN KEY (Manager_ID) REFERENCES Sales_Manager(Manager_ID),
    CHECK (Quantity >= Selling_Quantity)
);



CREATE TABLE Gardening_Staff_Fertilizer (
    Staff_ID INTEGER NOT NULL REFERENCES Gardening_Staff_Info(Staff_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    Fertilizer_Name TEXT NOT NULL REFERENCES Fertilizer(Fertilizer_Name)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    PRIMARY KEY (Staff_ID, Fertilizer_Name)
);




CREATE TABLE Sales_Manager (
    Manager_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE CHECK
(Email LIKE '%@dau.ac.in'));




CREATE TABLE Tree_Species (
    Common_Name VARCHAR(100) PRIMARY KEY,
    Botanical_Name VARCHAR(150) NOT NULL,
    Water_Req VARCHAR(20) CHECK (Water_Req IN ('Low', 'Medium', 'High')),
    Fertilizer_Name VARCHAR(50),
    FOREIGN KEY (Fertilizer_Name) REFERENCES Fertilizer(Fertilizer_Name)
);



CREATE TABLE Tree (
    Tree_ID INT PRIMARY KEY,
    Staff_ID INT,
    Common_Name VARCHAR(100),
    Age INT,
    Height DECIMAL(5,2),
    Planting_Date DATE,
    Pruning_Required BOOLEAN,
    FOREIGN KEY (Staff_ID) REFERENCES Gardening_Staff_Info(Staff_ID),
    FOREIGN KEY (Common_Name) REFERENCES Tree_Species(Common_Name)
);



CREATE TABLE Flower_Type (
    Type VARCHAR(50) PRIMARY KEY,
    Shelf_Life INT,
    Selling_Price DECIMAL(8,2)
);



CREATE TABLE Flowers (
    Flower_Name VARCHAR(100) PRIMARY KEY,
    Gardening_Staff INT,
    Manager_ID INT,
    Type VARCHAR(50),
    Colour VARCHAR(30),
    Fragrance VARCHAR(20) CHECK (Fragrance IN ('Strong', 'Mild', 'None')),
    Quantity INT,
    FOREIGN KEY (Gardening_Staff) REFERENCES Gardening_Staff_Info(Staff_ID),
    FOREIGN KEY (Manager_ID) REFERENCES Sales_Manager(Manager_ID),
    FOREIGN KEY (Type) REFERENCES Flower_Type(Type)
);




CREATE TABLE Sales_Header (
    Transaction_ID INT PRIMARY KEY,
    Date DATE,
    Customer_ID INT,
    Manager_ID INT,
    Total_Amount DECIMAL(10,2),
    Payment_Method VARCHAR(20) CHECK (Payment_Method IN ('Cash', 'Card', 'UPI', 'Net Banking')),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Manager_ID) REFERENCES Sales_Manager(Manager_ID)
);




CREATE TABLE Sales_Details (
    Transaction_ID INT PRIMARY KEY,
    Item_Type VARCHAR(20) NOT NULL CHECK (Item_Type IN ('Fertilizer', 'Flower', 'Both')),
    Fertilizer_Name VARCHAR(50),
    Flower_Name VARCHAR(100),
    Quantity_Sold INT NOT NULL CHECK (Quantity_Sold >= 0),
    FOREIGN KEY (Transaction_ID) REFERENCES Sales_Header(Transaction_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Fertilizer_Name) REFERENCES Fertilizer(Fertilizer_Name),
    FOREIGN KEY (Flower_Name) REFERENCES Flowers(Flower_Name),
    CHECK (
        (Item_Type = 'Fertilizer' AND Fertilizer_Name IS NOT NULL AND Flower_Name IS NULL) OR
        (Item_Type = 'Flower' AND Flower_Name IS NOT NULL AND Fertilizer_Name IS NULL) OR
        (Item_Type = 'Both' AND Fertilizer_Name IS NOT NULL AND Flower_Name IS NOT NULL)
    )
);




CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE,
    Registered_Date DATE,
    Last_Purchased_Date DATE,
    City VARCHAR(50)
);




CREATE TABLE Customer_Phone (
    Customer_ID INTEGER NOT NULL REFERENCES Customer(Customer_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    Phone_No TEXT NOT NULL,
    PRIMARY KEY (Customer_ID, Phone_No),
    CHECK (Phone_No ~ '^\d{11}$')  -- ensures 10-digit phone numbers
);




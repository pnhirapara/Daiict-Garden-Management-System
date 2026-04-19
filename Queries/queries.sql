-- =============================================== --
-- SQL Query Set for DAIICT GREEN CAMPUS MANAGEMENT --       
-- =============================================== --


-- 1. Find the Supervisor ID and Name of all supervisors working in the Gardening department.
SELECT Supervisor_ID, Name  
FROM Supervisor   
WHERE Department = 'Gardening';

-- 2. Retrieve all equipment purchased before 2021, sorted by latest purchase date first.
SELECT *  
FROM Equipment_Info  
WHERE EXTRACT(YEAR FROM Purchased_Date) < 2021 
ORDER BY Purchased_Date DESC;

-- 3. Count how many pieces of equipment fall under each condition state.
SELECT Condition_State, COUNT(*) AS Total_Count 
FROM Equipment_Maintenance  
GROUP BY Condition_State; 

-- 4. Get details of all gardening staff who are supervised by Supervisor ID 7.
SELECT *  
FROM Gardening_Staff_Info  
WHERE Supervisor_ID = 7;

-- 5. List all trees sorted by age in descending order (oldest first).
SELECT * 
FROM Tree 
ORDER BY Age DESC;

-- 6. Find the total number of customers.
SELECT COUNT(*) AS Total_Customers 
FROM Customer;

-- 7. Calculate the average salary of all supervisors.
SELECT AVG(Salary) AS Average_Salary 
FROM Supervisor;

-- 8. Update the condition of equipment with Maintenance ID 10 to 'Good'.
UPDATE Equipment_Maintenance 
SET Condition_State = 'Good' 
WHERE Maintenance_ID = 10;

-- 9. Retrieve all fertilizers that are of type Organic.
SELECT * 
FROM Fertilizer 
WHERE type = 'Organic';

-- 10. Find fertilizers that will expire within the next 30 days.
SELECT Fertilizer_Name, Expiry_Date 
FROM Fertilizer 
WHERE Expiry_Date >= CURRENT_DATE 
  AND Expiry_Date <= (CURRENT_DATE + INTERVAL '30 days');

-- 11. Retrieve all sales managers whose names start with 'P'.
SELECT * 
FROM Sales_Manager 
WHERE Name LIKE 'P%';

-- 12. Display the common name and botanical name of all tree species.
SELECT Common_Name, Botanical_Name 
FROM Tree_Species;

-- 13. Find all sales transactions that occurred on 31 October 2025.
SELECT * 
FROM Sales_Header 
WHERE Date = '2025-10-31';

-- 14. Count how many duties each staff member has performed.
SELECT Staff_ID, COUNT(Duty_Type) AS Duty_Count 
FROM Gardening_Staff_Duty 
GROUP BY Staff_ID

-- 15. Retrieve all flowers with quantity greater than 130.
SELECT * 
FROM Flowers 
WHERE Quantity > 130;

-- 16. Increase the selling price of all flower types by 5%.
UPDATE Flower_Type 
SET Selling_Price = Selling_Price * 1.05;

-- 17. Find all equipment that needs repair.
SELECT * 
FROM Equipment_Maintenance 
WHERE Condition_State = 'Needs Repair';

-- 18. Add a new duty 'Pest Control' for the Morning shift.
INSERT INTO Duty_Info (Duty_Type, Shift_Time) 
VALUES ('Pest Control', 'Morning');

-- 19. Retrieve all customers who live in Ahmedabad.
SELECT * 
FROM Customer 
WHERE City = 'Ahmedabad';

-- 20. Find all equipment purchased before 1 Jan 2024.
SELECT * FROM Equipment_Info 
WHERE Purchased_Date < '2024-01-01';

-- 21. Update the city of customer with ID 5 to Surat.
UPDATE Customer 
SET City = 'Surat' 
WHERE Customer_ID = 5;

-- 22. Set the quantity of Rose flowers to 150.
UPDATE Flowers 
SET Quantity = 150 
WHERE Flower_Name = 'Rose';

-- 23. List each staff member along with their duty type and supervisor name, ordered by duty.
SELECT g.Name AS Staff_Name, gd.Duty_Type, s.Name AS Supervisor_Name
FROM Gardening_Staff_Info g
JOIN Gardening_Staff_Duty gd ON g.Staff_ID = gd.Staff_ID
JOIN Supervisor s ON g.Supervisor_ID = s.Supervisor_ID
ORDER BY gd.duty_type

-- 24. → Find staff working under supervisors in the Gardening department.
SELECT gs.Staff_ID,gs.Name,s.Supervisor_ID 
FROM Gardening_Staff_Info gs 
JOIN Supervisor s ON gs.Supervisor_ID = s.Supervisor_ID 
WHERE s.Department = 'Gardening' 
ORDER BY gs.Supervisor_ID; 

-- 25. Retrieve equipment that is used daily.
SELECT e.Equipment_ID,e.Name 
FROM Equipment_Info e 
JOIN Equipment_Maintenance em ON e.Equipment_ID = em.Equipment_ID 
WHERE em.uses_frequency = 'Daily';


-- 26. Find customers who have purchased the flower 'Mogro'.
SELECT * FROM Customer
WHERE Customer_ID IN (
  SELECT sh.Customer_ID
  FROM Sales_Header sh
  JOIN Sales_Details sd ON sh.Transaction_ID = sd.Transaction_ID
  WHERE sd.Flower_Name = 'Mogro'
);

-- 27. Calculate total sales revenue handled by each manager.
SELECT sm.Manager_ID, sm.Name, SUM(sh.Total_Amount) AS Total_Sales_Revenue
FROM Sales_Manager sm
JOIN Sales_Header sh ON sm.Manager_ID = sh.Manager_ID
GROUP BY sm.Manager_ID, sm.Name
ORDER BY Total_Sales_Revenue DESC;

-- 28. Find the top 3 customers based on total spending.
WITH CustomerSales AS (
  SELECT Customer_ID, SUM(Total_Amount) AS Total_Spent
  FROM Sales_Header
  GROUP BY Customer_ID
)
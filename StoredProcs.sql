/***

 Procedure - UpdateMedicationStockAndNotify

 Procedure which check the medication reorded is required

 based on the id and quantity

 */
 
DROP PROCEDURE IF EXISTS UpdateMedicationStockAndNotify;

 DELIMITER $$
 
CREATE PROCEDURE UpdateMedicationStockAndNotify (

     IN MedicationID INT,

     IN QuantityOrdered INT

 )

 BEGIN

     DECLARE CurrentStock INT;

     DECLARE ReorderLevel INT;

     DECLARE MedicationName VARCHAR(100);

 	DECLARE NewStock INT;

     -- Get the current stock quantity, reorder level, and medication name for the medication

     SELECT i.Quantity, i.ReorderLevel, m.MedicationName

     INTO CurrentStock, ReorderLevel, MedicationName

     FROM Inventory i

     JOIN Medications m ON i.InventoryID = m.MedicationID

     WHERE m.MedicationID = MedicationID;
 
    -- If the MedicationID is not found in the Inventory, return an error

     IF CurrentStock IS NULL OR ReorderLevel IS NULL THEN

         SELECT 'Error: Medication not found or missing quantity/reorder level.' AS result;

     END IF;
 
    -- Prevent updating to NULL in the case of invalid quantity or reorder level

     IF CurrentStock IS NULL THEN

         SET CurrentStock = 0; -- Set to 0 if the current stock is NULL

     END IF;

     IF ReorderLevel IS NULL THEN

         SET ReorderLevel = 0; -- Set to 0 if the reorder level is NULL

     END IF;
 
    -- Calculate new stock level

     SET NewStock = CurrentStock + QuantityOrdered;
 
    -- Check if the new stock is below the reorder level

     IF  ReorderLevel > NewStock THEN

         -- Notify that reorder is needed, and prevent updating the stock to NULL

         SELECT CONCAT('Reorder needed for ', MedicationName, '. The total stock after ordering would be ', NewStock, '. Current stock is ', CurrentStock) AS result;

     ELSE

         -- Update the stock only if the total stock is sufficient

         UPDATE Inventory

         SET Quantity = NewStock

         WHERE InventoryID = MedicationID;
 
        -- Notify that the stock is sufficient and has been updated

         SELECT CONCAT('Stock for ', MedicationName, ' is sufficient. The stock has been updated to ', NewStock) AS result;

     END IF;

 END $$
 
DELIMITER ;
 
 
SELECT * FROM Inventory;
 
CALL UpdateMedicationStockAndNotify(1, 10);

 CALL UpdateMedicationStockAndNotify(7, 10);
 
 
/**

 Procedure to Generate a Monthly Billing Report for a Department

 This procedure generates a report of the total billing for all patients treated by a department in the last month.

 **/

 DROP PROCEDURE IF EXISTS MonthlyBillingReport;

 DELIMITER $$
 
CREATE PROCEDURE MonthlyBillingReport (

     IN DepartmentID INT

 )

 BEGIN

     DECLARE TotalBilling DECIMAL(10,2);

     DECLARE MonthStart DATE;

     DECLARE MonthEnd DATE;
 
    -- Set the start and end date for the current month

     SET MonthStart = CURDATE() - INTERVAL (DAY(CURDATE()) - 1) DAY;

     SET MonthEnd = LAST_DAY(CURDATE());
 
    -- Calculate total billing for the department in the last month

     SELECT SUM(b.TotalAmount)

     INTO TotalBilling

     FROM Appointments a

     JOIN Billing b ON a.PatientID = b.PatientID

     JOIN Staff s ON a.StaffID = s.StaffID

     WHERE s.DepartmentID = DepartmentID

     AND a.AppointmentDateTime BETWEEN MonthStart AND MonthEnd

     AND b.PaymentStatus = 'Paid';
 
    -- Output the total billing amount along with the department name

     SELECT 

         d.DepartmentID,

         d.DepartmentName, 

         TotalBilling AS MonthlyTotalBilling

     FROM Departments d

     WHERE d.DepartmentID = DepartmentID;

 END $$
 
DELIMITER ;
 
CALL MonthlyBillingReport(5);
 
/**

 Procedure to Track and Notify Patients with Pending Bills

 This procedure checks for patients who have pending bills (i.e., where the payment status is "Pending") and notifies them.

 **/

 DROP PROCEDURE IF EXISTS NotifyPendingBills;

 DELIMITER $$
 
CREATE PROCEDURE NotifyPendingBills()

 BEGIN

     DECLARE done INT DEFAULT 0;

     DECLARE PatientID INT;

     DECLARE PatientName VARCHAR(100);

     DECLARE TotalAmount DECIMAL(10,2);
 
 
    -- Declare cursor for patients with pending bills

     DECLARE patient_cursor CURSOR FOR 

         SELECT p.PatientID, CONCAT(p.FirstName, ' ', p.LastName), SUM(b.TotalAmount)

         FROM Patients p

         JOIN Billing b ON p.PatientID = b.PatientID

         WHERE b.PaymentStatus = 'Pending'

         GROUP BY p.PatientID;

     -- Declare continue handler for cursor

     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

 	CREATE TEMPORARY TABLE result(

 		message VARCHAR(255)

     );

     -- Open the cursor

     OPEN patient_cursor;
 
    -- Loop through each patient with pending bills

     read_loop: LOOP

         FETCH patient_cursor INTO PatientID, PatientName, TotalAmount;

         IF done THEN

             LEAVE read_loop;

         END IF;
 
        -- Notify (print) patient about pending bills

         INSERT INTO result VALUES( CONCAT('Dear ', PatientName, ', your total pending bill is $', TotalAmount));
 
        -- In a real-world scenario, an email could be sent instead of this message.

     END LOOP;
 
    -- Close the cursor

     CLOSE patient_cursor;

     SELECT * FROM result;

 END $$
 
DELIMITER ;
 
CALL NotifyPendingBills();
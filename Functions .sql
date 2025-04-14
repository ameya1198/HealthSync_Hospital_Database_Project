-- procedure retrieves attendance details for all staff in a specified department within a given date range.
DELIMITER //
CREATE FUNCTION GetAttendanceCount(
    dept_id INT,
    start_date DATE,
    end_date DATE
) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE attendance_count INT;
    SELECT 
        COUNT(*) 
    INTO 
        attendance_count
    FROM 
        Attendance a
    INNER JOIN 
        Staff s 
        ON a.StaffID = s.StaffID
    WHERE 
        s.DepartmentID = dept_id
        AND a.Date BETWEEN start_date AND end_date;
    RETURN attendance_count;
END //
DELIMITER ;

SELECT GetAttendanceCount(10, '2024-10-01', '2024-10-31');

select * from attendance




-- get outstanding bill
DELIMITER $$
 
CREATE FUNCTION CalculateOutstandingBill(patient_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE outstanding_amount DECIMAL(10,2) DEFAULT 0;
    -- Calculate the total outstanding amount for the patient based on the unpaid bill details
    SELECT SUM(CASE 
                WHEN PaymentStatus != 'Paid' THEN PatientResponsibility + InsuranceClaim 
                ELSE 0 
                END)
    INTO outstanding_amount
    FROM Billing
    WHERE PatientID = patient_id;
    -- Return the total outstanding amount
    RETURN outstanding_amount;
END $$
 
DELIMITER ;

SELECT CalculateOutstandingBill(5);



DELIMITER //
CREATE FUNCTION GetLabTestCostForPatient(patient_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_cost DECIMAL(10,2);

    SELECT SUM(lt.Cost)
    INTO total_cost
    FROM LabOrderHistory loh
    JOIN LabTests lt ON loh.TestID = lt.TestID
    WHERE loh.PatientID = patient_id;

    RETURN IFNULL(total_cost, 0.00);
END //
DELIMITER ;


SELECT GetLabTestCostForPatient(7) AS TotalLabTestCost;


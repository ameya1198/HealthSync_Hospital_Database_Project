/**
Triggers
*/
-- trigger creates an audit record whenever a staff member’s role or department changes.
	CREATE TABLE StaffAudit (
		AuditID INT PRIMARY KEY AUTO_INCREMENT,
		StaffID INT,
		ChangeType VARCHAR(20),
		OldValue VARCHAR(50),
		NewValue VARCHAR(50),
		ChangeDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);
 
	DELIMITER //
	CREATE TRIGGER LogStaffRoleDeptChange
	AFTER UPDATE ON Staff
	FOR EACH ROW
	BEGIN
		IF OLD.RoleID <> NEW.RoleID THEN
			INSERT INTO StaffAudit (StaffID, ChangeType, OldValue, NewValue)
			VALUES (NEW.StaffID, 'Role Change', OLD.RoleID, NEW.RoleID);
		END IF;
		IF OLD.DepartmentID <> NEW.DepartmentID THEN
			INSERT INTO StaffAudit (StaffID, ChangeType, OldValue, NewValue)
			VALUES (NEW.StaffID, 'Department Change', OLD.DepartmentID, NEW.DepartmentID);
		END IF;
	END //
	DELIMITER ;
 
	UPDATE Staff
	SET DepartmentID = 3
	WHERE StaffID = 1;
 
	SELECT * FROM StaffAudit;
SELECT * FROM Appointments;
SELECT * FROM Staff;
--  Trigger to Restrict Deleting Staff if They Have Active Appointments
DROP TRIGGER RestrictStaffDeletion;
DELIMITER //
CREATE TRIGGER RestrictStaffDeletion
BEFORE DELETE ON Staff
FOR EACH ROW
BEGIN
DECLARE active_appointments INT;
SELECT COUNT(*) INTO active_appointments
FROM Appointments
WHERE StaffID = OLD.StaffID AND Status = 'Scheduled';
IF active_appointments > 0 THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete a staff member with Scheduled appointments.';
END IF;
END //
DELIMITER ;

DELETE from Staff
WHERE staffid=1;
SELECT * FROM Billing;
-- Automatically Update PaymentStatus Based on Payment Amount
DROP TRIGGER UpdatePaymentStatusBeforeUpdate;
DELIMITER $$

CREATE TRIGGER UpdatePaymentStatusBeforeUpdate
BEFORE UPDATE ON Billing
FOR EACH ROW
BEGIN
    -- If the payment has been made in full (InsuranceClaim + PatientResponsibility = TotalAmount)
    IF (NEW.InsuranceClaim + NEW.PatientResponsibility) >= NEW.TotalAmount THEN
        SET NEW.PaymentStatus = 'Paid';
    -- If the payment is partial
    ELSEIF (NEW.InsuranceClaim + NEW.PatientResponsibility) > 0 THEN
        SET NEW.PaymentStatus = 'Partial';
    -- If no payment has been made yet (InsuranceClaim + PatientResponsibility = 0)
    ELSE
        SET NEW.PaymentStatus = 'Pending';
    END IF;
END $$
 
DELIMITER ;
 
 
UPDATE Billing
SET InsuranceClaim = 1000.00
WHERE BillingID = 1;

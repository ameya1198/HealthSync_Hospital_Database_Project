/**
	Complex Queries
**/
 

/**
1. Average Duration of patient admitted in hospital, sorted Department wise
   Joins Table Departments,PatientAdmissions and AdmissionStaff 
*/

SELECT d.DepartmentName, AVG(DATEDIFF(pa.DischargeDateTime, pa.AdmissionDateTime)) AS AvgStayDuration
FROM Departments d
JOIN Staff s ON d.DepartmentID = s.DepartmentID
JOIN AdmissionStaff ads ON s.StaffID = ads.StaffID
JOIN PatientAdmissions pa ON ads.AdmissionID = pa.AdmissionID
WHERE pa.DischargeDateTime IS NOT NULL
GROUP BY d.DepartmentName
ORDER BY AvgStayDuration DESC;

/**
 2.Find the staff  working in each ward with their roles
**/

SELECT 
    DISTINCT(s.StaffID),
    CONCAT(s.FirstName,' ',s.LastName) AS StaffName,
    r1.RoleName AS StaffRole,
	w.WardID,
    w.WardName
FROM 
    Wards w
JOIN 
    Rooms rm ON w.WardID = rm.WardID
JOIN 
    Beds b ON rm.RoomID = b.RoomID
JOIN 
    PatientAdmissions pa ON b.BedID = pa.BedID
JOIN 
    AdmissionStaff asf ON pa.AdmissionID = asf.AdmissionID
JOIN 
    Staff s ON asf.StaffID = s.StaffID
JOIN 
    Roles r1 ON s.RoleID = r1.RoleID
ORDER BY 
    w.WardName, StaffName;


/***
3. Satff Performance Matrix
staff information, their leave details, shift attendance, and revenue generation (from billing)
Joins table Staff,Roles,Departments,Leaves,Attendance,AdmissionStaff,PatientAdmissions and Billing
**/


SELECT 
    s.StaffID,
    CONCAT(s.FirstName,' ', s.LastName) AS name,
    r.RoleName,
    d.DepartmentName,
    l.LeaveType,
    l.Status AS LeaveStatus,
    l.StartDate AS LeaveStartDate,
    l.EndDate AS LeaveEndDate,
    a.Shift AS AttendanceShift,
    a.Date AS AttendanceDate,
    a.TimeIn,
    a.TimeOut,
    b.TotalAmount AS RevenueGenerated,
    b.PatientResponsibility AS RevenuePatientResponsibility,
    b.InsuranceClaim AS RevenueInsuranceClaim
FROM 
    Staff s
LEFT JOIN 
    Roles r ON s.RoleID = r.RoleID
LEFT JOIN 
    Departments d ON s.DepartmentID = d.DepartmentID
LEFT JOIN 
    Leaves l ON s.StaffID = l.StaffID
LEFT JOIN 
    Attendance a ON s.StaffID = a.StaffID
LEFT JOIN 
    AdmissionStaff asf ON s.StaffID = asf.StaffID -- Join with AdmissionStaff to get related admissions
LEFT JOIN 
    PatientAdmissions pa ON asf.AdmissionID = pa.AdmissionID -- Link to PatientAdmissions using AdmissionID
LEFT JOIN 
    Billing b ON pa.AdmissionID = b.AdmissionID
WHERE 
    -- Filter based on staff who have leaves, attended shifts, or generated revenue
    (l.Status IN ('Pending', 'Approved') OR a.Date IS NOT NULL OR b.BillingID IS NOT NULL)
ORDER BY 
    s.StaffID, a.Date DESC, l.StartDate DESC
LIMIT 0, 1000;


/*
4.Department Performance Matrix
query that retrieves department-wise information,
Joins Table Departments,DepartmenHeads,Staff,PatientAdmissions,Billing
**/


SELECT 
    d.DepartmentID,
    d.DepartmentName,
    d.Description AS DepartmentDescription,
    dh.StaffID AS DepartmentHeadStaffID,
    CONCAT(s.FirstName, ' ', s.LastName) AS DepartmentHeadName,
    COUNT(st.StaffID) AS StaffCount,
    COUNT(pa.AdmissionID) AS PatientAdmissions,
    SUM(b.TotalAmount) AS TotalRevenueGenerated,
    SUM(b.PatientResponsibility) AS TotalPatientResponsibility,
    SUM(b.InsuranceClaim) AS TotalInsuranceClaim
FROM 
    Departments d
LEFT JOIN 
    DepartmenHeads dh ON d.DepartmentID = dh.DepartmentID
LEFT JOIN 
    Staff s ON dh.StaffID = s.StaffID
LEFT JOIN 
    Staff st ON st.DepartmentID = d.DepartmentID
LEFT JOIN 
    PatientAdmissions pa ON pa.BedID IN (SELECT BedID FROM Beds WHERE RoomID IN (SELECT RoomID FROM Rooms WHERE WardID IN (SELECT WardID FROM Wards WHERE DepartmentID = d.DepartmentID)))
LEFT JOIN 
    Billing b ON pa.AdmissionID = b.AdmissionID
GROUP BY 
    d.DepartmentID, d.DepartmentName, d.Description, dh.StaffID, s.FirstName, s.LastName
ORDER BY 
    d.DepartmentName;


/**
5.Pharmacy Inventory history
query will output a list where each row represents a medication or item in the inventory along with the related pharmacy orders placed for that item,
including the quantity ordered, order status, and related comments
*/

SELECT 
    i.InventoryID,
    i.ItemName AS InventoryItemName,
    i.ItemType AS InventoryItemType,
    i.Quantity AS InventoryStockQuantity,
    i.UnitPrice AS InventoryUnitPrice,
    i.ExpirationDate AS InventoryExpirationDate,
    i.Supplier AS InventorySupplier,
    i.ReorderLevel AS InventoryReorderLevel,
    poh.OrderHistoryID,
    poh.PatientID,
    poh.StaffID,
    poh.OrderDate,
    poh.Status AS OrderStatus,
    poh.MedicationID,
    m.MedicationName AS MedicationName,
    poh.Quantity AS OrderQuantity,
    poh.OrderComments
FROM 
    Inventory i
LEFT JOIN 
    PharmacyOrderHistory poh ON i.InventoryID = poh.MedicationID
LEFT JOIN 
    Medications m ON poh.MedicationID = m.MedicationID
ORDER BY 
    poh.OrderDate DESC, i.ItemName;


/**
6.Frquent patients
Retrieve the patients who visit frequently, the total amount they've spent on medications,
the departments they've been treated in, and the doctors and staff who provided their care.
*/

SELECT
    p.PatientID,
    p.FirstName,
    p.LastName,
    COUNT(a.AdmissionID) AS VisitCount,
    SUM(b.TotalAmount) AS TotalMedicationCost,
    GROUP_CONCAT(DISTINCT d.DepartmentName) AS DepartmentsVisited,
    GROUP_CONCAT(DISTINCT CONCAT(s.FirstName, ' ', s.LastName)) AS TreatingDoctors
FROM
    Patients p
JOIN
    PatientAdmissions a ON p.PatientID = a.PatientID
JOIN
    Billing b ON p.PatientID = b.PatientID
JOIN
    Staff s ON s.StaffID = a.BedID
JOIN
    Wards w ON w.WardID = a.BedID
JOIN
    Departments d ON d.DepartmentID = w.DepartmentID
GROUP BY
    p.PatientID
ORDER BY
    VisitCount DESC;
    
    

/**
 7.Billing Info
 Get Patient Billing Information with Insurance and Payment Status History,
 Joining Tables Patients,Billing,PatientInsurance,BillingHistory and Staff
*/

SELECT 
    p.PatientID,
    p.FirstName AS PatientFirstName,
    p.LastName AS PatientLastName,
    p.DateOfBirth AS PatientDOB,
    b.BillingID,
    b.BillingDate,
    b.TotalAmount,
    b.PaymentStatus AS CurrentPaymentStatus,
    b.InsuranceClaim,
    b.PatientResponsibility,
    pi.InsuranceProvider,
    pi.PolicyNumber,
    pi.ExpirationDate AS InsuranceExpirationDate,
    bh.ChangeDateTime AS BillingStatusChangeDate,
    bh.PreviousPaymentStatus,
    bh.NewPaymentStatus,
    bh.PreviousInsuranceClaim,
    bh.NewInsuranceClaim,
    bh.PreviousPatientResponsibility,
    bh.NewPatientResponsibility,
    s.FirstName AS StaffFirstName,
    s.LastName AS StaffLastName,
    bh.Comments AS BillingStatusChangeComments
FROM 
    Patients p
JOIN 
    Billing b ON p.PatientID = b.PatientID
JOIN 
    PatientInsurance pi ON p.PatientID = pi.PatientID
JOIN 
    BillingHistory bh ON b.BillingID = bh.BillingID
JOIN 
    Staff s ON bh.ChangedBy = s.StaffID
ORDER BY 
    bh.ChangeDateTime DESC;

/**
8. Lab Order History
Get All Lab Orders , Patient with Test Results and Staff Information
Joining Table Patients,LabOrderHistory,LabTests
*/

SELECT 
    p.PatientID,
    p.FirstName AS PatientFirstName,
    p.LastName AS PatientLastName,
    lo.LabOrderHistoryID,
    lo.OrderDate,
    lo.Status AS LabOrderStatus,
    lo.ResultDate,
    lo.ResultValue,
    lo.ReferenceRange,
    lo.OrderComments,
    lt.TestName AS TestName,
    lt.Description AS Description,
    s.FirstName AS StaffFirstName,
    s.LastName AS StaffLastName
FROM 
    Patients p
JOIN 
    LabOrderHistory lo ON p.PatientID = lo.PatientID
JOIN 
    LabTests lt ON lo.TestID = lt.TestID
JOIN 
    Staff s ON lo.StaffID = s.StaffID
ORDER BY 
    lo.OrderDate DESC;

/*
9. Rooms occupancy and Billing
Get Admission History for a Patient Along with Ward, Room Information and billing.
Joining Table Patients,PatientAdmissions,Billing,Beds,Rooms and Wards
*/

SELECT 
    p.PatientID,
    p.FirstName AS PatientFirstName,
    p.LastName AS PatientLastName,
    pa.AdmissionID,
    pa.AdmissionDateTime,
    pa.DischargeDateTime,
    pa.AdmissionReason,
    b.BillingID,
    b.BillingDate,
    b.TotalAmount,
    b.PaymentStatus,
    b.PatientResponsibility,
    r.RoomNumber,
    w.WardName,
    r.RoomType,
    r.Capacity AS RoomCapacity
FROM 
    Patients p
JOIN 
    PatientAdmissions pa ON p.PatientID = pa.PatientID
JOIN 
    Billing b ON pa.AdmissionID = b.AdmissionID
JOIN 
    Beds bed ON pa.BedID = bed.BedID  
JOIN 
    Rooms r ON bed.RoomID = r.RoomID  
JOIN 
    Wards w ON r.WardID = w.WardID
ORDER BY 
    pa.AdmissionDateTime DESC;


/**
	10. Hospitals Performance 
    Get complete operation report of hospital based on the patient visite,medication,labtest and Treatments
    Joins Table Patients,Appointments,MedicalRecords,Prescriptions,LabOrderHistory,PharmacyOrderHistory, and Staff
*/

SELECT 
    p.PatientID,
    CONCAT(p.FirstName,' ',p.LastName ) AS PatientName,
    a.AppointmentDateTime AS VisitDate,
    a.Purpose AS AppointmentPurpose,
    a.Status AS AppointmentStatus,
    mr.RecordDate AS MedicalRecordDate,
    mr.Diagnosis,
    mr.Treatment,
    pr.Dosage AS MedicationDosage,
    pr.Frequency AS MedicationFrequency,
    pr.StartDate AS MedicationStartDate,
    pr.EndDate AS MedicationEndDate,
    lo.OrderDate AS LabOrderDate,
    lo.Status AS LabOrderStatus,
    lo.ResultValue AS LabResult,
    lo.ResultDate AS LabResultDate,
    po.OrderDate AS PurchaseOrderDate,
    po.Status AS PurchaseStatus,
    po.Quantity AS MedicationPurchased,
    CONCAT(s.FirstName,' ',  s.LastName) AS TreatedBy
FROM 
    Patients p
LEFT JOIN 
    Appointments a ON p.PatientID = a.PatientID
LEFT JOIN 
    MedicalRecords mr ON p.PatientID = mr.PatientID
LEFT JOIN 
    Prescriptions pr ON p.PatientID = pr.PatientID
LEFT JOIN 
    LabOrderHistory lo ON p.PatientID = lo.PatientID
LEFT JOIN 
    PharmacyOrderHistory po ON p.PatientID = po.PatientID
LEFT JOIN 
    Staff s ON a.StaffID = s.StaffID  OR lo.StaffID = s.StaffID OR po.StaffID = s.StaffID
ORDER BY 
    VisitDate DESC;
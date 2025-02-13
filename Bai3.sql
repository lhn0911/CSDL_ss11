use session_11
-- 2
DELIMITER //
CREATE PROCEDURE GetCustomerByPhone(IN phone_Number varchar(255))
BEGIN
SELECT CustomerID, FullName, DateOfBirth,Address,Email
FROM Customers
WHERE phoneNumber = phone_Number;
END;
// DELIMITER ;
CALL GetCustomerByPhone('0901234567');
drop procedure GetCustomerByPhone

-- 3
DELIMITER //
CREATE PROCEDURE GetTotalBalance(IN Customer_ID int, OUT TotalBalance decimal(15,2))
BEGIN
SELECT sum(Balance) into TotalBalance
FROM Accounts
WHERE CustomerID = Customer_ID
GROUP BY CustomerID;
END;
// DELIMITER ;
CALL GetTotalBalance('1', @TotalBalance);
SELECT @TotalBalance AS TotalBalance;
drop PROCEDURE GetTotalBalance
-- 4
DELIMITER //
CREATE PROCEDURE IncreaseEmployeeSalary(IN Employee_ID int,out NewSalary int)
BEGIN
set NewSalary = 0;
SELECT Salary*1.1 into NewSalary
FROM employees
WHERE EmployeeID = Employee_ID;
END;
// DELIMITER ;
set @salary = 0;
call IncreaseEmployeeSalary(4,@salary);
select @salary ;
drop procedure IncreaseEmployeeSalary;
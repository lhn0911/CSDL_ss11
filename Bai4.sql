-- 2
DELIMITER //
CREATE PROCEDURE UpdateSalaryByID(IN EmployeeIDInput INT,INOUT SalaryInput DECIMAL(10,2))
BEGIN
    IF SalaryInput < 20000000 THEN
        SET SalaryInput = SalaryInput * 1.10;
    ELSE
        SET SalaryInput = SalaryInput * 1.05;
    END IF;
    
    UPDATE Employees
    SET Salary = SalaryInput
    WHERE EmployeeID = EmployeeIDInput;
END;
//DELIMITER ;
--
SET @Salary = 18000000;
CALL UpdateSalaryByID(4, @Salary);
SELECT @Salary AS NewSalary;
--
DROP PROCEDURE IF EXISTS UpdateSalaryByID;
-- 3
DELIMITER //
CREATE PROCEDURE GetLoanAmountByCustomerID(IN inputCustomerID INT,OUT TotalLoanAmount DECIMAL(15,2))
BEGIN
    SELECT COALESCE(SUM(LoanAmount), 0) INTO TotalLoanAmount
    FROM Loans
    WHERE CustomerID = inputCustomerID;
END;
//DELIMITER ;
--
SET @TotalLoan = 0;
CALL GetLoanAmountByCustomerID(1, @TotalLoan);
SELECT @TotalLoan AS LoanAmount;
--
DROP PROCEDURE IF EXISTS GetLoanAmountByCustomerID;
-- 4
DELIMITER //
CREATE PROCEDURE DeleteAccountIfLowBalance(IN inputAccountID INT)
BEGIN
    DECLARE balance_new DECIMAL(15,2);
    SELECT Balance INTO balance_new FROM Accounts WHERE AccountID = inputAccountID;
    IF balance_new < 1000000 THEN
        DELETE FROM Accounts WHERE AccountID = inputAccountID;
        SELECT 'Đã xóa tài khoản thành công' AS Message;
    ELSE
        SELECT 'Không thể xóa tài khoản' AS Message;
    END IF;
END;
//DELIMITER ;
--
CALL DeleteAccountIfLowBalance(8);
--
DROP PROCEDURE IF EXISTS DeleteAccountIfLowBalance;

-- 5
DELIMITER //
CREATE PROCEDURE TransferMoney(
    IN senderAccountID INT,
    IN receiverAccountID INT,
    INOUT transferAmount DECIMAL(15,2)
)
BEGIN
    DECLARE senderBalance DECIMAL(15,2);
    SELECT Balance INTO senderBalance FROM Accounts WHERE AccountID = senderAccountID;
    IF senderBalance >= transferAmount THEN
        UPDATE Accounts SET Balance = Balance - transferAmount WHERE AccountID = senderAccountID;
        UPDATE Accounts SET Balance = Balance + transferAmount WHERE AccountID = receiverAccountID;
    ELSE
        SET transferAmount = 0;
    END IF;
END; 
//DELIMITER ;
--
SET @AmountToTransfer = 2000000;
CALL TransferMoney(1, 3, @AmountToTransfer);
SELECT @AmountToTransfer AS TransferredAmount;
--
DROP PROCEDURE IF EXISTS TransferMoney;

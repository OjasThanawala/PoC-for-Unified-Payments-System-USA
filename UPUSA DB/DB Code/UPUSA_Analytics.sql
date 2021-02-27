use upusa;

-- ------------------------------------------
-- Category-wise spending for a particular user
-- for any year
-- ------------------------------------------
DROP PROCEDURE IF EXISTS get_user_spending;
DELIMITER //
CREATE PROCEDURE get_user_spending
(
	user_name_param VARCHAR(255),
    year_param INT
)
BEGIN

SELECT service_type_name AS 'Category', (SUM(bill_amount) / (
	SELECT SUM(bill_amount)
    FROM upusa_user
	INNER JOIN bill_payments
	ON upusa_user.upusa_SSN = bill_payments.user_id
	AND upusa_user.full_name = user_name_param
    AND YEAR(bill_payments.bill_payment_due_dt) = year_param
)) * 100 AS 'Spending(%)'
FROM upusa_user
INNER JOIN bill_payments
	ON upusa_user.upusa_SSN = bill_payments.user_id
	AND upusa_user.full_name = user_name_param
    AND YEAR(bill_payments.bill_payment_due_dt) = year_param
GROUP BY bill_payments.service_type_name
ORDER BY `Spending(%)` DESC;
    
END //
DELIMITER ;
    
    
CALL get_user_spending('John Smith', 2019);

-- ------------------------------------------
-- Percentage of users spending in each category 
-- for any year irrespective of amount spent.
-- ------------------------------------------
DROP PROCEDURE IF EXISTS get_users_in_category;
DELIMITER //
CREATE PROCEDURE get_users_in_category
(
    year_param INT
)
BEGIN

SELECT service_type_name AS 'Category', (
	COUNT(CASE WHEN YEAR(bill_payment_due_dt) = year_param THEN user_id ELSE NULL END) / (
	SELECT COUNT(*)
    FROM upusa_user
)) * 100 AS 'Users(%)'
FROM bill_payments
GROUP BY bill_payments.service_type_name
ORDER BY `Users(%)` DESC;
    
END //
DELIMITER ;

CALL get_users_in_category(2019);

-- ------------------------------------------
-- Biller earnings month_wise for a particular
-- financial year. (If 2018 is supplied, results 
-- displayed will be for April, 2018 - March, 2019) 
-- ------------------------------------------
DROP PROCEDURE IF EXISTS biller_earnings;
DELIMITER //
CREATE PROCEDURE biller_earnings
(
    year_param INT
)
BEGIN

SELECT biller_entity.biller_entity_name AS 'biller', 
	MONTH(bill_payments.bill_payment_due_dt) AS 'month',
	SUM(bill_payments.bill_amount) AS 'total_sales'
FROM biller_entity
LEFT JOIN bill_payments
	ON biller_entity.biller_id = bill_payments.biller_id
	AND bill_payments.bill_payment_due_dt 
	 BETWEEN MAKEDATE(year_param, 91) AND MAKEDATE((year_param + 1), 60)
GROUP BY biller, month
ORDER BY month, total_sales DESC;
    
END //
DELIMITER ;

CALL biller_earnings(2019);
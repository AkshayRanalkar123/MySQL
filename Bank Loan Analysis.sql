use bankloan_sqlbi_db;
select * from bank_loan_data;

--Problem Statement--
--Dashboard 1: Summary--
--Q.1 Total loan application--

select count(id) as Total_applications from bank_loan_data;

--MTD total loan application--
select COUNT(id) as MTD_Loan_Application from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021;

--PMTD total loan application--
select COUNT(id) as PMTD_laon_application from bank_loan_data
where MONTH(issue_date) = 11 and year(issue_date) =2021;

--Q.2 Total Funded Amount--

select sum (loan_amount) as Total_Funded_Amount from bank_loan_data;

--MTD Funded Amount--
select SUM(loan_amount) as MTD_Total_Funded_Amount from bank_loan_data
where MONTH(issue_date) =12 and YEAR(issue_date) = 2021;

--PMTD Funded Amount--
select SUM(loan_amount) as PMTD_Total_Funded_Amount from bank_loan_data
where MONTH(issue_date)= 11 and YEAR(issue_date)= 2021;


-- Q.3 Total Amount Received--
select SUM(total_payment) as Total_Amount_received from bank_loan_data;

--MTD Funded Amount--
select SUM(total_payment) as MTD_Total_Amount_Received from bank_loan_data
where MONTH(issue_date)=12 and YEAR(issue_date)=2021;

--PMTD Funded Amount--
select SUM(total_payment) as PMTD_Total_Amount_Received from bank_loan_data
where MONTH(issue_date)=11 and YEAR(issue_date)= 2021;


--Q.4 Average Interst Rate--
select AVG(int_rate)*100 as Avg_Interest_rate from bank_loan_data;

-- if we want only two decimals--
select ROUND(AVG(int_rate), 4)*100 as Avg_Interest_rate from bank_loan_data;

--MTD Average Interest Rate--
select ROUND(avg(int_rate), 4)*100 as MTD_Avg_Int_Rate from bank_loan_data
where MONTH(issue_date) = 12 and YEAR(issue_date)= 2021;

--PMTD Average Interest Rate--
select ROUND(avg(int_rate), 4)*100 as PMTD_Avg_Interest_Rate from bank_loan_data
where MONTH(issue_date) = 11 and YEAR(issue_date)= 2021;


--Q.5 Average Debt-to-Income Ratio(DTI)--
select ROUND(avg(DTI), 4)* 100 as Avge_DTI from bank_loan_data;

--MTD Avg DTI--
select ROUND(avg(DTI), 4)*100 as MTD_Avg_DTI from bank_loan_data
where MONTH(issue_date)=12 and YEAR(issue_date)=2021;

--PMTD Avg DTI--
select ROUND(avg(DTI), 4)*100 as PMTD_Avg_DTI from bank_loan_data
where MONTH(issue_date)=11 and YEAR(issue_date)= 2021;

--DASHBOARD 1:SUMMARY--
-- Good Loan Vs Bad Loan --
--Good Loan--
--1. Good Loan Application Percentage --
select
	(COUNT(case when loan_status= 'Fully Paid' or loan_status= 'Current' then id end)*100)
	/
	COUNT(id)
	as Good_Loan_Application_Percentage
from
	bank_loan_data;

--2. Good Loan Applications--
select count(id) as Good_loan_application from bank_loan_data
where loan_status = 'Fully Paid' OR loan_status = 'Current';

--3. Good Loan Funded Amount--
select sum(loan_amount) as Good_Loan_Funded_Amount from bank_loan_data
where loan_status='Fully Paid' OR loan_status = 'Current';

--4.Good Loan Total Received Amount--
select sum(total_payment) as Good_loan_total_received_amount from bank_loan_data
where loan_status = 'Fully Paid' OR loan_status= 'Current';


-- BAD LAON --
--1. Bad Loan Application Percentage --
select
	(COUNT(case when loan_status= 'Charged Off' then id end)*100)
	/
	COUNT(id)
as Bad_loan_application_percentage
from bank_loan_data;

--2. Bad loan application--
select COUNT(id) as Bad_Loan_Applications from bank_loan_data
where loan_status= 'Charged Off';

--3. Bad Loan Funded Amount--
select sum(loan_amount) as Bad_loan_funded_amount from bank_loan_data
where loan_status= 'Charged Off';

--4. Bad Loan Received Amount--
select sum(total_payment) as Bad_Loan_Received_Amount from bank_loan_data
where loan_status= 'Charged Off';


-- Loan Status Grid View Report --
select
	Loan_status,
	COUNT(id) as Total_Loan_applications,
	SUM(loan_amount) as Total_Funded_amount,
	SUM(total_payment) as Total_Amount_receveied,
	AVG(int_rate)*100 as Interest_rate,
	AVG(dti)*100 as DTI
from
	bank_loan_data
group by
	loan_status;

--MTD Loan Status Report--
select
	loan_status,
	sum(loan_amount) as MTD_Total_Funded_Amount,
	sum(total_payment) as MTD_Total_amount_Received
	
from
	bank_loan_data
where
	MONTH(issue_date)= 12
group by
	loan_status;


--DASHBOARD 1:OVERVIEW--
-- CHARTS --
--1. Monthly Trends by issue Date--
select 
	MONTH(issue_date) as Month_No,
	DATENAME(month, issue_date) as Month,
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_received_amount
from bank_loan_data
group by MONTH(issue_date), DATENAME(month, issue_date)
order by Month(issue_date);

--2.Regional Analysis By State--
select
	address_state,
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_received_amount
from bank_loan_data
group by address_state
order by sum(loan_amount) desc;

--3. Loan Term Analysis--
select
	term,
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_received_amount
from bank_loan_data
group by term
order by term;

--4. Employee Length Analysis--
select
	emp_length,
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_received_amount
from bank_loan_data
group by emp_length
order by count(id) desc;

--5. Loan Purpose Breakdown--
select
	purpose,
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_received_amount
from bank_loan_data
group by purpose
order by count(id) desc;

--6. Home Ownership Analysis--
select
	home_ownership,
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_received_amount
from bank_loan_data
group by home_ownership
order by count(id) desc;

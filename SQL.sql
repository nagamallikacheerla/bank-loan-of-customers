use Bank_loan_project;
select * from finance_1;
select * from finance_2;
alter table finance_1 modify column `issue_d` Date ;
alter table finance_2 change `ï»¿id` id int ;
desc finance_1 ;
select count(*) from finance_1 ;
select count(*) from finance_2 ;

-- select str_to_date(`earliest_cr_line`, '%m/%d/%Y') from finance_2;
-- update finance_2 set `earliest_cr_line` = str_to_date(`earliest_cr_line`, '%m/%d/%Y');
-- alter table finance_2 modify column `earliest_cr_line` Date ;

-- select str_to_date(`last_pymnt_d`, '%m/%d/%Y %H:%i:%s') from finance_2;
-- update finance_2 set `last_pymnt_d` = str_to_date(`last_pymnt_d`,'%m/%d/%Y %H:%i:%s') where `last_pymnt_d` = '%m/%d/%Y';
-- alter table finance_2 modify column `last_pymnt_d` Date;

-- select str_to_date(`last_credit_pull_d`, '%m/%d/%Y') from finance_2;
-- update finance_2 set `last_credit_pull_d` = str_to_date(`last_credit_pull_d`, '%m/%d/%Y') where `last_credit_pull_d` = '%m/%d/%Y';
-- alter table finance_2 modify column `last_credit_pull_d` Date ;

##### KPI 1 (YEAR WISE LOAN AMOUNT STATS) #####

select year(`issue_d`), sum(loan_amnt) as Total_Loan_amnt from finance_1 
group by year(`issue_d`) 
order by year(`issue_d`) ;

##### KPI 2 (GRADE AND SUB GRADE WISE REVOL_BAL) #####

select grade, sub_grade,sum(revol_bal) as total_revol_bal
from finance_1 F1 inner join finance_2 F2 
on (F1.id = F2.id) 
group by grade,sub_grade
order by grade;

##### KPI 3 (Total Payment for Verified Status Vs Total Payment for Non Verified Status) #####

select verification_status, round(sum(total_pymnt),2) as Total_payment
from finance_1 F1 inner join finance_2 F2
on (F1.id = F2.id) 
where verification_status in('Verified', 'Not Verified')
group by verification_status;

##### KPI 4 (State wise and last_credit_pull_d wise loan status) #####

select addr_state, loan_status, str_to_date(`last_credit_pull_d`,'%d/%m/%Y')
from finance_1 F1 inner join finance_2 F2
on (F1.id = F2.id) 
group by addr_state, `last_credit_pull_d`,loan_status
order by addr_state;

##### KPI 5 (Home ownership Vs last payment date stats) #####

Select home_ownership, max(last_pymnt_d) as last_payment_date,sum(last_pymnt_amnt)
from finance_1 F1 join finance_2 F2
on(F1.id = F2.id)
group by home_ownership
order by home_ownership;


/* CURSOR EXAMPLE */

use sample;
select * from emp;

alter table emp add email varchar(255);

update emp set email='mno@gmail.com' where emp_id=4;
set sql_safe_updates=0;

delete from emp where emp_id=5;
insert into values
DELIMITER $$
create procedure modify_email(
inout email_list varchar(255)
)
begin
	declare done bool default false;
    declare email_address varchar(255) default " ";
    declare cur cursor for select email from emp;
    
    DECLARE CONTINUE handler
    FOR NOT FOUND set done =true;
    
    open cur;
    
    set email_list='';
    
    process_email : loop
		fetch cur into email_address;
        if done = true then 
			leave process_email;
		end if;
        
        set email_list = concat(email_address, " : ",email_list);
	end loop;
    
    close cur;
end $$
DELIMITER ;

call modify_email(@email_list);
select @email_list;
    
select * from empposition;
select * from emp;

-- --------------------------------------------------------
/* Find the total salary for a given department */
DELIMITER $$
CREATE procedure Find_Total_Sal(in dept varchar(255),out total int)
begin
	select sum(ep.salary) into total from emp e inner join empposition ep on
    e.emp_id=ep.empid where e.department=dept;
end$$
DELIMITER ;

call Find_Total_Sal('HR',@total);
select @total;





/* USING CURSOR */
DELIMITER $$
CREATE procedure Total_Sal(in dept varchar(255),out total varchar(255))
begin
	declare done bool default false;
    declare Tot_Salary int ;
    declare cur cursor for 
    select sum(ep.salary) from emp e inner join empposition ep on
    e.emp_id=ep.empid where e.department=dept;

    
    DECLARE CONTINUE handler
    FOR NOT FOUND set done =true;
    
    open cur;
    
    set Total=0;
    
    process_Salary : loop 
		fetch cur into Tot_Salary;
        set total= concat(dep,":",total);
        if done = true then 
			leave process_Salary;
		end if;
        
        
	end loop;
    
    close cur;
end $$
DELIMITER ;

call Total_Sal('HR',@total);
select @total;
-- ---------------------------------------------------------
DROP PROCEDURE IF EXISTS TS;
/* TO PRINT ALL DEPARTMENTS WITH TOTAL SALARY USING PROCEDURE */

DELIMITER $$
CREATE PROCEDURE TS()
BEGIN
	select e1.department as Dept, CONCAT('Total Salary= ',SUM(e2.salary)) as Salary from emp e1
    join empposition e2 on e1.emp_id=e2.empid group by e1.department;

END $$
DELIMITER ;

call TS();
create database date;
create table stu(
id int primary key,
name varchar(255),
dob date);

INSERT INTO stu VALUES
(1, 'Niki', '2002-01-18'),
(2, 'Anita', '2003-09-20'),
(3, 'Zynab', '2005-02-12'),
(4, 'Nikil', '2015-07-02');
select * from stu;
select id,name, date_format(dob, '%W %D %b %Y') as Birthday from stu;

select id,name, date_format(dob, '%W / %D %b %Y') as Birthday 
from stu order by dob desc;

select id,name, date_format(dob, '%d/%m/%Y %H:%i%p') as Birthday from stu;
select id,name, date_format(dob, '%a %D %b %Y %H:%i') as Birthday from stu;
select id,name, date_format(dob, '%a %D %b %Y %H:%i:%s') as Birthday from stu;
select id,name, date_format(dob, '%W %D %M %Y %H:%i') as Birthday from stu;
select id,name, date_format(dob, '%d-%b-%y') as Birthday from stu;
select id,name, date_format(dob, '%m-%d-%Y %H:%i') as Birthday from stu;

alter table stu  modify dob datetime;
update stu set dob='2002-01-18 11:20:05' where id=1;
update stu set dob='2003-09-20 20:12:15' where id=2;
update stu set dob='2005-02-12 24:00:00' where id=3;
update stu set dob='2015-07-02 12:00:05' where id=4;

insert into stu values (5,'Pankaj','2002-01-18 11:20:05');
update stu set dob='2007-02-18 12:00:05' where id=5;
select * from stu where date(dob)='2002-01-18';

select extract(day from '2002-01-18 11:20:05') day;
select extract(day_hour from '2002-01-18 11:20:05') day;
select extract(minute from '2002-01-18 11:20:05') day;
select extract(month from '2002-01-18 11:20:05') day;
select extract(week from '2002-01-18 11:20:05') day;
select extract(second from '2002-01-18 11:20:05') day;
select extract(quarter from '2002-01-18 11:20:05') day;
select extract(minute_second from '2002-01-18 11:20:05') day;

select name from stu where count(extract(day from dob))>1;
select  extract(day from dob) as date from stu group by extract(day from dob) having count(*)>1;
select dayname(dob) from stu;
/*find all the students who were born on Tuesday*/
select name from stu where dayname(dob)='Friday'; 
select name from stu where monthname(dob)='January';

show tables;
rename table student to student_details;

/* EXISTS  */

create table customer(
id int not null,
name varchar(255),
occ varchar(255),
age int);

INSERT INTO customer VALUES 
    (1,'Arjun','Actor',23),
    (2,'Deepika','Doctor',34),
    (3,'Varun','Scientist',31),
    (4,'David','Engineer',27);

create table order_det(
order_id int not null,
cust_id int,
product varchar(255),
order_date date);

INSERT INTO order_det values
(10,1,'TV','2020-05-21');
insert into order_det values
(11, 2, 'Refrigerator', '2024-01-12'),
(12, 3, 'TV', '2024-01-17'),
(13, 4, 'Printer', '2024-01-11'),
(14, 5, 'Mobile', '2024-01-21'),
(15, 6, 'Home Decor', '2024-01-23');
select * from order_det;
select * from customer where exists (select * from order_det where 
order_det.cust_id=customer.id);


select * from order_det;
truncate order_det;
select * from customer;

insert into customer values
(5,'Anisha','Engineer','30');

/* Select all the customers who are engineer and placed orders on or after 10th Jan 2024*/
select * from customer where exists (select * from order_det
where  occ='Engineer' and order_date >='2004-01-10');


/*********** JOINS IN SUBQUERY *************/

Select * from customer inner join order_det on customer.id=order_det.cust_id;

Select c.id,c.name,o.product,c.age,o.order_date from customer c inner join order_det o on
c.id=o.cust_id where order_date> '2024-01-01';

select * from stu;
show tables;

create table student (
id int not null,
name varchar(255),
age int,
city varchar(255),
dep_id int);

insert into  student values
(1, 'Shaeshu', 21, 'New York', 101),
(2, 'Anitha', 25, 'Bangalore', 102),
(3, 'Riya', 26, 'Chennai', 103),
(4, 'Nivetha', 22, 'Mumbai', 104);

insert into  student values
(6, 'Yashna', 27, 'Cbe', 106);

create table department(
id int not null,
name varchar(255),
hod varchar(255));

insert into department values
(101 , 'CSE', 'Yadav'),
(102 , 'Arts', 'John'),
(103 , 'AI', 'Robert'),
(104 , 'ECE', 'Pranav');

insert into department values
(105 , 'EEE', 'Dev');
/*********INNER JOIN************/
select s.name as Student_name,d.name as Department_name,d.hod as HOD from student s inner join department d on s.dep_id=d.id;

/******LEFT OUTER JOIN********/

select s.name as Student_name,d.name as Department_name,d.hod 
as HOD from student s left join department d on s.dep_id=d.id;

/* Find all the customers who have not made a purchase yet  */
select * from customer;
select * from order_det;
insert into customer values
(7, 'Diya' , 'Doctor', 35);

/*Find all the customers who have not made a purchase yet */
select c.name,o.order_id from customer c left join order_det o on c.id=o.cust_id where 
o.order_id is null;

/* CROSS JOIN**/
select count(*) from customer c cross join orders o;

/** SELF JOIN***/

select c1.name,c1.occ from customer c1,customer c2 where c1.id <>c2.id and c1.occ=c2.occ;

select * from customer;
select * from cust_bkp;
create table cust_bkp as (select * from customer);

select * from customer 
union 
select * from cust_bkp order by age;

/*****SAMPLE PRACTICE ******/
/*         START         */
/***** create table  if not exists student****/

create database petpals;
create table pets(
PetID int primary key,
Name varchar(255),
Age int,
Breed varchar(255),
Type varchar(255),
AvailableForAdoption bit );

create table shelters(
ShelterID int primary key,
Name varchar(255),
Location varchar(255));

create table donations(
DonationID int primary key,
DonorName varchar(255),
DonationType varchar(255),
DonationAmount decimal(10,2),
DonationItem varchar(255),
DonationDate datetime);

create table adoptionevents(
EventID int primary key,
EventName varchar(255),
EventDate datetime,
Location varchar(255));

create table participants(
ParticipantID int primary key,
ParticipantName varchar(255),
participantType varchar(255),
EventID int,
foreign key(EventID) references adoptionevents(EventID));

show tables;
select * from pets;
insert into pets values 
(1,'Max',2,'Golden Retriever','Dog',1),
(2,'Bruno',1,'Beagle','Dog',1),
(3,'Fin',3,'German Shepherd','Dog',0),
(4,'Juby',2,'Burmese Cat','Cat',1),
(5,'June',4,'Exotic Shorthair','Cat',0);

select Name,Age,Breed,Type from pets where AvailableForAdoption=1;

select * from shelters;

insert into shelters values
(1,'Blue Cross','abc street'),
(2,'vander shelter','3rd cross avenue'),
(3,'PC shelter','Brook side Avenue');

select * from adoptionevents;

insert into adoptionevents values
(1, 'Pet Adoption Fair','2024-01-18','Brooks Park'),
(2, 'Pet Expo','2024-02-20','Codissia');


select * from participants;
insert into participants values
(101,'Javid','Adopter',2),
(102,'PC shelter','Shelter',2),
(103,'Satvik','Adopter',1),
(104,'Blue Cross','Shelter',1);


/* pause assignment*/

select * from stu;
alter table stu add dicipline varchar(10);

update stu set dicipline='CS' where id=1;
update stu set dicipline='EC' where id=2;
update stu set dicipline='IT' where id=3;
/******* CASE EXPRESSION *****/
select id,name,dicipline,case dicipline
when 'EC' then 'Electronics'
when 'CS' then 'Computer Science'
when 'IT' then 'Information Technology'
end as branch from stu;

create table sales(
id int,
product_id int,
qnty int,
unit_price int);

INSERT INTO sales VALUES
(1, 'I Phone', 1, 50000),
(2, 'Laptop', 2, 100000),
(3, 'TV', 1, 75000);

select *, if(qnty>=2, qnty*unit_price*.9,qnty*unit_price) as total_price from sales;

select * from employee;
select *,if (age>=35,salary*1.1,salary) as total_salary from employee;

/***** ifnull()******/
select ifnull(null,'Hello') as welcome;
select * from stu;
select name,ifnull(dicipline,'Yet to ne assigned') dicipline from stu; 
select * from stu;

/***** nill if()*********/

select id,name,dob,dicipline,nullif(dicipline,'IT')participation from stu;
 /*****     COALESCE()  ******/
select coalesce(null,'telephone','fax') as communication_type;

select * from stu;

alter table stu add mobile int , add telephone int;

update stu set telephone = 888554638 where id=2;
select *,coalesce(mobile,telephone) as communication_type from stu;

/********** SUBQUERIES*******/

select * from order_det;

select * from customer;
/*mSome times join canot be applied at that time subqueries can be used**/
select * from order_det where cust_id not in (select id from customer);

/*        subqueries can be used in same table also   */
select name,occ from customer where id in (select id from customer);

select * from order_det where cust_id not in (select id from 
customer where age>20);

select * from employee;

select * from employee where emp_id in (select emp_id from employee where salary > 
25000);


use project;

select * from patient;
select * from doctor;
select * from appointment;
select * from billing;

-- Patient Table

select patient_id from patient; 
alter table patient change ï»¿patient_id patient_id int;

select count(patient_name) as Total_Patients from patient;

select count(patient_name),gender as Genders_Count from patient group by gender;

select count(patient_name),city as City_Distri from patient group by city;

select month(registration_date) as Months, count(patient_name) from patient group by Month(registration_date);

SELECT 
    CASE 
        WHEN age BETWEEN 20 AND 30 THEN '20-30'
        WHEN age BETWEEN 31 AND 40 THEN '31-40'
        WHEN age BETWEEN 41 AND 50 THEN '41-50'
        ELSE 'Over 50'
    END AS age_group,
    COUNT(*) AS total_patients
FROM patient
GROUP BY age_group
ORDER BY age_group;

select avg(age) as Average_Age from patient;

select count(age) as Senior_Citizen from patient where age>=60;

select * from patient where city='Chennai' and registration_date > 2023;

select count(patient_name), city from patient group by city ;

-- Doctor Table

select * from doctor;
alter table doctor change ï»¿doctor_id Doctor_id int;

select count(doctor_name) as Total_Doctors from doctor;

select count(doctor_name),specialization as Speciali_Count from doctor group by specialization;

select avg(experience_years), specialization from doctor group by specialization;

select doctor_name, experience_years from doctor where experience_years > 10;

select * from doctor order by experience_years desc;

select * from doctor order by experience_years;

select count(doctor_name), experience_years from doctor group by experience_years order by experience_years;

select doctor_name, specialization, experience_years from doctor order by experience_years desc limit 3;

-- Appointment Table

select * from appointment;

alter table appointment change ï»¿appointment_id appointment_id int;
select appointment_id from appointment;

select count(*) as Total_Appointments from appointment;

select count(appointment_id), doctor_id from appointment group by doctor_id;

SELECT MONTH(visit_date) AS month, COUNT(*) AS appointment_count FROM appointment GROUP BY MONTH(visit_date) ORDER BY month;

select count(*) as Total_Count, disease from appointment group by disease;

select count(patient_id), doctor_id from appointment group by doctor_id order by doctor_id;

select * from appointment where visit_date > '2025-03-31';

SELECT disease, COUNT(*) AS appointment_count FROM appointment GROUP BY disease ORDER BY appointment_count DESC LIMIT 1;

SELECT patient_id, COUNT(*) AS visit_count FROM appointment GROUP BY patient_id HAVING COUNT(*) > 3;

delete from appointment where patient_id=1;

SELECT patient_id, MIN(visit_date) AS first_visit FROM appointment GROUP BY patient_id limit 1;

select patient_id, max(visit_date) as Last_Visit from appointment group by patient_id order by patient_id desc limit 1;

select count(patient_id), doctor_id from appointment group by doctor_id order by doctor_id;


-- Billing Table

select * from billing;

select sum(bill_amount) as Total_Revenue from billing;

select avg(bill_amount) as Average_Bills from billing;

select sum(bill_amount) as Revenue, payment_mode from billing group by payment_mode;

select count(bill_amount) as Total_Transaction, payment_mode from billing group by payment_mode;

select max(bill_amount) as Highest_Bill from billing;

select min(bill_amount) as Lowest_Bill from billing;

SELECT DATE(payment_date) AS day, SUM(bill_amount) AS revenue FROM billing GROUP BY DATE(payment_date) ORDER BY day;

SELECT YEAR(payment_date) AS year,
       MONTH(payment_date) AS month,
       SUM(bill_amount) AS revenue
FROM billing GROUP BY YEAR(payment_date), MONTH(payment_date) ORDER BY year, month;

select * from billing where bill_amount > (select avg(bill_amount) from billing);

select * from billing order by bill_amount desc limit 10;

-- Joins

select p.city, sum(b.bill_amount) as Revenue from billing b
join appointment a on b.appointment_id = a.appointment_id 
join patient p on a.patient_id = p.patient_id group by p.city; 

select a.doctor_name, sum(b.bill_amount) as Revenue from billing b
join appointment c on b.appointment_id = c.appointment_id 
join doctor a on c.doctor_id = a.Doctor_id group by a.doctor_name ;

select a.specialization, sum(b.bill_amount) as Revenue from billing b
join appointment c on b.appointment_id = c.appointment_id 
join doctor a on c.doctor_id = a.Doctor_id group by a.specialization;

select p.patient_name, sum(b.bill_amount) as Total_Spending from billing b
join appointment a on b.appointment_id = a.appointment_id 
join patient p on a.patient_id = p.patient_id group by p.patient_name; 

select a.doctor_name, sum(b.bill_amount) as Highest_Revenue from billing b
join appointment c on b.appointment_id = c.appointment_id 
join doctor a on c.doctor_id = a.Doctor_id group by a.doctor_name order by Highest_Revenue desc limit 3 ;

select a.disease, sum(b.bill_amount) as Revenue_Diseases from billing b
join appointment a on b.appointment_id = a.appointment_id group by a.disease;

select a.doctor_name,a.experience_years, sum(b.bill_amount) as Performance_Revenue from billing b
join appointment c on b.appointment_id = c.appointment_id
join doctor a on c.doctor_id = a.Doctor_id group by a.doctor_name,a.experience_years order by a.experience_years;









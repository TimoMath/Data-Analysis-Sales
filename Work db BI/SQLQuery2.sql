-- create join table using left join
SELECT * FROM Absenteeism_at_work a
left join compensation b
ON a.ID = b.ID
left join Reasons r on
a.Reason_for_absence = r.Number;

--- Find the healthiest and this can be doneby seeing the absenteeism cause it shows their life style
SELECT * FROM Absenteeism_at_work
WHERE Social_drinker = 0
and Social_smoker = 0
and Body_mass_index < 25
and Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) from Absenteeism_at_work)

--- Compensation rate increase for non-smokers/ budget rate for nonsmokers 983,221
--- 686 nonsmokers
--- total number of hrs per year = 5dy/wk*8hr/dy*52wks/yr = 2,080per worker *686nonsmoker = 1,426,880 all workers hours
--- 983,211 / 1,426,880 = .68 increase rate per year
--- so each employee its 5*8*52 = 2,080 * 0.68 = 1,414.4 increament rate per year

SELECT count(*)as nonsmokers FROM Absenteeism_at_work
where Social_smoker = 0

--optimize query

SELECT 
a.ID,
r.Reason,
Month_of_absence,
Body_mass_index,
CASE WHEN Body_mass_index <18.5 then 'Underweight'
	 WHEN Body_mass_index between 18.5 and 25 then 'Healthy'
	 WHEN Body_mass_index between 25 and 30 then 'Overweight'
	 WHEN Body_mass_index >18.5 then 'Obese'
	 ELSE 'Unknown' END AS BMI_Weight,
CASE WHEN Month_of_absence IN (12,1,2) THEN 'Winter'
	 WHEN Month_of_absence IN (3,4,5) THEN 'Spring'
	 WHEN Month_of_absence IN (6,7,8) THEN 'Summer'
	 WHEN Month_of_absence IN (9,10,11) THEN 'Fall'
	 ELSE 'Unknown' END as Seasons,
Month_of_absence,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker,
Social_smoker,
Pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours
FROM Absenteeism_at_work a
left join compensation b
ON a.ID = b.ID
left join Reasons r on
a.Reason_for_absence = r.Number;
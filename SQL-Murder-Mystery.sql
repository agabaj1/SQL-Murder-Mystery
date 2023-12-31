--Searching for information about a murder on 15 January 2018
SELECT *
FROM crime_scene_report
WHERE type = 'murder' AND date = '20180115' AND city = 'SQL City'

--Seeking the witnesses
--The first witness:
SELECT *
FROM person 
WHERE address_street_name = 'Northwestern Dr' 
ORDER BY address_number DESC
LIMIT 1

--The second witness:
SELECT *
FROM person
WHERE address_street_name = 'Franklin Ave' AND name LIKE '%Annabel%'

--Witnesses - interview:
SELECT p.name, p.id, i.transcript
FROM interview i
JOIN person as p
  ON i.person_id = p.id
WHERE p.id = 14887 OR p.id = 16371

--Checking Morty Schapiro interview:
SELECT p.name, p.license_id,
  d.id, d.age, d.height, d.eye_color, d.hair_color, d.gender, 
  d.plate_number, d.car_make, d.car_model
FROM drivers_license d 
JOIN person p
  ON p.license_id=d.id
WHERE d.plate_number LIKE '%H42W%'

SELECT *
FROM get_fit_now_member
WHERE id LIKE '48Z%' AND membership_status = 'gold'

--Checking Annabel Miller interview:
SELECT m.id, m.person_id, m.membership_status,
  c.check_in_date, c.check_in_time, c.check_out_time
FROM get_fit_now_check_in c 
JOIN get_fit_now_member m
  ON m.id = c.membership_id
WHERE c.check_in_date = 20180109 AND m.membership_status = 'gold' AND m.person_id = 67318
  
--Check your solution
INSERT INTO solution VALUES (1, 'Jeremy Bowers')
SELECT value
FROM solution

--Murderer - interview:
SELECT *
FROM interview
WHERE person_id = 67318

--Checking woman:

--First option:
SELECT *
FROM person p
JOIN drivers_license d
  ON p.license_id = d.id
JOIN facebook_event_checkin f
  ON f.person_id = p.id
WHERE gender = 'female' AND d.car_make = 'Tesla' AND d.car_model = 'Model S'
AND f.event_name = 'SQL Symphony Concert'

--Second option:
SELECT *
FROM person
WHERE id =
  (SELECT person_id
  FROM facebook_event_checkin
  WHERE event_name = 'SQL Symphony Concert' AND date LIKE '201712%'
  GROUP BY person_id
  HAVING COUNT(DISTINCT event_name) = 3)
OR
license_id =
  (SELECT id
  FROM drivers_license
  WHERE gender = 'female' AND hair_color = 'red' AND height BETWEEN 65 AND 67
  AND car_make = 'Tesla' AND car_model = 'Model S')
OR
id =
  (SELECT ssn
  FROM income
  ORDER BY annual_income)

--Check your solution:
INSERT INTO solution VALUES (1, 'Miranda Priestly')
SELECT value FROM solution

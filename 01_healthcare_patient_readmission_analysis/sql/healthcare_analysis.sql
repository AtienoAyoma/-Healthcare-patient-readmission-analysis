-- Healthcare Patient Readmission & Data Quality Analysis
-- Dataset: UCI Diabetes 130-US Hospitals (1999-2008)
-- Load diabetes.csv into a table called diabetes before running.

-- 1. Overall encounter and readmission distribution
SELECT readmitted, COUNT(*) AS encounters
FROM diabetes
GROUP BY readmitted
ORDER BY encounters DESC;

-- 2. Readmission by age group
SELECT age, readmitted, COUNT(*) AS encounters
FROM diabetes
GROUP BY age, readmitted
ORDER BY age, readmitted;

-- 3. Average length of stay by readmission outcome
SELECT readmitted,
       COUNT(*) AS encounters,
       ROUND(AVG(time_in_hospital), 2) AS avg_days_in_hospital
FROM diabetes
GROUP BY readmitted
ORDER BY avg_days_in_hospital DESC;

-- 4. Admission type and readmission outcome
SELECT admission_type_id, readmitted, COUNT(*) AS encounters
FROM diabetes
GROUP BY admission_type_id, readmitted
ORDER BY admission_type_id, encounters DESC;

-- 5. Missing-value profile for selected clinically relevant fields
SELECT
    SUM(CASE WHEN race = '?' THEN 1 ELSE 0 END) AS missing_race,
    SUM(CASE WHEN weight = '?' THEN 1 ELSE 0 END) AS missing_weight,
    SUM(CASE WHEN medical_specialty = '?' THEN 1 ELSE 0 END) AS missing_medical_specialty,
    SUM(CASE WHEN payer_code = '?' THEN 1 ELSE 0 END) AS missing_payer_code,
    SUM(CASE WHEN diag_1 = '?' THEN 1 ELSE 0 END) AS missing_diag_1,
    SUM(CASE WHEN diag_2 = '?' THEN 1 ELSE 0 END) AS missing_diag_2,
    SUM(CASE WHEN diag_3 = '?' THEN 1 ELSE 0 END) AS missing_diag_3
FROM diabetes;

-- 6. Length-of-stay bands
SELECT
  CASE
    WHEN time_in_hospital BETWEEN 1 AND 3 THEN '1-3 days'
    WHEN time_in_hospital BETWEEN 4 AND 7 THEN '4-7 days'
    WHEN time_in_hospital BETWEEN 8 AND 14 THEN '8-14 days'
  END AS stay_band,
  COUNT(*) AS encounters,
  ROUND(AVG(CASE WHEN readmitted = '<30' THEN 1.0 ELSE 0.0 END)*100, 2) AS readmission_under_30_pct
FROM diabetes
GROUP BY stay_band
ORDER BY stay_band;
-- 7. Readmission outcome distribution

SELECT
    readmitted,
    COUNT(*) AS encounter_count
FROM diabetes
GROUP BY readmitted
ORDER BY encounter_count DESC;
-- 3. 30-day readmission rate

SELECT
    ROUND(
        100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS readmission_30_day_pct
FROM diabetes;
-- 4. Average hospital stay by readmission outcome

SELECT
    readmitted,
    COUNT(*) AS encounters,
    ROUND(AVG(time_in_hospital), 2) AS avg_days_in_hospital
FROM diabetes
GROUP BY readmitted
ORDER BY avg_days_in_hospital DESC;
-- 5. Missing-value profile

SELECT
 SUM(CASE WHEN race IS NULL THEN 1 ELSE 0 END) AS missing_race,
    SUM(CASE WHEN weight IS NULL THEN 1 ELSE 0 END) AS missing_weight,
    SUM(CASE WHEN medical_specialty IS NULL THEN 1 ELSE 0 END) AS missing_medical_specialty,
    SUM(CASE WHEN payer_code IS NULL THEN 1 ELSE 0 END) AS missing_payer_code,
    SUM(CASE WHEN diag_1 IS NULL THEN 1 ELSE 0 END) AS missing_diag_1,
    SUM(CASE WHEN diag_2 IS NULL THEN 1 ELSE 0 END) AS missing_diag_2,
    SUM(CASE WHEN diag_3 IS NULL THEN 1 ELSE 0 END) AS missing_diag_3   
FROM diabetes;
SELECT
    COUNT(*) AS total_rows,
    COUNT(race) AS race_non_null,
    COUNT(weight) AS weight_non_null
FROM diabetes;
-- 8. 30-day readmission rate by age group

SELECT
    age,
    COUNT(*) AS encounters,
    ROUND(
        100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS readmission_30_day_pct
FROM diabetes
GROUP BY age
ORDER BY age;
-- 9. 30-day readmission rate by hospital stay

SELECT
    time_in_hospital,
    COUNT(*) AS encounters,
    ROUND(
        100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS readmission_30_day_pct
FROM diabetes
GROUP BY time_in_hospital
ORDER BY time_in_hospital;
-- 10. 30-day readmission rate by previous inpatient visits

SELECT
    number_inpatient,
    COUNT(*) AS encounters,
    ROUND(
        100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS readmission_30_day_pct
FROM diabetes
GROUP BY number_inpatient
ORDER BY number_inpatient;
-- 11. Final healthcare analysis summary

SELECT
    COUNT(*) AS total_encounters,
    COUNT(DISTINCT patient_nbr) AS unique_patients,
    ROUND(AVG(time_in_hospital), 2) AS avg_hospital_stay_days,
    ROUND(
        100.0 * SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS readmission_30_day_pct,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_within_30_days
FROM diabetes;
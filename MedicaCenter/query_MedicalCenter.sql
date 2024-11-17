\c medicalCenter_db


-- A medical center employs several doctors
SELECT d.name doctor, m.name facility
FROM doctor d
JOIN medical_center m ON d.medical_centerid = m.id;

-- A doctors can see many patients
SELECT p.name patient
FROM checkup c
JOIN patient p ON c.patientid = p.id
WHERE c.doctorid = 1;

-- A patient can be seen by many doctors
SELECT p.name patient, d.name doctor
FROM checkup
JOIN doctor d ON d.id = doctorid
JOIN patient p ON p.id = patientid;

-- During a visit, a patient may be diagnosed to have one or more diseases.
SELECT
    p.name patient,
    d.name diagnoses,
    doc.name doctor,
    c.visit_date diagnosis_date
FROM checkup c
JOIN patient p ON c.patientid = p.id
JOIN doctor doc ON c.doctorid = doc.id
JOIN checkup_disease cd ON c.id = cd.checkupid
JOIN disease d ON cd.diseaseid = d.id
GROUP BY c.visit_date, p.name, d.name, doc.name;
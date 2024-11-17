\c medicalCenter_db


INSERT INTO medical_center (id, name, address) VALUES 
(1, 'Central Medical Center', '123 Main St'),
(2, 'Northside Health', '456 Elm St');

INSERT INTO doctor (id, name, medical_centerid) VALUES 
(1, 'Dr. Alice Smith', 1),
(2, 'Dr. Bob Johnson', 1),
(3, 'Dr. Carol White', 2);

INSERT INTO patient (id, name) VALUES 
(1, 'John Doe'),
(2, 'Jane Roe'),
(3, 'Sam Wilson');

INSERT INTO disease (id, name) VALUES 
(1, 'Flu'),
(2, 'Diabetes'),
(3, 'Hypertension');

INSERT INTO checkup (id, doctorid, patientid, visit_date) VALUES 
(1, 1, 1, '2024-01-15'),
(2, 2, 2, '2024-01-16'),
(3, 1, 3, '2024-01-17'),
(4, 3, 1, '2024-01-18');

INSERT INTO checkup_disease (checkupid, diseaseid) VALUES 
(1, 1), -- John Doe was diagnosed with Flu in checkup 1
(2, 2), -- Jane Roe was diagnosed with Diabetes in checkup 2
(3, 1), -- Sam Wilson was diagnosed with Flu in checkup 3
(4, 3); -- John Doe was diagnosed with Hypertension in checkup 4 

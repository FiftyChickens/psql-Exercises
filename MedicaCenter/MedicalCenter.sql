DROP DATABASE IF EXISTS medicalcenter_db;
CREATE DATABASE medicalcenter_db;

\c medicalCenter_db

CREATE TABLE "medical_center" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    CONSTRAINT "pk_medical_center" PRIMARY KEY ("id")
);

CREATE TABLE "doctor" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "medical_centerid" INT NOT NULL,
    CONSTRAINT "pk_doctor" PRIMARY KEY ("id"),
    CONSTRAINT "fk_doctor_medical_centerid" FOREIGN KEY ("medical_centerid")
    REFERENCES "medical_center" ("id")
);

CREATE TABLE "patient" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    CONSTRAINT "pk_patient" PRIMARY KEY ("id")
);

CREATE TABLE "checkup" (
    "id" SERIAL NOT NULL,
    "doctorid" INT NOT NULL,
    "patientid" INT NOT NULL,
    "visit_date" DATE NOT NULL,
    CONSTRAINT "pk_checkup" PRIMARY KEY ("id"),
    CONSTRAINT "fk_checkup_doctorid" FOREIGN KEY ("doctorid")
    REFERENCES "doctor" ("id"),
    CONSTRAINT "fk_checkup_patientid" FOREIGN KEY ("patientid")
    REFERENCES "patient" ("id")
);

CREATE TABLE "checkup_disease" (
    "checkupid" INT NOT NULL,
    "diseaseid" INT NOT NULL,
    CONSTRAINT "fk_checkup_disease_checkupid" FOREIGN KEY ("checkupid")
    REFERENCES "checkup" ("id"),
    CONSTRAINT "fk_checkup_disease_diseaseid" FOREIGN KEY ("diseaseid")
    REFERENCES "disease" ("id")
);

CREATE TABLE "disease" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    CONSTRAINT "pk_disease" PRIMARY KEY ("id")
);

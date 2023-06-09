CREATE DATABASE vet_clinic_diagram;
-- Create a table named invoice_items  with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
--unit_price        DECIMAL,
 -- quantity          INT,
  --total_price       DECIMAL,
  --invoice_id        INT REFERENCES invoices(id),
  --treatment_id      INT REFERENCES treatments(id),
  --PRIMARY KEY(id, invoice_id, treatment_id)
CREATE TABLE invoice_items (
  id                INT GENERATED ALWAYS AS IDENTITY,
  unit_price        DECIMAL,
  quantity          INT,
  total_price       DECIMAL,
  invoice_id        INT REFERENCES invoices(id),
  treatment_id      INT REFERENCES treatments(id),
  PRIMARY KEY(id)
);

CREATE TABLE patients(
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	date_of_birth DATE
);

CREATE TABLE invoices(
	id SERIAL PRIMARY KEY,
	total_amount DECIMAL NOT NULL,
	generated_at TIMESTAMP,
	payed_at TIMESTAMP,
	medical_history_id INTEGER REFERENCES medical_histories(id)
);

CREATE TABLE medical_histories (
		id INT GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP,
    patient_id INT REFERENCES patients(id),
    status VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE treatments (
	id INT GENERATED ALWAYS AS IDENTITY,
  type	VARCHAR(100), 
  name	VARCHAR(100),
  PRIMARY KEY (id)
);

CREATE TABLE medical_history_treatment(
    medical_history_id INTEGER REFERENCES medical_histories(id),
    treatment_id INTEGER REFERENCES treatments(id),
    PRIMARY KEY (medical_history_id, treatment_id)
);

CREATE INDEX invoice_id ON invoice_items(invoice_id);
CREATE INDEX treatment_id ON invoice_items(treatment_id);

CREATE INDEX medical_history_id ON invoices(medical_history_id);

CREATE INDEX patient_id ON medical_histories (patient_id)

CREATE INDEX medical_history_id ON medical_history_treatment (medical_history_id);
CREATE INDEX treatment_id ON medical_history_treatment (treatment_id);
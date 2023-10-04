/* Database schema_based_on_diagram to keep the structure of entire database. */

CREATE TABLE patients (
    id int GENERATED ALWAYS AS IDENTITY,
    name varchar(255),
    date_of_birth date,
    PRIMARY KEY (id)
);

CREATE TABLE medical_histories (
    id int GENERATED ALWAYS AS IDENTITY,
    admitted_at timestamp,
    patient_id int,
    FOREIGN KEY (patient_id)
    REFERENCES patients(id),
    status varchar(255),
    PRIMARY KEY (id),
);

CREATE INDEX ids_patient_id ON medical_histories (patient_id);


CREATE TABLE invoices (
    id int GENERATED ALWAYS AS IDENTITY,
    total_amount decimal,
    generated_at timestamp,
    payed_at timestamp,
    medical_history_id int,
    FOREIGN KEY (medical_history_id)
    REFERENCES medical_histories(id),
    PRIMARY KEY (id)
);

CREATE INDEX idx_medical_history_id ON invoices (medical_history_id);

CREATE TABLE treatments (
    id int GENERATED ALWAYS AS IDENTITY,
    type varchar(255),
    name varchar(255),
    PRIMARY KEY (id)
);

CREATE TABLE invoice_items (
    id int GENERATED ALWAYS AS IDENTITY,
    unit_price decimal,
    quantity int,
    total_price decimal,
    invoice_id int,
    treatment_id int,
    FOREIGN KEY (invoice_id)
    REFERENCES invoices(id),
    FOREIGN KEY (treatment_id)
    REFERENCES treatments (id),
    PRIMARY KEY (id)
);

CREATE INDEX idx_invoice_id ON invoice_items (invoice_id);
CREATE INDEX idx_treatment_id ON invoice_items (treatment_id);

CREATE TABLE treatments_history (
    id INT GENERATED ALWAYS AS IDENTITY,
    medical_history_id INT,
    treatment_id INT,
    FOREIGN KEY (medical_history_id)
    REFERENCES medical_histories(id),
    FOREIGN KEY (treatment_id)
    REFERENCES treatments(id),
    PRIMARY KEY (id)
);

CREATE INDEX idx_medical_history_id ON treatments_history (medical_history_id);
CREATE INDEX idx_treatment_id ON treatments_history (treatment_id);

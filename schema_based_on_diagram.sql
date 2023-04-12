CREATE TABLE invoice_items {
  id                INT GENERATED ALWAYS AS IDENTITY,
  unit_price        DECIMAL,
  quantity          INT,
  total_price       DECIMAL,
  invoice_id        INT REFERENCES invoices(id),
  treatment_id      INT REFERENCES treatments(id),
  PRIMARY KEY(id, invoice_id, treatment_id)
}
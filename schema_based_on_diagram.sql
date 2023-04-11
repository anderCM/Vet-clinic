CREATE TABLE owners(
	id SERIAL PRIMARY KEY,
	fullname VARCHAR(50) NOT NULL,
	age INTEGER DEFAULT 1,
    email VARCHAR(120)
);

CREATE TABLE animals (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attempts INTEGER DEFAULT 0,
	neutered BOOLEAN DEFAULT false,
	weight_kg DECIMAL NOT NULL,
    species_id INTEGER REFERENCES species(id),
    owner_id INTEGER REFERENCES owners(id)
);


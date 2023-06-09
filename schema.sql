CREATE TABLE animals (
	id INTEGER PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attempts INTEGER DEFAULT 0,
	neutered BOOLEAN DEFAULT false,
	weight_kg DECIMAL NOT NULL
);

ALTER TABLE animals 
	ADD COLUMN species VARCHAR(50) NOT NULL DEFAULT 'unspecified';

CREATE TABLE owners(
	id SERIAL PRIMARY KEY,
	fullname VARCHAR(50) NOT NULL,
	age INTEGER DEFAULT 1
);

CREATE TABLE species(
	id SERIAL PRIMARY KEY,
	name VARCHAR(20)
);

ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals
	ADD COLUMN species_id INTEGER REFERENCES species(id),
	ADD COLUMN owner_id INTEGER REFERENCES owners(id);

CREATE TABLE specializations(
	species_id INTEGER NOT NULL,
	vet_id INTEGER NOT NULL,
	FOREIGN KEY (species_id) REFERENCES species(id),
	FOREIGN KEY (vet_id) REFERENCES vets(id)
);

CREATE TABLE visits(
	animal_id INTEGER NOT NULL,
	vet_id INTEGER NOT NULL,
	date_of_visit DATE NOT NULL,
	FOREIGN KEY (animal_id) REFERENCES animals(id),
	FOREIGN KEY (vet_id) REFERENCES vets(id)
);

CREATE TABLE vets(
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	age INTEGER NOT NULL,
	date_of_graduation DATE
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);
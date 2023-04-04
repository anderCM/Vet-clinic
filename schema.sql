CREATE TABLE animals (
	id integer PRIMARY KEY,
	name varchar(50) NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attempts integer DEFAULT 0,
	neutered boolean DEFAULT false,
	weight_kg decimal NOT NULL
);
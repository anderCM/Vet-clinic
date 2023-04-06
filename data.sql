INSERT INTO 
	animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES	
		(1, 'Agumon', '2020-02-03', 0, true, 10.23),
		(2, 'Gabumon', '2018-11-15', 2, true, 8),
		(3, 'Pikachu', '2021-01-07', 1, false, 15.04),
		(4, 'Devimon', '2017-05-12', 5, true, 11);

INSERT INTO 
	animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES	
		(5, 'Charmander', '2020-02-08', 0, false, -11),
		(6, 'Plantmon', '2021-11-15', 2, true, -5.7),
		(7, 'Squirtle', '1993-04-02', 3, false, -12.13),
		(8, 'Angemon', '2005-06-12', 1, true, -45),
		(9, 'Boarmon', '2005-06-07', 7, true, 20.4),
		(10, 'Blossom', '1998-10-13', 3, true, 17),
		(11, 'Ditto', '2022-05-14', 4, true, 22);

INSERT INTO owners(fullname, age)
	VALUES
		('Sam Smith', 34),
		('Jennifer Orwell', 19),
		('Bob', 45),
		('Melody Pond', 77),
		('Dean Winchester', 14),
		('Jodie Whittaker', 38);

INSERT INTO species(name)
	VALUES
		('Pokemon'),
		('Digimon');

UPDATE animals anm
SET species_id = spc.id
FROM species spc
WHERE 
	(anm.name NOT LIKE '%mon' AND spc.name = 'Pokemon')
   OR
   	(anm.name LIKE '%mon' AND spc.name = 'Digimon');


UPDATE animals anm
SET owner_id = own.id
FROM owners own
WHERE
	(own.fullname = 'Sam Smith' AND anm.name = 'Agumon')
	OR
	(own.fullname = 'Jennifer Orwell' AND (anm.name = 'Gabumon' OR anm.name = 'Pikachu'))
	OR
	(own.fullname = 'Bob' AND (anm.name = 'Devimon' OR anm.name = 'Plantmon'))
	OR
	(own.fullname = 'Melody Pond' AND (anm.name = 'Charmander' OR anm.name = 'Squirtle' OR anm.name = 'Blossom'))
	OR
	(own.fullname = 'Dean Winchester' AND (anm.name = 'Angemon' OR anm.name = 'Boarmon'));
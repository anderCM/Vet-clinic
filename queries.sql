/* Find all animals whose name ends in "mon" */
SELECT * FROM animals
	WHERE name LIKE '%mon';

/* List the name of all animals born between 2016 and 2019 */
SELECT name FROM animals
	WHERE date_part('year', date_of_birth) >= '2016'
	AND date_part('year', date_of_birth) <= '2019';

/* List the name of all animals that are neutered and have less than 3 escape attempts */
SELECT name FROM animals
	WHERE neutered = true
	AND escape_attempts < 3;

/* List the date of birth of all animals named either "Agumon" or "Pikachu" */
SELECT date_of_birth FROM animals
	WHERE name = 'Agumon'
		OR name = 'Pikachu';

/* List name and escape attempts of animals that weigh more than 10.5kg */
SELECT name, escape_attempts FROM animals
	WHERE weight_kg > 10.5;

/* Find all animals that are neutered */
SELECT * FROM animals
	WHERE neutered = true;

/* Find all animals not named Gabumon */
SELECT * FROM animals
	WHERE name != 'Gabumon';

/* Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg) */
SELECT * FROM animals
	WHERE weight_kg >= 10.4
		AND weight_kg <= 17.3;

/* 	Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
	Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
	Commit the transaction. */
BEGIN;		
UPDATE animals 
	SET species = CASE
					WHEN name LIKE '%mon'
						THEN 'digimon'
					ELSE
						'pokemon'
					END;
SELECT species FROM animals;

COMMIT;
SELECT species from animals;


/* Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made.
	Then roll back the change and verify that the species columns went back to the state before the transaction */
BEGIN;
SAVEPOINT trs_upd_spec_unde;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;

BEGIN;
ROLLBACK TO trs_upd_spec_unde;
SELECT species FROM animals;


/* Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
	After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;) */
START TRANSACTION;
SAVEPOINT trs;
DELETE FROM animals;

START TRANSACTION;
ROLLBACK TO trs;
COMMIT;

/* Inside a transaction:
		Delete all animals born after Jan 1st, 2022.
		Create a savepoint for the transaction.
		Update all animals' weight to be their weight multiplied by -1.
		Rollback to the savepoint
		Update all animals' weights that are negative to be their weight multiplied by -1.
		Commit transaction */

BEGIN;
DELETE FROM animals
	WHERE date_of_birth > '2022-01-01';
SAVEPOINT trs_del_anim_jan01;
UPDATE animals
	SET weight_kg = weight_kg * -1;
ROLLBACK TO trs_del_anim_jan01;
UPDATE animals
	SET weight_kg = weight_kg * -1
	WHERE
		weight_kg < 0;
COMMIT;

/* How many animals are there? */
SELECT COUNT(id) total_animals FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(id) animals_no_escape FROM animals
	WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT ROUND(AVG(weight_kg), 2) average_weight FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT COUNT(id) total, neutered FROM animals
	GROUP BY neutered
	ORDER BY total DESC
	LIMIT 1;

/* What is the minimum and maximum weight of each type of animal? */
SELECT species, MAX(weight_kg) max_weight, MIN(weight_kg) min_weight FROM animals
	GROUP BY species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT species, ROUND(AVG(escape_attempts), 2) average_escape FROM animals
	WHERE date_part('year', date_of_birth) >= '1990'
	AND date_part('year', date_of_birth) <= '2000'
	GROUP BY species;

/* What animals belong to Melody Pond? */
SELECT anm.* FROM animals anm
JOIN owners own ON own.id = anm.owner_id
WHERE
	own.fullname = 'Melody Pond';

/* List of all animals that are pokemon */
SELECT anm.* FROM animals anm
JOIN species spc ON spc.id = anm.species_id
WHERE
	spc.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal */
SELECT anm.name animal, own.fullname owner_name FROM animals anm
FULL JOIN owners own ON own.id = anm.owner_id;

/* How many animals are there per species */
SELECT spc.name specie ,COUNT(anm.id) quantity FROM animals anm
JOIN species spc ON spc.id = anm.species_id
GROUP BY spc.name;

/* List all Digimon owned by Jennifer Orwell */
SELECT anm.name animal_name FROM animals anm
JOIN owners own ON own.id = anm.owner_id
JOIN species spc ON spc.id = anm.species_id
WHERE own.fullname = 'Jennifer Orwell'
	AND spc.name = 'Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape */
SELECT anm.name animal_name FROM animals anm
JOIN owners own ON own.id = anm.owner_id
WHERE anm.escape_attempts = 0
	AND own.fullname = 'Dean Winchester';

/* Who owns the most animals */
SELECT own.fullname owner ,COUNT(anm.id) quantity FROM animals anm
JOIN owners own ON own.id = anm.owner_id
GROUP BY owner
ORDER BY quantity DESC
LIMIT 1;
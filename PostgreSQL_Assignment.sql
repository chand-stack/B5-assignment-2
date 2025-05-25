-- Active: 1747433022653@@localhost@5432@postgres
-- table creation
CREATE TABLE rangers(
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region TEXT NOT NULL
);

CREATE TABLE species(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(20) NOT NULL
);

CREATE TABLE sightings(
sighting_id SERIAL PRIMARY KEY,
ranger_id INT REFERENCES rangers(ranger_id) ON DELETE CASCADE,
species_id INT REFERENCES species(species_id) ON DELETE CASCADE,
sighting_time TIMESTAMP NOT NULL,
location TEXT NOT NULL,
notes TEXT DEFAULT NULL
);

-- data inserting
INSERT INTO rangers(name,region) VALUES
('Alice Green','Northern Hills'),
('Bob White','River Delta'),
('Carol King','Mountain Range');

INSERT INTO species(common_name,scientific_name,discovery_date,conservation_status) VALUES
('Snow Leopard','Panthera uncia','1775-01-01','Endangered'),
('Bengal Tiger','Panthera tigris tigris','1758-01-01','Endangered'),
('Red Panda','Ailurus fulgens','1825-01-01','Vulnerable'),
('Asiatic Elephant','Elephas maximus indicus','1758-01-01','Endangered');

INSERT INTO sightings(ranger_id,species_id,sighting_time,location,notes) VALUES
(1,1,'2024-05-10 07:45:00','Peak Ridge','Camera trap image captured'),
(2,2,'2024-05-12 16:20:00','Bankwood Area','Juvenile seen'),
(3,3,'2024-05-15 09:10:00','Bamboo Grove East','Feeding observed'),
(2,1,'2024-05-18 18:30:00','Snowfall Pass', NULL);

-- problem 1
INSERT INTO rangers(name,region) VALUES('Derek Fox','Coastal Plains');


-- problem 2
SELECT COUNT(DISTINCT species_id) as unique_species_count FROM sightings ;

-- problem 3
SELECT * FROM sightings WHERE location LIKE ('%Pass%');

-- problem 4
SELECT name, COUNT(*) as total_sightings FROM rangers INNER JOIN sightings ON rangers.ranger_id = sightings.ranger_id GROUP BY name;


-- problem 5
SELECT common_name FROM species WHERE species.species_id NOT IN (SELECT species_id FROM sightings);


-- problem 6
SELECT common_name, sighting_time, name FROM species JOIN sightings ON species.species_id = sightings.species_id JOIN rangers ON sightings.ranger_id=rangers.ranger_id  ORDER BY sighting_time DESC LIMIT 2;



-- problem 7
UPDATE species SET conservation_status = 'Historic' WHERE  1800 > extract(YEAR FROM discovery_date);


-- problem 8 
SELECT sighting_id,
CASE
WHEN 12 > extract(HOUR FROM sighting_time) THEN 'Morning'
WHEN 12 <= extract(HOUR FROM sighting_time) AND 17 > extract(HOUR FROM sighting_time) THEN 'Afternoon'
ELSE 'Evening'
END AS time_of_day
FROM sightings;


-- problem 9
DELETE FROM rangers WHERE ranger_id NOT IN(SELECT ranger_id FROM sightings);


 


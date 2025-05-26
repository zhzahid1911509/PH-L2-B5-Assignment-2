-- rangers Table Creation
CREATE TABLE rangers (
    ranger_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255),
    region VARCHAR(255)
);

-- species Table Creation
CREATE TABLE species (
  species_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  common_name VARCHAR(255),
  scientific_name VARCHAR(255),
  discovery_date DATE,
  conservation_status VARCHAR(100)
);

-- sightings Table Creation
CREATE TABLE sightings (
  sighting_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  species_id INT REFERENCES species(species_id),
  ranger_id INT REFERENCES rangers(ranger_id),
  location VARCHAR(255),
  sighting_time DATE,
  notes TEXT
);

-- rangers Sample Data Insertion
INSERT INTO rangers (name, region)
VALUES ('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

-- species Sample Data Insertion
INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status)
VALUES ('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

-- sightings Sample Data Insertion
INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes)
VALUES (1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

-- Problem 1
INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings

-- Problem 3
SELECT * FROM sightings
WHERE location LIKE '%Pass%';

-- Problem 4
SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r, sightings s
WHERE r.ranger_id = s.ranger_id
GROUP BY r.name;

-- Problem 5
SELECT common_name 
FROM species sp    
LEFT JOIN sightings si ON sp.species_id = si.species_id
WHERE si.sighting_id IS NULL;

-- Problem 6
SELECT sp.common_name, si.sighting_time, r.name 
FROM species sp, sightings si, rangers r
WHERE si.species_id = sp.species_id AND si.ranger_id = r.ranger_id
ORDER BY si.sighting_time DESC
LIMIT 2;

-- Problem 7
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01'; 

-- Problem 8
SELECT sighting_id,
CASE
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS time_of_day
FROM sightings

-- Problem 9
DELETE FROM rangers r
WHERE NOT EXISTS (
    SELECT * FROM sightings s
    WHERE s.ranger_id = r.ranger_id
)

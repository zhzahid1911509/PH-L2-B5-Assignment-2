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
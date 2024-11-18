-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE passenger (
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  seat TEXT NOT NULL
);

CREATE TABLE destination (
  id SERIAL PRIMARY KEY,
  date_time TIMESTAMP NOT NULL,
  city TEXT NOT NULL,
  country TEXT NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('arrival', 'departure')) -- 'arrival' or 'departure'
);

CREATE TABLE flight (
  id SERIAL PRIMARY KEY,
  airline TEXT NOT NULL
);

CREATE TABLE ticket (
  id SERIAL PRIMARY KEY,
  passenger_id INT NOT NULL,
  departure_id INT NOT NULL, -- Links to 'departure' destination
  arrival_id INT NOT NULL,   -- Links to 'arrival' destination
  flight_id INT NOT NULL,
  CONSTRAINT fk_ticket_passenger FOREIGN KEY (passenger_id) REFERENCES passenger (id),
  CONSTRAINT fk_ticket_departure FOREIGN KEY (departure_id) REFERENCES destination (id),
  CONSTRAINT fk_ticket_arrival FOREIGN KEY (arrival_id) REFERENCES destination (id),
  CONSTRAINT fk_ticket_flight FOREIGN KEY (flight_id) REFERENCES flight (id)
);

INSERT INTO passenger (first_name, last_name, seat) VALUES
  ('Jennifer', 'Finch', '33B'),
  ('Thadeus', 'Gathercoal', '8A'),
  ('Sonja', 'Pauley', '12F'),
  ('Jennifer', 'Finch', '20A'),
  ('Waneta', 'Skeleton', '23D'),
  ('Thadeus', 'Gathercoal', '18C'),
  ('Berkie', 'Wycliff', '9E'),
  ('Alvin', 'Leathes', '1A'),
  ('Berkie', 'Wycliff', '32B'),
  ('Cory', 'Squibbes', '10D');

INSERT INTO flight (airline) VALUES
  ('United'),
  ('British Airways'),
  ('Delta'),
  ('TUI Fly Belgium'),
  ('Air China'),
  ('American Airlines'),
  ('Avianca Brasil');

INSERT INTO destination (date_time, city, country, type) VALUES
  ('2018-04-08 09:00:00', 'Washington DC', 'United States', 'departure'), -- Flight 1
  ('2018-04-08 12:00:00', 'Seattle', 'United States', 'arrival'),         -- Flight 2
  ('2018-12-19 12:45:00', 'Tokyo', 'Japan', 'departure'),                 -- Flight 3
  ('2018-12-19 16:15:00', 'London', 'United Kingdom', 'arrival'),         -- Flight 4
  ('2018-01-02 07:00:00', 'Los Angeles', 'United States', 'departure'),   -- Flight 5
  ('2018-01-02 08:03:00', 'Las Vegas', 'United States', 'arrival'),       -- Flight 6
  ('2018-04-15 16:50:00', 'Seattle', 'United States', 'departure'),       -- Flight 7
  ('2018-04-15 21:00:00', 'Mexico City', 'Mexico', 'arrival'),            -- Flight 8
  ('2018-08-01 18:30:00', 'Paris', 'France', 'departure'),                -- Flight 9
  ('2018-08-01 21:50:00', 'Casablanca', 'Morocco', 'arrival'),            -- Flight 10
  ('2018-10-31 01:15:00', 'Dubai', 'UAE', 'departure'),                   -- Flight 11
  ('2018-10-31 12:55:00', 'Beijing', 'China', 'arrival'),                 -- Flight 12
  ('2019-02-06 06:00:00', 'New York', 'United States', 'departure'),      -- Flight 13
  ('2019-02-06 07:47:00', 'Charlotte', 'United States', 'arrival'),       -- Flight 14
  ('2019-02-06 16:28:00', 'Charlotte', 'United States', 'departure'),     -- Flight 15
  ('2019-02-06 19:18:00', 'New Orleans', 'United States', 'arrival'),     -- Flight 16
  ('2018-12-22 14:42:00', 'Cedar Rapids', 'United States', 'departure'),  -- Flight 17
  ('2018-12-22 15:56:00', 'Chicago', 'United States', 'arrival'),         -- Flight 18
  ('2019-01-20 19:30:00', 'Sao Paolo', 'Brazil', 'departure'),            -- Flight 19
  ('2019-01-20 22:45:00', 'Santiago', 'Chile', 'arrival');                -- Flight 20

INSERT INTO ticket (passenger_id, departure_id, arrival_id, flight_id) VALUES
  (1, 1, 2, 1), -- Jennifer Finch: Washington DC to Seattle on United
  (2, 3, 4, 2), -- Thadeus Gathercoal: Tokyo to London on British Airways
  (3, 5, 6, 3), -- Sonja Pauley: Los Angeles to Las Vegas on Delta
  (1, 7, 8, 3), -- Jennifer Finch: Seattle to Mexico City on Delta
  (4, 9, 10, 4), -- Waneta Skeleton: Paris to Casablanca on TUI Fly Belgium
  (2, 11, 12, 5), -- Thadeus Gathercoal: Dubai to Beijing on Air China
  (5, 13, 14, 1), -- Berkie Wycliff: New York to Charlotte on United
  (6, 17, 18, 6), -- Alvin Leathes: Cedar Rapids to Chicago on American Airlines
  (5, 15, 16, 6), -- Berkie Wycliff: Charlotte to New Orleans on American Airlines
  (7, 19, 20, 7); -- Cory Squibbes: Sao Paolo to Santiago on Avianca Brasil


SELECT 
    ticket.id AS ticket_id,
    passenger.first_name,
    passenger.last_name,
    passenger.seat,
    departure.date_time AS departure_time,
    departure.city AS departure_city,
    departure.country AS departure_country,
    arrival.date_time AS arrival_time,
    arrival.city AS arrival_city,
    arrival.country AS arrival_country,
    flight.airline
FROM 
    ticket
JOIN 
    passenger ON ticket.passenger_id = passenger.id
JOIN 
    destination AS departure ON ticket.departure_id = departure.id
JOIN 
    destination AS arrival ON ticket.arrival_id = arrival.id
JOIN 
    flight ON ticket.flight_id = flight.id
ORDER BY 
    ticket.id;


-- INSERT INTO tickets
--   (first_name, last_name, seat, departure, arrival, airline, from_city, from_country, to_city, to_country)
-- VALUES
--   ('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 'United', 'Washington DC', 'United States', 'Seattle', 'United States'),
--   ('Thadeus', 'Gathercoal', '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 'British Airways', 'Tokyo', 'Japan', 'London', 'United Kingdom'),
--   ('Sonja', 'Pauley', '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 'Delta', 'Los Angeles', 'United States', 'Las Vegas', 'United States'),
--   ('Jennifer', 'Finch', '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 'Delta', 'Seattle', 'United States', 'Mexico City', 'Mexico'),
--   ('Waneta', 'Skeleton', '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 'TUI Fly Belgium', 'Paris', 'France', 'Casablanca', 'Morocco'),
--   ('Thadeus', 'Gathercoal', '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 'Air China', 'Dubai', 'UAE', 'Beijing', 'China'),
--   ('Berkie', 'Wycliff', '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 'United', 'New York', 'United States', 'Charlotte', 'United States'),
--   ('Alvin', 'Leathes', '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 'American Airlines', 'Cedar Rapids', 'United States', 'Chicago', 'United States'),
--   ('Berkie', 'Wycliff', '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 'American Airlines', 'Charlotte', 'United States', 'New Orleans', 'United States'),
--   ('Cory', 'Squibbes', '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 'Avianca Brasil', 'Sao Paolo', 'Brazil', 'Santiago', 'Chile');
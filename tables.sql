CREATE TABLE delays (
	id integer UNIQUE PRIMARY KEY,
	name VARCHAR(15) NOT NULL
);

CREATE TABLE classes (
	id integer UNIQUE PRIMARY KEY,
	name VARCHAR(20) NOT NULL
);

CREATE TABLE seats (
	id integer UNIQUE PRIMARY KEY,
	number_place integer NOT NULL,
	classes_id integer REFERENCES classes(id)
);

CREATE TABLE planes (
	id integer UNIQUE PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);

CREATE TABLE planes_seats (
	id integer UNIQUE PRIMARY KEY,
	planes_id integer REFERENCES planes(id),
	seats_id integer REFERENCES seats(id)
);

CREATE TABLE gates (
	id integer UNIQUE PRIMARY KEY,
	number_gate integer NOT NULL,
	planes_id integer REFERENCES planes(id)
);

CREATE TABLE services (
	id integer UNIQUE PRIMARY KEY,
	cost integer NOT NULL,
	planes_id integer REFERENCES planes(id)
);

CREATE TABLE offers (
	id integer UNIQUE PRIMARY KEY,
	city_from VARCHAR(150) NOT NULL,
	city_to VARCHAR(150) NOT NULL,
	cost integer NOT NULL
);

CREATE TABLE customers (
	id integer UNIQUE PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	surname VARCHAR(150) NOT NULL,
	email VARCHAR(100) NOT NULL,
	sex VARCHAR(15) NOT NULL,
	street VARCHAR(120) NOT NULL,
	city VARCHAR(150) NOT NULL,
	country VARCHAR(150) NOT NULL,
	phone_number VARCHAR(30) NOT NULL
);

CREATE TABLE employers (
	id integer UNIQUE PRIMARY KEY,
	profession VARCHAR(60) NOT NULL,
	name VARCHAR(60) NOT NULL,
	surname VARCHAR(150) NOT NULL,
	email VARCHAR(100) NOT NULL,
	sex VARCHAR(15) NOT NULL,
	street VARCHAR(120) NOT NULL,
	city VARCHAR(150) NOT NULL,
	country VARCHAR(150) NOT NULL,
	phone_number VARCHAR(30) NOT NULL,
	customers_id integer REFERENCES customers(id)
);

CREATE TABLE flights (
	id integer UNIQUE PRIMARY KEY,
	offers_id integer REFERENCES offers(id),
	time_departure TIME NOT NULL,
	time_arrival TIME NOT NULL,
	data DATE NOT NULL,
	flight_duration TIME NOT NULL,
	delays_id integer REFERENCES delays(id),
	gates_id integer REFERENCES gates(id)
);

CREATE TABLE tickets (
	id integer UNIQUE PRIMARY KEY,
	customers_id integer REFERENCES customers(id),
	flights_id integer REFERENCES flights(id),
	seats_id integer REFERENCES seats(id),
	gates_id integer REFERENCES gates(id),
	classes_id integer REFERENCES classes(id)
);



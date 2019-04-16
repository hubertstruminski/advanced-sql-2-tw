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


CREATE SEQUENCE delays_id_seq;
ALTER TABLE delays ALTER id SET DEFAULT NEXTVAL('delays_id_seq');
CREATE SEQUENCE classes_id_seq;
ALTER TABLE classes ALTER id SET DEFAULT NEXTVAL('classes_id_seq');
CREATE SEQUENCE seats_id_seq;
ALTER TABLE seats ALTER id SET DEFAULT NEXTVAL('seats_id_seq');
CREATE SEQUENCE planes_id_seq;
ALTER TABLE planes ALTER id SET DEFAULT NEXTVAL('planes_id_seq');
CREATE SEQUENCE pleans_seats_id_seq;
ALTER TABLE planes_seats ALTER id SET DEFAULT NEXTVAL('pleans_seats_id_seq');
CREATE SEQUENCE gates_id_seq;
ALTER TABLE gates ALTER id SET DEFAULT NEXTVAL('gates_id_seq');
CREATE SEQUENCE services_id_seq;
ALTER TABLE services ALTER id SET DEFAULT NEXTVAL('services_id_seq');
CREATE SEQUENCE offers_id_seq;
ALTER TABLE offers ALTER id SET DEFAULT NEXTVAL('offers_id_seq');
CREATE SEQUENCE customers_id_seq;
ALTER TABLE customers ALTER id SET DEFAULT NEXTVAL('customers_id_seq');
CREATE SEQUENCE employers_id_seq;
ALTER TABLE employers ALTER id SET DEFAULT NEXTVAL('employers_id_seq');
CREATE SEQUENCE flights_id_seq;
ALTER TABLE flights ALTER id SET DEFAULT NEXTVAL('flights_id_seq');
CREATE SEQUENCE tickets_id_seq;
ALTER TABLE tickets ALTER id SET DEFAULT NEXTVAL('tickets_id_seq');

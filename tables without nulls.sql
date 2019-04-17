CREATE TABLE delays (
	id integer UNIQUE PRIMARY KEY,
	name VARCHAR(15)
);

CREATE TABLE classes (
	id integer UNIQUE PRIMARY KEY,
	name VARCHAR(20)
);

CREATE TABLE seats (
	id integer UNIQUE PRIMARY KEY,
	number_place integer,
	classes_id integer REFERENCES classes(id) ON DELETE CASCADE
);

CREATE TABLE planes (
	id integer UNIQUE PRIMARY KEY,
	name VARCHAR(60)
);

CREATE TABLE planes_seats (
	id integer UNIQUE PRIMARY KEY,
	planes_id integer REFERENCES planes(id) ON DELETE CASCADE,
	seats_id integer REFERENCES seats(id) ON DELETE CASCADE
);

CREATE TABLE gates (
	id integer UNIQUE PRIMARY KEY,
	number_gate integer,
	planes_id integer REFERENCES planes(id) ON DELETE CASCADE
);

CREATE TABLE services (
	id integer UNIQUE PRIMARY KEY,
	cost integer,
	planes_id integer REFERENCES planes(id) ON DELETE CASCADE
);

CREATE TABLE offers (
	id integer UNIQUE PRIMARY KEY,
	city_from VARCHAR(150),
	city_to VARCHAR(150),
	cost integer
);

CREATE TABLE customers (
	id integer UNIQUE PRIMARY KEY,
	name VARCHAR(60),
	surname VARCHAR(150),
	email VARCHAR(100),
	sex VARCHAR(15),
	street VARCHAR(120),
	city VARCHAR(150),
	country VARCHAR(150),
	phone_number VARCHAR(30)
);

CREATE TABLE employers (
	id integer UNIQUE PRIMARY KEY,
	profession VARCHAR(60),
	name VARCHAR(60),
	surname VARCHAR(150),
	email VARCHAR(100),
	sex VARCHAR(15),
	street VARCHAR(120),
	city VARCHAR(150),
	country VARCHAR(150),
	phone_number VARCHAR(30)
);

CREATE TABLE flights (
	id integer UNIQUE PRIMARY KEY,
	offers_id integer REFERENCES offers(id) ON DELETE CASCADE,
	time_departure TIME,
	time_arrival TIME,
	data DATE,
	flight_duration integer,
	delays_id integer REFERENCES delays(id) ON DELETE CASCADE,
	gates_id integer REFERENCES gates(id) ON DELETE CASCADE
);

CREATE TABLE tickets (
	id integer UNIQUE PRIMARY KEY,
	customers_id integer REFERENCES customers(id) ON DELETE CASCADE,
	flights_id integer REFERENCES flights(id) ON DELETE CASCADE,
	seats_id integer REFERENCES seats(id) ON DELETE CASCADE,
	gates_id integer REFERENCES gates(id) ON DELETE CASCADE,
	classes_id integer REFERENCES classes(id) ON DELETE CASCADE
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

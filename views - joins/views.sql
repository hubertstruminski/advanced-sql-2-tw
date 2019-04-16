1.
CREATE MATERIALIZED VIEW ticket_view AS
	SELECT cu.name, cu.surname, f.data AS flight_data, f.time_departure, g.number_gate, s.number_place, cl.name AS class_name FROM tickets t
	INNER JOIN flights f ON t.flights_id = f.id
	INNER JOIN customers cu ON cu.id = t.customers_id
	INNER JOIN gates g ON g.id = t.gates_id
	INNER JOIN seats s ON s.id = t.seats_id
	INNER JOIN classes cl ON cl.id = t.classes_id
WITH DATA;


2.

CREATE MATERIALIZED VIEW flight_departure_view AS
	SELECT f.id, o.city_to AS destination, f.time_departure, f.data AS data_flight, g.number_gate, d.name AS delay_name FROM flights f
	INNER JOIN offers o ON f.offers_id = o.id
	INNER JOIN gates g ON g.id = f.gates_id
	INNER JOIN delays d ON d.id = f.delays_id
	ORDER BY f.time_departure ASC
WITH DATA;


3.

CREATE MATERIALIZED VIEW flight_departure_cancelled_view AS
	SELECT id, destination, number_gate	FROM public.flight_departure_view WHERE delay_name LIKE 'cancelled'
WITH DATA;


4.

CREATE MATERIALIZED VIEW employers_consumer_services_view AS
	SELECT name AS employee_name, surname AS employee_surname, profession, phone_number FROM employers WHERE profession LIKE 'Consumer Services'
WITH DATA;

5.

CREATE MATERIALIZED VIEW customers_tickets_information_view AS
	SELECT cu.name, cu.surname, cu.phone_number, o.city_from, o.city_to, g.number_gate FROM tickets t
	INNER JOIN customers cu ON cu.id = t.customers_id
	INNER JOIN flights f ON f.id = t.flights_id
	INNER JOIN offers o ON o.id = f.offers_id
	INNER JOIN gates g ON t.gates_id = g.id
WITH DATA;


6.

CREATE MATERIALIZED VIEW cost_repair_airbus_view AS
	SELECT s.id AS service_id, s.cost AS service_cost, p.id AS plane_id, p.name AS plane_name FROM services s
	INNER JOIN planes p ON s.planes_id = p.id
	WHERE p.name LIKE 'Airbus%'
WITH DATA;


7.


CREATE MATERIALIZED VIEW cost_repair_boeing_view AS
	SELECT s.id AS service_id, s.cost AS service_cost, p.id AS plane_id, p.name AS plane_name FROM services s
	INNER JOIN planes p ON s.planes_id = p.id
	WHERE p.name LIKE 'Boeing%'
WITH DATA;


8.

CREATE MATERIALIZED VIEW passengers_first_class_view AS
	SELECT cu.name, cu.surname, cu.country, cu.phone_number, o.city_to AS destination, cl.name AS class_name FROM tickets t
	INNER JOIN customers cu ON cu.id = t.customers_id
	INNER JOIN flights f ON f.id = t.flights_id
	INNER JOIN offers o ON o.id = f.offers_id
	INNER JOIN classes cl ON cl.id = t.classes_id
	WHERE cl.name LIKE 'first class'
	ORDER BY cu.surname ASC
WITH DATA;


9.

CREATE MATERIALIZED VIEW passengers_first_class_view AS
	SELECT cu.name, cu.surname, cu.country, cu.phone_number, o.city_to AS destination, cl.name AS class_name FROM tickets t
	INNER JOIN customers cu ON cu.id = t.customers_id
	INNER JOIN flights f ON f.id = t.flights_id
	INNER JOIN offers o ON o.id = f.offers_id
	INNER JOIN classes cl ON cl.id = t.classes_id
	WHERE cl.name LIKE 'business'
	ORDER BY cu.surname ASC
WITH DATA;


10.

CREATE MATERIALIZED VIEW passengers_economical_premium_class_view AS
	SELECT cu.name, cu.surname, cu.country, cu.phone_number, o.city_to AS destination, cl.name AS class_name FROM tickets t
	JOIN customers cu ON cu.id = t.customers_id
	JOIN flights f ON f.id = t.flights_id
	JOIN offers o ON o.id = f.offers_id
	JOIN classes cl ON cl.id = t.classes_id
	WHERE cl.name LIKE 'economical premium'
	ORDER BY cu.surname
WITH DATA;

CREATE FUNCTION delays_delete() RETURNS trigger AS $$
BEGIN
	IF OLD.id IS NULL THEN
		RAISE EXCEPTION 'ID cannot be null';
	END IF;
	
	DELETE FROM flights WHERE flights.delays_id = OLD.id;
	DELETE FROM delays WHERE id = OLD.id;
	
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;


CREATE FUNCTION classes_delete() RETURNS trigger AS $$
BEGIN
	IF OLD.id IS NULL THEN
		RAISE EXCEPTION 'ID cannot be null';
	END IF;
	
	DELETE FROM tickets WHERE tickets.classes_id = OLD.id;
	DELETE FROM seats WHERE seats.classes_id = OLD.id;
	DELETE FROM classes WHERE id = OLD.id;
	
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;


CREATE FUNCTION gates_delete() RETURNS trigger AS $$
BEGIN
	IF OLD.id IS NULL THEN
		RAISE EXCEPTION 'ID cannot be null';
	END IF;
	
	DELETE FROM tickets WHERE tickets.gates_id = OLD.id;
	DELETE FROM flights WHERE flights.gates_id = OLD.id;
	DELETE FROM gates WHERE id = OLD.id;
	
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;


CREATE FUNCTION seats_delete() RETURNS trigger AS $$
BEGIN
	IF OLD.id IS NULL THEN
		RAISE EXCEPTION 'ID cannot be null';
	END IF;
	
	DELETE FROM tickets WHERE tickets.seats_id = OLD.id;
	DELETE FROM planes_seats WHERE planes_seats.seats_id = OLD.id;
	DELETE FROM seats WHERE id = OLD.id;
	
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;



CREATE FUNCTION flights_delete() RETURNS trigger AS $$
BEGIN
	IF OLD.id IS NULL THEN
		RAISE EXCEPTION 'ID cannot be null';
	END IF;
	
	DELETE FROM tickets WHERE tickets.flights_id = OLD.id;
	DELETE FROM flights WHERE id = OLD.id;
	
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;


CREATE FUNCTION customers_delete() RETURNS trigger AS $$
BEGIN
	IF OLD.id IS NULL THEN
		RAISE EXCEPTION 'ID cannot be null';
	END IF;
	
	DELETE FROM tickets WHERE tickets.customers_id = OLD.id;
	DELETE FROM customers WHERE id = OLD.id;
	
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;



CREATE FUNCTION offers_delete() RETURNS trigger AS $$
BEGIN
	IF OLD.id IS NULL THEN
		RAISE EXCEPTION 'ID cannot be null';
	END IF;
	
	DELETE FROM flights WHERE flights.offers_id = OLD.id;
	DELETE FROM offers WHERE id = OLD.id;
	
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;


CREATE FUNCTION planes_delete() RETURNS trigger AS $$
BEGIN
	IF OLD.id IS NULL THEN
		RAISE EXCEPTION 'ID cannot be null';
	END IF;
	
	DELETE FROM services WHERE services.planes_id = OLD.id;
	DELETE FROM gates WHERE gates.planes_id = OLD.id;
	DELETE FROM planes_seats WHERE planes_seats.planes_id = OLD.id;
	DELETE FROM planes WHERE id = OLD.id;
	
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;

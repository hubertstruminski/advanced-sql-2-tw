CREATE FUNCTION delays_insert() RETURN trigger AS $$
BEGIN
	IF NEW.name IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'name cannot be null';
	ELSIF NEW.name !~ '^[A-Za-z]{3,}' THEN
		RAISE EXCEPTION 'Given value is not a name';
	ELSE
		INSERT INTO delays (name) VALUES (NEW.name);
		RETURN NEW;
	END IF;
END;
$$ 
LANGUAGE plpgsql;


CREATE FUNCTION classes_insert() RETURNS trigger AS $$
BEGIN
	IF NEW.name IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'name cannot be null';
	ELSIF NEW.name !~ '^[A-Za-z]{2,}' THEN
		RAISE EXCEPTION 'Given value is not a name';
	ELSE
		INSERT INTO delays (name) VALUES (NEW.name);
		RETURN NEW;
	END IF;
END;
$$ 
LANGUAGE plpgsql;


CREATE FUNCTION seats_insert() RETURNS trigger AS $$
DECLARE
	result integer;
BEGIN
	IF NEW.number_place IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'number of place cannot be null';
	END IF;
	
	IF NEW.classes_id IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'classes_id cannnot be null';
	ELSE
		SELECT id INTO result FROM classes WHERE id = NEW.classes_id;
		
		IF result IS DISTINCT FROM NULL THEN
			INSERT INTO seats (number_place, classes_id) VALUES (NEW.number_place, NEW.classes_id);
			RETURN NEW;
		ELSE
			RAISE EXCEPTION 'Given value of classes_id doesn''t exsist';
		END IF;
	END IF;
END;

$$ 
LANGUAGE plpgsql;



CREATE FUNCTION planes_insert() RETURNS trigger AS $$
BEGIN
	IF NEW.name IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'name cannot be null';
	ELSIF NEW.name !~ '^[A-Za-z]{2,}' THEN
		RAISE EXCEPTION 'Given value is not a name';
	ELSE
		INSERT INTO delays (name) VALUES (NEW.name);
		RETURN NEW;
	END IF;
END;
$$ 
LANGUAGE plpgsql;



CREATE FUNCTION planes_seats_insert() RETURNS trigger AS $$
DECLARE
	var_plane integer;
	var_seat integer;
BEGIN

	IF NEW.planes_id IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'planes_id cannnot be null';
	ELSE
		IF NEW.seats_id IS NOT DISTINCT FROM NULL THEN
			RAISE EXCEPTION 'seats_id cannnot be null';
		ELSE
			SELECT id INTO var_plane FROM planes WHERE id = NEW.planes_id;
			
			IF var_plane IS DISTINCT FROM NULL THEN
				SELECT id INTO var_seat FROM seats WHERE id = NEW.seats_id;
				
				IF var_seat IS DISTINCT FROM NULL THEN
					INSERT INTO planes_seats (planes_id, seats_id) VALUES (NEW.planes_id, NEW.seats_id);
					RETURN NEW;
				ELSE
					RAISE EXCEPTION 'Given value of seats_id doesnt'' exsist';
				END IF;
			ELSE
				RAISE EXCEPTION 'Given value of planes_id doesnt'' exsist';
			END IF;
		END IF;
	END IF;
END;
$$ 
LANGUAGE plpgsql;



CREATE FUNCTION gates_insert() RETURNS trigger AS $$
DECLARE
	var_plane integer;
BEGIN
	IF NEW.number_gate IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'number of place cannot be null';
	END IF;
	
	IF NEW.planes_id IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'planes_id cannnot be null';
	ELSE
		SELECT id INTO var_plane FROM planes WHERE id = NEW.planes_id;
		
		IF var_plane IS DISTINCT FROM NULL THEN
			INSERT INTO gates (number_gate, planes_id) VALUES (NEW.number_gate, NEW.planes_id);
			RETURN NEW;
		ELSE
			RAISE EXCEPTION 'Given value of planes_id doesn''t exist';
		END IF;
	END IF;
END;
$$ 
LANGUAGE plpgsql;


CREATE FUNCTION services_insert() RETURNS trigger AS $$
DECLARE
	var_plane integer;
BEGIN
	IF NEW.cost IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'cost cannot be null';
	ELSIF NEW.cost < 0 THEN
		RAISE EXCEPTION 'cost cannot be negative value';
	END IF;
	
	IF NEW.planes_id IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'planes_id cannnot be null';
	ELSE
		SELECT id INTO var_plane FROM planes WHERE id = NEW.planes_id;
		
		IF var_plane IS DISTINCT FROM NULL THEN
			INSERT INTO services (cost, planes_id) VALUES (NEW.cost, NEW.planes_id);
			RETURN NEW;
		ELSE
			RAISE EXCEPTION 'Given value of planes_id doesn''t exist';
		END IF;
	END IF;
END;
$$ 
LANGUAGE plpgsql;


CREATE FUNCTION offers_insert() RETURNS trigger AS $$
BEGIN
	
	IF NEW.city_from IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'city_from cannot be null';
	ELSIF NEW.city_from !~ '^[A-Za-z]{2,}' OR NEW.city_to !~ '^[A-Za-z]{2,}' THEN
		RAISE EXCEPTION 'Given value is not a city';
	END IF;
	
	IF NEW.city_to IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'city_to cannot be null';
	END IF;
	
	IF NEW.cost IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'cost cannot be null';
	ELSIF NEW.cost < 0 THEN
		RAISE EXCEPTION 'cost cannot be negative value';
	ELSE
		INSERT INTO offers (city_from, city_to, cost) VALUES (NEW.city_from, NEW.city_to, NEW.cost);
		RETURN NEW;
	END IF;
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;


CREATE FUNCTION customers_insert() RETURNS trigger AS $$
DECLARE
	inputs text ARRAY DEFAULT ARRAY[NEW.name, NEW.surname, NEW.email, NEW.sex, NEW.street, NEW.city, NEW.country, NEW.phone_number];
	length integer := array_length(inputs, 1);
BEGIN
	
	FOR i IN 1..length LOOP
		IF inputs[i] IS NOT DISTINCT FROM NULL THEN
			RAISE EXCEPTION 'cannot assign null to any field';
		ELSIF i = 3 THEN
			IF inputs[i] !~ '[A-Za-z0-9.]+@[a-zA-Z0-9]{2,8}\.[A-Za-z]{2,3}' THEN
				RAISE EXCEPTION 'Given value is not an email';
			END IF;
		ELSIF i = 4 THEN
			IF inputs[i] !~ '[A-Za-z]{1,}' THEN
				RAISE EXCEPTION 'Given value is not a sex';
			END IF;
		ELSIF i = 8 THEN
			IF inputs[i] !~ '\d{3}-\d{3}-\d{3}' THEN
				RAISE EXCEPTION 'Given value is not a phone number';
			END IF;
		ELSE
			IF inputs[i] !~ '[A-Za-z]{2,}' THEN
				RAISE EXCEPTION 'Given value doesn''t match to any field';
			END IF;
		END IF;
	END LOOP;
	
	INSERT INTO customers (name, surname, email, sex, street, city, country, phone_number) 
	VALUES (NEW.name, NEW.surname, NEW.email, NEW.sex, NEW.street, NEW.city, NEW.country, NEW.phone_number);
	
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;


CREATE FUNCTION employers_insert() RETURNS trigger AS $$
DECLARE
	inputs text ARRAY DEFAULT ARRAY[NEW.name, NEW.surname, NEW.email, NEW.sex, NEW.street, NEW.city, NEW.country, NEW.phone_number, NEW.profession];
	length integer := array_length(inputs, 1);
BEGIN
	
	FOR i IN 1..length LOOP
		IF inputs[i] IS NOT DISTINCT FROM NULL THEN
			RAISE EXCEPTION 'cannot assign null to any field';
		ELSIF i = 3 THEN
			IF inputs[i] !~ '[A-Za-z0-9.]+@[a-zA-Z0-9]{2,8}\.[A-Za-z]{2,3}' THEN
				RAISE EXCEPTION 'Given value is not an email';
			END IF;
		ELSIF i = 4 THEN
			IF inputs[i] !~ '[A-Za-z]{1,}' THEN
				RAISE EXCEPTION 'Given value is not a sex';
			END IF;
		ELSIF i = 8 THEN
			IF inputs[i] !~ '\d{3}-\d{3}-\d{3}' THEN
				RAISE EXCEPTION 'Given value is not a phone number';
			END IF;
		ELSE
			IF inputs[i] !~ '[A-Za-z]{2,}' THEN
				RAISE EXCEPTION 'Given value doesn''t match to any field';
			END IF;
		END IF;
	END LOOP;
	
	INSERT INTO employers (profession, name, surname, email, sex, street, city, country, phone_number) 
	VALUES (NEW.profession, NEW.name, NEW.surname, NEW.email, NEW.sex, NEW.street, NEW.city, NEW.country, NEW.phone_number);
	
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;


CREATE FUNCTION flights_insert() RETURNS trigger AS $$
DECLARE
	var_offer integer;
	var_delay integer;
	var_gate integer;
BEGIN
	
	IF NEW.offers_id IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'offers_id cannot be null';
	ELSE
		SELECT id INTO var_offer FROM offers WHERE id = NEW.offers_id;
	END IF;
	
	IF NEW.time_departure IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'time_departure cannot be null';
	END IF;
	
	IF NEW.time_arrival IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'time_arrival cannot be null';
	END IF;
	
	IF NEW.data IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'data cannot be null';
	END IF;
	
	IF NEW.flight_duration IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'flight_duration cannot be null';
	END IF;
	
	IF NEW.delays_id IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'delays_id cannot be null';
	ELSE
		SELECT id INTO var_delay FROM delays WHERE id = NEW.delays_id;
	END IF;
	
	IF NEW.gates_id IS NOT DISTINCT FROM NULL THEN
		RAISE EXCEPTION 'gates_id cannot be null';
	ELSE
		SELECT id INTO var_gate FROM gates WHERE id = NEW.gates_id;
	END IF;
	
	IF NEW.offers_id IS NOT DISTINCT FROM null OR NEW.delays_id IS NOT DISTINCT FROM null OR NEW.gates_id IS NOT DISTINCT FROM null THEN
		RAISE EXCEPTION 'offers_id or delays_id or gates_id cannot be null';
	ELSE
		INSERT INTO flights (offers_id, time_departure, time_arrival, data, flight_duration, delays_id, gates_id)
		VALUES (NEW.offers_id, NEW.time_departure, NEW.time_arrival, NEW.data, NEW.flight_duration, NEW.delays_id, NEW.gates_id);
		RETURN NEW;
	END IF;
END;
$$
LANGUAGE plpgsql;


CREATE FUNCTION tickets_insert() RETURNS trigger AS $$
DECLARE
	customer integer;
	flight integer;
	seat integer;
	gate integer;
	var_class integer;
BEGIN
	
	IF NEW.customers_id IS NOT DISTINCT FROM null THEN
		RAISE EXCEPTION 'customers_id cannot be null';
	ELSE
		SELECT id INTO customer FROM customers WHERE id = NEW.customers_id;
	END IF;
	
	IF NEW.flights_id IS NOT DISTINCT FROM null THEN
		RAISE EXCEPTION 'flights_id cannot be null';
	ELSE
		SELECT id INTO flight FROM flights WHERE id = NEW.flights_id;
	END IF;
	
	IF NEW.seats_id IS NOT DISTINCT FROM null THEN
		RAISE EXCEPTION 'seats_id cannot be null';
	ELSE
		SELECT id INTO seat FROM seats WHERE id = NEW.seats_id;
	END IF;
	
	IF NEW.gates_id IS NOT DISTINCT FROM null THEN
		RAISE EXCEPTION 'gates_id cannot be null';
	ELSE
		SELECT id INTO gate FROM gates WHERE id = NEW.gates_id;
	END IF;
	
	IF NEW.classes_id IS NOT DISTINCT FROM null THEN
		RAISE EXCEPTION 'classes_id cannot be null';
	ELSE
		SELECT id INTO var_class FROM classes WHERE id = NEW.classes_id;
	END IF;
	
	IF customer IS NOT NULL OR flight IS NOT NULL OR seat IS NOT NULL OR gate IS NOT NULL OR var_class IS NOT NULL THEN
		RAISE EXCEPTION 'customers_id or flights_id or seats_id or gates_id or classes_id cannot be null';
	ELSE
		INSERT INTO tickets (customers_id, flights_id, seats_id, gates_id, classes_id) 
		VALUES (NEW.customers_id, NEW.flights_id, NEW.seats_id, NEW.gates_id, NEW.classes_id);
		RETURN NEW;
	END IF;
END;
$$
LANGUAGE plpgsql;

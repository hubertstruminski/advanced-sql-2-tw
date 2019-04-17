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

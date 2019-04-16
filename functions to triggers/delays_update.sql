CREATE FUNCTION delays_update() RETURNS trigger AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		IF NEW.name IS NULL THEN
			RAISE EXCEPTION 'name cannot be null';
		END IF;
		
		IF NEW.id IS NULL THEN
			INSERT INTO delays (name) VALUES(NEW.name);
		ELSE
			INSERT INTO delays (id, name) VALUES (NEW.id, NEW.name);
		END IF;
		RETURN NEW;
	END IF;
	
	IF TG_OP = 'UPDATE' THEN
		UPDATE delays SET name = NEW.name WHERE id = OLD.id;
		IF NOT FOUND THEN
			RETURN NULL;
		END IF;
		RETURN NEW;
	END IF;
	
	IF TG_OP = 'DELETE' THEN
		DELETE FROM delays WHERE id = OLD.id;
		IF NOT FOUND THEN
			RETURN NULL;
		END IF;
		RETURN OLD;
	END IF;
END;
$$
LANGUAGE plpgsql;

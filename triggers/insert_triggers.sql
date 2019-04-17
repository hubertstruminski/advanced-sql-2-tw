CREATE TRIGGER delays_insert_trigger
BEFORE INSERT ON delays
FOR EACH ROW
EXECUTE PROCEDURE delays_insert();

CREATE TRIGGER classes_insert_trigger
BEFORE INSERT ON classes 
FOR EACH ROW 
WHEN (pg_trigger_depth() = 0)
EXECUTE PROCEDURE classes_insert();

CREATE TRIGGER seats_insert_trigger
BEFORE INSERT ON seats
FOR EACH ROW
WHEN (pg_trigger_depth() = 0)
EXECUTE PROCEDURE seats_insert();

CREATE TRIGGER planes_insert_trigger
BEFORE INSERT ON planes
FOR EACH ROW
WHEN (pg_trigger_depth() = 0)
EXECUTE PROCEDURE planes_insert();

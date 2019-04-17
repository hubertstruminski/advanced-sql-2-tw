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

CREATE TRIGGER planes_seats_insert_trigger
BEFORE INSERT ON planes_seats
FOR EACH ROW
WHEN (pg_trigger_depth() = 0)
EXECUTE PROCEDURE planes_seats_insert();

CREATE TRIGGER services_insert_trigger
BEFORE INSERT ON services
FOR EACH ROW
WHEN (pg_trigger_depth() = 0)
EXECUTE PROCEDURE services_insert();

CREATE TRIGGER offers_insert_trigger
BEFORE INSERT ON offers
FOR EACH ROW
WHEN (pg_trigger_depth() = 0)
EXECUTE PROCEDURE offers_insert();

CREATE TRIGGER employers_insert_trigger
BEFORE INSERT ON employers
FOR EACH ROW
WHEN (pg_trigger_depth() = 0)
EXECUTE PROCEDURE employers_insert();

CREATE TRIGGER flights_insert_trigger
BEFORE INSERT ON flights
FOR EACH ROW
WHEN (pg_trigger_depth() = 0)
EXECUTE PROCEDURE flights_insert();

CREATE TRIGGER tickets_insert_trigger
BEFORE INSERT ON tickets
FOR EACH ROW
WHEN (pg_trigger_depth() = 0)
EXECUTE PROCEDURE tickets_insert();

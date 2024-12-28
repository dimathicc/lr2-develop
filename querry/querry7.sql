CREATE OR REPLACE FUNCTION enforce_valid_parent()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idparent IS NOT NULL THEN
        IF (SELECT COUNT(*) FROM SouvenirCategories WHERE id = NEW.idparent) = 0 THEN
            RAISE EXCEPTION 'Такой parent id % не существует', NEW.idparent;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_parent_id
BEFORE INSERT OR UPDATE ON SouvenirCategories
FOR EACH ROW
EXECUTE FUNCTION enforce_valid_parent();

INSERT INTO SouvenirCategories (idparent, name) VALUES (6666, 'Некорректная категория') RETURNING id;

DROP TRIGGER IF EXISTS validate_parent_id ON SouvenirCategories;
DROP FUNCTION IF EXISTS enforce_valid_parent CASCADE;

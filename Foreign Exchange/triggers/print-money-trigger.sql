DELIMITER //
DROP TRIGGER IF EXISTS printMoneyUSA //
CREATE TRIGGER printMoneyUSA
    BEFORE UPDATE ON USA

    FOR EACH ROW
    BEGIN
        if OLD.SUPPLY_OF_CURRENCY = 0 then
            set NEW.SUPPLY_OF_CURRENCY = 30000000000;
        end if;
    END //
DELIMITER;
DELIMITER $$
DROP TRIGGER IF EXISTS change_interest_rate $$
CREATE TRIGGER change_interest_rate
  BEFORE UPDATE ON USA
  FOR EACH ROW
BEGIN
  SET @old_interest = OLD.EXCHANGE_RATE;
  SET @new_interest = NEW.EXCHANGE_RATE;
  CALL change_interest_rate('USD', @old_interest, @new_interest);
END$$
DELIMITER ;

/*----------*/

DELIMITER $$
DROP TRIGGER IF EXISTS change_interest_rate $$
CREATE TRIGGER change_interest_rate
  BEFORE UPDATE ON CHINA
  FOR EACH ROW
BEGIN
  SET @old_interest = OLD.EXCHANGE_RATE;
  SET @new_interest = NEW.EXCHANGE_RATE;
  CALL change_interest_rate('CNY', @old_interest, @new_interest);
END$$
DELIMITER ;

/*----------*/

DELIMITER $$
DROP TRIGGER IF EXISTS change_interest_rate $$
CREATE TRIGGER change_interest_rate
  BEFORE UPDATE ON RUSSIA
  FOR EACH ROW
BEGIN
  SET @old_interest = OLD.EXCHANGE_RATE;
  SET @new_interest = NEW.EXCHANGE_RATE;
  CALL change_interest_rate('RUB', @old_interest, @new_interest);
END$$
DELIMITER ;


/*----------*/

DELIMITER $$
DROP TRIGGER IF EXISTS change_interest_rate $$
CREATE TRIGGER change_interest_rate
  BEFORE UPDATE ON EU
  FOR EACH ROW
BEGIN
  SET @old_interest = OLD.EXCHANGE_RATE;
  SET @new_interest = NEW.EXCHANGE_RATE;
  CALL change_interest_rate('EUR', @old_interest, @new_interest);
END$$
DELIMITER ;


/*----------*/


DELIMITER $$
DROP TRIGGER IF EXISTS change_interest_rate $$
CREATE TRIGGER change_interest_rate
  BEFORE UPDATE ON JAPAN
  FOR EACH ROW
BEGIN
  SET @old_interest = OLD.EXCHANGE_RATE;
  SET @new_interest = NEW.EXCHANGE_RATE;
  CALL change_interest_rate('JPY', @old_interest, @new_interest);
END$$
DELIMITER ;


/*----------*/


DELIMITER $$
DROP PROCEDURE IF EXISTS change_interest_rate $$
CREATE PROCEDURE change_interest_rate(IN iso_code VARCHAR(20), IN old_exchange_rate DECIMAL(18, 4), IN new_exchange_rate DECIMAL(18, 4))
  
  SET @iso = iso_code;
  SET @old_interest = (SELECT COUPON FROM BOND_RATES WHERE COUNTRY_ISO = @iso); 
  
  IF (old_exchange_rate < new_exchange_rate) THEN
      SET @new_interest = @old_interest * 0.95; /* calculate new interest by decreasing by 5% */
 ELSE
      SET @new_interest = @old_interest * 1.05; /* calculate new interest by increasing by 5% */
END IF;
UPDATE BOND_RATES SET COUPON = @new_interest WHERE COUNTRY_ISO = @iso;

END $$
DELIMITER ;

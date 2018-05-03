DELIMITER $$
DROP TRIGGER IF EXISTS change_interest_rate $$
CREATE TRIGGER change_interest_rate 
AFTER UPDATE ON CURRENCY_EXCHANGE
FOR EACH ROW
BEGIN
DECLARE OLD_BOND_COUPON DECIMAL(18,2);
IF NEW.USD < (OLD.USD * 0.9) THEN
SELECT COUPON INTO OLD_BOND_COUPON FROM BOND_RATES WHERE COUNTRY_ISO = 'USD';
UPDATE BOND_RATES SET COUPON = OLD_BOND_COUPON * 1.1 WHERE COUNTRY_ISO = 'USD';
CALL buy_bond_usd_cny();
CALL buy_bond_usd_jpy();
CALL buy_bond_usd_rub();
CALL buy_bond_usd_eur();
ELSEIF NEW.CNY < (OLD.CNY * 0.9) THEN
SELECT COUPON INTO OLD_BOND_COUPON FROM BOND_RATES WHERE COUNTRY_ISO = 'CNY';
UPDATE BOND_RATES SET COUPON = OLD_BOND_COUPON * 1.1 WHERE COUNTRY_ISO = 'CNY';	
CALL buy_bond_cny_usd();
CALL buy_bond_cny_jpy();
CALL buy_bond_cny_eur();
CALL buy_bond_cny_rub();
ELSEIF NEW.RUB < (OLD.RUB * 0.9) THEN
SELECT COUPON INTO OLD_BOND_COUPON FROM BOND_RATES WHERE COUNTRY_ISO = 'RUB';
UPDATE BOND_RATES SET COUPON = OLD_BOND_COUPON * 1.1 WHERE COUNTRY_ISO = 'RUB';	
CALL buy_bond_rub_usd();
CALL buy_bond_rub_eur();
CALL buy_bond_rub_cny();
CALL buy_bond_rub_jpy();
ELSEIF NEW.JPY < (OLD.JPY * 0.9) THEN
SELECT COUPON INTO OLD_BOND_COUPON FROM BOND_RATES WHERE COUNTRY_ISO = 'JPY';
UPDATE BOND_RATES SET COUPON = OLD_BOND_COUPON * 1.1 WHERE COUNTRY_ISO = 'JPY';	
CALL buy_bond_jpy_usd();
CALL buy_bond_jpy_cny();
CALL buy_bond_jpy_eur();
CALL buy_bond_jpy_rub();
ELSEIF NEW.EUR < (OLD.EUR * 0.9) THEN
SELECT COUPON INTO OLD_BOND_COUPON FROM BOND_RATES WHERE COUNTRY_ISO = 'EUR';
UPDATE BOND_RATES SET COUPON = OLD_BOND_COUPON * 1.1 WHERE COUNTRY_ISO = 'EUR';	
CALL buy_bond_eur_usd();
CALL buy_bond_eur_jpy();
CALL buy_bond_eur_cny();
CALL buy_bond_eur_rub();
END IF;
END $$
DELIMITER ;

/*********************************
Procedure: change_interest_rate
**********************************/
/* Do this when reserve is less than or equal to zero */
DELIMITER $$
DROP PROCEDURE IF EXISTS change_interest_rate $$
CREATE PROCEDURE change_interest_rate(IN iso_code VARCHAR(20), IN old_exchange_rate DECIMAL(18, 4), IN new_exchange_rate DECIMAL(18, 4))
  /**************************************************************************
     ISO_CODE = The current country
     OLD_EXCHANGE_RATE = old exchange rate of the country's bond.
     NEW_EXCHANGE_RATE = new exchange rate of the country's bond.
  ***************************************************************************/
  BEGIN
  SET @old_interest = CONCAT("SELECT COUPON FROM BOND_RATES WHERE COUNTRY_ISO = '", iso_code, "'"); /* get coupon rate */

  IF (old_exchange_rate < new_exchange_rate) THEN
      SET @new_interest = @old_interest * 0.95; /* calculate new interest by decreasing by 5% */
  ELSE
      /* When the bond interest rate goes up, every other country wants to buy more bonds.
         The buy_bonds procedure mimics this behavior and intiates the trading of bonds
         between this country and all other countries. */
      SET @new_interest = @old_interest * 1.05; /* calculate new interest by increasing by 5% */

      IF iso_code = 'USD' THEN
                CALL buy_bond('USD', 'CNY');
                CALL buy_bond('USD', 'RUB');
                CALL buy_bond('USD', 'JPY');
                CALL buy_bond('USD', 'EUR');
      ELSEIF iso_code = 'CNY' THEN
                CALL buy_bond('CNY', 'USD');
                CALL buy_bond('CNY', 'RUB');
                CALL buy_bond('CNY', 'JPY');
                CALL buy_bond('CNY', 'EUR');
      ELSEIF iso_code = 'RUB' THEN
                CALL buy_bond('RUB', 'USD');
                CALL buy_bond('RUB', 'CNY');
                CALL buy_bond('RUB', 'JPY');
                CALL buy_bond('RUB', 'EUR');
      ELSEIF iso_code = 'EUR' THEN
                CALL buy_bond('EUR', 'USD');
                CALL buy_bond('EUR', 'RUB');
                CALL buy_bond('EUR', 'JPY');
                CALL buy_bond('EUR', 'CNY');
      ELSEIF iso_code = 'JPY' THEN
                CALL buy_bond('JPY', 'USD');
                CALL buy_bond('JPY', 'RUB');
                CALL buy_bond('JPY', 'CNY');
                CALL buy_bond('JPY', 'EUR');
      END IF;
  END IF;
  UPDATE BOND_RATES SET COUPON = @new_interest WHERE COUNTRY_ISO = iso_code; /* update the new interest rate of the current country */
END $$
DELIMITER ;

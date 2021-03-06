DELIMITER //

CREATE PROCEDURE pay_russia_eu_deficit()
BEGIN

  DECLARE PAY_RATE decimal(3,2);
  DECLARE PAY_RESULT decimal(3,2);
  DECLARE RUSSIA_EU_DEFICIT decimal(18,4);
  DECLARE RUSSIA_EUR_SUPPLY bigint(20);
  DECLARE RUSSIA_EU_PAYMENT decimal(18,4);
  DECLARE EU_EUR_SUPPLY bigint(20);
  DECLARE RUSSIA_EU_DEFICIT_NEW decimal(18,4);

  SET PAY_RATE = 0.1;
  SET PAY_RESULT = 0.9;
  SET RUSSIA_EU_DEFICIT = (SELECT DEFICIT FROM S18336Pteam1.RUSSIA WHERE CURRENCY_ISO = 'EUR');
  SET RUSSIA_EUR_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.RUSSIA WHERE CURRENCY_ISO = 'EUR');
  SET RUSSIA_EU_PAYMENT = (RUSSIA_EU_DEFICIT * PAY_RATE);
  SET EU_EUR_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.EU WHERE CURRENCY_ISO = 'EUR');

  if RUSSIA_EU_DEFICIT < 0 then
    WHILE RUSSIA_EUR_SUPPLY < abs(RUSSIA_EU_PAYMENT) DO
      call generate_rub_trader(2, 'RUB', 'EUR', 1);
      call eur_rub_marketplace;
      SET RUSSIA_EUR_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.RUSSIA WHERE CURRENCY_ISO = 'EUR');
    END WHILE;
    UPDATE S18336Pteam1.RUSSIA SET DEFICIT = (RUSSIA_EU_DEFICIT * PAY_RESULT) WHERE CURRENCY_ISO = 'EUR';
    UPDATE S18336Pteam1.RUSSIA SET SUPPLY_OF_CURRENCY = (RUSSIA_EUR_SUPPLY + RUSSIA_EU_PAYMENT) WHERE CURRENCY_ISO = 'EUR';
    UPDATE S18336Pteam1.EU SET SUPPLY_OF_CURRENCY = (EU_EUR_SUPPLY - RUSSIA_EU_PAYMENT) WHERE CURRENCY_ISO = 'EUR';
    SET RUSSIA_EU_DEFICIT_NEW = (SELECT DEFICIT FROM S18336Pteam1.RUSSIA WHERE CURRENCY_ISO = 'EUR');
    UPDATE S18336Pteam1.EU SET DEFICIT = abs(RUSSIA_EU_DEFICIT_NEW) WHERE CURRENCY_ISO = 'RUB';
  end if;
END //

DELIMITER ;

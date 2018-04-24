DELIMITER //

CREATE PROCEDURE pay_eu_usa_deficit()
BEGIN

  DECLARE PAY_RATE decimal(3,2);
  DECLARE PAY_RESULT decimal(3,2);
  DECLARE EU_USA_DEFICIT decimal(18,4);
  DECLARE EU_USD_SUPPLY bigint(20);
  DECLARE EU_USA_PAYMENT decimal(18,4);
  DECLARE USA_USD_SUPPLY bigint(20);
  DECLARE EU_USA_DEFICIT_NEW decimal(18,4);

  SET PAY_RATE = 0.1;
  SET PAY_RESULT = 0.9;
  SET EU_USA_DEFICIT = (SELECT DEFICIT FROM S18336Pteam1.EU WHERE CURRENCY_ISO = 'USD');
  SET EU_USD_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.EU WHERE CURRENCY_ISO = 'USD');
  SET EU_USA_PAYMENT = (EU_USA_DEFICIT * PAY_RATE);
  SET USA_USD_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.USA WHERE CURRENCY_ISO = 'USD');

  if EU_USA_DEFICIT < 0 then
    WHILE EU_USD_SUPPLY < abs(EU_USA_PAYMENT) DO
      call generate_eur_trader(2, 'EUR', 'USD', 1);
      call eur_usd_marketplace;
      SET EU_USD_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.EU WHERE CURRENCY_ISO = 'USD');
    END WHILE;
    UPDATE S18336Pteam1.EU SET DEFICIT = (EU_USA_DEFICIT * PAY_RESULT) WHERE CURRENCY_ISO = 'USD';
    UPDATE S18336Pteam1.EU SET SUPPLY_OF_CURRENCY = (EU_USD_SUPPLY + EU_USA_PAYMENT) WHERE CURRENCY_ISO = 'USD';
    UPDATE S18336Pteam1.USA SET SUPPLY_OF_CURRENCY = (USA_USD_SUPPLY - EU_USA_PAYMENT) WHERE CURRENCY_ISO = 'USD';
    SET EU_USA_DEFICIT_NEW = (SELECT DEFICIT FROM S18336Pteam1.EU WHERE CURRENCY_ISO = 'USD');
    UPDATE S18336Pteam1.USA SET DEFICIT = abs(EU_USA_DEFICIT_NEW) WHERE CURRENCY_ISO = 'EUR';
  end if;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE pay_china_usa_deficit()
BEGIN

  DECLARE PAY_RATE decimal(3,2);
  DECLARE PAY_RESULT decimal(3,2);
  DECLARE CHINA_USA_DEFICIT decimal(18,4);
  DECLARE CHINA_USD_SUPPLY bigint(20);
  DECLARE CHINA_USA_PAYMENT decimal(18,4);
  DECLARE USA_USD_SUPPLY bigint(20);
  DECLARE CHINA_USA_DEFICIT_NEW decimal(18,4);

  SET PAY_RATE = 0.1;
  SET PAY_RESULT = 0.9;
  SET CHINA_USA_DEFICIT = (SELECT DEFICIT FROM S18336Pteam1.CHINA WHERE CURRENCY_ISO = 'USD');
  SET CHINA_USD_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.CHINA WHERE CURRENCY_ISO = 'USD');
  SET CHINA_USA_PAYMENT = (CHINA_USA_DEFICIT * PAY_RATE);
  SET USA_USD_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.USA WHERE CURRENCY_ISO = 'USD');

  if CHINA_USA_DEFICIT < 0 then
    WHILE CHINA_USD_SUPPLY < abs(CHINA_USA_PAYMENT) DO
      call generate_cny_trader(2, 'CNY', 'USD', 1);
      call cny_usd_marketplace;
      SET CHINA_USD_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.CHINA WHERE CURRENCY_ISO = 'USD');
    END WHILE;
    UPDATE S18336Pteam1.CHINA SET DEFICIT = (CHINA_USA_DEFICIT * PAY_RESULT) WHERE CURRENCY_ISO = 'USD';
    UPDATE S18336Pteam1.CHINA SET SUPPLY_OF_CURRENCY = (CHINA_USD_SUPPLY + CHINA_USA_PAYMENT) WHERE CURRENCY_ISO = 'USD';
    UPDATE S18336Pteam1.USA SET SUPPLY_OF_CURRENCY = (USA_USD_SUPPLY - CHINA_USA_PAYMENT) WHERE CURRENCY_ISO = 'USD';
    SET CHINA_USA_DEFICIT_NEW = (SELECT DEFICIT FROM S18336Pteam1.CHINA WHERE CURRENCY_ISO = 'USD');
    UPDATE S18336Pteam1.USA SET DEFICIT = abs(CHINA_USA_DEFICIT_NEW) WHERE CURRENCY_ISO = 'CNY';
  end if;
END //

DELIMITER ;
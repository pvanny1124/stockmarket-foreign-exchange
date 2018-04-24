DELIMITER //

CREATE PROCEDURE pay_china_japan_deficit()
BEGIN

  DECLARE PAY_RATE decimal(3,2);
  DECLARE PAY_RESULT decimal(3,2);
  DECLARE CHINA_JAPAN_DEFICIT decimal(18,4);
  DECLARE CHINA_JPY_SUPPLY bigint(20);
  DECLARE CHINA_JAPAN_PAYMENT decimal(18,4);
  DECLARE JAPAN_JPY_SUPPLY bigint(20);
  DECLARE CHINA_JAPAN_DEFICIT_NEW decimal(18,4);

  SET PAY_RATE = 0.1;
  SET PAY_RESULT = 0.9;
  SET CHINA_JAPAN_DEFICIT = (SELECT DEFICIT FROM S18336Pteam1.CHINA WHERE CURRENCY_ISO = 'JPY');
  SET CHINA_JPY_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.CHINA WHERE CURRENCY_ISO = 'JPY');
  SET CHINA_JAPAN_PAYMENT = (CHINA_JAPAN_DEFICIT * PAY_RATE);
  SET JAPAN_JPY_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.JAPAN WHERE CURRENCY_ISO = 'JPY');

  if CHINA_JAPAN_DEFICIT < 0 then
    WHILE CHINA_JPY_SUPPLY < abs(CHINA_JAPAN_PAYMENT) DO
      call generate_cny_trader(2, 'CNY', 'JPY', 1);
      call cny_jpy_marketplace;
      SET CHINA_JPY_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.CHINA WHERE CURRENCY_ISO = 'JPY');
    END WHILE;
    UPDATE S18336Pteam1.CHINA SET DEFICIT = (CHINA_JAPAN_DEFICIT * PAY_RESULT) WHERE CURRENCY_ISO = 'JPY';
    UPDATE S18336Pteam1.CHINA SET SUPPLY_OF_CURRENCY = (CHINA_JPY_SUPPLY + CHINA_JAPAN_PAYMENT) WHERE CURRENCY_ISO = 'JPY';
    UPDATE S18336Pteam1.JAPAN SET SUPPLY_OF_CURRENCY = (JAPAN_JPY_SUPPLY - CHINA_JAPAN_PAYMENT) WHERE CURRENCY_ISO = 'JPY';
    SET CHINA_JAPAN_DEFICIT_NEW = (SELECT DEFICIT FROM S18336Pteam1.CHINA WHERE CURRENCY_ISO = 'JPY');
    UPDATE S18336Pteam1.JAPAN SET DEFICIT = abs(CHINA_JAPAN_DEFICIT_NEW) WHERE CURRENCY_ISO = 'CNY';
  end if;
END //

DELIMITER ;
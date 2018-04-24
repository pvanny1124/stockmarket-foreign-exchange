DELIMITER //

CREATE PROCEDURE pay_usa_russia_deficit()
BEGIN

  DECLARE PAY_RATE decimal(3,2);
  DECLARE PAY_RESULT decimal(3,2);
  DECLARE USA_RUSSIA_DEFICIT decimal(18,4);
  DECLARE USA_RUB_SUPPLY bigint(20);
  DECLARE USA_RUSSIA_PAYMENT decimal(18,4);
  DECLARE RUSSIA_RUB_SUPPLY bigint(20);
  DECLARE USA_RUSSIA_DEFICIT_NEW decimal(18,4);

  SET PAY_RATE = 0.1;
  SET PAY_RESULT = 0.9;
  SET USA_RUSSIA_DEFICIT = (SELECT DEFICIT FROM S18336Pteam1.USA WHERE CURRENCY_ISO = 'RUB');
  SET USA_RUB_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.USA WHERE CURRENCY_ISO = 'RUB');
  SET USA_RUSSIA_PAYMENT = (USA_RUSSIA_DEFICIT * PAY_RATE);
  SET RUSSIA_RUB_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.RUSSIA WHERE CURRENCY_ISO = 'RUB');

  if USA_RUSSIA_DEFICIT < 0 then
    WHILE USA_RUB_SUPPLY < abs(USA_RUSSIA_PAYMENT) DO
      call generate_usd_trader(2, 'USD', 'RUB', 1);
      call rub_usd_marketplace;
      SET USA_RUB_SUPPLY = (SELECT SUPPLY_OF_CURRENCY FROM S18336Pteam1.USA WHERE CURRENCY_ISO = 'RUB');
    END WHILE;
    UPDATE S18336Pteam1.USA SET DEFICIT = (USA_RUSSIA_DEFICIT * PAY_RESULT) WHERE CURRENCY_ISO = 'RUB';
    UPDATE S18336Pteam1.USA SET SUPPLY_OF_CURRENCY = (USA_RUB_SUPPLY + USA_RUSSIA_PAYMENT) WHERE CURRENCY_ISO = 'RUB';
    UPDATE S18336Pteam1.RUSSIA SET SUPPLY_OF_CURRENCY = (RUSSIA_RUB_SUPPLY - USA_RUSSIA_PAYMENT) WHERE CURRENCY_ISO = 'RUB';
    SET USA_RUSSIA_DEFICIT_NEW = (SELECT DEFICIT FROM S18336Pteam1.USA WHERE CURRENCY_ISO = 'RUB');
    UPDATE S18336Pteam1.RUSSIA SET DEFICIT = abs(USA_RUSSIA_DEFICIT_NEW) WHERE CURRENCY_ISO = 'USD';
  end if;
END //

DELIMITER ;
DELIMITER $$
DROP PROCEDURE IF EXISTS buy_bond_usd_rub $$
CREATE PROCEDURE buy_bond_usd_rub()
BEGIN
    SET @RESERVE_MONEY = (SELECT SUPPLY_OF_CURRENCY FROM RUSSIA WHERE CURRENCY_ISO = 'USD');
    SET @PERCENTAGE_SPENT = .01;
    SET @AMT_SPENT = @RESERVE_MONEY * @PERCENTAGE_SPENT;   

    IF @RESERVE_MONEY > 0 THEN
        call bonds_aux_usd_rub(@RESERVE_MONEY, @AMT_SPENT);
    ELSE
    SET @AMT_SPENT = RAND() * 1000;

        WHILE @RESERVE_MONEY <= @AMT_SPENT DO
        call generate_rub_trader(2, 'RUB', 'USD', 1);
        call marketplace('USD', 'RUB');

        SET @RESERVE_MONEY = (SELECT SUPPLY_OF_CURRENCY FROM RUSSIA WHERE CURRENCY_ISO = 'USD');


      END WHILE;
      call bonds_aux_usd_rub(@RESERVE_MONEY, @AMT_SPENT);


    END IF;


    SET @OLD_SUPPLY_BONDS_BASE = (SELECT SUPPLY_OF_BONDS FROM USA WHERE CURRENCY_ISO = 'USD');
    IF @OLD_SUPPLY_BONDS_BASE < 0 THEN
    SET @NEW_SUPPLY_BONDS_BASE = RAND() * 10000000;

    UPDATE USA SET SUPPLY_OF_BONDS = @NEW_SUPPLY_BONDS_BASE WHERE CURRENCY_ISO = 'USD';
  
    END IF;
END $$
DELIMITER ;

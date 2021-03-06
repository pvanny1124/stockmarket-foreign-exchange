DELIMITER $$
DROP PROCEDURE IF EXISTS buy_bond_rub_usd $$
CREATE PROCEDURE buy_bond_rub_usd()
BEGIN
    SET @RESERVE_MONEY = (SELECT SUPPLY_OF_CURRENCY FROM USA WHERE CURRENCY_ISO = 'RUB');
    SET @PERCENTAGE_SPENT = .01;
    SET @AMT_SPENT = @RESERVE_MONEY * @PERCENTAGE_SPENT;   

    IF @RESERVE_MONEY > 0 THEN
        call bonds_aux_rub_usd(@RESERVE_MONEY, @AMT_SPENT);
    ELSE
    SET @AMT_SPENT = RAND() * 1000;

        WHILE @RESERVE_MONEY <= @AMT_SPENT DO
        call generate_usd_trader(2, 'USD', 'RUB', 1);
        call marketplace('RUB', 'USD');

        SET @RESERVE_MONEY = (SELECT SUPPLY_OF_CURRENCY FROM USA WHERE CURRENCY_ISO = 'RUB');


      END WHILE;
      call bonds_aux_rub_usd(@RESERVE_MONEY, @AMT_SPENT);


    END IF;


    SET @OLD_SUPPLY_BONDS_BASE = (SELECT SUPPLY_OF_BONDS FROM RUSSIA WHERE CURRENCY_ISO = 'RUB');
    IF @OLD_SUPPLY_BONDS_BASE < 0 THEN
    SET @NEW_SUPPLY_BONDS_BASE = RAND() * 10000000;

    UPDATE RUSSIA SET SUPPLY_OF_BONDS = @NEW_SUPPLY_BONDS_BASE WHERE CURRENCY_ISO = 'RUB';
  
    END IF;
END $$
DELIMITER ;

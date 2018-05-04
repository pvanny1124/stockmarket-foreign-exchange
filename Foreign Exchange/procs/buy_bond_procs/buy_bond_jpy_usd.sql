DELIMITER $$
DROP PROCEDURE IF EXISTS buy_bond_jpy_usd $$
CREATE PROCEDURE buy_bond_jpy_usd()
BEGIN
    SET @RESERVE_MONEY = (SELECT SUPPLY_OF_CURRENCY FROM USA WHERE CURRENCY_ISO = 'JPY');
    SET @PERCENTAGE_SPENT = .01;
    SET @AMT_SPENT = @RESERVE_MONEY * @PERCENTAGE_SPENT;   

    IF @RESERVE_MONEY > 0 THEN
        call bonds_aux_jpy_usd(@RESERVE_MONEY, @AMT_SPENT);
    ELSE
    SET @AMT_SPENT = RAND() * 1000;

        WHILE @RESERVE_MONEY <= @AMT_SPENT DO
        call generate_usd_trader(2, 'USD', 'JPY', 1);
        call marketplace('JPY', 'USD');

        SET @RESERVE_MONEY = (SELECT SUPPLY_OF_CURRENCY FROM USA WHERE CURRENCY_ISO = 'JPY');


      END WHILE;
      call bonds_aux_jpy_usd(@RESERVE_MONEY, @AMT_SPENT);


    END IF;


    SET @OLD_SUPPLY_BONDS_BASE = (SELECT SUPPLY_OF_BONDS FROM JAPAN WHERE CURRENCY_ISO = 'JPY');
    IF @OLD_SUPPLY_BONDS_BASE < 0 THEN
    SET @NEW_SUPPLY_BONDS_BASE = RAND() * 10000000;

    UPDATE JAPAN SET SUPPLY_OF_BONDS = @NEW_SUPPLY_BONDS_BASE WHERE CURRENCY_ISO = 'JPY';
  
    END IF;
END $$
DELIMITER ;
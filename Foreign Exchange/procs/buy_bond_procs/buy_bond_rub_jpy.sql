DELIMITER $$
DROP PROCEDURE IF EXISTS buy_bond_rub_jpy $$
CREATE PROCEDURE buy_bond_rub_jpy()
BEGIN
    SET @RESERVE_MONEY = (SELECT SUPPLY_OF_CURRENCY FROM JAPAN WHERE CURRENCY_ISO = 'RUB');
    SET @PERCENTAGE_SPENT = .01;
    SET @AMT_SPENT = @RESERVE_MONEY * @PERCENTAGE_SPENT;   

    IF @RESERVE_MONEY > 0 THEN
        call bonds_aux_rub_jpy(@RESERVE_MONEY, @AMT_SPENT);
    ELSE
    SET @AMT_SPENT = RAND() * 1000;

        WHILE @RESERVE_MONEY <= @AMT_SPENT DO
        call generate_jpy_trader(2, 'JPY', 'RUB', 1);
        call marketplace('RUB', 'JPY');

        SET @RESERVE_MONEY = (SELECT SUPPLY_OF_CURRENCY FROM JAPAN WHERE CURRENCY_ISO = 'RUB');


      END WHILE;
      call bonds_aux_rub_jpy(@RESERVE_MONEY, @AMT_SPENT);


    END IF;


    SET @OLD_SUPPLY_BONDS_BASE = (SELECT SUPPLY_OF_BONDS FROM RUSSIA WHERE CURRENCY_ISO = 'RUB');
    IF @OLD_SUPPLY_BONDS_BASE < 0 THEN
    SET @NEW_SUPPLY_BONDS_BASE = RAND() * 10000000;

    UPDATE RUSSIA SET SUPPLY_OF_BONDS = @NEW_SUPPLY_BONDS_BASE WHERE CURRENCY_ISO = 'RUB';
  
    END IF;
END $$
DELIMITER ;

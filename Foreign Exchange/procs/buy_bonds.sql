/*********************************
Procedure: buy_bonds
**********************************/
/* Do this when interest rate of a country's bonds goes up */
DELIMITER $$
DROP PROCEDURE IF EXISTS buy_bond $$
CREATE PROCEDURE buy_bond(IN BASE VARCHAR(5), IN TRADE_WITH VARCHAR(5))
BEGIN
    /**************************************************************************
       BASE = The current country
       TRADE_WITH = The country that wants to buy the BASE country's bonds.
    ***************************************************************************/
    DECLARE RESERVE_MONEY INT(11);                    /* the trade_with_country's supply of currency */
    DECLARE AMT_SPENT INT(11);                        /* The amount that the trade_with_country is willing to spend to buy bonds. */
    DECLARE PERCENTAGE_SPENT DECIMAL(10,2);           /* The percentage of the reserve money that is going to be spent to buy bonds */
    DECLARE NEW_SUPPLY_CURR_BASE DECIMAL(18,2);       /* new supply of currency for base */
    DECLARE NEW_SUPPLY_CURR_TRADE_WITH DECIMAL(18,2); /* new supply of currency for trade_with */
    DECLARE NEW_SUPPLY_BONDS DECIMAL(18,2);           /* The new number of bonds that the trade_with country will end up having. */

    CALL get_country(BASE, @BASE_COUNTRY);
    CALL get_country(TRADE_WITH, @TRADE_WITH_COUNTRY);

    SET RESERVE_MONEY = CONCAT("SELECT SUPPLY_OF_CURRENCY FROM ", @TRADE_WITH_COUNTRY, " WHERE CURRENCY_ISO = '", BASE, "'");

    IF RESERVE_MONEY > 0 THEN
            SET PERCENTAGE_SPENT = .01;
            SET AMT_SPENT = RESERVE_MONEY * PERCENTAGE_SPENT;   /* MONEY FROM TRADE_WITH_COUNTRY SPENT TO BUY BONDS FROM BASE */
            SET NEW_SUPPLY_CURR_BASE = SUPPLY_OF_CURRENCY + AMT_SPENT;
            SET @T1 = CONCAT("UPDATE ", @BASE_COUNTRY, " SET SUPPLY_OF_CURRENCY = ", NEW_SUPPLY_CURR_BASE ," WHERE CURRENCY_ISO = '", BASE, "'");
            PREPARE STMT1 FROM @T1;
            EXECUTE STMT1;
            DEALLOCATE PREPARE STMT1;

    SET NEW_SUPPLY_CURR_TRADE_WITH =  SUPPLY_OF_CURRENCY - AMT_SPENT;

    /* deduct amount spent from the supply_of_Currency in trade_with country table */
    SET @T2 = CONCAT("UPDATE ", @TRADE_WITH_COUNTRY, " SET SUPPLY_OF_CURRENCY = ", NEW_SUPPLY_CURR_TRADE_WITH , " WHERE CURRENCY_ISO = '", BASE, "'");
    PREPARE STMT2 FROM @T2;
    EXECUTE STMT2;
    DEALLOCATE PREPARE STMT2;

    /* Add to supply of bonds bought to trade with country table */
    SET NEW_SUPPLY_BONDS = SUPPLY_OF_BONDS + (AMT_SPENT / (select PRICE from BOND_RATES where CURRENCY_ISO = BASE));
    SET @T3 = CONCAT("UPDATE ", @TRADE_WITH_COUNTRY, " SET SUPPLY_OF_BONDS = ", @NEW_SUPPLY_BONDS, " WHERE CURRENCY_ISO = '", BASE, "'");
    PREPARE STMT3 FROM @T3;
    EXECUTE STMT3;
    DEALLOCATE PREPARE STMT3;

    END IF;
END $$
DELIMITER ;

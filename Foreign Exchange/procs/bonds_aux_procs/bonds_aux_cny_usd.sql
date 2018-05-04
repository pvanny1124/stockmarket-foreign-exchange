DELIMITER $$
DROP PROCEDURE IF EXISTS bonds_aux_cny_usd $$
CREATE PROCEDURE bonds_aux_cny_usd(IN RESERVE_MONEY DECIMAL(18, 2), IN AMT_SPENT DECIMAL(18, 2))
    BEGIN 
        SET @AMT_SPENT = AMT_SPENT;
        SET @RESERVE_MONEY = RESERVE_MONEY;
        SET @OLD_SUPPLY_CURR_BASE = (SELECT SUPPLY_OF_CURRENCY FROM CHINA WHERE CURRENCY_ISO = 'CNY');
        SET @NEW_SUPPLY_CURR_BASE = @OLD_SUPPLY_CURR_BASE + @AMT_SPENT;      
        UPDATE CHINA SET SUPPLY_OF_CURRENCY = @NEW_SUPPLY_CURR_BASE WHERE CURRENCY_ISO = 'CNY';
        
        SET @OLD_SUPPLY_CURR_TRADE_WITH = (SELECT SUPPLY_OF_CURRENCY FROM USA WHERE CURRENCY_ISO = 'CNY');
            
        SET @NEW_SUPPLY_CURR_TRADE_WITH =  @OLD_SUPPLY_CURR_TRADE_WITH - @AMT_SPENT;

        UPDATE USA SET SUPPLY_OF_CURRENCY = @NEW_SUPPLY_CURR_TRADE_WITH WHERE CURRENCY_ISO = 'CNY';
    
        SET @OLD_SUPPLY_BONDS = (SELECT SUPPLY_OF_BONDS FROM USA WHERE CURRENCY_ISO = 'CNY');

        SET @EXCHANGE_RATE = (SELECT PRICE FROM BOND_RATES WHERE COUNTRY_ISO = 'CNY');

        SET @AMT_BONDS_BOUGHT = (@AMT_SPENT / @EXCHANGE_RATE);
        SET @NEW_SUPPLY_BONDS = @OLD_SUPPLY_BONDS + @AMT_BONDS_BOUGHT;
        
        UPDATE USA SET SUPPLY_OF_BONDS = @NEW_SUPPLY_BONDS WHERE CURRENCY_ISO = 'CNY';
        
        SET @OLD_SUPPLY_BONDS_BASE = (SELECT SUPPLY_OF_BONDS FROM CHINA WHERE CURRENCY_ISO = 'CNY');

        SET @NEW_SUPPLY_BONDS_BASE = @OLD_SUPPLY_BONDS_BASE - @AMT_BONDS_BOUGHT;
        
        UPDATE CHINA SET SUPPLY_OF_BONDS = @NEW_SUPPLY_BONDS_BASE WHERE CURRENCY_ISO = 'CNY';

END $$
DELIMITER ;
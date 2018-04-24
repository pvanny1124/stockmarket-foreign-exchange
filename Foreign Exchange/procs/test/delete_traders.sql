/**********************
Procedure to delete the traders in a table.
=> used for testing purposes only.
**********************/

DROP PROCEDURE IF EXISTS `delete_traders` ;
DELIMITER $$
CREATE PROCEDURE `delete_traders` (IN trader_table VARCHAR(40))
BEGIN
    SET @t1 = CONCAT('DELETE FROM ', trader_table, ' WHERE TRADER_ID >= 0');
    PREPARE stmt3 FROM @t1;
    EXECUTE stmt3;
    DEALLOCATE PREPARE stmt3;
END $$

/*********************************
Country Traders Schemas:

  TRADER ID = ID OF THE TRADER
  ORIGIN = COUNTRY OF WHERE TRADER COMES FROM
  TRADE_WITH = COUNTRY IT WANTS TO INITIATE TRADES WITH
  PRICE = PRICE OF ASK
**********************************/

CREATE TABLE `USA_TRADERS` (
      `TRADER_ID` INT NOT NULL AUTO_INCREMENT,
      `ORIGIN` CHAR(3) NOT NULL,
      `TRADE_WITH` CHAR(3) NOT NULL,
      `PRICE` DECIMAL(18,4) NOT NULL,
      `QUANTITY_OF_CURRENCY` BIGINT(20) NOT NULL,
      PRIMARY KEY(`TRADER_ID`)
);

CREATE TABLE `CNY_TRADERS` (
      `TRADER_ID` INT NOT NULL AUTO_INCREMENT,
      `ORIGIN` CHAR(3) NOT NULL,
      `TRADE_WITH` CHAR(3) NOT NULL,
      `PRICE` DECIMAL(18,4) NOT NULL,
      `QUANTITY_OF_CURRENCY` BIGINT(20) NOT NULL,
      PRIMARY KEY(`TRADER_ID`)
);

CREATE TABLE `RUB_TRADERS` (
      `TRADER_ID` INT NOT NULL AUTO_INCREMENT,
      `ORIGIN` CHAR(3) NOT NULL,
      `TRADE_WITH` CHAR(3) NOT NULL,
      `PRICE` DECIMAL(18,4) NOT NULL,
      `QUANTITY_OF_CURRENCY` BIGINT(20) NOT NULL,
      PRIMARY KEY(`TRADER_ID`)
);

CREATE TABLE `EU_TRADERS` (
      `TRADER_ID` INT NOT NULL AUTO_INCREMENT,
      `ORIGIN` CHAR(3) NOT NULL,
      `TRADE_WITH` CHAR(3) NOT NULL,
      `PRICE` DECIMAL(18,4) NOT NULL,
      `QUANTITY_OF_CURRENCY` BIGINT(20) NOT NULL,
      PRIMARY KEY(`TRADER_ID`)
);

CREATE TABLE `JPY_TRADERS` (
      `TRADER_ID` INT NOT NULL AUTO_INCREMENT,
      `ORIGIN` CHAR(3) NOT NULL,
      `TRADE_WITH` CHAR(3) NOT NULL,
      `PRICE` DECIMAL(18,4) NOT NULL,
      `QUANTITY_OF_CURRENCY` BIGINT(20) NOT NULL,
      PRIMARY KEY(`TRADER_ID`)
);


DELETE FROM USD_TRADERS WHERE TRADER_ID >= 0;
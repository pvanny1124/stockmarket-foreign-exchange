/* Table Models for Countries for the Foreign Exchange Project */

/*
  Each table will hold the following attributes:

  1) Supply of that country’s currency (including self)-- you can make this different for different
     countries. Use millions or billions as you like.

  2) Supply of that country’s 10 year bonds (as a value in that country’s currency)

  3) Interest rate (coupon) on those bonds

  4) Trade surplus or deficit between self and that other country ( of course self:self =0)

  5) The prime interest rate for that country

  For the purposes of this project, we will use USA, China, Russia, EU, and Japan modeled after
  the currency ISO codes:  USD, CNY, RUB, EUR, JPY (US Dollar, Chinese Yuan, Russia Ruble, European Euro, and Japanese Yen)
*/

CREATE TABLE `USA` (
  `CURRENCY_ISO` CHAR(3),
  `EXCHANGE_RATE` DECIMAL(18,4),
  `SUPPLY_OF_CURRENCY` INT(11),
  `SUPPLY_OF_BONDS` INT(11),
  `COUPON` DECIMAL(1,5),
  `DEFICIT` DECIMAL (18,4)
);

CREATE TABLE `CHINA` (
  `CURRENCY_ISO` CHAR(11),
  `EXCHANGE_RATE` DECIMAL (18,4),
  `SUPPLY_OF_CURRENCY` INT(11),
  `SUPPLY_OF_BONDS` INT(11),
  `COUPON` DECIMAL(1,5),
  `DEFICIT` DECIMAL (18,4)
);

CREATE TABLE `RUSSIA` (
  `CURRENCY_ISO` CHAR(11),
  `EXCHANGE_RATE` DECIMAL(18,4),
  `SUPPLY_OF_CURRENCY` INT(11),
  `SUPPLY_OF_BONDS` INT(11),
  `COUPON` DECIMAL(1,5),
  `DEFICIT` DECIMAL (18,4)
);

CREATE TABLE `EU` (
  `CURRENCY_ISO` CHAR(11),
  `EXCHANGE_RATE` DECIMAL(18,4),
  `SUPPLY_OF_CURRENCY` INT(11),
  `SUPPLY_OF_BONDS` INT(11),
  `COUPON` DECIMAL(1,5),
  `DEFICIT` DECIMAL (18,4)
);

CREATE TABLE `JAPAN` (
  `CURRENCY_ISO` CHAR(11),
  `EXCHANGE_RATE` DECIMAL (18,4),
  `SUPPLY_OF_CURRENCY` INT(11),
  `SUPPLY_OF_BONDS` INT(11),
  `COUPON` DECIMAL(1,5),
  `DEFICIT` DECIMAL (18,4)
);

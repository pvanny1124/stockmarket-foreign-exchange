/* Seed exhange-rates into country model tables */
/*
    1) For a 'self' row, we set the exchange rate to NULL since there is no such thing as
       an exchange rate for a currency's self.

    2) All values taken for prime interest rates and coupons (country's 10-year bond interest rate)
       were generated with 2017 data from investopedia.com.

    3) Values for SUPPLY_OF_CURRENCY and SUPPLY_OF_BONDS are just random values that I inserted
       enough to make sure that if a country is in an extreme deficit, then it would have
       enough supply of currency/bonds to balance their deficits.

       i.e. if USA has a trade deficit of -375,000,000,000 chinese yuan with china, and it only has
       a supply of 2,000,000,000 chinese yuan [ (2 bil * 6.33) = 12,656,000,000 ], it will go into the
       market and buy 57,242,496,051 chinese yuan.

       TODO: must simplify SUPPLY_OF_BONDS and SUPPLY_OF_CURRENCY to be values in millions or
       thousands while keeping an accurate portrayel of real world defecits.

       TODO: add remaining seed data for the rest of the country models


*/


/* /////////////// USA SEEDS ////////////////////*/

INSERT INTO `USA` (`CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('USD', NULL, '3855088000', '100000', '0.0275', '0', '0.0450');

/* One USD == 6.33 Chinese Yuan */
INSERT INTO `USA` (`CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('CNY', '6.33', '2000000000', '400000', '0.03804', '-375000000000.0', '0.0435');

/* One USD == 57.49 Russia Rubless */
INSERT INTO `USA` (`CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('RUB', '57.49', '400000000', '6000000', '0.0705', '-15000000000.0', '0.0930');

/* One USD == 0.82 EUR */
INSERT INTO `USA` (`CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('EUR', '0.82', '80000000', '5400000', '0.0127', '-151415600000.0', '0.0200');

/* One USD == 106.47 Japanese yen */
INSERT INTO `USA` (`CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('JPY', '106.47', '300000000', '650000', '0.0007', '-68847700000.0', '0.0100');

/* /////////////// CHINA SEEDS ////////////////////*/

INSERT INTO `CHINA` (`CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('CNY', NULL, '344442000000', '7000000', '0.03804', '0', '0.0435');

INSERT INTO `CHINA` (`CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('USD', '0.16', '440000000', '65000000', '0.0275', '375000000000.0', '0.0450');

INSERT INTO `CHINA` (`CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('RUB', '9.08', '500000000', '65000000', '0.0705', '-2000000000.0', '0.0930');

INSERT INTO `CHINA` (`CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('EUR', '0.13', '3400000000', '65000000', '0.0127', '375000000000.0', '0.0200');

INSERT INTO `CHINA` `CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('JPY', '16.82', '3442000000', '65000000', '0.0007', '375000000000.0', '0.0100');

/* /////////////// RUSSIA SEEDS ////////////////////*/

INSERT INTO `RUSSIA` (`CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('RUB', NULL, '3442000000', '65000000', '0', '375000000000', '0.0930');

INSERT INTO `RUSSIA` (`CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('USD', '0.017', '3442000000', '65000000', '0.0275', '375000000000', '0.0450');

INSERT INTO `RUSSIA` (`CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('CNY', '0.11', '3442000000', '65000000', '0.03804', '375000000000', '0.0435');

INSERT INTO `RUSSIA` (`CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('JPY', '1.85', '3442000000', '65000000', '0.0007', '375000000000', '0.0100');

INSERT INTO `RUSSIA` (`CURRENCY_ISO`, `EXCHANGE_RATE`, `SUPPLY_OF_CURRENCY`, `SUPPLY_OF_BONDS`, `COUPON`, `DEFECIT`, `PRIME_INTEREST_RATE`)
      VALUES ('EUR', '0.017', '3442000000', '65000000', '0.0127', '375000000000', '0.0200');

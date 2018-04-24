/**********************
Exchange tables for different markets
And Currency Exchange tables that keeps track of different rates between different countries;
**********************/

CREATE TABLE `CNY_EUR_EXCHANGE` (
  CNY_EUR int(11),
  EUR_CNY int(11)
);

CREATE TABLE `CNY_RUB_EXCHANGE` (
  CNY_RUB int(11),
  RUB_CNY int(11)
);

CREATE TABLE `CNY_USD_EXCHANGE` (
  CNY_USD int(11),
  USD_CNY int(11)
);

CREATE TABLE `CNY_JPY_EXCHANGE` (
  CNY_JPY int(11),
  JPY_CNY int(11)
);

CREATE TABLE `EUR_USD_EXCHANGE` (
  EUR_USD int(11),
  USD_EUR int(11)
);

CREATE TABLE `EUR_JPY_EXCHANGE` (
  EUR_JPY int(11),
  JPY_EUR int(11)
);

CREATE TABLE `EUR_RUB_EXCHANGE` (
  EUR_RUB int(11),
  RUB_EUR int(11)
);

CREATE TABLE `JPY_USD_EXCHANGE` (
  JPY_USD int(11),
  USD_JPY int(11)
);

CREATE TABLE `JPY_RUB_EXCHANGE` (
  JPY_RUB int(11),
  RUB_JPY int(11)
);

CREATE TABLE `RUB_USD_EXCHANGE` (
  RUB_USD int(11),
  USD_RUB int(11)
);

CREATE TABLE `CURRENCY_EXCHANGE` (
  CURRENCY_ISO char(3),
  USD decimal(18,8),
  EUR decimal(18,8),
  RUB decimal(18,8),
  JPY decimal(18,8),
  CNY decimal(18,8)
);

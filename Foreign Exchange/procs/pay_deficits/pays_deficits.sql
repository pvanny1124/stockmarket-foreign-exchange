DELIMITER //

CREATE PROCEDURE pay_usa_deficit()
BEGIN
  call pay_usa_china_deficit;
  call pay_usa_eu_deficit;
  call pay_usa_japan_deficit;
  call pay_usa_russia_deficit;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE pay_russia_deficit()
BEGIN
  call pay_russia_eu_deficit;
  call pay_russia_usa_deficit;
  call pay_russia_china_deficit;
  call pay_russia_japan_deficit;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE pay_japan_deficit()
BEGIN
  call pay_japan_eu_deficit;
  call pay_japan_usa_deficit;
  call pay_japan_china_deficit;
  call pay_japan_russia_deficit;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE pay_eu_deficit()
BEGIN
  call pay_eu_usa_deficit;
  call pay_eu_china_deficit;
  call pay_eu_japan_deficit;
  call pay_eu_russia_deficit;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE pay_china_deficit()
BEGIN
  call pay_china_eu_deficit;
  call pay_china_usa_deficit;
  call pay_china_japan_deficit;
  call pay_china_russia_deficit;
END //

DELIMITER ;

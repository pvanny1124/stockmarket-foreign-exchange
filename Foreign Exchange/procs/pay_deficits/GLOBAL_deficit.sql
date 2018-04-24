DELIMITER //

CREATE PROCEDURE pay_global_deficit()
BEGIN
  call pay_usa_deficit;
  call pay_eu_deficit;
  call pay_japan_deficit;
  call pay_china_deficit;
  call pay_russia_deficit;
END //

DELIMITER ;

DELIMITER $$
DROP FUNCTION IF EXISTS `get_distance`;
CREATE FUNCTION `get_distance` (lat1 DOUBLE, lng1 DOUBLE, lat2 DOUBLE, lng2 DOUBLE)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
	DECLARE radlat1 DOUBLE;
	DECLARE radlng1 DOUBLE;
	DECLARE radlat2 DOUBLE;
	DECLARE radlng2 DOUBLE;
	DECLARE theta DOUBLE;
	DECLARE radtheta DOUBLE;
	DECLARE dist DOUBLE;
	
	SET radlat1 = pi() * lat1/180;
	SET radlng1 = pi() * lng1/180;
	SET radlat2 = pi() * lat2/180;
	SET radlng2 = pi() * lng2/180;
	SET theta = lng1 - lng2;
	SET radtheta = pi() * theta/180;
	SET dist = sin(radlat1) * sin(radlat2) + cos(radlat1) * cos(radlat2) * cos(radtheta);
	SET dist = acos(dist);
	SET dist = dist * 180/pi();
	SET dist = dist * 60 * 1.1515;
	SET dist = dist * 1.609344;
	RETURN round(dist, 3);
#	RETURN 6378 * 2 * ASIN(SQRT(
#	POWER(SIN((lat1 - abs(lat2)) * pi()/180 / 2), 2) + COS(lat1 * pi()/180 ) * COS(abs(lat2) * pi()/180) * 
#	POWER(SIN((lng1 - lng2) * pi()/180 / 2), 2) ));
END $$
DELIMITER ;
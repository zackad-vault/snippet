-- fungsi untuk pengubah string waypoint menjadi data spatial linestring
-- 
DELIMITER $$
DROP FUNCTION IF EXISTS `waytoline` $$
CREATE FUNCTION `waytoline` (way TEXT) RETURNS LINESTRING
BEGIN
	DECLARE line LINESTRING;
	
	SET way = replace(way, ',', ' ');
	SET way = replace(way, ';', ',');
	SET line = geomfromtext(concat('linestring(', way, ')'));
	
	RETURN line;
END $$
DELIMITER ;
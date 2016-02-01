-- fungsi untuk pengubah string koordinat menjadi data spatial point
-- 
DELIMITER $$
DROP FUNCTION IF EXISTS `ptopoint` $$
CREATE FUNCTION `ptopoint` (p1 TEXT) RETURNS POINT
BEGIN
	DECLARE po POINT;
	DECLARE x TEXT;
	DECLARE y TEXT;
	SET x = substring(p1, 1, locate(',', p1)-1);
	SET y = substring(p1, locate(',', p1)+1);
	SET po = geomfromtext(concat('Point(', x, ' ', y, ')'));
	RETURN po;
END $$
DELIMITER ;
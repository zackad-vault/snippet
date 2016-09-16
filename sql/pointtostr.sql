-- fungsi untuk mengubah data spatial point >> string koordinat
-- point(107.787 -6.867) >> -6.867,107.787
-- 
DELIMITER $$
DROP FUNCTION IF EXISTS `pointtostr` $$
CREATE FUNCTION `pointtostr` (po POINT) RETURNS TEXT
BEGIN
	DECLARE str TEXT;
	SET str = concat(y(po), ',', x(po));
	RETURN str;
END $$
DELIMITER ;
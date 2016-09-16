-- fungsi untuk mencari jarak terdekat dari satu titik terhadap
-- kumpulan titik yang menyusun suatu polyline
--
DELIMITER $$
DROP FUNCTION IF EXISTS `calc_distance` $$
CREATE FUNCTION `calc_distance` (p1 POINT, pline LINESTRING) RETURNS DOUBLE
BEGIN
	DECLARE dist DOUBLE;
	DECLARE i INT;
	DECLARE jum_titik INT;
	DECLARE temp DOUBLE;
	
	SET jum_titik = numpoints(pline);
	SET i = 1;
	SET dist = 0;
	while i < jum_titik do
		set temp = get_distance(
				y(p1), 
				x(p1), 
				y(pointn(pline, i)), 
				x(pointn(pline, i))
			);
		if(dist < temp or dist = 0) then
			set dist = temp;
		end if;
		set i = i + 1;
	end while;
	
	RETURN dist;
END $$
DELIMITER ;
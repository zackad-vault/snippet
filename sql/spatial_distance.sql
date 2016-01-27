-- fungsi untuk mencari jarak terdekat dari satu titik terhadap
-- kumpulan titik yang menyusun suatu polyline
-- how to use :
-- 1. siapkan table untuk menampung hasil kalkulasi (1 column)
-- 2. truncate table sebelum memanggil fungsi
-- 
DELIMITER $$
DROP FUNCTION IF EXISTS `calc_distance` $$
CREATE FUNCTION `calc_distance` (p1 POINT, pline LINESTRING) RETURNS DOUBLE
BEGIN
	DECLARE dist DOUBLE;
	DECLARE i INT;
	DECLARE jum_titik INT;
	
	SET jum_titik = numpoints(pline);
	SET i = 1;
	
	while i < jum_titik do
		insert into ci_distance_temp values (
			get_distance(
				y(p1), 
				x(p1), 
				y(pointn(pline, i)), 
				x(pointn(pline, i))
			)
		);
		set i = i + 1;
	end while;
	
	set dist = (select min(distance) from ci_distance_temp);
	RETURN dist;
END $$
DELIMITER ;
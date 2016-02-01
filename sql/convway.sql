-- fungsi untuk mengubah string waypoints >> linestring
-- y,x;y,x >> linestring(x y, x y) 
-- 
DELIMITER $$
DROP FUNCTION IF EXISTS `convway` $$
CREATE FUNCTION `convway` (way TEXT) RETURNS LINESTRING
BEGIN
	DECLARE temp_line LINESTRING;
	DECLARE line LINESTRING;
	DECLARE i INT;
	DECLARE jum_titik INT;
	DECLARE waypts TEXT;
	SET waypts = '';
	SET way = replace(way, ',', ' ');
	SET way = replace(way, ';', ',');
	SET temp_line = geomfromtext(concat('linestring(', way, ')'));
	SET jum_titik = numpoints(temp_line);
	SET i = 1;
	while i < jum_titik+1 do
		if (i = jum_titik) then
			SET waypts = concat(waypts, y(pointn(temp_line, i)), ' ', x(pointn(temp_line, i)));
		else
			SET waypts = concat(waypts, y(pointn(temp_line, i)), ' ', x(pointn(temp_line, i)), ',');
		end if;
		SET i = i + 1;
	end while;
	SET line = geomfromtext(concat('linestring(', waypts, ')'));
	RETURN line;
END $$
DELIMITER ;
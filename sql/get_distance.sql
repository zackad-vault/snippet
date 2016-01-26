set @orig_lat = -6.896306;
set @orig_lng = 107.652942;
select nama,
substring_index(substring_index(koordinat, ',', 1), ',', -1) as lat,
trim(substr(koordinat, locate(',', koordinat)+1)) as lng,
koordinat,
round(get_distance(substring_index(substring_index(koordinat, ',', 1), ',', -1), 
	trim(substr(koordinat, locate(',', koordinat)+1)), 
	@orig_lat, 
	@orig_lng), 2) as distance
from ci_lokasi
where get_distance(
	substring_index(substring_index(koordinat, ',', 1), ',', -1), 
	trim(substr(koordinat, locate(',', koordinat)+1)), 
	@orig_lat, 
	@orig_lng) < 7
#and distance < 9
#where trim(substr(koordinat, locate(',', koordinat)+1)) > 108
order by distance
limit 3
;
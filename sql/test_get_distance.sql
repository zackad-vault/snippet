set @orig_lat = -6.896306;
set @orig_lng = 107.652942;
select nama,
substring_index(substring_index(koordinat, ',', 1), ',', -1) as lat,
trim(substr(koordinat, locate(',', koordinat)+1)) as lng,
koordinat,
get_distance(substring_index(substring_index(koordinat, ',', 1), ',', -1), 
	trim(substr(koordinat, locate(',', koordinat)+1)), 
	@orig_lat, 
	@orig_lng) as distance
from ci_lokasi
having distance < 3
order by distance
#limit 3
;

# get distance from spatial data
# please note that y = lattitude, x = longitude
select astext(orig) as origin, 
astext(dest) as destination, 
get_distance(y(orig), x(orig), y(dest), x(dest)) as distance 
from ci_spatial_test;
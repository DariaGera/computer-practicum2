insert into region
select DISTINCT regname from territory_place;

insert into area
select DISTINCT AreaInfo.areaname, region.regname 
from(
	select DISTINCT areaname, regname from territory_place
	)as AreaInfo(areaname, regname)
left join region on AreaInfo.regname = region.regname;

	
insert into place(areaname, tername, regname)
select DISTINCT area.areaname, PlaceInfo.tername, area.region_regname
from(
	select DISTINCT areaname, tername, regname from territory_place
	)as PlaceInfo(areaname, tername, regname)
left join area on PlaceInfo.areaname = area.areaname and
					PlaceInfo.regname = area.region_regname;
					
insert into person
select DISTINCT ON(OutID) OutID, Birth, SextypeName, RegTypeName from zno_ua19_20;

insert into indwelling
select DISTINCT ON(person.OutID) person.OutID, place.place_id, Dwell.tertypename 
from (
	select DISTINCT OutID, areaname, tername, regname, tertypename from zno_ua19_20
	)as Dwell(OutID, areaname, tername, regname, tertypename)
left join place on 
	Dwell.tername = place.tername AND
	Dwell.areaname = place.areaname AND
	Dwell.regname = place.regname
left join person on 
	Dwell.OutID = person.OutID;
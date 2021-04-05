create view territory_place as
select DISTINCT *
from(
	-- територія реєстрації/проживання учасника
	select DISTINCT areaname, tername, regname from zno_ua19_20
	-- територія навчального закладу
	UNION select DISTINCT EOAreaName, EOTerName, EORegName from zno_ua19_20
	-- території пунктів проведення ЗНО
	UNION select DISTINCT ukrPTAreaName, ukrPTTerName, ukrPTRegName from zno_ua19_20
	UNION select DISTINCT mathPTAreaName, mathPTTerName, mathPTRegName from zno_ua19_20
	UNION select DISTINCT histPTAreaName, histPTTerName, histPTRegName from zno_ua19_20
	UNION select DISTINCT physPTAreaName, physPTTerName, physPTRegName from zno_ua19_20
	UNION select DISTINCT chemPTAreaName, chemPTTerName, chemPTRegName from zno_ua19_20
	UNION select DISTINCT bioPTAreaName, bioPTTerName, bioPTRegName from zno_ua19_20
	UNION select DISTINCT geoPTAreaName, geoPTTerName, geoPTRegName from zno_ua19_20
	UNION select DISTINCT engPTAreaName, engPTTerName, engPTRegName from zno_ua19_20
	UNION select DISTINCT fraPTAreaName, fraPTTerName, fraPTRegName from zno_ua19_20
	UNION select DISTINCT deuPTAreaName, deuPTTerName, deuPTRegName from zno_ua19_20
	UNION select DISTINCT spaPTAreaName, spaPTTerName, spaPTRegName from zno_ua19_20
	)as terr_place(areaname, tername, regname)
where terr_place.areaname is not null 
	and terr_place.tername is not null
	and terr_place.regname is not null;
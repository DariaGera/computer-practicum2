create view educ_place as
select DISTINCT *
from(
	-- навчальний заклад
	select DISTINCT EOAreaName, EOTerName, EORegName, EOName from zno_ua19_20
	-- територія пунктів проведення ЗНО
	UNION select DISTINCT ukrPTAreaName, ukrPTTerName, ukrPTRegName, ukrPTName from zno_ua19_20
	UNION select DISTINCT mathPTAreaName, mathPTTerName, mathPTRegName, mathPTName from zno_ua19_20
	UNION select DISTINCT histPTAreaName, histPTTerName, histPTRegName, histPTName from zno_ua19_20
	UNION select DISTINCT physPTAreaName, physPTTerName, physPTRegName, physPTName from zno_ua19_20
	UNION select DISTINCT chemPTAreaName, chemPTTerName, chemPTRegName, chemPTName from zno_ua19_20
	UNION select DISTINCT bioPTAreaName, bioPTTerName, bioPTRegName, bioPTName from zno_ua19_20
	UNION select DISTINCT geoPTAreaName, geoPTTerName, geoPTRegName, geoPTName from zno_ua19_20
	UNION select DISTINCT engPTAreaName, engPTTerName, engPTRegName, engPTName from zno_ua19_20
	UNION select DISTINCT fraPTAreaName, fraPTTerName, fraPTRegName, fraPTName from zno_ua19_20
	UNION select DISTINCT deuPTAreaName, deuPTTerName, deuPTRegName, deuPTName from zno_ua19_20
	UNION select DISTINCT spaPTAreaName, spaPTTerName, spaPTRegName, spaPTName from zno_ua19_20
	)as Edu(areaname, tername, regname, eoname)
where Edu.areaname is not null 
	and Edu.tername is not null
	and Edu.regname is not null
	and Edu.eoname is not null;
create view stud_exam as
select DISTINCT *
from(	
	select DISTINCT zno_year, outid, ukrtest, 'українська', educational_institution.education_id , ukrball100, ukrball12, ukrball from zno_ua19_20
		left join place on place.areaname = ukrptAreaName and place.tername = ukrptTerName and place.regname = ukrptRegName
		inner join educational_institution on zno_ua19_20.ukrptName = educational_institution.edu_name 
											and place.place_id = educational_institution.place_id 
	UNION select DISTINCT zno_year, outid, histtest, histlang, educational_institution.education_id , histball100, histball12, histball from zno_ua19_20
		left join place on place.areaname = histptAreaName and place.tername = histptTerName and place.regname = histptRegName
		inner join educational_institution on zno_ua19_20.histptName = educational_institution.edu_name 
											and place.place_id = educational_institution.place_id 
	UNION select DISTINCT zno_year, outid, mathtest, mathlang, educational_institution.education_id , mathball100, mathball12, mathball from zno_ua19_20
		left join place on place.areaname = mathptAreaName and place.tername = mathptTerName and place.regname = mathptRegName
		inner join educational_institution on zno_ua19_20.mathptName = educational_institution.edu_name 
											and place.place_id = educational_institution.place_id 
	UNION select DISTINCT zno_year, outid, phystest, physlang, educational_institution.education_id , physball100, physball12, physball from zno_ua19_20
		left join place on place.areaname = physptAreaName and place.tername = physptTerName and place.regname = physptRegName
		inner join educational_institution on zno_ua19_20.physptName = educational_institution.edu_name 
											and place.place_id = educational_institution.place_id 
	UNION select DISTINCT zno_year, outid, chemtest, chemlang, educational_institution.education_id , chemball100, chemball12, chemball from zno_ua19_20
		left join place on place.areaname = chemptAreaName and place.tername = chemptTerName and place.regname = chemptRegName
		inner join educational_institution on zno_ua19_20.chemptName = educational_institution.edu_name 
											and place.place_id = educational_institution.place_id 
	UNION select DISTINCT zno_year, outid, biotest, biolang, educational_institution.education_id , bioball100, bioball12, bioball from zno_ua19_20
		left join place on place.areaname = bioptAreaName and place.tername = bioptTerName and place.regname = bioptRegName
		inner join educational_institution on zno_ua19_20.bioptName = educational_institution.edu_name 
											and place.place_id = educational_institution.place_id 
	UNION select DISTINCT zno_year, outid, geotest, geolang, educational_institution.education_id , geoball100, geoball12, geoball from zno_ua19_20
		left join place on place.areaname = geoptAreaName and place.tername = geoptTerName and place.regname = geoptRegName
		inner join educational_institution on zno_ua19_20.geoptName = educational_institution.edu_name 
											and place.place_id = educational_institution.place_id
	UNION select DISTINCT zno_year, outid, engtest, 'англійська', educational_institution.education_id , engball100, engball12, engball from zno_ua19_20
		left join place on place.areaname = engptAreaName and place.tername = engptTerName and place.regname = engptRegName
		inner join educational_institution on zno_ua19_20.engptName = educational_institution.edu_name 
											and place.place_id = educational_institution.place_id 
	UNION select DISTINCT zno_year, outid, fratest, 'французька', educational_institution.education_id , fraball100, fraball12, fraball from zno_ua19_20
		left join place on place.areaname = fraptAreaName and place.tername = fraptTerName and place.regname = fraptRegName
		inner join educational_institution on zno_ua19_20.fraptName = educational_institution.edu_name 
											and place.place_id = educational_institution.place_id 
	UNION select DISTINCT zno_year, outid, deutest, 'німецька', educational_institution.education_id, deuball100, deuball12, deuball from zno_ua19_20
		left join place on place.areaname = deuptAreaName and place.tername = deuptTerName and place.regname = deuptRegName
		inner join educational_institution on zno_ua19_20.deuptName = educational_institution.edu_name 
											and place.place_id = educational_institution.place_id 
	UNION select DISTINCT zno_year, outid, spatest, 'іспанська', educational_institution.education_id , spaball100, spaball12, spaball from zno_ua19_20
		left join place on place.areaname = spaptAreaName and place.tername = spaptTerName and place.regname = spaptRegName
		inner join educational_institution on zno_ua19_20.spaptName = educational_institution.edu_name 
											and place.place_id = educational_institution.place_id 
)as Exam(zno_year, outid, test, lang, education_id, ball100, ball12, ball);
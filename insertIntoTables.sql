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


insert into educational_institution(edu_name, place_id)
select DISTINCT Instit.eoname, place.place_id
from(
	select areaname, tername, regname, eoname from educ_place
)as Instit(areaname, tername, regname, eoname)
left join place on
	Instit.tername = place.tername AND
	Instit.areaname = place.areaname AND
	Instit.regname = place.regname;
	
insert into language
select DISTINCT ClassLangName from zno_ua19_20 where ClassLangName is not NULL;
insert into language values('англійська');
insert into language values('французька');
insert into language values('німецька');
insert into language values('іспанська');




insert into student
select DISTINCT ON(Stud.outid, educational_institution.education_id)Stud.outid, educational_institution.education_id,
						language.language, Stud.classprofname
from(select DISTINCT outid, classprofilename, classlangname, EOAreaName, EOTerName, EORegName, EOName from zno_ua19_20 
	)as Stud(outid, classprofname, classlang, areaname, tername, regname, eoname) 
left join person on Stud.outid = person.outid
left join language on language.language = Stud.classlang
left join place on place.areaname = Stud.areaname and
					place.tername = Stud.tername and
					place.regname = Stud.regname
left join educational_institution on Stud.eoname = educational_institution.edu_name and
									place.place_id = educational_institution.place_id										   
where Stud.classprofname is not null and
Stud.classlang is not null and
Stud.areaname is not null;

insert into edu_type 
select DISTINCT EOTypeName from zno_ua19_20 where EOTypeName is not NULL;

insert into government 
select DISTINCT EOParent from zno_ua19_20 where EOParent is not NULL;


insert into stud_education 
select DISTINCT ON(student.person_outid, student.education_id)student.person_outid, student.education_id,
					edu_type.eotypename, government.eoparent
from(select DISTINCT outid,  place.place_id, EOName, eotypename, eoparent from zno_ua19_20 
	left join place on place.areaname = EOAreaName and
					place.tername = EOTerName and
					place.regname = EORegName 
)as Education(outid, place_id, EOName, eotypename, eoparent)
inner join educational_institution on Education.EOName = educational_institution.edu_name and
									 Education.place_id = educational_institution.place_id
left join student on student.person_outid = Education.outid and
					student.education_id = educational_institution.education_id
left join edu_type on edu_type.eotypename = Education.eotypename
left join government on government.eoparent = Education.eoparent;


insert into subject values('Українська мова і література');
insert into subject values('Історія України');
insert into subject values('Математика');
insert into subject values('Фізика');
insert into subject values('Хімія');
insert into subject values('Біологія');
insert into subject values('Географія');
insert into subject values('Англійська мова');
insert into subject values('Французька мова');
insert into subject values('Німецька мова');
insert into subject values('Іспанська мова');


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


insert into exam 
select DISTINCT ON(stud_ex.zno_year, person.outid, subject.test)stud_ex.zno_year, person.outid, subject.test, language.language, educational_institution.education_id
from(
	select DISTINCT ON(zno_year, outid, test)zno_year, outid, test, lang, education_id from stud_exam
)as stud_ex(zno_year, outid, test, lang, education_id)
left join person on person.outid = stud_ex.outid
left join subject on subject.test = stud_ex.test
left join language on language.language = stud_ex.lang
inner join educational_institution on educational_institution.education_id = stud_ex.education_id; 


insert into test_condition values (0, 'не потребує');
insert into test_condition values (3, 'угорська');
insert into test_condition values (4, 'молдовська');
insert into test_condition values (7, 'румунська');


insert into test_result
select DISTINCT ON(zno_year, outid, res_test.test)zno_year, outid, res_test.test,
					test_condition.adaptscale, res_test.ball100, res_test.ball12, res_test.ball
from(
	select DISTINCT ON(stud_exam.zno_year, stud_exam.outid, test)
					stud_exam.zno_year, stud_exam.outid, test, 
				zno_ua19_20.ukradaptscale, ball100, ball12, ball from stud_exam
	inner join zno_ua19_20 on zno_ua19_20.zno_year = stud_exam.zno_year and
								zno_ua19_20.outid = stud_exam.outid
)as res_test(zno_year, outid, test, adaptscale, ball100, ball12, ball)
left join test_condition on test_condition.adaptscale = CAST(res_test.adaptscale as integer)
left join exam on exam.year = res_test.zno_year and
				exam.person_outid = res_test.outid and
				exam.test = res_test.test;












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

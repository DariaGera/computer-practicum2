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
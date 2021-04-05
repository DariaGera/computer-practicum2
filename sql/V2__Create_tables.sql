CREATE TABLE area (
    areaname        TEXT NOT NULL,
    region_regname  TEXT NOT NULL
);

ALTER TABLE area ADD CONSTRAINT area_pk PRIMARY KEY ( areaname,
                                                      region_regname );

CREATE TABLE edu_type (
    eotypename TEXT NOT NULL
);

ALTER TABLE edu_type ADD CONSTRAINT edu_type_pk PRIMARY KEY ( eotypename );

CREATE TABLE educational_institution (
    education_id  SERIAL,
    edu_name      TEXT NOT NULL,
    place_id      SERIAL NOT NULL
);

ALTER TABLE educational_institution ADD CONSTRAINT educational_institution_pk PRIMARY KEY ( education_id );


ALTER TABLE educational_institution ADD CONSTRAINT edu_place_id_un UNIQUE ( edu_name,
                                                                             place_id );

CREATE TABLE exam (
    year          INTEGER NOT NULL,
    person_outid  TEXT NOT NULL,
    test          TEXT NOT NULL,
    lang          TEXT NOT NULL,
    education_id  SERIAL NOT NULL
);

ALTER TABLE exam
    ADD CONSTRAINT exam_pk PRIMARY KEY ( year,
                                         test,
                                         person_outid );

CREATE TABLE government (
    eoparent TEXT NOT NULL
);

ALTER TABLE government ADD CONSTRAINT government_pk PRIMARY KEY ( eoparent );

CREATE TABLE indwelling (
    person_outid    TEXT NOT NULL,
    place_place_id  SERIAL,
    tertypename TEXT NOT NULL
);

ALTER TABLE indwelling ADD CONSTRAINT indwelling_pk PRIMARY KEY ( person_outid );

CREATE TABLE language (
    language TEXT NOT NULL
);

ALTER TABLE language ADD CONSTRAINT language_pk PRIMARY KEY ( language );

CREATE TABLE person (
    outid        TEXT NOT NULL,
    birth        INTEGER NOT NULL,
    sextypename  TEXT NOT NULL,
    regtypename  TEXT NOT NULL
);

ALTER TABLE person ADD CONSTRAINT person_pk PRIMARY KEY ( outid );

CREATE TABLE place (
    place_id  SERIAL,
    areaname  TEXT NOT NULL,
    tername   TEXT NOT NULL,
    regname TEXT NOT NULL
);

ALTER TABLE place ADD CONSTRAINT place_pk PRIMARY KEY ( place_id );

ALTER TABLE place ADD CONSTRAINT place_areaname_tername_un UNIQUE ( areaname,
                                                                    tername, regname);

CREATE TABLE region (
    regname TEXT NOT NULL
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( regname );

CREATE TABLE stud_education (
    outid         TEXT NOT NULL,
    education_id  SERIAL NOT NULL,
    eotypename    TEXT NOT NULL,
    eoparent      TEXT NOT NULL
);

ALTER TABLE stud_education ADD CONSTRAINT stud_education_pk PRIMARY KEY ( outid,
                                                                          education_id );

CREATE TABLE student (
    person_outid   TEXT NOT NULL,
    education_id   SERIAL NOT NULL,
    classlang      TEXT NOT NULL,
    classprofname  TEXT NOT NULL
);


ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( person_outid,
                                                            education_id );

CREATE TABLE subject (
    test TEXT NOT NULL
);

ALTER TABLE subject ADD CONSTRAINT subject_pk PRIMARY KEY ( test );

CREATE TABLE test_condition (
    adaptscale  INTEGER NOT NULL,
    condit      TEXT NOT NULL
);

ALTER TABLE test_condition ADD CONSTRAINT test_condition_pk PRIMARY KEY ( adaptscale );

CREATE TABLE test_result (
    exam_year   INTEGER NOT NULL,
    exam_outid  TEXT NOT NULL,
    exam_test   TEXT NOT NULL,
    adaptscale  INTEGER NOT NULL,
    ball100     NUMERIC,
    ball12      NUMERIC,
    ball        NUMERIC
);

ALTER TABLE test_result
    ADD CONSTRAINT test_result_pk PRIMARY KEY ( exam_year,
                                                exam_test,
                                                exam_outid );

ALTER TABLE area
    ADD CONSTRAINT area_region_fk FOREIGN KEY ( region_regname )
        REFERENCES region ( regname );


ALTER TABLE educational_institution
    ADD CONSTRAINT edu_place_fk FOREIGN KEY ( place_id )
        REFERENCES place ( place_id );

ALTER TABLE exam
    ADD CONSTRAINT exam_edu_fk FOREIGN KEY ( education_id )
        REFERENCES educational_institution ( education_id );

ALTER TABLE exam
    ADD CONSTRAINT exam_language_fk FOREIGN KEY ( lang )
        REFERENCES language ( language );

ALTER TABLE exam
    ADD CONSTRAINT exam_person_fk FOREIGN KEY ( person_outid )
        REFERENCES person ( outid );

ALTER TABLE exam
    ADD CONSTRAINT exam_subject_fk FOREIGN KEY ( test )
        REFERENCES subject ( test );

ALTER TABLE indwelling
    ADD CONSTRAINT indwelling_person_fk FOREIGN KEY ( person_outid )
        REFERENCES person ( outid );

ALTER TABLE indwelling
    ADD CONSTRAINT indwelling_place_fk FOREIGN KEY ( place_place_id )
        REFERENCES place ( place_id );

ALTER TABLE place
    ADD CONSTRAINT place_area_fk FOREIGN KEY ( areaname,
                                               regname )
        REFERENCES area ( areaname,
                          region_regname );

ALTER TABLE stud_education
    ADD CONSTRAINT stud_education_edu_type_fk FOREIGN KEY ( eotypename )
        REFERENCES edu_type ( eotypename );

ALTER TABLE stud_education
    ADD CONSTRAINT stud_education_government_fk FOREIGN KEY ( eoparent )
        REFERENCES government ( eoparent );

ALTER TABLE stud_education
    ADD CONSTRAINT stud_education_student_fk FOREIGN KEY ( outid,
                                                           education_id )
        REFERENCES student ( person_outid,
                             education_id );

ALTER TABLE student
    ADD CONSTRAINT student_institut_fk FOREIGN KEY ( education_id )
        REFERENCES educational_institution ( education_id );

ALTER TABLE student
    ADD CONSTRAINT student_language_fk FOREIGN KEY ( classlang )
        REFERENCES language ( language );

ALTER TABLE student
    ADD CONSTRAINT student_person_fk FOREIGN KEY ( person_outid )
        REFERENCES person ( outid );

ALTER TABLE test_result
    ADD CONSTRAINT test_result_exam_fk FOREIGN KEY ( exam_year,
                                                     exam_test,
                                                     exam_outid )
        REFERENCES exam ( year,
                          test,
                          person_outid );

ALTER TABLE test_result
    ADD CONSTRAINT test_result_test_condition_fk FOREIGN KEY ( adaptscale )
        REFERENCES test_condition ( adaptscale );









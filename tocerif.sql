-- functions to create and retrieve semantics from CERIF tables

/*

-- test if semantics exist

testsemantics (classhuman text, schemehuman text, out class varchar(128) , out scheme varchar(128) )  

-- retrieve semantics and throw error when not found

semantics (text classhuman, text schemehuman, out varchar(128) class , out varchar(128) scheme) RETURNS VOID  

-- create semantics

createsemantics (classid varchar(128), classschemeid varchar(128), classname varchar(64), classschemename text ) RETURNS VOID



-- a guid generator and CERIF magic values

eposuuid () RETURNS varchar(128)

eposmindate () RETURNS timestamp

eposmaxdate () RETURNS timestamp

webservice (uuidwebserice varchar(128), title varchar(250),abstract text, uri varchar(2083)) RETURNS VOID
webserviceorganisation (uuidwebservice varchar(128), uuidorgunit varchar(128), role text) RETURNS VOID
webservicekeyword (uuidwebservice varchar(128),  keyword varchar(64)) RETURNS VOID
webservicethesauruskeyword (uuidwebservice varchar(128),  keyword varchar(64), thesaurus varchar(64)) RETURNS VOID
webservicperson (uuidwebservice varchar(128), uuidpers varchar(128), role text) RETURNS VOID
webservicedates (uuidwebservice varchar(128),  creation timestamp,  revision timestamp, publication timestamp) RETURNS VOID
webserviceresolution (uuidwebservice varchar(128),  resolution varchar(64)) RETURNS VOID
webservicespatialrepresentationtype (uuidwebservice varchar(128),  type varchar(64)) RETURNS VOID
webservicespatialreferencesystem (uuidwebservice varchar(128),  referencesystem varchar(64)) RETURNS VOID
webserviceisotopic (uuidwebservice varchar(128),  topic varchar(64)) RETURNS VOID
webserviceformat (uuidwebservice varchar(128),  format varchar(64)) RETURNS VOID
webserviceaccessanduserestriction (uuidwebservice varchar(128),  accessanduse varchar(64)) RETURNS VOID
webservicepublicaccesslimit (uuidwebservice varchar(128),  publicaccesslimit varchar(1024)) RETURNS VOID
webservicelineage (uuidwebservice varchar(128),  lineage varchar(1024)) RETURNS VOID
webservicetemporalextent (uuidwebservice varchar(128),  startdate timestamp, enddate timestamp) RETURNS VOID
webservicelocation (uuidwebservice varchar(128), minlat double precision,  maxlat double precision, minlon double precision,maxlon double precision, minelev double precision, maxelev double precision) RETURNS VOID
webserviceparameter (uuidwebservice varchar(128), paramname varchar(64), paramtype varchar(64), paramvalue varchar(64), paramversion varchar(64)) RETURNS VOID
webservicetype (uuidwebservice varchar(128),  servicetype varchar(64)) RETURNS VOID


dataset (uuiddataset varchar(128), title varchar(250),abstract text, uri varchar(2083)) RETURNS VOID
datasetorganisation (uuiddataset varchar(128), uuidorgunit varchar(128), role text) RETURNS VOID
datasetperson (uuiddataset varchar(128), uuidpers varchar(128), role text) RETURNS VOID  
datasetlocation (uuiddataset varchar(128), minlat double precision,  maxlat double precision, minlon double precision,maxlon double precision, minelev double precision,minaxelev double precision)
datasetdates (uuiddataset varchar(128),  creation timestamp,  revision timestamp, publication timestamp) RETURNS VOID
datasetresolution (uuiddataset varchar(128),  resolution varchar(64)) RETURNS VOID AS  
datasetspatialrepresentationtype (uuiddataset varchar(128),  type varchar(64)) RETURNS VOID AS  
datasetspatialreferencesystem (uuiddataset varchar(128),  referencesystem varchar(64)) RETURNS VOID AS  
datasetisotopic (uuiddataset varchar(128),  topic varchar(64)) RETURNS VOID AS  
datasetformat (uuiddataset varchar(128),  format varchar(64)) RETURNS VOID AS  
datasetkeyword (uuiddataset varchar(128),  keyword varchar(64)) RETURNS VOID AS $$
datasetthesauruskeyword (uuiddataset varchar(128),  keyword varchar(64), thesaurus varchar(64)) RETURNS VOID AS  
datasetaccessanduserestriction (uuiddataset varchar(128),  accessanduse varchar(64)) RETURNS VOID AS  
datasetpublicaccesslimit (uuiddataset varchar(128),  publicaccesslimit varchar(1024)) RETURNS VOID AS  
datasetlineage (uuiddataset varchar(128),  lineage varchar(1024)) RETURNS VOID AS  
datasettemporalextent (uuiddataset varchar(128),  startdate timestamp, enddate timestamp) RETURNS VOID AS  
datasetmetadata (uuiddataset varchar(128), uuidmeta varchar(128)) RETURNS VOID
isometa (uuidmeta varchar(128), fileidentifier varchar(128), language varchar(64), charset varchar(64) ) RETURNS VOID  
isometadates (uuidmeta varchar(128), created timestamp, updated timestamp) RETURNS VOID
isometadetails (uuidmeta varchar(128), standardname varchar(64), standardversion varchar(64)) RETURNS VOID


person (uuidpers varchar(128), firstname varchar(64),familyname varchar(64)) RETURNS VOID
personfullname (uuidpers varchar(128), fullname varchar(64)) RETURNS VOID


equipment (uuidequip varchar(128), type varchar(64), name varchar(254)) RETURNS VOID  
equipmentdescription (uuidequip varchar(128), descr varchar(1024)) RETURNS VOID  
equipmentdetail (uuidequip varchar(128), attributelabel varchar (20), attributevalue text ) RETURNS VOID  
equipmentlocation (uuidequip varchar(128), lat double precision, lon double precision, elev double precision) RETURNS VOID
equipmentorganisation (uuidequip varchar(128), uuidorgunit varchar(128), role text) RETURNS VOID


organisation (uuidorgunit varchar(128), name varchar(250)) RETURNS VOID  
organisationperson(uuidpers varchar(128), uuidorgunit varchar(128), role text) RETURNS VOID
organisationwebsite (uuidorgunit varchar(128), url varchar(2083)) RETURNS VOID
organisationparent(uuidparent varchar(128), uuidchild varchar(128)) RETURNS VOID


publication (uuidrespubl varchar(128), title varchar(250),abstract text, pubdate timestamp) RETURNS VOID
publicationperson (uuidrespubl varchar(128), uuidpers varchar(128), role text) RETURNS VOID  
publicationorganisation (uuidrespubl varchar(128), uuidorgunit varchar(128), role text) RETURNS VOID  


service (uuidsrv varchar(128), type varchar(64), name varchar(254), uri varchar(2083)) RETURNS VOID  
servicedescription (uuidsrv varchar(128), descr varchar(8000)) RETURNS VOID  
serviceperson (uuidsrv varchar(128), uuidpers varchar(128), text role) RETURNS VOID  
serviceorganisation (uuidsrv varchar(128), uuidorgunit varchar(128), text role) RETURNS VOID


facility (uuidfacility varchar(128), name varchar(250)) RETURNS VOID
facilitywebsite (uuidfacility varchar(128), url varchar(2083)) RETURNS VOID
facilityperson(uuidfacil varchar(128), uuidpers varchar(128), role text) RETURNS VOID

*/


CREATE OR REPLACE FUNCTION eposmindate () RETURNS timestamp AS $$
BEGIN
    RETURN '1901-01-01T00:0000-01:00';
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION eposmaxdate () RETURNS timestamp AS $$
BEGIN
    RETURN '2099-12-31T23:59:59-01:00';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_class (v_cfresprodid char(128), v_cfclassid char(128), v_cfclassschemeid char(128), v_cfstartdate timestamp, v_cfenddate timestamp, v_cffraction float8) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfresprod_class WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cfstartdate = v_cfstartdate and cfenddate = v_cfenddate) THEN 
	INSERT INTO cfresprod_class (cfresprodid, cfclassid, cfclassschemeid, cfstartdate, cfenddate, cffraction) VALUES (v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate, v_cffraction);
ELSE
	UPDATE cfresprod_class SET cffraction = v_cffraction  WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cfstartdate = v_cfstartdate and cfenddate = v_cfenddate;
END IF;
END; 
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION tocfresprod (v_cfresprodid char(128), v_cfuri varchar(2083)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfresprod WHERE cfresprodid = v_cfresprodid) THEN 
	INSERT INTO cfresprod (cfresprodid, cfuri) VALUES (v_cfresprodid, v_cfuri);
ELSE
	UPDATE cfresprod SET cfuri = v_cfuri  WHERE cfresprodid = v_cfresprodid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprodname (v_cfresprodid char(128), v_cfname char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfresprodname WHERE cfresprodid = v_cfresprodid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfresprodname (cfresprodid, cfname, cflangcode, cftrans) VALUES (v_cfresprodid, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfresprodname SET cfname = v_cfname  WHERE cfresprodid = v_cfresprodid and cftrans = v_cftrans and cflangcode = v_cflangcode;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresproddescr (v_cfresprodid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfresproddescr WHERE cfresprodid = v_cfresprodid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfresproddescr (cfresprodid, cfdescr, cflangcode, cftrans) VALUES (v_cfresprodid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfresproddescr SET cfdescr = v_cfdescr  WHERE cfresprodid = v_cfresprodid and cftrans = v_cftrans and cflangcode = v_cflangcode;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION webservice (uuidwebserice varchar(128), title varchar(250),abstract text, uri varchar(2083)) RETURNS VOID AS $$
DECLARE
    class varchar(128);  
    scheme varchar(128);
BEGIN
    perform tocfresprod (uuidwebserice,uri);
    perfrom tocfresprodname (uuidwebserice, title, 'en','h');
    perfrom tocfresproddescr (uuidwebserice, abstract, 'en','h');
    PERFORM resprodclass(uuidwebserice,'Webservice'::varchar(64),'EPOS Result Product Types'::varchar(64),NULL::timestamp,NULL::timestamp);
END;
$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION tocfresprodkeyw (v_cfresprodid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfresprodkeyw WHERE cfresprodid = v_cfresprodid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfresprodkeyw (cfresprodid, cfkeyw, cflangcode, cftrans) VALUES (v_cfresprodid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfresprodkeyw SET cfkeyw = v_cfkeyw  WHERE cfresprodid = v_cfresprodid and cftrans = v_cftrans and cflangcode = v_cflangcode;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION webservicekeyword (uuidwebservice varchar(128),  keyword varchar(64)) RETURNS VOID AS $$
BEGIN
    perform tocfresprodkeyw(uuidwebservice, keyword, 'en', 'h');
END;
$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION webservicethesauruskeyword (uuidwebservice varchar(128),  keyword varchar(64), thesaurus varchar(64)) RETURNS VOID AS $$

BEGIN

    SELECT resprodclass(uuidwebservice,keyword,thesaurus,NULL,NULL);

END;

$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_resprod (v_cfpersid char(128), v_cfresprodid char(128), v_cfclassid char(128), v_cfclassschemeid char(128), v_cfavailability char(64), v_cfconditions char(254), v_cfcurrcode char(3), v_cfipr char(64), v_cforder numeric(10,0), v_cfprice float8, v_cfstartdate timestamp, v_cfenddate timestamp, v_cffraction float8) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfpers_resprod WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfstartdate = v_cfstartdate and cfenddate = v_cfenddate) THEN 
	INSERT INTO cfpers_resprod (cfpersid, cfresprodid, cfclassid, cfclassschemeid, cfavailability, cfconditions, cfcurrcode, cfipr, cforder, cfprice, cfstartdate, cfenddate, cffraction) VALUES (v_cfpersid, v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfavailability, v_cfconditions, v_cfcurrcode, v_cfipr, v_cforder, v_cfprice, v_cfstartdate, v_cfenddate, v_cffraction);
ELSE
	UPDATE cfpers_resprod SET cfavailability = v_cfavailability, cfconditions = v_cfconditions, cfcurrcode = v_cfcurrcode, cfipr = v_cfipr, cforder = v_cforder, cfprice = v_cfprice, cffraction = v_cffraction  WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfstartdate = v_cfstartdate and cfenddate = v_cfenddate;
END IF;
END; 
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION webservicperson (uuidwebservice varchar(128), uuidpers varchar(128), role text) RETURNS VOID AS $$

DECLARE
    class varchar(128);
    scheme varchar(128);
BEGIN

	select s.schemeid, s.classid into scheme, class from getSemantics(role,'Person Output Contributions')) s;

    perform tocfpers_resprod()

END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION webserviceorganisation (uuidwebservice varchar(128), uuidorgunit varchar(128), role text) RETURNS VOID AS $$

DECLARE

    class varchar(128);

    scheme varchar(128);

BEGIN


    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  (role,'Organisation Output Roles') tbl ;


    IF NOT EXISTS (SELECT * FROM cforgunit_resprod WHERE cfOrgunitId=uuidorgunit AND cfResprodId=uuidwebservice AND cfClassId=class AND cfClassSchemeId=scheme) THEN

        INSERT INTO cforgunit_resprod (cfResprodId,cfOrgunitId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidwebservice,uuidorgunit,eposmindate(),eposmaxdate(),class,scheme) ;

    ELSE

        UPDATE cforgunit_resprod SET cfResprodId=uuidwebservice WHERE cfOrgunitId=uuidorgunit AND cfClassId=class AND cfClassSchemeId=scheme;

    END IF;

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION webservicedates (uuidwebservice varchar(128),  creation timestamp,  revision timestamp, publication timestamp) RETURNS VOID AS $$

BEGIN

--

    IF creation IS NOT NULL THEN

        PERFORM resprodclass(uuidwebservice,'Creation','EPOS Dates',creation,NULL);

    END IF;

    IF revision IS NOT NULL THEN

        PERFORM resprodclass(uuidwebservice,'Revision','EPOS Dates',revision,NULL);

    END IF;

    IF publication IS NOT NULL THEN

        PERFORM resprodclass(uuidwebservice,'Publication','EPOS Dates',publication,NULL);

    END IF;

--

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION webservicetype (uuidwebservice varchar(128),  servicetype varchar(64)) RETURNS VOID AS $$

BEGIN

        PERFORM resprodclass(uuidwebservice,servicetype,'EPOS Webservice Types',NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION webservicedomain (uuidwebservice varchar(128),  domain varchar(64)) RETURNS VOID AS $$

BEGIN

        PERFORM resprodclass(uuidwebservice,domain,'EPOS Domain',NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION webservicesubdomain (uuidwebservice varchar(128),  subdomain varchar(64)) RETURNS VOID AS $$

BEGIN

        PERFORM resprodclass(uuidwebservice,subdomain,'EPOS Subdomain',NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION webserviceresolution (uuidwebservice varchar(128),  resolution varchar(64)) RETURNS VOID AS $$
DECLARE

       measid varchar(128);
       class varchar(128);
       scheme varchar(128);

BEGIN

    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Spatial Resolution','Reuse Information') tbl ;

    IF NOT EXISTS (SELECT *  FROM cfResprod_meas WHERE cfResprodId=uuidwebservice) THEN

        measid := eposuuid();

        INSERT INTO cfMeas (cfMeasId, cfvaljudText) VALUES (measid, resolution);

        INSERT INTO cfResprod_meas (cfMeasId, cfResprodId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (measid,uuidwebservice,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        SELECT cfMeasId INTO measid FROM cfResprod_meas WHERE cfResprodId=uuidwebservice AND cfClassschemeId=scheme AND cfClassId=scheme;

        UPDATE cfMeas SET cfvaljudgeText=resolution WHERE cfMeasId=measid;

    END IF;

END;


END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION webservicespatialrepresentationtype (uuidwebservice varchar(128),  type varchar(64)) RETURNS VOID AS $$

BEGIN

    PERFORM resprodclass(uuidwebservice,type,'Spatial Representation Type',NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION webservicespatialreferencesystem (uuidwebservice varchar(128),  referencesystem varchar(64)) RETURNS VOID AS $$

BEGIN

    PERFORM resprodclass(uuidwebservice,referencesystem,'Spatial Reference System',NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION webserviceisotopic (uuidwebservice varchar(128),  topic varchar(64)) RETURNS VOID AS $$

BEGIN

    PERFORM resprodclass(uuidwebservice,topic,'ISO Topic',NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION webserviceformat (uuidwebservice varchar(128),  format varchar(64)) RETURNS VOID AS $$

BEGIN

    PERFORM resprodclass(uuidwebservice,format,'Distribution Format',NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION webserviceaccessanduserestriction (uuidwebservice varchar(128),  accessanduse varchar(64)) RETURNS VOID AS $$

BEGIN

    PERFORM resprodclass(uuidwebservice,accessanduse,'Access and Use Restrictions',NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION webservicepublicaccesslimit (uuidwebservice varchar(128),  publicaccesslimit varchar(1024)) RETURNS VOID AS $$

DECLARE

       measid varchar(128);
       class varchar(128);
       scheme varchar(128);

BEGIN

    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Public Access Limit','Reuse Information') tbl ;


    IF NOT EXISTS (SELECT *  FROM cfResprod_meas WHERE cfResprodId=uuidwebservice) THEN

        measid := eposuuid();

        INSERT INTO cfMeas (cfMeasId, cfvaljudText) VALUES (measid, publicaccesslimit);

        INSERT INTO cfResprod_meas (cfMeasId, cfResprodId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (measid,uuidwebservice,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        SELECT cfMeasId INTO measid FROM cfResprod_meas WHERE cfResprodId=uuidwebservice AND cfClassschemeId=scheme AND cfClassId=scheme;

        UPDATE cfMeas SET cfvaljudgeText=publicaccesslimit WHERE cfMeasId=measid;

    END IF;

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION webservicelineage (uuidwebservice varchar(128),  lineage varchar(1024)) RETURNS VOID AS $$

DECLARE

       measid varchar(128);
       class varchar(128);
       scheme varchar(128);

BEGIN

    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Lineage','Reuse Information') tbl ;


    IF NOT EXISTS (SELECT *  FROM cfResprod_meas WHERE cfResprodId=uuidwebservice) THEN

        measid := eposuuid();

        INSERT INTO cfMeas (cfMeasId, cfvaljudText) VALUES (measid, lineage);

        INSERT INTO cfResprod_meas (cfMeasId, cfResprodId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (measid,uuidwebservice,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        SELECT cfMeasId INTO measid FROM cfResprod_meas WHERE cfResprodId=uuidwebservice AND cfClassschemeId=scheme AND cfClassId=scheme;

        UPDATE cfMeas SET cfvaljudText=lineage WHERE cfMeasId=measid;

    END IF;

END;

$$ LANGUAGE plpgsql;


--

CREATE OR REPLACE FUNCTION webservicetemporalextent (uuidwebservice varchar(128),  startdate timestamp, enddate timestamp) RETURNS VOID AS $$

DECLARE

       measid varchar(128);
       class varchar(128);
       scheme varchar(128);

BEGIN

    IF startdate IS NOT NULL THEN

        SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Start Date','EPOS Temporal Extent') tbl ;

        IF NOT EXISTS (SELECT *  FROM cfResprod_meas WHERE cfResprodId=uuidwebservice) THEN

            measid := eposuuid();

            INSERT INTO cfMeas (cfMeasId, cfDatetime) VALUES (measid, startdate);

            INSERT INTO cfResprod_meas (cfMeasId, cfResprodId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (measid,uuidwebservice,eposmindate(),eposmaxdate(),class,scheme);

        ELSE

            SELECT cfMeasId INTO measid FROM cfResprod_meas WHERE cfResprodId=uuidwebservice AND cfClassschemeId=scheme AND cfClassId=scheme;

            UPDATE cfMeas SET cfDatetime=startdate WHERE cfMeasId=measid;

        END IF;

    END IF;


    IF enddate IS NOT NULL THEN

        SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('End Date','EPOS Temporal Extent') tbl ;


        IF NOT EXISTS (SELECT *  FROM cfResprod_meas WHERE cfResprodId=uuidwebservice) THEN

            measid := eposuuid();

            INSERT INTO cfMeas (cfMeasId, cfDatetime) VALUES (measid, enddate);

            INSERT INTO cfResprod_meas (cfMeasId, cfResprodId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (measid,uuidwebservice,eposmindate(),eposmaxdate(),class,scheme);

        ELSE

            SELECT cfMeasId INTO measid FROM cfResprod_meas WHERE cfResprodId=uuidwebservice AND cfClassschemeId=scheme AND cfClassId=scheme;

            UPDATE cfMeas SET cfDatetime=enddate WHERE cfMeasId=measid;

        END IF;

    END IF;


END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION webservicelocation (uuidwebservice varchar(128), minlat double precision,  maxlat double precision, minlon double precision,maxlon double precision, minelev double precision, maxelev double precision) RETURNS VOID AS $$

DECLARE

    uuidgeobbox varchar(128);

        class varchar(128);

    scheme varchar(128);

BEGIN


    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Location','EPOS Dataset Details') tbl ;


    IF NOT EXISTS (SELECT * FROM cfResprod_geobbox WHERE cfResprodId=uuidwebservice and cfClassId=class and cfclassschemeId=scheme) THEN

        uuidgeobbox := eposuuid();

        INSERT INTO cfGeoBBox (cfGeoBBoxId,cfSBLat,cfNBLat,cfWBLong,cfEBLong,cfMinElev,cfMaxElev) VALUES (uuidgeobbox,minlat,maxlat,minlon,maxlon,minelev,maxelev);

        INSERT INTO cfResprod_geobbox (cfResprodId,cfGeoBBoxId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidwebservice,uuidgeobbox,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        SELECT cfGeoBBoxId INTO uuidgeobbox FROM cfResprod_geobbox WHERE cfResprodId=uuidwebservice and cfClassId=class and cfclassschemeId=scheme;

        UPDATE cfGeoBBox SET cfSBLat=minlat, cfNBLat=maxlat, cfWBLong=minlon, cfEBLong=maxlon, cfMinElev=minelev, cfMaxElev=maxelev WHERE cfGeoBBoxId=uuidgeobbox;

    END IF;

--

END;

$$ LANGUAGE plpgsql;

--
CREATE OR REPLACE FUNCTION webserviceparameter (webserviceuri varchar(128), paramname varchar(64), paramtype varchar(64), paramvalue varchar(64), paramversion varchar(64)) RETURNS VOID AS $$

DECLARE

    paramclass varchar(128);
    paramscheme varchar(128);
    
    resprodid varchar(128);
    paramgroupid varchar(128);
    paramid varchar(128);
    measclass varchar(128);
    measscheme varchar(128);

BEGIN

    -- read resprodid of webservice endpoint

    SELECT cfresprodid INTO resprodid  FROM cfResprod WHERE cfURI=webserviceuri;

    -- "kind ID" for the parameter for grouping
    paramgroupid=eposuuid();
    INSERT INTO cfMeas (cfMeasId) VALUES (paramgroupid);
    PERFORM createsemantics  (eposuuid (),eposuuid (),'Parameter Group','Webservice Information');
    SELECT tbl.class, tbl.scheme INTO paramclass, paramscheme FROM semantics  ('Webservice Paramenter Group','EPOS Measurement Types') tbl ;
    insert into cfresprod_meas (cfresprodid, cfmeasid, cfstartdate, cfenddate, cfclassid, cfclassschemeid) values (resprodid, paramgroupid, eposmindate(), eposmaxdate(),paramclass, paramscheme);

    -- webservice information

    paramid=eposuuid();
    INSERT INTO cfMeas (cfMeasId, cfValJudgeText) VALUES (paramid,paramname);
    PERFORM createsemantics  (eposuuid (),eposuuid (),'Parameter Name','Webservice Information');
    SELECT tbl.class, tbl.scheme INTO paramclass, paramscheme FROM semantics  ('Parameter Name','Webservice Information') tbl ;
    insert into cfmeas_meas (cfmeasd1, cfmeasid2, cfstartdate, cfenddate, cfclassid, cfclassschemeid) values (paramgroupid,paramid, eposmindate(), eposmaxdate(),paramclass, paramscheme);


    paramid=eposuuid();
    INSERT INTO cfMeas (cfMeasId, cfValJudgeText) VALUES (paramid,paramtype);
    PERFORM createsemantics  (eposuuid (),eposuuid (),'Parameter Type','Webservice Information');
    SELECT tbl.class, tbl.scheme INTO paramclass, paramscheme FROM semantics  ('Parameter Type','Webservice Information') tbl ;
    insert into cfmeas_meas (cfmeasd1, cfmeasid2, cfstartdate, cfenddate, cfclassid, cfclassschemeid) values (paramgroupid, paramid, eposmindate(), eposmaxdate(),paramclass, paramscheme);


    paramid=eposuuid();
    INSERT INTO cfMeas (cfMeasId, cfValJudgeText) VALUES (paramid,paramvalue);
    PERFORM createsemantics  (eposuuid (),eposuuid (),'Parameter Value','Webservice Information');
    SELECT tbl.class, tbl.scheme INTO paramclass, paramscheme FROM semantics  ('Parameter Value','Webservice Information') tbl ;
    insert into cfmeas_meas (cfmeasd1, cfmeasid2, cfstartdate, cfenddate, cfclassid, cfclassschemeid) values (paramgroupid,paramid, eposmindate(), eposmaxdate(),paramclass, paramscheme);


    paramid=eposuuid();
    INSERT INTO cfMeas (cfMeasId, cfValJudgeText) VALUES (paramid,paramversion);
    PERFORM createsemantics  (eposuuid (),eposuuid (),'Parameter Version','Webservice Information');
    SELECT tbl.class, tbl.scheme INTO paramclass, paramscheme FROM semantics  ('Parameter Version','Webservice Information') tbl ;
    insert into cfmeas_meas (cfmeasd1, cfmeasid2, cfstartdate, cfenddate, cfclassid, cfclassschemeid) values (paramgroupid,paramid, eposmindate(), eposmaxdate(),paramclass, paramscheme);

END;

$$ LANGUAGE plpgsql;

--


CREATE OR REPLACE FUNCTION semantics (classhuman text, schemehuman text, out class varchar(128) , out scheme varchar(128) )  AS $$

BEGIN

    SELECT c.cfclassid INTO class FROM cfClassterm c JOIN cfClassschemename cs ON cs.cfclassschemeid=c.cfclassschemeid WHERE cs.cfname=schemehuman and c.cfterm=classhuman;

    IF class IS NULL THEN
    PERFORM createsemantics(eposuuid(),eposuuid(),classhuman,schemehuman);
    END IF;

    SELECT c.cfclassid INTO class FROM cfClassterm c JOIN cfClassschemename cs ON cs.cfclassschemeid=c.cfclassschemeid WHERE cs.cfname=schemehuman and c.cfterm=classhuman;
    SELECT c.cfclassschemeid INTO scheme FROM cfClassterm c JOIN cfClassschemename cs ON cs.cfclassschemeid=c.cfclassschemeid WHERE cs.cfname=schemehuman and c.cfterm=classhuman;


        IF class IS NULL OR scheme IS NULL THEN

        RAISE EXCEPTION 'Missing semantics in database for (%)', classhuman ||':'||schemehuman;

        END IF;


--    SELECT class, scheme;


END;

$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION testsemantics (classhuman text, schemehuman text, out class varchar(128) , out scheme varchar(128) )  AS $$

BEGIN

    SELECT c.cfclassid INTO class FROM cfClassterm c JOIN cfClassschemename cs ON cs.cfclassschemeid=c.cfclassschemeid WHERE cs.cfname=schemehuman and c.cfterm=classhuman;

    SELECT c.cfclassschemeid INTO scheme FROM cfClassterm c JOIN cfClassschemename cs ON cs.cfclassschemeid=c.cfclassschemeid WHERE cs.cfname=schemehuman and c.cfterm=classhuman;


--    SELECT class, scheme;


END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION createsemantics (classid varchar(128), classschemeid varchar(128), classname varchar(64), classschemename text ) RETURNS VOID AS $$

BEGIN

    IF NOT EXISTS  (SELECT * FROM cfClassScheme WHERE cfClassSchemeId=classschemeid) THEN

        INSERT INTO cfClassScheme (cfClassSchemeId)   VALUES (classschemeid);

    END IF;


    IF NOT EXISTS  (SELECT * FROM cfClassSchemename WHERE cfClassSchemeId=classschemeid) THEN

        INSERT INTO cfClassSchemename (cfClassSchemeId, CFLANGCODE, CFTRANS, CFNAME) VALUES (classschemeid, 'en', 'o', classschemename );

    END IF;


    IF NOT EXISTS  (SELECT * FROM cfClass WHERE cfClassId=classid AND cfClassSchemeId=classschemeid ) THEN

        INSERT INTO cfClass (cfClassId,cfClassSchemeId,cfStartDate,cfEndDate) VALUES (classid,classschemeid,eposmindate(),eposmaxdate());     

    END IF;


    IF NOT EXISTS  (SELECT * FROM cfClassTerm where  cfClassId=classid AND cfClassSchemeId=classschemeid) THEN

        INSERT INTO cfClassTerm (cfClassId, cfClassSchemeId, CFLANGCODE, CFTRANS, CFTERM, CFTERMSRC, CFROLEEXPR) VALUES ( classid,classschemeid, 'en', 'o', classname, 'EPOS', 'is a' );    

    END IF;

END;

$$ LANGUAGE plpgsql;





--

-- helper functions to retrieve CERIF 'magic values' and a new uuid (seems database specific)

--


CREATE OR REPLACE FUNCTION eposuuid () RETURNS varchar(128) AS $$

BEGIN

    RETURN uuid_in(md5(random()::text || now()::text)::cstring);

END;

$$ LANGUAGE plpgsql;




--



CREATE OR REPLACE FUNCTION dataset (uuiddataset varchar(128), title varchar(250),abstract text, uri varchar(2083)) RETURNS VOID AS $$

DECLARE

    class varchar(128);  

    scheme varchar(128);

BEGIN

   


    IF NOT EXISTS (SELECT * FROM cfResprod WHERE cfResprodId=uuiddataset) THEN

        INSERT INTO cfResprod (cfResprodId,cfURI) VALUES(uuiddataset, uri);

    END IF;


    IF NOT EXISTS (SELECT * FROM cfResprodName WHERE cfResprodId=uuiddataset) THEN

        INSERT INTO cfResprodName (cfResprodId, cfLangcode,cfTrans,cfName) VALUES (uuiddataset,'en','h',title);

    ELSE

        UPDATE cfResprodName SET cfLangcode='en', cfTrans='h', cfName=title  WHERE cfResprodId=uuiddataset;

    END IF;



    IF NOT EXISTS (SELECT * FROM cfResprodDescr WHERE cfResProdId=uuiddataset) THEN

        INSERT INTO cfResprodDescr (cfResprodId, cfLangcode,cfTrans,cfDescr) VALUES (uuiddataset,'en','h',abstract);

    ELSE

        UPDATE cfResprodDescr SET cfLangcode='en', cfTrans='h', cfDescr=abstract  WHERE cfResprodId=uuiddataset;

    END IF;


    PERFORM resprodclass(uuiddataset,'Dataset'::varchar(64),'EPOS Result Product Types'::varchar(64),NULL::timestamp,NULL::timestamp);



END;

$$ LANGUAGE plpgsql;


--

CREATE OR REPLACE FUNCTION datasetkeyword (uuiddataset varchar(128),  keyword varchar(64)) RETURNS VOID AS $$

BEGIN

    IF NOT EXISTS (SELECT * FROM cfResprodKeyw WHERE cfResprodId=uuiddataset AND cfkeyw=keyword) THEN

        INSERT INTO cfResprodKeyw (cfResprodId, cfLangcode,cfTrans,cfkeyw) VALUES (uuiddataset,'en','h',keyword);

    END IF;

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION datasetthesauruskeyword (uuiddataset varchar(128),  keyword varchar(64), thesaurus varchar(64)) RETURNS VOID AS $$

BEGIN

    SELECT resprodclass(uuiddataset,keyword,thesaurus,NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--


CREATE OR REPLACE FUNCTION datasetperson (uuiddataset varchar(128), uuidpers varchar(128), role text) RETURNS VOID AS $$

DECLARE

    class varchar(128);

    scheme varchar(128);

BEGIN


    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  (role,'Person Output Contributions') tbl ;


    IF NOT EXISTS (SELECT * FROM cfpers_resprod WHERE cfResprodId=uuiddataset AND cfPersId=uuidpers AND cfClassId=class AND cfClassSchemeId=scheme) THEN

        INSERT INTO cfpers_resprod (cfResprodId,cfPersId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId,cfCurrcode) VALUES (uuiddataset,uuidpers,eposmindate(),eposmaxdate(),class,scheme,'EUR') ;

    ELSE

        UPDATE cfpers_resprod SET cfResprodId=uuiddataset WHERE cfPersId=uuidpers AND cfClassId=class AND cfClassSchemeId=scheme;

    END IF;

END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION datasetorganisation (uuiddataset varchar(128), uuidorgunit varchar(128), role text) RETURNS VOID AS $$

DECLARE

    class varchar(128);

    scheme varchar(128);

BEGIN


    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  (role,'Organisation Output Roles') tbl ;


    IF NOT EXISTS (SELECT * FROM cforgunit_resprod WHERE cfOrgunitId=uuidorgunit AND cfResprodId=uuiddataset AND cfClassId=class AND cfClassSchemeId=scheme) THEN

        INSERT INTO cforgunit_resprod (cfResprodId,cfOrgunitId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuiddataset,uuidorgunit,eposmindate(),eposmaxdate(),class,scheme) ;

    ELSE

        UPDATE cforgunit_resprod SET cfResprodId=uuiddataset WHERE cfOrgunitId=uuidorgunit AND cfClassId=class AND cfClassSchemeId=scheme;

    END IF;

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION datasetdates (uuiddataset varchar(128),  creation timestamp,  revision timestamp, publication timestamp) RETURNS VOID AS $$

BEGIN

--

    IF creation IS NOT NULL THEN

        PERFORM resprodclass(uuiddataset,'Creation','EPOS Dates',creation,NULL);

    END IF;

    IF revision IS NOT NULL THEN

        PERFORM resprodclass(uuiddataset,'Revision','EPOS Dates',revision,NULL);

    END IF;

    IF publication IS NOT NULL THEN

        PERFORM resprodclass(uuiddataset,'Publication','EPOS Dates',publication,NULL);

    END IF;

--

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION datasetresolution (uuiddataset varchar(128),  resolution varchar(64)) RETURNS VOID AS $$

BEGIN

    SELECT resprodclass(uuiddataset,resolution,'Spatial Resolution',NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION datasetspatialrepresentationtype (uuiddataset varchar(128),  type varchar(64)) RETURNS VOID AS $$

BEGIN

    SELECT resprodclass(uuiddataset,type,'Spatial Representation Type',NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION datasetspatialreferencesystem (uuiddataset varchar(128),  referencesystem varchar(64)) RETURNS VOID AS $$

BEGIN

    SELECT resprodclass(uuiddataset,referencesystem,'Spatial Reference System',NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION datasetisotopic (uuiddataset varchar(128),  topic varchar(64)) RETURNS VOID AS $$

BEGIN

    SELECT resprodclass(uuiddataset,topic,'ISO Topic',NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION datasetformat (uuiddataset varchar(128),  format varchar(64)) RETURNS VOID AS $$

BEGIN

    SELECT resprodclass(uuiddataset,format,'Distribution Format',NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION datasetaccessanduserestriction (uuiddataset varchar(128),  accessanduse varchar(64)) RETURNS VOID AS $$

BEGIN

    SELECT resprodclass(uuiddataset,accessanduse,'Access and Use Restrictions',NULL,NULL);

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION datasetpublicaccesslimit (uuiddataset varchar(128),  publicaccesslimit varchar(1024)) RETURNS VOID AS $$

DECLARE

    cfmeasid varchar(128);
    class varchar(128);
    scheme     varchar(128);
BEGIN

    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Public Access Limit','Reuse Information') tbl ;


    IF NOT EXISTS (SELECT *  FROM cfResprod_meas WHERE cfResprodId=uuidmeta) THEN

        cfmeasid := eposuuid();

        INSERT INTO cfMeas (cfMeasId, cfvaljudText) VALUES (cfmeasid, publicaccesslimit);

        INSERT INTO cfResprod_meas (cfMeasId, cfResprodId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (cfmeasid,uuiddataset,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        SELECT cfMeasId INTO cfmeasid FROM cfResprod_meas WHERE cfResprodId=uuiddataset AND cfClassschemeId=scheme AND cfClassId=scheme;

        UPDATE cfMeas SET cfvaljudText=publicaccesslimit WHERE cfMeasId=cfmeasid;

    END IF;

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION datasetlineage (uuiddataset varchar(128),  lineage varchar(1024)) RETURNS VOID AS $$

DECLARE

       cfmeasid varchar(128);
    class varchar(128);
    scheme     varchar(128);
BEGIN

    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Lineage','Reuse Information') tbl ;


    IF NOT EXISTS (SELECT *  FROM cfResprod_meas WHERE cfResprodId=uuidmeta) THEN

        cfmeasid := eposuuid();

        INSERT INTO cfMeas (cfMeasId, cfvaljudText) VALUES (cfmeasid, lineage);

        INSERT INTO cfResprod_meas (cfMeasId, cfResprodId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (cfmeasid,uuiddataset,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        SELECT cfMeasId INTO cfmeasid FROM cfResprod_meas WHERE cfResprodId=uuiddataset AND cfClassschemeId=scheme AND cfClassId=scheme;

        UPDATE cfMeas SET cfvaljudText=lineage WHERE cfMeasId=cfmeasid;

    END IF;

END;

$$ LANGUAGE plpgsql;


--

CREATE OR REPLACE FUNCTION datasettemporalextent (uuiddataset varchar(128),  startdate timestamp, enddate timestamp) RETURNS VOID AS $$

DECLARE

       cfmeasid varchar(128);
    class varchar(128);
    scheme     varchar(128);
BEGIN

    IF startdate IS NOT NULL THEN


        SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Start Date','EPOS Temporal Extent') tbl ;

        IF NOT EXISTS (SELECT *  FROM cfResprod_meas WHERE cfResprodId=uuidmeta) THEN

            cfmeasid := eposuuid();

            INSERT INTO cfMeas (cfMeasId, cfDatetime) VALUES (cfmeasid, startdate);

            INSERT INTO cfResprod_meas (cfMeasId, cfResprodId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (cfmeasid,uuiddataset,eposmindate(),eposmaxdate(),class,scheme);

        ELSE

            SELECT cfMeasId INTO cfmeasid FROM cfResprod_meas WHERE cfResprodId=uuiddataset AND cfClassschemeId=scheme AND cfClassId=scheme;

            UPDATE cfMeas SET cfDatetime=startdate WHERE cfMeasId=cfmeasid;

        END IF;

    END IF;


    IF enddate IS NOT NULL THEN

        SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('End Date','EPOS Temporal Extent') tbl ;


        IF NOT EXISTS (SELECT *  FROM cfResprod_meas WHERE cfResprodId=uuidmeta) THEN

            cfmeasid := eposuuid();

            INSERT INTO cfMeas (cfMeasId, cfDatetime) VALUES (cfmeasid, enddate);

            INSERT INTO cfResprod_meas (cfMeasId, cfResprodId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (cfmeasid,uuiddataset,eposmindate(),eposmaxdate(),class,scheme);

        ELSE

            SELECT cfMeasId INTO cfmeasid FROM cfResprod_meas WHERE cfResprodId=uuiddataset AND cfClassschemeId=scheme AND cfClassId=scheme;

            UPDATE cfMeas SET cfDatetime=enddate WHERE cfMeasId=cfmeasid;

        END IF;

    END IF;


END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION datasetlocation (uuiddataset varchar(128), minlat double precision,  maxlat double precision, minlon double precision,maxlon double precision, minelev double precision, maxelev double precision) RETURNS VOID AS $$

DECLARE

    uuidgeobbox varchar(128);

        class varchar(128);

    scheme varchar(128);

BEGIN


    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Location','EPOS Dataset Details') tbl ;


    IF NOT EXISTS (SELECT * FROM cfResprod_geobbox WHERE cfResprodId=uuiddataset and cfClassId=class and cfclassschemeId=scheme) THEN

        uuidgeobbox := eposuuid();

        INSERT INTO cfGeoBBox (cfGeoBBoxId,cfSBLat,cfNBLat,cfWBLong,cfEBLong,cfMinElev,cfMaxElev) VALUES (uuidgeobbox,lat,lat,lon,lon,elev,elev);

        INSERT INTO cfResprod_geobbox (cfResprodId,cfGeoBBoxId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuiddataset,uuidgeobbox,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        SELECT cfGeoBBoxId INTO uuidgeobbox FROM cfResprod_geobbox WHERE cfResprodId=uuiddataset and cfClassId=class and cfclassschemeId=scheme;

        UPDATE cfGeoBBox SET cfSBLat=lat, cfNBLat=lat, cfWBLong=lon, cfEBLong=lon, cfMinElev=elev, cfMaxElev=elev WHERE cfGeoBBoxId=uuidgeobbox;

    END IF;

--

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION datasetmetadata (uuiddataset varchar(128), uuidmeta varchar(128)) RETURNS VOID AS $$

DECLARE

        class varchar(128);

    scheme varchar(128);

BEGIN

    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Dataset Metadata','EPOS Dataset Details') tbl ;


    IF NOT EXISTS (SELECT * FROM cfResprod_resprod WHERE cfResprodId1=uuiddataset and cfClassId=class and cfclassschemeId=scheme) THEN

        INSERT INTO cfResprod_resprod (cfResprodId1,cfResprodId2,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuiddataset,uuidmeta,eposmindate(),eposmaxdate(),class,scheme);

    END IF;

--

END;

$$ LANGUAGE plpgsql;

--


CREATE OR REPLACE FUNCTION isometa (uuidmeta varchar(128), fileidentifier varchar(128), language varchar(64), charset varchar(64) ) RETURNS VOID AS $$

BEGIN


    IF NOT EXISTS (SELECT * FROM cfResprod WHERE cfResprodId=uuidmeta) THEN

        INSERT INTO cfResprod (cfResprodId,cfURI) VALUES(uuidmeta, fileidentifier);

    END IF;


    SELECT resprodclass(uuidmeta,language,'EPOS Dataset Metadata Languages',NULL,NULL);

    SELECT resprodclass(uuidmeta,charset,'EPOS Dataset Metadata Charsets',NULL,NULL);

    SELECT resprodclass(uuidmeta,'ISO19115/19 Metadata','EPOS Result Product Types',NULL,NULL);



END;

$$ LANGUAGE plpgsql;

--



CREATE OR REPLACE FUNCTION isometadetails (uuidmeta varchar(128), standardname varchar(64), standardversion varchar(64)) RETURNS VOID AS $$

BEGIN


    SELECT resprodclass(uuidmeta,standardname,'EPOS Dataset Metadata Standard Name',NULL,NULL);

    SELECT resprodclass(uuidmeta,standardversion,'EPOS Dataset Metadata Standard Version',NULL,NULL);

END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION isometadates (uuidmeta varchar(128), created timestamp, updated timestamp) RETURNS VOID AS $$

DECLARE

       class varchar(128);  

       scheme varchar(128);

       cfmeasid varchar(128);

BEGIN


    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Created','EPOS Dataset Metadata Dates') tbl ;


    IF NOT EXISTS (SELECT *  FROM cfResprod_meas WHERE cfResprodId=uuidmeta) THEN

        cfmeasid := eposuuid();

        INSERT INTO cfMeas (cfMeasId, cfDatetime) VALUES (uuidmeta, created);

        INSERT INTO cfResprod_meas (cfMeasId, cfResprodId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (cfmeasid,uuidmeta,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        SELECT cfMeasId INTO cfmeasid FROM cfResprod_meas WHERE cfResprodId=uuidmeta AND cfClassschemeId=scheme AND cfClassId=scheme;

        UPDATE cfMeas SET cfDatetime=created WHERE cfMeasId=cfmeasid;

    END IF;

    

    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Updated','EPOS Dataset Metadata Dates') tbl ;


    IF NOT EXISTS (SELECT *  FROM cfResprod_meas WHERE cfResprodId=uuidmeta) THEN

        cfmeasid := eposuuid();

        INSERT INTO cfMeas (cfMeasId, cfDatetime) VALUES (uuidmeta, updated);

        INSERT INTO cfResprod_meas (cfMeasId, cfResprodId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (cfmeasid,uuidmeta,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        SELECT cfMeasId INTO cfmeasid FROM cfResprod_meas WHERE cfResprodId=uuidmeta AND cfClassschemeId=scheme AND cfClassId=scheme;

        UPDATE cfMeas SET cfDatetime=updated WHERE cfMeasId=cfmeasid;

    END IF;


END;

$$ LANGUAGE plpgsql;



--

CREATE OR REPLACE FUNCTION personfullname (uuidpers varchar(128), fullname varchar(64)) RETURNS VOID AS $$

DECLARE

    uuidpersname varchar(128);

        class varchar(128);  

    scheme varchar(128);

BEGIN


    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Full Name','Person Names') tbl ;


    IF NOT EXISTS (SELECT * FROM cfPers where cfPersId=uuidpers) THEN

        INSERT INTO cfPers (cfPersId) VALUES (uuidpers);

    END IF;


    IF NOT EXISTS (SELECT *  FROM cfPersname_Pers WHERE cfPersId=uuidpers) THEN

        uuidpersname=eposuuid();

        INSERT INTO cfPersname (cfPersNameId,cfFamilyNames) VALUES (uuidpersname,fullname);

        INSERT INTO cfPersname_Pers (cfPersNameId,cfPersId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidpersname,uuidpers,eposmindate(),eposmaxdate(),class,scheme) ;

    ELSE

        SELECT cfPersNameId INTO uuidpersname FROM cfPersname_Pers WHERE cfPersId=uuidpers AND cfClassschemeId=scheme AND cfClassId=scheme;

        UPDATE cfPersname SET cfFamilyNames=fullname WHERE cfPersNameId=uuidpersname;

    END IF;


END;

$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION person (uuidpers varchar(128), firstname varchar(64),familyname varchar(64)) RETURNS VOID AS $$

DECLARE

    uuidpersname varchar(128);

        class varchar(128);  

    scheme varchar(128);

BEGIN


    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Formal Name','Person Names') tbl ;


    IF NOT EXISTS (SELECT * FROM cfPers where cfPersId=uuidpers) THEN

        INSERT INTO cfPers (cfPersId) VALUES (uuidpers);

    END IF;


    IF NOT EXISTS (SELECT *  FROM cfPersname_Pers WHERE cfPersId=uuidpers) THEN

        uuidpersname=eposuuid();

        INSERT INTO cfPersname (cfPersNameId,cfFirstNames,cfFamilyNames) VALUES (uuidpersname,firstname,familyname);

        INSERT INTO cfPersname_Pers (cfPersNameId,cfPersId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidpersname,uuidpers,eposmindate(),eposmaxdate(),class,scheme) ;

    ELSE

        SELECT cfPersNameId INTO uuidpersname FROM cfPersname_Pers WHERE cfPersId=uuidpers AND cfClassschemeId=scheme AND cfClassId=scheme;

        UPDATE cfPersname SET cfFirstNames=firstname, cfFamilyNames=familyname WHERE cfPersNameId=uuidpersname;

    END IF;


END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION equipment (uuidequip varchar(128), type varchar(64), name varchar(254)) RETURNS VOID AS $$

DECLARE

    class varchar(128);

        scheme varchar(128);

BEGIN


    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics   (type,'EPOS Equipment Types') tbl ;


    IF NOT EXISTS (SELECT * FROM cfEquip WHERE cfEquipId=uuidequip) THEN

        INSERT INTO cfEquip (cfEquipId) VALUES (uuidequip);

    END IF;


    IF NOT EXISTS (SELECT * FROM cfEquipName WHERE cfEquipId=uuidequip) THEN

        INSERT INTO cfEquipName (cfEquipId, cfLangcode,cfTrans,cfName) VALUES (uuidequip,'en','h',name);

    ELSE

        UPDATE cfEquipName SET cfLangcode='en', cfTrans='h', cfName=name  WHERE cfEquipId=uuidequip;

    END IF;


        IF class IS NOT NULL THEN


        IF NOT EXISTS (SELECT * FROM cfEquip_class WHERE cfEquipId=uuidequip AND cfclassid=class AND cfClassSchemeId=scheme) THEN

            --relation does not exist

            INSERT INTO cfEquip_class (cfEquipId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidequip,eposmindate(),eposmaxdate(),class,scheme) ;

        ELSE

            --update relation

            UPDATE cfEquip_class SET cfClassId=class  WHERE cfEquipId=uuidequip  AND cfClassSchemeId=scheme;

        END IF;

    END IF;

END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION equipmentdescription (uuidequip varchar(128), descr varchar(1024)) RETURNS VOID AS $$

BEGIN

    IF NOT EXISTS (SELECT * FROM cfEquipDescr WHERE cfEquipId=uuidequip) THEN

        INSERT INTO cfEquipDescr (cfEquipId, cfLangcode,cfTrans,cfdescr) VALUES (uuidequip,'en','h',descr);

    ELSE

        UPDATE cfEquipDescr SET cfLangcode='en', cfTrans='h', cfdescr=descr  WHERE cfEquipId=uuidequip;

    END IF;

END;

$$ LANGUAGE plpgsql;



--


CREATE OR REPLACE FUNCTION equipmentdetail (uuidequip varchar(128), attributelabel varchar (20), attributevalue text ) RETURNS VOID AS $$

DECLARE

        uuidmeas varchar(128);

        scheme varchar(128);

    class varchar(128);

BEGIN


    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics   (attributelabel,'EPOS Equipment Details') tbl ;


    IF lower(attributelabel) = lower ('validFrom') OR  lower(attributelabel) = lower ('validTo') THEN

        IF NOT EXISTS (SELECT * FROM cfEquip_Meas WHERE cfEquipId=uuidequip AND cfClassschemeId=scheme AND cfClassId=validFrom) THEN

            uuidmeas := eposuuid();

            INSERT INTO cfMeas (cfMeasId,cfdatetime) VALUES (uuidmeas, attributevalue::timestamp);

            INSERT INTO cfEquip_Meas (cfEquipId,cfMeasId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidequip,uuidmeas,eposmindate(),eposmaxdate(),class,scheme);

        ELSE

            SELECT cfMeasId INTO uuidmeas FROM cfEquip_Meas WHERE cfEquipId=uuidequip AND cfClassschemeId=scheme AND cfClassId=validFrom;

            UPDATE cfMeas SET cfdatetime=attributevalue::timestamp WHERE cfMeasID=uuidmeas;

        END IF;

    END IF;

    IF lower(attributelabel) = lower ('quantity') THEN

        IF NOT EXISTS (SELECT * FROM cfEquip_Meas WHERE cfEquipId=uuidequip AND cfClassschemeId=scheme AND cfClassId=quantity) THEN

            uuidmeas := eposuuid();

            INSERT INTO cfMeas (cfMeasId,cfcountint) VALUES (uuidmeas, attributevalue::integer);

            INSERT INTO cfEquip_Meas (cfEquipId,cfMeasId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidequip,uuidmeas,eposmindate(),eposmaxdate(),class,scheme);

        ELSE

            SELECT cfMeasId INTO uuidmeas FROM cfEquip_Meas WHERE cfEquipId=uuidequip AND cfClassschemeId=scheme AND cfClassId=quantity;

            UPDATE cfMeas SET cfcountint=attributevalue::integer WHERE cfMeasID=uuidmeas;

        END IF;

    END IF;

END;

$$ LANGUAGE plpgsql;


--  Equipment with location that is modelled through a postal address


CREATE OR REPLACE FUNCTION equipmentlocation (uuidequip varchar(128), lat double precision, lon double precision, elev double precision) RETURNS VOID AS $$

DECLARE

    countrycode varchar(2);

    uuidpaddr varchar(128);

    uuidgeobbox varchar(128);

        class varchar(128);

    scheme varchar(128);


BEGIN


    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics   ('Equipment Location','EPOS Locations') tbl ;

--

    IF NOT EXISTS (SELECT * FROM cfEquip_paddr WHERE cfEquipId=uuidequip and cfClassId=class and cfclassschemeId=scheme) THEN

        SELECT c.cfCountryCode INTO countrycode   FROM cfCountry c JOIN cfCountryName cn ON c.cfCountryCode=cn.cfCountryCode WHERE cfName='unknown';

        uuidpaddr := eposuuid();

                INSERT INTO cfPAddr (cfPAddrId,cfCountryCode) VALUES (uuidpaddr,countrycode);

        INSERT INTO cfEquip_paddr (cfEquipId,cfPaddrId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidequip,uuidpaddr,eposmindate(),eposmaxdate(),class,scheme);

    END IF;

    

    SELECT cfPaddrId INTO uuidpaddr FROM cfEquip_paddr WHERE cfEquipId=uuidequip and cfClassId=class and cfclassschemeId=scheme;


    IF NOT EXISTS (SELECT * FROM cfPaddr_geobbox WHERE cfpaddrId=uuidpaddr and cfClassId=class and cfclassschemeId=scheme) THEN

        uuidgeobbox := eposuuid();

        INSERT INTO cfGeoBBox (cfGeoBBoxId,cfSBLat,cfNBLat,cfWBLong,cfEBLong,cfMinElev,cfMaxElev) VALUES (uuidgeobbox,lat,lat,lon,lon,elev,elev);

        INSERT INTO cfPaddr_geobbox (cfPaddrId,cfGeoBBoxId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidpaddr,uuidgeobbox,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        SELECT cfGeoBBoxId INTO uuidgeobbox FROM cfPaddr_geobbox WHERE cfPaddrId=uuidpaddr and cfClassId=class and cfclassschemeId=scheme;

        UPDATE cfGeoBBox SET cfSBLat=lat, cfNBLat=lat, cfWBLong=lon, cfEBLong=lon, cfMinElev=elev, cfMaxElev=elev WHERE cfGeoBBoxId=uuidgeobbox;

    END IF;

--

END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION equipmentorganisation (uuidequip varchar(128), uuidorgunit varchar(128), role text) RETURNS VOID AS $$

DECLARE

        class varchar(128);

    scheme varchar(128);

BEGIN


    IF lower(role) = lower('owner') THEN

        SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics   ('Manufacturer','Organisation Research Infrastructure Roles') tbl ;

    END IF;


    IF NOT EXISTS (SELECT * FROM cforgunit_equip WHERE cfOrgunitId=uuidorgunit AND cfEquipId=uuidequip AND cfClassId=class AND cfClassSchemeId=scheme) THEN

        INSERT INTO cforgunit_equip (cfOrgunitId,cfEquipId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidorgunit,uuidequip,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        UPDATE cforgunit_equip SET cfOrgunitId=uuidorgunit WHERE cfEquipId=uuidequip;

    END IF;

END;

$$ LANGUAGE plpgsql;


--

CREATE OR REPLACE FUNCTION facility (uuidfacility varchar(128), name varchar(250)) RETURNS VOID AS $$

BEGIN

    IF NOT EXISTS (SELECT * FROM cfFacil WHERE cfFacilId=uuidfacility) THEN

        INSERT INTO cfFacil (cfFacilId) VALUES (uuidfacility);

    END IF;


    IF NOT EXISTS (SELECT * FROM cfFacilname WHERE cfFacilId=uuidfacility) THEN

        INSERT INTO cfFacilname (cfFacilId, cfLangcode,cfTrans,cfName) VALUES (uuidfacility,'en','h',name);

    ELSE

        UPDATE cfFaciltname SET cfLangcode='en', cfTrans='h', cfName=name  WHERE cfFacilId=uuidfacility;

    END IF;

END;

$$ LANGUAGE plpgsql;

--


CREATE OR REPLACE FUNCTION facilitywebsite (uuidfacility varchar(128), url varchar(2083)) RETURNS VOID AS $$

BEGIN

    UPDATE cfFacil SET URI=url WHERE cfFacilId=uuidfacility;

END;

$$ LANGUAGE plpgsql;

--


CREATE OR REPLACE FUNCTION facilityorganisation(uuidfacil varchar(128), uuidorgunit varchar(128), role text) RETURNS VOID AS $$

DECLARE

        class varchar(128);

    scheme varchar(128);

BEGIN

    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics   (role,'Organisation ResearchInfrastructure Roles') tbl ;


    IF NOT EXISTS (SELECT * FROM cforgunit_facil WHERE cfOrgunitId=uuidorgunit AND cfFacilId=uuidfacil AND cfClassId=class AND cfClassSchemeId=scheme) THEN

        INSERT INTO cforgunit_facil (cfOrgunitId,cfFacilId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidorgunit,uuidfacil,eposmindate(),eposmaxdate(), class, scheme);

    ELSE

        UPDATE cforgunit_facil SET cfFacilId=uuidfacil WHERE cfOrgunitId=uuidorgunit;

    END IF;

END;

$$ LANGUAGE plpgsql;

--


CREATE OR REPLACE FUNCTION facilityperson(uuidfacil varchar(128), uuidpers varchar(128), role text) RETURNS VOID AS $$

DECLARE

        class varchar(128);

    scheme varchar(128);

BEGIN


    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics   (role,'Person ResearchInfrastructure Roles') tbl ;


    IF NOT EXISTS (SELECT * FROM cfpers_facil WHERE cfOrgunitId=uuidorgunit AND cfPersId=uuidpers AND cfClassId=class AND cfClassSchemeId=scheme) THEN

        INSERT INTO cfpers_facil (cfOrgunitId,cfPersId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidorgunit,uuidpers,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        UPDATE cfpers_facil SET cfPersId=uuidpers WHERE cfOrgunitId=uuidorgunit;

    END IF;

END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION organisation (uuidorgunit varchar(128), name varchar(250)) RETURNS VOID AS $$

BEGIN

    IF NOT EXISTS (SELECT * FROM cfOrgunit WHERE cfOrgunitId=uuidorgunit) THEN

        INSERT INTO cfOrgunit (cfOrgunitId) VALUES (uuidorgunit);

    END IF;


    IF NOT EXISTS (SELECT * FROM cfOrgunitname WHERE cfOrgunitId=uuidorgunit) THEN

        INSERT INTO cfOrgunitname (cfOrgunitId, cfLangcode,cfTrans,cfName) VALUES (uuidorgunit,'en','h',name);

    ELSE

        UPDATE cfOrgunitname SET cfLangcode='en', cfTrans='h', cfName=name  WHERE cfOrgunitId=uuidorgunit;

    END IF;

END;

$$ LANGUAGE plpgsql;

--

CREATE OR REPLACE FUNCTION organisationparent(uuidparent varchar(128), uuidchild varchar(128)) RETURNS VOID AS $$

DECLARE

        class varchar(128);

    scheme varchar(128);

BEGIN

    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics   ('Part','Inter-Organisational Structure') tbl ;


    IF NOT EXISTS (SELECT * FROM cforgunit_orgunit WHERE cfOrgunitId1=uuidparent AND cfOrgunitId2=uuidchild AND cfClassId=class AND cfClassSchemeId=scheme) THEN

        INSERT INTO cfpers_orgunit (cfOrgunitId1,cfOrgunitId2,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidparent,uuidchild,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        UPDATE cfpers_orgunit SET cfOrgunitId1=uuidparent WHERE cfOrgunitId2=uuidchild AND cfClassId=class AND cfClassSchemeId=scheme;

    END IF;

END;

$$ LANGUAGE plpgsql;

--


CREATE OR REPLACE FUNCTION organisationwebsite (uuidorgunit varchar(128), url varchar(2083)) RETURNS VOID AS $$

BEGIN

    UPDATE cfOrgunit SET URI=url WHERE cfOrgunitId=uuidorgunit;

END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION organisationperson(uuidpers varchar(128), uuidorgunit varchar(128), role text) RETURNS VOID AS $$

DECLARE

        class varchar(128);

    scheme varchar(128);

BEGIN

    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics   (role,'Organisation Contact Details') tbl ;


    IF NOT EXISTS (SELECT * FROM cfpers_orgunit WHERE cfOrgunitId=uuidorgunit AND cfPersId=uuidpers AND cfClassId=class AND cfClassSchemeId=scheme) THEN

        INSERT INTO cfpers_orgunit (cfOrgunitId,cfPersId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidorgunit,uuidpers,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        UPDATE cfpers_orgunit SET cfPersId=uuidrespubl WHERE cfOrgunitId=uuidorgunit AND cfClassId=class AND cfClassSchemeId=scheme;

    END IF;

END;

$$ LANGUAGE plpgsql;

--


CREATE OR REPLACE FUNCTION organisationwebsite (uuidorgunit varchar(128), url varchar(2083)) RETURNS VOID AS $$

BEGIN

    UPDATE cfOrgunit SET URI=url WHERE cfOrgunitId=uuidorgunit;

END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION publication (uuidrespubl varchar(128), title varchar(250),abstract text, pubdate timestamp) RETURNS VOID AS $$

BEGIN


    IF NOT EXISTS (SELECT * FROM cfRespubl WHERE cfRespublId=uuidrespubl) THEN

        INSERT INTO cfRespubl (cfRespublId,cfRespublDate) VALUES(uuidrespubl,pubdate);

    END IF;


    IF NOT EXISTS (SELECT * FROM cfRespublTitle WHERE cfRespublId=uuidrespubl) THEN

        INSERT INTO cfRespublTitle (cfRespublId, cfLangcode,cfTrans,cftitle) VALUES (uuidrespubl,'en','h',title);

    ELSE

        UPDATE cfRespublTitle SET cfLangcode='en', cfTrans='h', cftitle=title  WHERE cfRespublId=uuidrespubl;

    END IF;



    IF NOT EXISTS (SELECT * FROM cfRespublAbstr WHERE cfRespublId=uuidrespubl) THEN

        INSERT INTO cfRespublAbstr (cfRespublId, cfLangcode,cfTrans,cfabstr) VALUES (uuidrespubl,'en','h',abstract);

    ELSE

        UPDATE cfRespublAbstr SET cfLangcode='en', cfTrans='h', cfabstr=desabstractcr  WHERE cfRespublId=uuidrespubl;

    END IF;


END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION publicationauthor (uuidrespubl varchar(128), uuidpers varchar(128), role text) RETURNS VOID AS $$

DECLARE

        class varchar(128);

    scheme varchar(128);

BEGIN

    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  (role,'Person Output Contributions') tbl ;

--

    IF NOT EXISTS (SELECT * FROM cfpers_respubl WHERE cfPersId=uuidpers AND cfResPublId=uuidrespubl AND cfClassId=class AND cfClassSchemeId=scheme) THEN

        INSERT INTO cforgunit_equip (cfPersId,cfResPublId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidpers,uuidrespubl,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        UPDATE cfpers_respubl SET cfPersId=uuidpers WHERE cfResPublId=uuidrespubl AND cfClassId=class AND cfClassSchemeId=scheme;

    END IF;

--

END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION publicationorganisation (uuidrespubl varchar(128), uuidorgunit varchar(128), role text) RETURNS VOID AS $$

DECLARE

        class varchar(128);

    scheme varchar(128);

BEGIN

    CASE lower(role)

        WHEN 'Author' THEN

            SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Author','Organisation Output Contributions') tbl ;

        WHEN 'Publisher' THEN

            SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  ('Publisher','Organisation Output Roles') tbl ;

    END CASE;


    IF NOT EXISTS (SELECT * FROM cforgunit_respubl WHERE cfOrgunitId=uuidorgunit AND cfResPublId=uuidrespubl AND cfClassId=class AND cfClassSchemeId=scheme) THEN

        INSERT INTO cforgunit_respubl (cfOrgunitId,cfResPublId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidorgunit,uuidrespubl,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        UPDATE cforgunit_respubl SET cfOrgunitId=uuidorgunit WHERE cfResPublId=uuidrespubl AND cfClassId=class AND cfClassSchemeId=scheme;

    END IF;

END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION service (uuidsrv varchar(128), type varchar(64), name varchar(254), uri varchar(2083)) RETURNS VOID AS $$

DECLARE


    class varchar(128);

        scheme varchar(128);


BEGIN

    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  (type,'EPOS Service Types') tbl ;


    IF NOT EXISTS (SELECT * FROM cfSrv WHERE cfSrvId=uuidsrv) THEN

        INSERT INTO cfSrv (cfSrvId,cfURI) VALUES (uuidsrv,uri);

    END IF;


    IF NOT EXISTS (SELECT * FROM cfSrvName WHERE cfSrvId=uuidsrv) THEN

        INSERT INTO cfSrvName (cfSrvId, cfLangcode,cfTrans,cfName) VALUES (uuidsrv,'en','h',name);

    ELSE

        UPDATE cfSrvName SET cfLangcode='en', cfTrans='h', cfName=name  WHERE cfSrvId=uuidsrv;

    END IF;


        IF class IS NOT NULL THEN

        IF NOT EXISTS (SELECT * FROM cfSrv_class WHERE cfSrvId=uuidsrv AND cfclassid=class AND cfClassSchemeId=scheme) THEN

            --relation does not exist

            INSERT INTO cfSrv_class (cfSrvId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidsrv,eposmindate(),eposmaxdate(),class,scheme);

        ELSE

            --update relation

            UPDATE cfSrv_class SET cfClassId=class  WHERE cfSrvId=uuidsrv;

        END IF;

    END IF;

END;

$$ LANGUAGE plpgsql;


--

CREATE OR REPLACE FUNCTION servicedescription (uuidsrv varchar(128), descr varchar(8000)) RETURNS VOID AS $$

BEGIN

--

    IF NOT EXISTS (SELECT * FROM cfSrvDescr WHERE cfSrvId=uuidsrv) THEN

        INSERT INTO cfSrvDescr (cfSrvId, cfLangcode,cfTrans,cfdescr) VALUES (uuidsrv,'en','h',descr);

    ELSE

        UPDATE cfSrvDescr SET cfLangcode='en', cfTrans='h', cfdescr=descr  WHERE cfSrvId=uuidsrv;

    END IF;

--

END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION serviceperson (uuidsrv varchar(128), uuidpers varchar(128), role text) RETURNS VOID AS $$

DECLARE

        class varchar(128);

    scheme varchar(128);

BEGIN

    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  (role,'Person ResearchInfrastructure Roles') tbl ;


    IF NOT EXISTS (SELECT * FROM cfpers_srv WHERE cfPersId=uuidpers AND cfSrvId=uuidsrv AND cfClassId=class AND cfClassSchemeId=scheme) THEN

        INSERT INTO cfpers_srv (cfSrvId,cfPersId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidsrv,uuidpers,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        UPDATE cfpers_srv SET cfPersId=uuidpers WHERE cfSrvId=uuidsrv AND cfClassId=class AND cfClassSchemeId=scheme;

    END IF;

--

END;

$$ LANGUAGE plpgsql;


--


CREATE OR REPLACE FUNCTION serviceorganisation (uuidsrv varchar(128), uuidorgunit varchar(128), role text) RETURNS VOID AS $$

DECLARE

        class varchar(128);

    scheme varchar(128);

BEGIN

    SELECT tbl.class, tbl.scheme INTO class, scheme FROM semantics  (role,'Organisation Research Infrastructure Roles') tbl ;


    IF NOT EXISTS (SELECT * FROM cforgunit_srv WHERE cfOrgunitId=uuidorgunit AND cfSrvId=uuidsrv AND cfClassId=class AND cfClassSchemeId=scheme) THEN

        INSERT INTO cforgunit_srv (cfSrvId,cfOrgunitId,cfStartDate,cfEnddate,cfClassId,cfClassSchemeId) VALUES (uuidsrv,uuidorgunit,eposmindate(),eposmaxdate(),class,scheme);

    ELSE

        UPDATE cforgunit_srv SET cfOrgunitId=uuidorgunit WHERE cfSrvId=uuidsrv AND cfClassId=class AND cfClassSchemeId=scheme;

    END IF;

--

END;

$$ LANGUAGE plpgsql;


--Semantics - Formal Name


SELECT createsemantics('3c60b5deb4ca40c8e054002128a4790'     ,'7375609d-cfa6-45ce-a803-75de69abe21f','Formal Name','Person Names');

SELECT createsemantics('82156d46-3000-11e7-8a30-675d856d70a4'     ,'7375609d-cfa6-45ce-a803-75de69abe21f','Full Name','Person Names');


--Semantics - Equipment types

SELECT createsemantics('8a9a85ca-fd1e-41df-97ba-ad1fe7c76824','c9901b7e-49a5-4178-9571-1389d27b3e0b','Seismic Station','EPOS Equipment Types');

SELECT createsemantics('0aec0614-9339-47a0-a0b5-b7e1616907c3','c9901b7e-49a5-4178-9571-1389d27b3e0b','GNSS Station','EPOS Equipment Types');


--Semantics - GNSS Equipment types

SELECT createsemantics('31082300-f9bc-11e6-9076-7710fb08aabf','c9901b7e-49a5-4178-9571-1389d27b3e0b','antenna','EPOS Equipment Types');

SELECT createsemantics('31085320-f9bc-11e6-8f1d-8f7db648c4aa','c9901b7e-49a5-4178-9571-1389d27b3e0b','frequency_standard','EPOS Equipment Types');

SELECT createsemantics('31088e76-f9bc-11e6-958a-0b4f3e92226b','c9901b7e-49a5-4178-9571-1389d27b3e0b','GNSS Continuous','EPOS Equipment Types');

SELECT createsemantics('3108c788-f9bc-11e6-b9b3-97118767a41b','c9901b7e-49a5-4178-9571-1389d27b3e0b','GPS/GNSS Continuous','EPOS Equipment Types');

SELECT createsemantics('3108fe74-f9bc-11e6-870f-dfe949f4b5cd','c9901b7e-49a5-4178-9571-1389d27b3e0b','humidity_sensor','EPOS Equipment Types');

SELECT createsemantics('31093722-f9bc-11e6-81e2-d79d67c68318','c9901b7e-49a5-4178-9571-1389d27b3e0b','other_instrumentation','EPOS Equipment Types');

SELECT createsemantics('31097124-f9bc-11e6-acc3-b70ff4668915','c9901b7e-49a5-4178-9571-1389d27b3e0b','pressure_sensor','EPOS Equipment Types');

SELECT createsemantics('3109a630-f9bc-11e6-9c92-17042d098089','c9901b7e-49a5-4178-9571-1389d27b3e0b','radome','EPOS Equipment Types');

SELECT createsemantics('310a0800-f9bc-11e6-8fa5-9f9da896261e','c9901b7e-49a5-4178-9571-1389d27b3e0b','receiver','EPOS Equipment Types');

SELECT createsemantics('310a3e06-f9bc-11e6-a774-532ddd10310d','c9901b7e-49a5-4178-9571-1389d27b3e0b','temperature_sensor','EPOS Equipment Types');

SELECT createsemantics('310a9a9a-f9bc-11e6-a42c-c7e2e3d77396','c9901b7e-49a5-4178-9571-1389d27b3e0b','water_vapor_radiometer','EPOS Equipment Types');


--Semantics - Equipment Details

SELECT createsemantics('bdaf4c1d-f4d7-46df-bb73-bfd935d79a2a','92de3a60-5f82-4c3f-9000-382181cdf73a','validFrom','EPOS Equipment Details');

SELECT createsemantics('2c75c06c-f410-4490-8108-2fdd7f591245','92de3a60-5f82-4c3f-9000-382181cdf73a','validTo','EPOS Equipment Details');

SELECT createsemantics('53e9eaac-2430-4a41-ab40-3758ecf001c0','92de3a60-5f82-4c3f-9000-382181cdf73a','quantity','EPOS Equipment Details');


--Semantics - Equipment Location

SELECT createsemantics('e7ec244e-9d73-4a17-b9ae-29d9d532567c','f8bf5bf7-1d4a-4580-935c-14308d90c9af','Equipment Location','EPOS Locations');


--Semantics - EPOS Result Product Types

SELECT createsemantics('2749c634-2fe0-11e7-87da-434c16a71d2f','259d9d74-2fe0-11e7-a90d-53b7617da604','Dataset','EPOS Result Product Types');


--Countrycodes


INSERT INTO cfCurrency (cfCurrCode,cfNumCurrCode) SELECT 'CZK','203' WHERE NOT EXISTS (SELECT * FROM cfCurrency WHERE cfCurrCode='CZK' AND cfNumCurrCode='203');

INSERT INTO cfCurrency (cfCurrCode,cfNumCurrCode) SELECT 'PLN','985' WHERE NOT EXISTS (SELECT * FROM cfCurrency WHERE cfCurrCode='PLN' AND cfNumCurrCode='985');

INSERT INTO cfCurrency (cfCurrCode,cfNumCurrCode) SELECT 'EUR','978' WHERE NOT EXISTS (SELECT * FROM cfCurrency WHERE cfCurrCode='EUR' AND cfNumCurrCode='978');

INSERT INTO cfCurrency (cfCurrCode,cfNumCurrCode) SELECT 'GBP','826' WHERE NOT EXISTS (SELECT * FROM cfCurrency WHERE cfCurrCode='GBP' AND cfNumCurrCode='826');

INSERT INTO cfCurrency (cfCurrCode,cfNumCurrCode) SELECT 'NOK','578' WHERE NOT EXISTS (SELECT * FROM cfCurrency WHERE cfCurrCode='NOK' AND cfNumCurrCode='578');

INSERT INTO cfCurrency (cfCurrCode,cfNumCurrCode) SELECT 'DKK','208' WHERE NOT EXISTS (SELECT * FROM cfCurrency WHERE cfCurrCode='DKK' AND cfNumCurrCode='208');

INSERT INTO cfCurrency (cfCurrCode,cfNumCurrCode) SELECT 'ISK','352' WHERE NOT EXISTS (SELECT * FROM cfCurrency WHERE cfCurrCode='ISK' AND cfNumCurrCode='352');

INSERT INTO cfCurrency (cfCurrCode,cfNumCurrCode) SELECT 'CHF','756' WHERE NOT EXISTS (SELECT * FROM cfCurrency WHERE cfCurrCode='CHF' AND cfNumCurrCode='756');

INSERT INTO cfCurrency (cfCurrCode,cfNumCurrCode) SELECT 'RON','946' WHERE NOT EXISTS (SELECT * FROM cfCurrency WHERE cfCurrCode='RON' AND cfNumCurrCode='946');

INSERT INTO cfCurrency (cfCurrCode,cfNumCurrCode) SELECT 'SEK','752' WHERE NOT EXISTS (SELECT * FROM cfCurrency WHERE cfCurrCode='SEK' AND cfNumCurrCode='752');

INSERT INTO cfCurrency (cfCurrCode,cfNumCurrCode) SELECT 'USD','840' WHERE NOT EXISTS (SELECT * FROM cfCurrency WHERE cfCurrCode='USD' AND cfNumCurrCode='840');

INSERT INTO cfCurrency (cfCurrCode,cfNumCurrCode) SELECT 'TRY','949' WHERE NOT EXISTS (SELECT * FROM cfCurrency WHERE cfCurrCode='TRY' AND cfNumCurrCode='949');

INSERT INTO cfCountry (cfCountryCode) SELECT 'CZ' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='CZ');

INSERT INTO cfCountry (cfCountryCode) SELECT 'PL' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='PL');

INSERT INTO cfCountry (cfCountryCode) SELECT 'GR' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='GR');

INSERT INTO cfCountry (cfCountryCode) SELECT 'DE' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='DE');

INSERT INTO cfCountry (cfCountryCode) SELECT 'GB' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='GB');

INSERT INTO cfCountry (cfCountryCode) SELECT 'FR' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='FR');

INSERT INTO cfCountry (cfCountryCode) SELECT 'ES' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='ES');

INSERT INTO cfCountry (cfCountryCode) SELECT 'PT' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='PT');

INSERT INTO cfCountry (cfCountryCode) SELECT 'NO' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='NO');

INSERT INTO cfCountry (cfCountryCode) SELECT 'IT' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='IT');

INSERT INTO cfCountry (cfCountryCode) SELECT 'DK' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='DK');

INSERT INTO cfCountry (cfCountryCode) SELECT 'NL' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='NL');

INSERT INTO cfCountry (cfCountryCode) SELECT 'IE' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='IE');

INSERT INTO cfCountry (cfCountryCode) SELECT 'IS' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='IS');

INSERT INTO cfCountry (cfCountryCode) SELECT 'CH' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='CH');

INSERT INTO cfCountry (cfCountryCode) SELECT 'RO' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='RO');

INSERT INTO cfCountry (cfCountryCode) SELECT 'AT' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='AT');

INSERT INTO cfCountry (cfCountryCode) SELECT 'SW' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='SW');

INSERT INTO cfCountry (cfCountryCode) SELECT 'SI' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='SI');

INSERT INTO cfCountry (cfCountryCode) SELECT 'FI' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='FI');

INSERT INTO cfCountry (cfCountryCode) SELECT 'TR' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='TR');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'CZ','en','h','czech_republic' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='CZ');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'PL','en','h','poland' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='PL');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'GR','en','h','greece' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='GR');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'DE','en','h','germany' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='DE');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'GB','en','o','united_kingdom' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='GB');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'FR','en','h','france' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='FR');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'ES','en','h','spain' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='ES');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'PT','en','h','portugal' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='PT');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'NO','en','h','norway' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='NO');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'IT','en','h','italy' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='IT');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'DK','en','h','denmark' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='DK');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'NL','en','h','netherlands' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='NL');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'IE','en','h','ireland' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='IE');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'IS','en','h','iceland' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='IS');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'CH','en','h','switzerland' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='CH');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'RO','en','h','romania' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='RO');

INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'AT','en','h','austria' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='AT');
INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'SW','en','h','sweden' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='SW');
INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'SI','en','h','slovenia' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='SI');
INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'FI','en','h','finland' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='FI');
INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT 'TR','en','h','turkey' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='TR');
INSERT INTO cfCountry (cfCountryCode) SELECT '99' WHERE NOT EXISTS (SELECT * FROM cfCountry WHERE cfCountryCode='99');
INSERT INTO cfCountryName (cfCountryCode,cfLangCode,cfTrans,cfName) SELECT '99','en','h','unknown' WHERE NOT EXISTS (SELECT * FROM cfCountryName WHERE cfCountryCode='99');
--Modifications to the original data model
ALTER TABLE cfResprod ALTER COLUMN cfURI TYPE varchar(2083);
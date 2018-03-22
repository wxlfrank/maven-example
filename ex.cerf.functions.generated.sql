CREATE OR REPLACE FUNCTION getsemantics (classhuman text, schemehuman text, out classid varchar(128) , out classschemeid varchar(128) )  AS $$
BEGIN
    SELECT c.cfclassid, c.cfclassschemeid INTO classid, classschemeid 
    FROM cfClassterm c JOIN cfClassschemename cs 
    ON cs.cfclassschemeid=c.cfclassschemeid WHERE cs.cfname=schemehuman and c.cfterm=classhuman;

    IF classid IS NULL OR classschemeid IS NULL THEN
    	IF classid IS NULL THEN
    		classid := eposuuid();
    	END IF;
    	IF classschemeid IS NULL THEN
    		classschemeid := eposuuid();
    	END IF;
    	BEGIN
			perform tocfclassscheme(classschemeid, null);
			perform tocfclassschemename(classschemeid, classschemename, 'EPOS', 'en', 'o');
			perform tocfclass(classid, classschemeid, null, eposmindate(), eposmaxdate());
			perform tocfclassterm(classid, classschemeid, 'is a', classname, 'EPOS', 'en', 'o');
		END; 
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_meas_time (v_cfresprodid char(128), v_meas_time timestamp, v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
	 v_cfmeasid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	SELECT cfmeasid INTO v_cfmeasid FROM cfresprod_meas WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid;
	IF v_cfmeasid IS NULL THEN 
		v_cfmeasid := eposuuid();
		INSERT INTO cfmeas (cfmeasid, cfdatetime) VALUES (v_cfmeasid, v_meas_time);
		INSERT INTO cfresprod_meas (cfresprodid, cfmeasid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfresprodid, v_cfmeasid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfresprod_meas SET cfdatetime = v_meas_time  WHERE cfmeasid = v_cfmeasid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_meas_char (v_cfresprodid char(128), v_meas_char char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
	 v_cfmeasid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	SELECT cfmeasid INTO v_cfmeasid FROM cfresprod_meas WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid;
	IF v_cfmeasid IS NULL THEN 
		v_cfmeasid := eposuuid();
		INSERT INTO cfmeas (cfmeasid, cfvaljudtext) VALUES (v_cfmeasid, v_meas_char);
		INSERT INTO cfresprod_meas (cfresprodid, cfmeasid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfresprodid, v_cfmeasid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfresprod_meas SET cfvaljudtext = v_meas_char  WHERE cfmeasid = v_cfmeasid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmeas_meas (v_cfmeasid1 char(128), v_meas_char char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
	 v_cfmeasid2 varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	SELECT cfmeasid2 INTO v_cfmeasid2 FROM cfmeas_meas WHERE cfclassid = v_cfclassid and cfmeasid1 = v_cfmeasid1 and cfclassschemeid = v_cfclassschemeid;
	IF v_cfmeasid2 IS NULL THEN 
		v_cfmeasid2 := eposuuid();
		INSERT INTO cfmeas (cfmeasid, cfvaljudtext) VALUES (v_cfmeasid2, v_meas_char);
		INSERT INTO cfmeas_meas (cfmeasid1, cfmeasid2, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmeasid1, v_cfmeasid2, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfmeas_meas SET cfvaljudtext = v_meas_char  WHERE cfmeasid2 = v_cfmeasid2;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_geobbox (v_cfresprodid char(128), v_minlat float8,  v_maxlat float8, v_minlon float8, v_maxlon float8, v_minelev float8, v_maxelev float8, v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
	 v_cfgeobboxid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	SELECT cfgeobboxid INTO v_cfgeobboxid FROM cfresprod_geobbox WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid; 
	IF v_cfgeobboxid IS NULL THEN
		v_cfgeobboxid :=  eposuuid();
		INSERT INTO cfGeoBBox (cfgeobboxid, cfeblong, cfmaxelev, cfminelev, cfnblat, cfsblat, cfuri, cfwblong) VALUES (v_cfgeobboxid, v_maxlon, v_maxlelev, v_minelev, v_maxlat, v_minlat, null, v_minlon);
		INSERT INTO cfresprod_geobbox (cfgeobboxid, cfresprodid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfgeobboxid, v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfresprod_geobbox SET cfeblong = v_maxlon, cfmaxelev = v_maxlelev, cfminelev = v_minelev, cfnblat = v_maxlat, cfsblat = v_minlat, cfwblong = v_minlon WHERE cfgeobboxid = v_cfgeobboxid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eposuuid () RETURNS varchar(128) AS $$
BEGIN
    RETURN uuid_in(md5(random()::text || now()::text)::cstring);
END;
$$ LANGUAGE plpgsql;

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
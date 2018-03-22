CREATE OR REPLACE FUNCTION tocfclassscheme (v_cfclassschemeid char(128), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfclassscheme WHERE cfclassschemeid = v_cfclassschemeid) THEN 
	INSERT INTO cfclassscheme (cfclassschemeid, cfuri) VALUES (v_cfclassschemeid, v_cfuri);
ELSE
	UPDATE cfclassscheme SET cfuri = v_cfuri  WHERE cfclassschemeid = v_cfclassschemeid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfclassdescr (v_cfclassid char(128), v_cfclassschemeid char(128), v_cfdescr text, v_cfdescrsrc text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfclassdescr WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfclassdescr (cfclassid, cfclassschemeid, cfdescr, cfdescrsrc, cflangcode, cftrans) VALUES (v_cfclassid, v_cfclassschemeid, v_cfdescr, v_cfdescrsrc, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfclassdescr SET cfdescr = v_cfdescr, cfdescrsrc = v_cfdescrsrc  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfcitetitle (v_cfciteid char(128), v_cftitle char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfcitetitle WHERE cfciteid = v_cfciteid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfcitetitle (cfciteid, cftitle, cflangcode, cftrans) VALUES (v_cfciteid, v_cftitle, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfcitetitle SET cftitle = v_cftitle  WHERE cfciteid = v_cfciteid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfclassschemename (v_cfclassschemeid char(128), v_cfname text, v_cfnamesrc text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfclassschemename WHERE cfclassschemeid = v_cfclassschemeid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfclassschemename (cfclassschemeid, cfname, cfnamesrc, cflangcode, cftrans) VALUES (v_cfclassschemeid, v_cfname, v_cfnamesrc, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfclassschemename SET cfname = v_cfname, cfnamesrc = v_cfnamesrc  WHERE cfclassschemeid = v_cfclassschemeid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfcurrency (v_cfcurrcode char(3), v_cfnumcurrcode char(3), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfcurrency WHERE cfcurrcode = v_cfcurrcode) THEN 
	INSERT INTO cfcurrency (cfcurrcode, cfnumcurrcode, cfuri) VALUES (v_cfcurrcode, v_cfnumcurrcode, v_cfuri);
ELSE
	UPDATE cfcurrency SET cfnumcurrcode = v_cfnumcurrcode, cfuri = v_cfuri  WHERE cfcurrcode = v_cfcurrcode;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfcurrencyname (v_cfcurrcode char(3), v_cfname char(64), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfcurrencyname WHERE cfcurrcode = v_cfcurrcode and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfcurrencyname (cfcurrcode, cfname, cflangcode, cftrans) VALUES (v_cfcurrcode, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfcurrencyname SET cfname = v_cfname  WHERE cfcurrcode = v_cfcurrcode and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfcurrency_class (v_cfclassname text, v_cfschemename text, v_cfcurrcode char(3), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfcurrency_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfcurrency_class (cfclassid, cfclassschemeid, cfcurrcode, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfcurrcode, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfcurrency_class SET cfcurrcode = v_cfcurrcode, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfcurrencyentname (v_cfcurrcode char(3), v_cfentname char(64), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfcurrencyentname WHERE cfcurrcode = v_cfcurrcode and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfcurrencyentname (cfcurrcode, cfentname, cflangcode, cftrans) VALUES (v_cfcurrcode, v_cfentname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfcurrencyentname SET cfentname = v_cfentname  WHERE cfcurrcode = v_cfcurrcode and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfclassdef (v_cfclassid char(128), v_cfclassschemeid char(128), v_cfdef text, v_cfdefsrc text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfclassdef WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfclassdef (cfclassid, cfclassschemeid, cfdef, cfdefsrc, cflangcode, cftrans) VALUES (v_cfclassid, v_cfclassschemeid, v_cfdef, v_cfdefsrc, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfclassdef SET cfdef = v_cfdef, cfdefsrc = v_cfdefsrc  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfclassschemedescr (v_cfclassschemeid char(128), v_cfdescr text, v_cfdescrsrc text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfclassschemedescr WHERE cfclassschemeid = v_cfclassschemeid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfclassschemedescr (cfclassschemeid, cfdescr, cfdescrsrc, cflangcode, cftrans) VALUES (v_cfclassschemeid, v_cfdescr, v_cfdescrsrc, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfclassschemedescr SET cfdescr = v_cfdescr, cfdescrsrc = v_cfdescrsrc  WHERE cfclassschemeid = v_cfclassschemeid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfclassterm (v_cfclassid char(128), v_cfclassschemeid char(128), v_cfroleexpr varchar(128), v_cfroleexpropp varchar(128), v_cfterm char(64), v_cftermsrc text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfclassterm WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfclassterm (cfclassid, cfclassschemeid, cfroleexpr, cfroleexpropp, cfterm, cftermsrc, cflangcode, cftrans) VALUES (v_cfclassid, v_cfclassschemeid, v_cfroleexpr, v_cfroleexpropp, v_cfterm, v_cftermsrc, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfclassterm SET cfroleexpr = v_cfroleexpr, cfroleexpropp = v_cfroleexpropp, cfterm = v_cfterm, cftermsrc = v_cftermsrc  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfclassex (v_cfclassid char(128), v_cfclassschemeid char(128), v_cfex text, v_cfexsrc text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfclassex WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfclassex (cfclassid, cfclassschemeid, cfex, cfexsrc, cflangcode, cftrans) VALUES (v_cfclassid, v_cfclassschemeid, v_cfex, v_cfexsrc, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfclassex SET cfex = v_cfex, cfexsrc = v_cfexsrc  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfclass_class (v_cfclassname text, v_cfschemename text, v_cfclassid1 char(128), v_cfclassid2 char(128), v_cfclassschemeid1 char(128), v_cfclassschemeid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfclass_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfclass_class (cfclassid, cfclassschemeid, cfclassid1, cfclassid2, cfclassschemeid1, cfclassschemeid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfclassid1, v_cfclassid2, v_cfclassschemeid1, v_cfclassschemeid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfclass_class SET cfclassid1 = v_cfclassid1, cfclassid2 = v_cfclassid2, cfclassschemeid1 = v_cfclassschemeid1, cfclassschemeid2 = v_cfclassschemeid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfclassscheme_classscheme (v_cfclassname text, v_cfschemename text, v_cfclassschemeid1 char(128), v_cfclassschemeid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfclassscheme_classscheme WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfclassscheme_classscheme (cfclassid, cfclassschemeid, cfclassschemeid1, cfclassschemeid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfclassschemeid1, v_cfclassschemeid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfclassscheme_classscheme SET cfclassschemeid1 = v_cfclassschemeid1, cfclassschemeid2 = v_cfclassschemeid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfcitedescr (v_cfciteid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfcitedescr WHERE cfciteid = v_cfciteid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfcitedescr (cfciteid, cfdescr, cflangcode, cftrans) VALUES (v_cfciteid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfcitedescr SET cfdescr = v_cfdescr  WHERE cfciteid = v_cfciteid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdc (v_cfdcid char(32), v_cfdcscheme char(32), v_cfdcschemeuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdc WHERE cfdcid = v_cfdcid and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdc (cfdcid, cfdcscheme, cfdcschemeuri) VALUES (v_cfdcid, v_cfdcscheme, v_cfdcschemeuri);
ELSE
	UPDATE cfdc SET cfdcschemeuri = v_cfdcschemeuri  WHERE cfdcid = v_cfdcid and cfdcscheme = v_cfdcscheme;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfcv (v_cfcvid char(128), v_cfcvdoc bytea, v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfcv WHERE cfcvid = v_cfcvid) THEN 
	INSERT INTO cfcv (cfcvid, cfcvdoc, cfuri) VALUES (v_cfcvid, v_cfcvdoc, v_cfuri);
ELSE
	UPDATE cfcv SET cfcvdoc = v_cfcvdoc, cfuri = v_cfuri  WHERE cfcvid = v_cfcvid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcdescription (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcdescription WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdcdescription (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdcdescription SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdccoveragetemporal (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdcvalue text, v_cffdcenddatetime timestamp, v_cffdcprecision numeric(12,6), v_cffdcstartdatetime timestamp) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdccoveragetemporal WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdccoveragetemporal (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdcvalue, cffdcenddatetime, cffdcprecision, cffdcstartdatetime) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdcvalue, v_cffdcenddatetime, v_cffdcprecision, v_cffdcstartdatetime);
ELSE
	UPDATE cfdccoveragetemporal SET cfdcvalue = v_cfdcvalue, cffdcenddatetime = v_cffdcenddatetime, cffdcprecision = v_cffdcprecision, cffdcstartdatetime = v_cffdcstartdatetime  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcformat (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcformat WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdcformat (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdcformat SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdclanguage (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdclanguage WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdclanguage (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdclanguage SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcpublisher (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcpublisher WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdcpublisher (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdcpublisher SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcprovenance (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcprovenance WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdcprovenance (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdcprovenance SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcrelation (v_cfdcenddate timestamp, v_cfdcid1 char(32), v_cfdcid2 char(32), v_cfdclangtag char(5), v_cfdcscheme1 char(32), v_cfdcscheme2 char(32), v_cfdcstartdate timestamp, v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcrelation WHERE cfdcid1 = v_cfdcid1 and cfdcscheme2 = v_cfdcscheme2 and cfdcid2 = v_cfdcid2 and cfdcscheme1 = v_cfdcscheme1 and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans) THEN 
	INSERT INTO cfdcrelation (cfdcenddate, cfdcid1, cfdcid2, cfdclangtag, cfdcscheme1, cfdcscheme2, cfdcstartdate, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcenddate, v_cfdcid1, v_cfdcid2, v_cfdclangtag, v_cfdcscheme1, v_cfdcscheme2, v_cfdcstartdate, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdcrelation SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid1 = v_cfdcid1 and cfdcid2 = v_cfdcid2 and cfdclangtag = v_cfdclangtag and cfdcscheme1 = v_cfdcscheme1 and cfdcscheme2 = v_cfdcscheme2 and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcresourceidentifier (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcresourceidentifier WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdcresourceidentifier (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdcresourceidentifier SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdccoverage (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdccoverage WHERE cfdcid = v_cfdcid and cfdctrans = v_cfdctrans and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdccoverage (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdccoverage SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcresourcetype (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcresourcetype WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdcresourcetype (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdcresourcetype SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcdate (v_cfdcid char(32), v_cfdcdatebegin timestamp, v_cfdcdateend timestamp, v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcdate WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdcdate (cfdcid, cfdcdatebegin, cfdcdateend, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdcdatebegin, v_cfdcdateend, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdcdate SET cfdcdatebegin = v_cfdcdatebegin, cfdcdateend = v_cfdcdateend, cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdccoveragespatial (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdcvalue text, v_cffdcprecision numeric(12,6), v_cffdcxcoordinate numeric(12,6), v_cffdcycoordinate numeric(12,6), v_cffdczcoordinate numeric(12,6)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdccoveragespatial WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdccoveragespatial (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdcvalue, cffdcprecision, cffdcxcoordinate, cffdcycoordinate, cffdczcoordinate) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdcvalue, v_cffdcprecision, v_cffdcxcoordinate, v_cffdcycoordinate, v_cffdczcoordinate);
ELSE
	UPDATE cfdccoveragespatial SET cfdcvalue = v_cfdcvalue, cffdcprecision = v_cffdcprecision, cffdcxcoordinate = v_cffdcxcoordinate, cffdcycoordinate = v_cffdcycoordinate, cffdczcoordinate = v_cffdczcoordinate  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcrightsmmlicense (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcrightsmmlicense WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdcrightsmmlicense (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdcvalue);
ELSE
	UPDATE cfdcrightsmmlicense SET cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcrightsmmaccessrights (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcrightsmmaccessrights WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdcrightsmmaccessrights (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdcvalue);
ELSE
	UPDATE cfdcrightsmmaccessrights SET cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcrightsmm (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcrightsmm WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdcrightsmm (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdcrightsmm SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfequip_paddr (v_cfequipid char(128), v_cfpaddrid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfequip_paddr WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfpaddrid = v_cfpaddrid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfequip_paddr (cfequipid, cfpaddrid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cfpaddrid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfequip_paddr SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfpaddrid = v_cfpaddrid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcsubject (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcsubject WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdcsubject (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdcsubject SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfequip (v_cfequipid char(128), v_cfacro char(16), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfequip WHERE cfequipid = v_cfequipid) THEN 
	INSERT INTO cfequip (cfequipid, cfacro, cfuri) VALUES (v_cfequipid, v_cfacro, v_cfuri);
ELSE
	UPDATE cfequip SET cfacro = v_cfacro, cfuri = v_cfuri  WHERE cfequipid = v_cfequipid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfequip_event (v_cfequipid char(128), v_cfeventid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfequip_event WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfequip_event (cfequipid, cfeventid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cfeventid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfequip_event SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfequip_fund (v_cfequipid char(128), v_cffundid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfequip_fund WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfequip_fund (cfequipid, cffundid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cffundid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfequip_fund SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfequip_indic (v_cfequipid char(128), v_cfindicid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfequip_indic WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfequip_indic (cfequipid, cfindicid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cfindicid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfequip_indic SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfequip_srv (v_cfequipid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfequip_srv WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cfequip_srv (cfequipid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfequip_srv SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfeaddr (v_cfeaddrid char(128), v_cfpaddrid char(128), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfeaddr WHERE cfeaddrid = v_cfeaddrid) THEN 
	INSERT INTO cfeaddr (cfeaddrid, cfpaddrid, cfuri) VALUES (v_cfeaddrid, v_cfpaddrid, v_cfuri);
ELSE
	UPDATE cfeaddr SET cfpaddrid = v_cfpaddrid, cfuri = v_cfuri  WHERE cfeaddrid = v_cfeaddrid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfequip_medium (v_cfequipid char(128), v_cfmediumid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfequip_medium WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfequip_medium (cfequipid, cfmediumid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cfmediumid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfequip_medium SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfequip_meas (v_cfequipid char(128), v_cfmeasid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfequip_meas WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfequip_meas (cfequipid, cfmeasid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cfmeasid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfequip_meas SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdctitle (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdctitle WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdctitle (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdctitle SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfevent (v_cfeventid char(128), v_cfcitytown char(30), v_cfcountrycode char(2), v_cffeeorfree char(1), v_cfuri char(128), v_cfstartdate date, v_cfenddate date) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfevent WHERE cfeventid = v_cfeventid) THEN 
	INSERT INTO cfevent (cfeventid, cfcitytown, cfcountrycode, cffeeorfree, cfuri, cfstartdate, cfenddate) VALUES (v_cfeventid, v_cfcitytown, v_cfcountrycode, v_cffeeorfree, v_cfuri, v_cfstartdate, v_cfenddate);
ELSE
	UPDATE cfevent SET cfcitytown = v_cfcitytown, cfcountrycode = v_cfcountrycode, cffeeorfree = v_cffeeorfree, cfuri = v_cfuri, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfeventid = v_cfeventid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffacil_fund (v_cffacilid char(128), v_cffundid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffacil_fund WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid) THEN 
		INSERT INTO cffacil_fund (cffacilid, cffundid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffacilid, v_cffundid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffacil_fund SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfexpskills (v_cfexpskillsid char(128), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfexpskills WHERE cfexpskillsid = v_cfexpskillsid) THEN 
	INSERT INTO cfexpskills (cfexpskillsid, cfuri) VALUES (v_cfexpskillsid, v_cfuri);
ELSE
	UPDATE cfexpskills SET cfuri = v_cfuri  WHERE cfexpskillsid = v_cfexpskillsid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffacil (v_cffacilid char(128), v_cfacro char(16), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cffacil WHERE cffacilid = v_cffacilid) THEN 
	INSERT INTO cffacil (cffacilid, cfacro, cfuri) VALUES (v_cffacilid, v_cfacro, v_cfuri);
ELSE
	UPDATE cffacil SET cfacro = v_cfacro, cfuri = v_cfuri  WHERE cffacilid = v_cffacilid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfeventname (v_cfeventid char(128), v_cfname char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfeventname WHERE cfeventid = v_cfeventid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfeventname (cfeventid, cfname, cflangcode, cftrans) VALUES (v_cfeventid, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfeventname SET cfname = v_cfname  WHERE cfeventid = v_cfeventid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfexpskillsname (v_cfexpskillsid char(128), v_cfname char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfexpskillsname WHERE cfexpskillsid = v_cfexpskillsid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfexpskillsname (cfexpskillsid, cfname, cflangcode, cftrans) VALUES (v_cfexpskillsid, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfexpskillsname SET cfname = v_cfname  WHERE cfexpskillsid = v_cfexpskillsid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfexpskillskeyw (v_cfexpskillsid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfexpskillskeyw WHERE cfexpskillsid = v_cfexpskillsid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfexpskillskeyw (cfexpskillsid, cfkeyw, cflangcode, cftrans) VALUES (v_cfexpskillsid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfexpskillskeyw SET cfkeyw = v_cfkeyw  WHERE cfexpskillsid = v_cfexpskillsid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfevent_indic (v_cfeventid char(128), v_cfindicid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfevent_indic WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfevent_indic (cfeventid, cfindicid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfeventid, v_cfindicid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfevent_indic SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfequipkeyw (v_cfequipid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfequipkeyw WHERE cfequipid = v_cfequipid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfequipkeyw (cfequipid, cfkeyw, cflangcode, cftrans) VALUES (v_cfequipid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfequipkeyw SET cfkeyw = v_cfkeyw  WHERE cfequipid = v_cfequipid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfeventkeyw (v_cfeventid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfeventkeyw WHERE cfeventid = v_cfeventid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfeventkeyw (cfeventid, cfkeyw, cflangcode, cftrans) VALUES (v_cfeventid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfeventkeyw SET cfkeyw = v_cfkeyw  WHERE cfeventid = v_cfeventid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfequipdescr (v_cfequipid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfequipdescr WHERE cfequipid = v_cfequipid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfequipdescr (cfequipid, cfdescr, cflangcode, cftrans) VALUES (v_cfequipid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfequipdescr SET cfdescr = v_cfdescr  WHERE cfequipid = v_cfequipid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffacil_facil (v_cfclassname text, v_cfschemename text, v_cffacilid1 char(128), v_cffacilid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffacil_facil WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cffacil_facil (cfclassid, cfclassschemeid, cffacilid1, cffacilid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cffacilid1, v_cffacilid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffacil_facil SET cffacilid1 = v_cffacilid1, cffacilid2 = v_cffacilid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfevent_medium (v_cfeventid char(128), v_cfmediumid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfevent_medium WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfevent_medium (cfeventid, cfmediumid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfeventid, v_cfmediumid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfevent_medium SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfequipname (v_cfequipid char(128), v_cfname char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfequipname WHERE cfequipid = v_cfequipid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfequipname (cfequipid, cfname, cflangcode, cftrans) VALUES (v_cfequipid, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfequipname SET cfname = v_cfname  WHERE cfequipid = v_cfequipid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfeventdescr (v_cfeventid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfeventdescr WHERE cfeventid = v_cfeventid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfeventdescr (cfeventid, cfdescr, cflangcode, cftrans) VALUES (v_cfeventid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfeventdescr SET cfdescr = v_cfdescr  WHERE cfeventid = v_cfeventid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfexpskillsdescr (v_cfexpskillsid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfexpskillsdescr WHERE cfexpskillsid = v_cfexpskillsid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfexpskillsdescr (cfexpskillsid, cfdescr, cflangcode, cftrans) VALUES (v_cfexpskillsid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfexpskillsdescr SET cfdescr = v_cfdescr  WHERE cfexpskillsid = v_cfexpskillsid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffacil_event (v_cfeventid char(128), v_cffacilid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffacil_event WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid) THEN 
		INSERT INTO cffacil_event (cfeventid, cffacilid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfeventid, v_cffacilid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffacil_event SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfevent_meas (v_cfeventid char(128), v_cfmeasid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfevent_meas WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfevent_meas (cfeventid, cfmeasid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfeventid, v_cfmeasid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfevent_meas SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffacil_class (v_cffacilid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffacil_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid) THEN 
		INSERT INTO cffacil_class (cffacilid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffacilid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffacil_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffacil_equip (v_cfequipid char(128), v_cffacilid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffacil_equip WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid) THEN 
		INSERT INTO cffacil_equip (cfequipid, cffacilid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cffacilid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffacil_equip SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffedid (v_cffedid char(128), v_cffedidid char(128), v_cfinstid char(128), v_cfclassid char(128), v_cfclassschemeid char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cffedid WHERE cffedidid = v_cffedidid) THEN 
	INSERT INTO cffedid (cffedid, cffedidid, cfinstid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffedid, v_cffedidid, v_cfinstid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
ELSE
	UPDATE cffedid SET cffedid = v_cffedid, cfinstid = v_cfinstid, cfclassid = v_cfclassid, cfclassschemeid = v_cfclassschemeid, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cffedidid = v_cffedidid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffacilkeyw (v_cffacilid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cffacilkeyw WHERE cffacilid = v_cffacilid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cffacilkeyw (cffacilid, cfkeyw, cflangcode, cftrans) VALUES (v_cffacilid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cffacilkeyw SET cfkeyw = v_cfkeyw  WHERE cffacilid = v_cffacilid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffund (v_cffundid char(128), v_cfacro char(16), v_cfamount float8, v_cfcurrcode char(3), v_cfuri char(128), v_cfstartdate date, v_cfenddate date) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cffund WHERE cffundid = v_cffundid) THEN 
	INSERT INTO cffund (cffundid, cfacro, cfamount, cfcurrcode, cfuri, cfstartdate, cfenddate) VALUES (v_cffundid, v_cfacro, v_cfamount, v_cfcurrcode, v_cfuri, v_cfstartdate, v_cfenddate);
ELSE
	UPDATE cffund SET cfacro = v_cfacro, cfamount = v_cfamount, cfcurrcode = v_cfcurrcode, cfuri = v_cfuri, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cffundid = v_cffundid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffacilname (v_cffacilid char(128), v_cfname char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cffacilname WHERE cffacilid = v_cffacilid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cffacilname (cffacilid, cfname, cflangcode, cftrans) VALUES (v_cffacilid, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cffacilname SET cfname = v_cfname  WHERE cffacilid = v_cffacilid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffdcrightsmmprivacy (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cffdcprivacyconstraint text, v_cffdctrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cffdcrightsmmprivacy WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cffdctrans = v_cffdctrans) THEN 
	INSERT INTO cffdcrightsmmprivacy (cfdcid, cfdclangtag, cfdcscheme, cffdcprivacyconstraint, cffdctrans) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cffdcprivacyconstraint, v_cffdctrans);
ELSE
	UPDATE cffdcrightsmmprivacy SET cffdcprivacyconstraint = v_cffdcprivacyconstraint  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cffdctrans = v_cffdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffdcrightsmmrights (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cffdcrightsconstraint text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cffdcrightsmmrights WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cffdcrightsmmrights (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cffdcrightsconstraint) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cffdcrightsconstraint);
ELSE
	UPDATE cffdcrightsmmrights SET cffdcrightsconstraint = v_cffdcrightsconstraint  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffdcrightsmmsecurity (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cffdcsecurityconstraint char(32), v_cffdctrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cffdcrightsmmsecurity WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cffdctrans = v_cffdctrans) THEN 
	INSERT INTO cffdcrightsmmsecurity (cfdcid, cfdclangtag, cfdcscheme, cffdcsecurityconstraint, cffdctrans) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cffdcsecurityconstraint, v_cffdctrans);
ELSE
	UPDATE cffdcrightsmmsecurity SET cffdcsecurityconstraint = v_cffdcsecurityconstraint  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cffdctrans = v_cffdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffund_indic (v_cffundid char(128), v_cfindicid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffund_indic WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cffund_indic (cffundid, cfindicid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffundid, v_cfindicid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffund_indic SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffacildescr (v_cffacilid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cffacildescr WHERE cffacilid = v_cffacilid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cffacildescr (cffacilid, cfdescr, cflangcode, cftrans) VALUES (v_cffacilid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cffacildescr SET cfdescr = v_cfdescr  WHERE cffacilid = v_cffacilid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffdcrightsmmpricing (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cffdcpriceconstraint text, v_cffdctrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cffdcrightsmmpricing WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cffdctrans = v_cffdctrans) THEN 
	INSERT INTO cffdcrightsmmpricing (cfdcid, cfdclangtag, cfdcscheme, cffdcpriceconstraint, cffdctrans) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cffdcpriceconstraint, v_cffdctrans);
ELSE
	UPDATE cffdcrightsmmpricing SET cffdcpriceconstraint = v_cffdcpriceconstraint  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cffdctrans = v_cffdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffedid_srv (v_cffedidid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffedid_srv WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffedidid = v_cffedidid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cffedid_srv (cffedidid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffedidid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffedid_srv SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffedidid = v_cffedidid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffacil_srv (v_cffacilid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffacil_srv WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cffacil_srv (cffacilid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffacilid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffacil_srv SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffacil_paddr (v_cffacilid char(128), v_cfpaddrid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffacil_paddr WHERE cfclassid = v_cfclassid and cfpaddrid = v_cfpaddrid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid) THEN 
		INSERT INTO cffacil_paddr (cffacilid, cfpaddrid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffacilid, v_cfpaddrid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffacil_paddr SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfpaddrid = v_cfpaddrid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffacil_meas (v_cffacilid char(128), v_cfmeasid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffacil_meas WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid) THEN 
		INSERT INTO cffacil_meas (cffacilid, cfmeasid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffacilid, v_cfmeasid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffacil_meas SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffund_fund (v_cfclassname text, v_cfschemename text, v_cffundid1 char(128), v_cffundid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffund_fund WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cffund_fund (cfclassid, cfclassschemeid, cffundid1, cffundid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cffundid1, v_cffundid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffund_fund SET cffundid1 = v_cffundid1, cffundid2 = v_cffundid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffacil_medium (v_cffacilid char(128), v_cfmediumid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffacil_medium WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid) THEN 
		INSERT INTO cffacil_medium (cffacilid, cfmediumid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffacilid, v_cfmediumid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffacil_medium SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmeas_class (v_cfmeasid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfmeas_class WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfmeas_class (cfmeasid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmeasid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfmeas_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfindic (v_cfindicid char(128), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfindic WHERE cfindicid = v_cfindicid) THEN 
	INSERT INTO cfindic (cfindicid, cfuri) VALUES (v_cfindicid, v_cfuri);
ELSE
	UPDATE cfindic SET cfuri = v_cfuri  WHERE cfindicid = v_cfindicid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmeaskeyw (v_cfmeasid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfmeaskeyw WHERE cfmeasid = v_cfmeasid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfmeaskeyw (cfmeasid, cfkeyw, cflangcode, cftrans) VALUES (v_cfmeasid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfmeaskeyw SET cfkeyw = v_cfkeyw  WHERE cfmeasid = v_cfmeasid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfindicname (v_cfindicid char(128), v_cfname char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfindicname WHERE cfindicid = v_cfindicid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfindicname (cfindicid, cfname, cflangcode, cftrans) VALUES (v_cfindicid, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfindicname SET cfname = v_cfname  WHERE cfindicid = v_cfindicid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmeas_meas (v_cfclassname text, v_cfschemename text, v_cfmeasd1 char(128), v_cfmeasid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfmeas_meas WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfmeas_meas (cfclassid, cfclassschemeid, cfmeasd1, cfmeasid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfmeasd1, v_cfmeasid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfmeas_meas SET cfmeasd1 = v_cfmeasd1, cfmeasid2 = v_cfmeasid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffundname (v_cffundid char(128), v_cfname char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cffundname WHERE cffundid = v_cffundid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cffundname (cffundid, cfname, cflangcode, cftrans) VALUES (v_cffundid, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cffundname SET cfname = v_cfname  WHERE cffundid = v_cffundid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfgeobbox (v_cfgeobboxid char(128), v_cfeblong float8, v_cfmaxelev float8, v_cfminelev float8, v_cfnblat float8, v_cfsblat float8, v_cfuri char(128), v_cfwblong float8) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfgeobbox WHERE cfgeobboxid = v_cfgeobboxid) THEN 
	INSERT INTO cfgeobbox (cfgeobboxid, cfeblong, cfmaxelev, cfminelev, cfnblat, cfsblat, cfuri, cfwblong) VALUES (v_cfgeobboxid, v_cfeblong, v_cfmaxelev, v_cfminelev, v_cfnblat, v_cfsblat, v_cfuri, v_cfwblong);
ELSE
	UPDATE cfgeobbox SET cfeblong = v_cfeblong, cfmaxelev = v_cfmaxelev, cfminelev = v_cfminelev, cfnblat = v_cfnblat, cfsblat = v_cfsblat, cfuri = v_cfuri, cfwblong = v_cfwblong  WHERE cfgeobboxid = v_cfgeobboxid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfindickeyw (v_cfindicid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfindickeyw WHERE cfindicid = v_cfindicid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfindickeyw (cfindicid, cfkeyw, cflangcode, cftrans) VALUES (v_cfindicid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfindickeyw SET cfkeyw = v_cfkeyw  WHERE cfindicid = v_cfindicid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmeasdescr (v_cfmeasid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfmeasdescr WHERE cfmeasid = v_cfmeasid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfmeasdescr (cfmeasid, cfdescr, cflangcode, cftrans) VALUES (v_cfmeasid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfmeasdescr SET cfdescr = v_cfdescr  WHERE cfmeasid = v_cfmeasid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfgeobboxname (v_cfgeobboxid char(128), v_cfname char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfgeobboxname WHERE cfgeobboxid = v_cfgeobboxid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfgeobboxname (cfgeobboxid, cfname, cflangcode, cftrans) VALUES (v_cfgeobboxid, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfgeobboxname SET cfname = v_cfname  WHERE cfgeobboxid = v_cfgeobboxid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfindicdescr (v_cfindicid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfindicdescr WHERE cfindicid = v_cfindicid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfindicdescr (cfindicid, cfdescr, cflangcode, cftrans) VALUES (v_cfindicid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfindicdescr SET cfdescr = v_cfdescr  WHERE cfindicid = v_cfindicid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfgeobboxkeyw (v_cfgeobboxid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfgeobboxkeyw WHERE cfgeobboxid = v_cfgeobboxid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfgeobboxkeyw (cfgeobboxid, cfkeyw, cflangcode, cftrans) VALUES (v_cfgeobboxid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfgeobboxkeyw SET cfkeyw = v_cfkeyw  WHERE cfgeobboxid = v_cfgeobboxid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfgeobboxdescr (v_cfgeobboxid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfgeobboxdescr WHERE cfgeobboxid = v_cfgeobboxid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfgeobboxdescr (cfgeobboxid, cfdescr, cflangcode, cftrans) VALUES (v_cfgeobboxid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfgeobboxdescr SET cfdescr = v_cfdescr  WHERE cfgeobboxid = v_cfgeobboxid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocflang_class (v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp, v_cflangcode char(5)) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cflang_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cflang_class (cfclassid, cfclassschemeid, cfstartdate, cfenddate, cflangcode) VALUES (v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate, v_cflangcode);
	ELSE
		UPDATE cflang_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate, cflangcode = v_cflangcode  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfindic_class (v_cfindicid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfindic_class WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfindic_class (cfindicid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfindicid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfindic_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffundkeyw (v_cffundid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cffundkeyw WHERE cffundid = v_cffundid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cffundkeyw (cffundid, cfkeyw, cflangcode, cftrans) VALUES (v_cffundid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cffundkeyw SET cfkeyw = v_cfkeyw  WHERE cffundid = v_cffundid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffunddescr (v_cffundid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cffunddescr WHERE cffundid = v_cffundid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cffunddescr (cffundid, cfdescr, cflangcode, cftrans) VALUES (v_cffundid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cffunddescr SET cfdescr = v_cfdescr  WHERE cffundid = v_cffundid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocflangname (v_cflangcodeoflangname char(5), v_cfname char(64), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cflangname WHERE cflangcodeoflangname = v_cflangcodeoflangname and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cflangname (cflangcodeoflangname, cfname, cflangcode, cftrans) VALUES (v_cflangcodeoflangname, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cflangname SET cfname = v_cfname  WHERE cflangcodeoflangname = v_cflangcodeoflangname and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmetrics (v_cfmetricsid char(128), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfmetrics WHERE cfmetricsid = v_cfmetricsid) THEN 
	INSERT INTO cfmetrics (cfmetricsid, cfuri) VALUES (v_cfmetricsid, v_cfuri);
ELSE
	UPDATE cfmetrics SET cfuri = v_cfuri  WHERE cfmetricsid = v_cfmetricsid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmedium (v_cfmediumid char(128), v_cfmediumcreationdate varchar(30), v_cfmimetype varchar(30), v_cfsize float8, v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfmedium WHERE cfmediumid = v_cfmediumid) THEN 
	INSERT INTO cfmedium (cfmediumid, cfmediumcreationdate, cfmimetype, cfsize, cfuri) VALUES (v_cfmediumid, v_cfmediumcreationdate, v_cfmimetype, v_cfsize, v_cfuri);
ELSE
	UPDATE cfmedium SET cfmediumcreationdate = v_cfmediumcreationdate, cfmimetype = v_cfmimetype, cfsize = v_cfsize, cfuri = v_cfuri  WHERE cfmediumid = v_cfmediumid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit (v_cforgunitid char(128), v_cfacro char(16), v_cfcurrcode char(3), v_cfheadcount integer, v_cfturn float8, v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cforgunit WHERE cforgunitid = v_cforgunitid) THEN 
	INSERT INTO cforgunit (cforgunitid, cfacro, cfcurrcode, cfheadcount, cfturn, cfuri) VALUES (v_cforgunitid, v_cfacro, v_cfcurrcode, v_cfheadcount, v_cfturn, v_cfuri);
ELSE
	UPDATE cforgunit SET cfacro = v_cfacro, cfcurrcode = v_cfcurrcode, cfheadcount = v_cfheadcount, cfturn = v_cfturn, cfuri = v_cfuri  WHERE cforgunitid = v_cforgunitid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmetricsname (v_cfmetricsid char(128), v_cfname char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfmetricsname WHERE cfmetricsid = v_cfmetricsid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfmetricsname (cfmetricsid, cfname, cflangcode, cftrans) VALUES (v_cfmetricsid, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfmetricsname SET cfname = v_cfname  WHERE cfmetricsid = v_cfmetricsid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmediumtitle (v_cfmediumid char(128), v_cftitle char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfmediumtitle WHERE cfmediumid = v_cfmediumid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfmediumtitle (cfmediumid, cftitle, cflangcode, cftrans) VALUES (v_cfmediumid, v_cftitle, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfmediumtitle SET cftitle = v_cftitle  WHERE cfmediumid = v_cfmediumid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_facil (v_cffacilid char(128), v_cforgunitid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_facil WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_facil (cffacilid, cforgunitid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffacilid, v_cforgunitid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_facil SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_expskills (v_cfexpskillsid char(128), v_cforgunitid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_expskills WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfexpskillsid = v_cfexpskillsid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_expskills (cfexpskillsid, cforgunitid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfexpskillsid, v_cforgunitid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_expskills SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfexpskillsid = v_cfexpskillsid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmedium_medium (v_cfclassname text, v_cfschemename text, v_cfmediumid1 char(128), v_cfmediumid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfmedium_medium WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfmedium_medium (cfclassid, cfclassschemeid, cfmediumid1, cfmediumid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfmediumid1, v_cfmediumid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfmedium_medium SET cfmediumid1 = v_cfmediumid1, cfmediumid2 = v_cfmediumid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmediumdescr (v_cfmediumid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfmediumdescr WHERE cfmediumid = v_cfmediumid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfmediumdescr (cfmediumid, cfdescr, cflangcode, cftrans) VALUES (v_cfmediumid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfmediumdescr SET cfdescr = v_cfdescr  WHERE cfmediumid = v_cfmediumid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_dc (v_cfdcid char(32), v_cforgunitid char(128), v_cfclassname text, v_cfschemename text, v_cfdcscheme char(32), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_dc WHERE cfclassid = v_cfclassid and cfdcid = v_cfdcid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_dc (cfdcid, cforgunitid, cfclassid, cfclassschemeid, cfdcscheme, cfstartdate, cfenddate) VALUES (v_cfdcid, v_cforgunitid, v_cfclassid, v_cfclassschemeid, v_cfdcscheme, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_dc SET cfdcscheme = v_cfdcscheme, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfdcid = v_cfdcid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_equip (v_cfequipid char(128), v_cforgunitid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_equip WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_equip (cfequipid, cforgunitid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cforgunitid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_equip SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_event (v_cfeventid char(128), v_cforgunitid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_event WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_event (cfeventid, cforgunitid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfeventid, v_cforgunitid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_event SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_eaddr (v_cfeaddrid char(128), v_cforgunitid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_eaddr WHERE cfclassid = v_cfclassid and cfeaddrid = v_cfeaddrid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_eaddr (cfeaddrid, cforgunitid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfeaddrid, v_cforgunitid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_eaddr SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfeaddrid = v_cfeaddrid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmediumkeyw (v_cfmediumid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfmediumkeyw WHERE cfmediumid = v_cfmediumid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfmediumkeyw (cfmediumid, cfkeyw, cflangcode, cftrans) VALUES (v_cfmediumid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfmediumkeyw SET cfkeyw = v_cfkeyw  WHERE cfmediumid = v_cfmediumid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmetricsdescr (v_cfmetricsid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfmetricsdescr WHERE cfmetricsid = v_cfmetricsid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfmetricsdescr (cfmetricsid, cfdescr, cflangcode, cftrans) VALUES (v_cfmetricsid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfmetricsdescr SET cfdescr = v_cfdescr  WHERE cfmetricsid = v_cfmetricsid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmetricskeyw (v_cfmetricsid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfmetricskeyw WHERE cfmetricsid = v_cfmetricsid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfmetricskeyw (cfmetricsid, cfkeyw, cflangcode, cftrans) VALUES (v_cfmetricsid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfmetricskeyw SET cfkeyw = v_cfkeyw  WHERE cfmetricsid = v_cfmetricsid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_class (v_cforgunitid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_class (cforgunitid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cforgunitid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmedium_meas (v_cfmeasid char(128), v_cfmediumid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfmedium_meas WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfmedium_meas (cfmeasid, cfmediumid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmeasid, v_cfmediumid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfmedium_meas SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmetrics_class (v_cfmetricsid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfmetrics_class WHERE cfclassid = v_cfclassid and cfmetricsid = v_cfmetricsid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfmetrics_class (cfmetricsid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmetricsid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfmetrics_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfmetricsid = v_cfmetricsid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_meas (v_cfmeasid char(128), v_cforgunitid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_meas WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_meas (cfmeasid, cforgunitid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmeasid, v_cforgunitid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_meas SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_orgunit (v_cfclassname text, v_cfschemename text, v_cforgunitid1 char(128), v_cforgunitid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_orgunit WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cforgunit_orgunit (cfclassid, cfclassschemeid, cforgunitid1, cforgunitid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cforgunitid1, v_cforgunitid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_orgunit SET cforgunitid1 = v_cforgunitid1, cforgunitid2 = v_cforgunitid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_respat (v_cforgunitid char(128), v_cfrespatid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_respat WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_respat (cforgunitid, cfrespatid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cforgunitid, v_cfrespatid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_respat SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_resprod (v_cforgunitid char(128), v_cfresprodid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_resprod WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_resprod (cforgunitid, cfresprodid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cforgunitid, v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_resprod SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_respubl (v_cforgunitid char(128), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_respubl WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_respubl (cforgunitid, cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cforgunitid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_respubl SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunitkeyw (v_cforgunitid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cforgunitkeyw WHERE cftrans = v_cftrans and cflangcode = v_cflangcode and cforgunitid = v_cforgunitid) THEN 
	INSERT INTO cforgunitkeyw (cforgunitid, cfkeyw, cflangcode, cftrans) VALUES (v_cforgunitid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cforgunitkeyw SET cfkeyw = v_cfkeyw  WHERE cforgunitid = v_cforgunitid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpaddr (v_cfpaddrid char(128), v_cfaddrline1 char(80), v_cfaddrline2 char(80), v_cfaddrline3 char(80), v_cfaddrline4 char(80), v_cfaddrline5 char(80), v_cfcitytown char(64), v_cfcountrycode char(2), v_cfpostcode char(16), v_cfstateofcountry char(64), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfpaddr WHERE cfpaddrid = v_cfpaddrid) THEN 
	INSERT INTO cfpaddr (cfpaddrid, cfaddrline1, cfaddrline2, cfaddrline3, cfaddrline4, cfaddrline5, cfcitytown, cfcountrycode, cfpostcode, cfstateofcountry, cfuri) VALUES (v_cfpaddrid, v_cfaddrline1, v_cfaddrline2, v_cfaddrline3, v_cfaddrline4, v_cfaddrline5, v_cfcitytown, v_cfcountrycode, v_cfpostcode, v_cfstateofcountry, v_cfuri);
ELSE
	UPDATE cfpaddr SET cfaddrline1 = v_cfaddrline1, cfaddrline2 = v_cfaddrline2, cfaddrline3 = v_cfaddrline3, cfaddrline4 = v_cfaddrline4, cfaddrline5 = v_cfaddrline5, cfcitytown = v_cfcitytown, cfcountrycode = v_cfcountrycode, cfpostcode = v_cfpostcode, cfstateofcountry = v_cfstateofcountry, cfuri = v_cfuri  WHERE cfpaddrid = v_cfpaddrid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunitname (v_cforgunitid char(128), v_cfname char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cforgunitname WHERE cftrans = v_cftrans and cflangcode = v_cflangcode and cforgunitid = v_cforgunitid) THEN 
	INSERT INTO cforgunitname (cforgunitid, cfname, cflangcode, cftrans) VALUES (v_cforgunitid, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cforgunitname SET cfname = v_cfname  WHERE cforgunitid = v_cforgunitid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_medium (v_cfmediumid char(128), v_cforgunitid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_medium WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_medium (cfmediumid, cforgunitid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmediumid, v_cforgunitid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_medium SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_prize (v_cforgunitid char(128), v_cfprizeid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_prize WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfprizeid = v_cfprizeid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_prize (cforgunitid, cfprizeid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cforgunitid, v_cfprizeid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_prize SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfprizeid = v_cfprizeid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers (v_cfpersid char(128), v_cfbirthdate date, v_cfgender char(1), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfpers WHERE cfpersid = v_cfpersid) THEN 
	INSERT INTO cfpers (cfpersid, cfbirthdate, cfgender, cfuri) VALUES (v_cfpersid, v_cfbirthdate, v_cfgender, v_cfuri);
ELSE
	UPDATE cfpers SET cfbirthdate = v_cfbirthdate, cfgender = v_cfgender, cfuri = v_cfuri  WHERE cfpersid = v_cfpersid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_srv (v_cforgunitid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_srv WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cforgunit_srv (cforgunitid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cforgunitid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_srv SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_class (v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid) THEN 
		INSERT INTO cfpers_class (cfpersid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunitresact (v_cforgunitid char(128), v_cfresact text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cforgunitresact WHERE cftrans = v_cftrans and cflangcode = v_cflangcode and cforgunitid = v_cforgunitid) THEN 
	INSERT INTO cforgunitresact (cforgunitid, cfresact, cflangcode, cftrans) VALUES (v_cforgunitid, v_cfresact, v_cflangcode, v_cftrans);
ELSE
	UPDATE cforgunitresact SET cfresact = v_cfresact  WHERE cforgunitid = v_cforgunitid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpaddr_class (v_cfpaddrid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpaddr_class WHERE cfclassid = v_cfclassid and cfpaddrid = v_cfpaddrid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfpaddr_class (cfpaddrid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfpaddrid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpaddr_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfpaddrid = v_cfpaddrid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_country (v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfcountrycode char(2), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_country WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid) THEN 
		INSERT INTO cfpers_country (cfpersid, cfclassid, cfclassschemeid, cfcountrycode, cfstartdate, cfenddate) VALUES (v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfcountrycode, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_country SET cfcountrycode = v_cfcountrycode, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_fund (v_cffundid char(128), v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_fund WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid) THEN 
		INSERT INTO cfpers_fund (cffundid, cfpersid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffundid, v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_fund SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_facil (v_cffacilid char(128), v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_facil WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cffacilid = v_cffacilid) THEN 
		INSERT INTO cfpers_facil (cffacilid, cfpersid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffacilid, v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_facil SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cffacilid = v_cffacilid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_indic (v_cfindicid char(128), v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_indic WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid) THEN 
		INSERT INTO cfpers_indic (cfindicid, cfpersid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfindicid, v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_indic SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_lang (v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp, v_cflangcode char(5)) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_lang WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid) THEN 
		INSERT INTO cfpers_lang (cfpersid, cfclassid, cfclassschemeid, cfstartdate, cfenddate, cflangcode) VALUES (v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate, v_cflangcode);
	ELSE
		UPDATE cfpers_lang SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate, cflangcode = v_cflangcode  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_eaddr (v_cfeaddrid char(128), v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_eaddr WHERE cfclassid = v_cfclassid and cfeaddrid = v_cfeaddrid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid) THEN 
		INSERT INTO cfpers_eaddr (cfeaddrid, cfpersid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfeaddrid, v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_eaddr SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfeaddrid = v_cfeaddrid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_meas (v_cfmeasid char(128), v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_meas WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid) THEN 
		INSERT INTO cfpers_meas (cfmeasid, cfpersid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmeasid, v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_meas SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_medium (v_cfmediumid char(128), v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_medium WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid) THEN 
		INSERT INTO cfpers_medium (cfmediumid, cfpersid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmediumid, v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_medium SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_paddr (v_cfpaddrid char(128), v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_paddr WHERE cfclassid = v_cfclassid and cfpaddrid = v_cfpaddrid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid) THEN 
		INSERT INTO cfpers_paddr (cfpaddrid, cfpersid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfpaddrid, v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_paddr SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfpaddrid = v_cfpaddrid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_dc (v_cfdcid char(32), v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfdcscheme char(32), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_dc WHERE cfclassid = v_cfclassid and cfdcid = v_cfdcid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid) THEN 
		INSERT INTO cfpers_dc (cfdcid, cfpersid, cfclassid, cfclassschemeid, cfdcscheme, cfstartdate, cfenddate) VALUES (v_cfdcid, v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfdcscheme, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_dc SET cfdcscheme = v_cfdcscheme, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfdcid = v_cfdcid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_pers (v_cfclassname text, v_cfschemename text, v_cfpersid1 char(128), v_cfpersid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_pers WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfpers_pers (cfclassid, cfclassschemeid, cfpersid1, cfpersid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfpersid1, v_cfpersid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_pers SET cfpersid1 = v_cfpersid1, cfpersid2 = v_cfpersid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_prize (v_cfpersid char(128), v_cfprizeid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_prize WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfprizeid = v_cfprizeid) THEN 
		INSERT INTO cfpers_prize (cfpersid, cfprizeid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfpersid, v_cfprizeid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_prize SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfprizeid = v_cfprizeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_expskills (v_cfexpskillsid char(128), v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_expskills WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfexpskillsid = v_cfexpskillsid) THEN 
		INSERT INTO cfpers_expskills (cfexpskillsid, cfpersid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfexpskillsid, v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_expskills SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfexpskillsid = v_cfexpskillsid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_equip (v_cfequipid char(128), v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_equip WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid) THEN 
		INSERT INTO cfpers_equip (cfequipid, cfpersid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_equip SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_event (v_cfeventid char(128), v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_event WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid) THEN 
		INSERT INTO cfpers_event (cfeventid, cfpersid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfeventid, v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_event SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_orgunit (v_cforgunitid char(128), v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_orgunit WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cfpers_orgunit (cforgunitid, cfpersid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cforgunitid, v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_orgunit SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj (v_cfprojid char(128), v_cfacro char(16), v_cfuri char(128), v_cfstartdate date, v_cfenddate date) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfproj WHERE cfprojid = v_cfprojid) THEN 
	INSERT INTO cfproj (cfprojid, cfacro, cfuri, cfstartdate, cfenddate) VALUES (v_cfprojid, v_cfacro, v_cfuri, v_cfstartdate, v_cfenddate);
ELSE
	UPDATE cfproj SET cfacro = v_cfacro, cfuri = v_cfuri, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfprojid = v_cfprojid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpersresint (v_cfpersid char(128), v_cfresint text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfpersresint WHERE cfpersid = v_cfpersid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfpersresint (cfpersid, cfresint, cflangcode, cftrans) VALUES (v_cfpersid, v_cfresint, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfpersresint SET cfresint = v_cfresint  WHERE cfpersid = v_cfpersid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_respat (v_cfpersid char(128), v_cfrespatid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_respat WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfrespatid = v_cfrespatid) THEN 
		INSERT INTO cfpers_respat (cfpersid, cfrespatid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfpersid, v_cfrespatid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_respat SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfrespatid = v_cfrespatid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfprize (v_cfprizeid char(128), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfprize WHERE cfprizeid = v_cfprizeid) THEN 
	INSERT INTO cfprize (cfprizeid, cfuri) VALUES (v_cfprizeid, v_cfuri);
ELSE
	UPDATE cfprize SET cfuri = v_cfuri  WHERE cfprizeid = v_cfprizeid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_resprod (v_cfpersid char(128), v_cfresprodid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_resprod WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid) THEN 
		INSERT INTO cfpers_resprod (cfpersid, cfresprodid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfpersid, v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_resprod SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_fund (v_cffundid char(128), v_cfprojid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_fund WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfproj_fund (cffundid, cfprojid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffundid, v_cfprojid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_fund SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_respubl (v_cfpersid char(128), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_respubl WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfrespublid = v_cfrespublid) THEN 
		INSERT INTO cfpers_respubl (cfpersid, cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfpersid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_respubl SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfrespublid = v_cfrespublid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_facil (v_cffacilid char(128), v_cfprojid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_facil WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid) THEN 
		INSERT INTO cfproj_facil (cffacilid, cfprojid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffacilid, v_cfprojid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_facil SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfprizename (v_cfprizeid char(128), v_cfname char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfprizename WHERE cftrans = v_cftrans and cfprizeid = v_cfprizeid and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfprizename (cfprizeid, cfname, cflangcode, cftrans) VALUES (v_cfprizeid, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfprizename SET cfname = v_cfname  WHERE cfprizeid = v_cfprizeid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_srv (v_cfpersid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_srv WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cfpers_srv (cfpersid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfpersid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_srv SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfperskeyw (v_cfpersid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfperskeyw WHERE cfpersid = v_cfpersid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfperskeyw (cfpersid, cfkeyw, cflangcode, cftrans) VALUES (v_cfpersid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfperskeyw SET cfkeyw = v_cfkeyw  WHERE cfpersid = v_cfpersid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_equip (v_cfequipid char(128), v_cfprojid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_equip WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfproj_equip (cfequipid, cfprojid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cfprojid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_equip SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_event (v_cfeventid char(128), v_cfprojid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_event WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfproj_event (cfeventid, cfprojid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfeventid, v_cfprojid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_event SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_indic (v_cfindicid char(128), v_cfprojid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_indic WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfproj_indic (cfindicid, cfprojid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfindicid, v_cfprojid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_indic SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpersname (v_cfpersnameid char(128), v_cffamilynames char(64), v_cffirstnames char(64), v_cfothernames char(64)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfpersname WHERE cfpersnameid = v_cfpersnameid) THEN 
	INSERT INTO cfpersname (cfpersnameid, cffamilynames, cffirstnames, cfothernames) VALUES (v_cfpersnameid, v_cffamilynames, v_cffirstnames, v_cfothernames);
ELSE
	UPDATE cfpersname SET cffamilynames = v_cffamilynames, cffirstnames = v_cffirstnames, cfothernames = v_cfothernames  WHERE cfpersnameid = v_cfpersnameid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_class (v_cfprojid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_class WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfproj_class (cfprojid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfprojid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfprizekeyw (v_cfprizeid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfprizekeyw WHERE cftrans = v_cftrans and cfprizeid = v_cfprizeid and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfprizekeyw (cfprizeid, cfkeyw, cflangcode, cftrans) VALUES (v_cfprizeid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfprizekeyw SET cfkeyw = v_cfkeyw  WHERE cfprizeid = v_cfprizeid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_dc (v_cfdcid char(32), v_cfprojid char(128), v_cfclassname text, v_cfschemename text, v_cfdcscheme char(32), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_dc WHERE cfclassid = v_cfclassid and cfdcid = v_cfdcid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfproj_dc (cfdcid, cfprojid, cfclassid, cfclassschemeid, cfdcscheme, cfstartdate, cfenddate) VALUES (v_cfdcid, v_cfprojid, v_cfclassid, v_cfclassschemeid, v_cfdcscheme, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_dc SET cfdcscheme = v_cfdcscheme, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfdcid = v_cfdcid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_meas (v_cfmeasid char(128), v_cfprojid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_meas WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfproj_meas (cfmeasid, cfprojid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmeasid, v_cfprojid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_meas SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_resprod (v_cfprojid char(128), v_cfresprodid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_resprod WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfproj_resprod (cfprojid, cfresprodid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfprojid, v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_resprod SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_proj (v_cfclassname text, v_cfschemename text, v_cfprojid1 char(128), v_cfprojid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_proj WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfproj_proj (cfclassid, cfclassschemeid, cfprojid1, cfprojid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfprojid1, v_cfprojid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_proj SET cfprojid1 = v_cfprojid1, cfprojid2 = v_cfprojid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_respubl (v_cfprojid char(128), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_respubl WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid) THEN 
		INSERT INTO cfproj_respubl (cfprojid, cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfprojid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_respubl SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_srv (v_cfprojid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_srv WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cfproj_srv (cfprojid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfprojid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_srv SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfprojkeyw (v_cfprojid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfprojkeyw WHERE cfprojid = v_cfprojid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfprojkeyw (cfprojid, cfkeyw, cflangcode, cftrans) VALUES (v_cfprojid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfprojkeyw SET cfkeyw = v_cfkeyw  WHERE cfprojid = v_cfprojid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfqual (v_cfqualid char(128), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfqual WHERE cfqualid = v_cfqualid) THEN 
	INSERT INTO cfqual (cfqualid, cfuri) VALUES (v_cfqualid, v_cfuri);
ELSE
	UPDATE cfqual SET cfuri = v_cfuri  WHERE cfqualid = v_cfqualid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfprojtitle (v_cfprojid char(128), v_cftitle char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfprojtitle WHERE cfprojid = v_cfprojid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfprojtitle (cfprojid, cftitle, cflangcode, cftrans) VALUES (v_cfprojid, v_cftitle, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfprojtitle SET cftitle = v_cftitle  WHERE cfprojid = v_cfprojid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespat (v_cfrespatid char(128), v_cfapprovdate date, v_cfcountrycode char(2), v_cfpatentnum char(64), v_cfregistrdate date, v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfrespat WHERE cfrespatid = v_cfrespatid) THEN 
	INSERT INTO cfrespat (cfrespatid, cfapprovdate, cfcountrycode, cfpatentnum, cfregistrdate, cfuri) VALUES (v_cfrespatid, v_cfapprovdate, v_cfcountrycode, v_cfpatentnum, v_cfregistrdate, v_cfuri);
ELSE
	UPDATE cfrespat SET cfapprovdate = v_cfapprovdate, cfcountrycode = v_cfcountrycode, cfpatentnum = v_cfpatentnum, cfregistrdate = v_cfregistrdate, cfuri = v_cfuri  WHERE cfrespatid = v_cfrespatid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_orgunit (v_cforgunitid char(128), v_cfprojid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_orgunit WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cfproj_orgunit (cforgunitid, cfprojid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cforgunitid, v_cfprojid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_orgunit SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_prize (v_cfprizeid char(128), v_cfprojid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_prize WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid and cfprizeid = v_cfprizeid) THEN 
		INSERT INTO cfproj_prize (cfprizeid, cfprojid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfprizeid, v_cfprojid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_prize SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid and cfprizeid = v_cfprizeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfprojabstr (v_cfprojid char(128), v_cfabstr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfprojabstr WHERE cfprojid = v_cfprojid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfprojabstr (cfprojid, cfabstr, cflangcode, cftrans) VALUES (v_cfprojid, v_cfabstr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfprojabstr SET cfabstr = v_cfabstr  WHERE cfprojid = v_cfprojid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespat_class (v_cfrespatid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespat_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid) THEN 
		INSERT INTO cfrespat_class (cfrespatid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfrespatid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespat_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfqualtitle (v_cfqualid char(128), v_cftitle char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfqualtitle WHERE cftrans = v_cftrans and cflangcode = v_cflangcode and cfqualid = v_cfqualid) THEN 
	INSERT INTO cfqualtitle (cfqualid, cftitle, cflangcode, cftrans) VALUES (v_cfqualid, v_cftitle, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfqualtitle SET cftitle = v_cftitle  WHERE cfqualid = v_cfqualid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_respat (v_cfprojid char(128), v_cfrespatid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_respat WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid) THEN 
		INSERT INTO cfproj_respat (cfprojid, cfrespatid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfprojid, v_cfrespatid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_respat SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_medium (v_cfmediumid char(128), v_cfprojid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_medium WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfproj_medium (cfmediumid, cfprojid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmediumid, v_cfprojid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_medium SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespatkeyw (v_cfrespatid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfrespatkeyw WHERE cfrespatid = v_cfrespatid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfrespatkeyw (cfrespatid, cfkeyw, cflangcode, cftrans) VALUES (v_cfrespatid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfrespatkeyw SET cfkeyw = v_cfkeyw  WHERE cfrespatid = v_cfrespatid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespat_facil (v_cffacilid char(128), v_cfrespatid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespat_facil WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid and cfrespatid = v_cfrespatid) THEN 
		INSERT INTO cfrespat_facil (cffacilid, cfrespatid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffacilid, v_cfrespatid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespat_facil SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid and cfrespatid = v_cfrespatid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespat_respat (v_cfclassname text, v_cfschemename text, v_cfrespatid1 char(128), v_cfrespatid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespat_respat WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfrespat_respat (cfclassid, cfclassschemeid, cfrespatid1, cfrespatid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfrespatid1, v_cfrespatid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespat_respat SET cfrespatid1 = v_cfrespatid1, cfrespatid2 = v_cfrespatid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespatabstr (v_cfrespatid char(128), v_cfabstr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfrespatabstr WHERE cfrespatid = v_cfrespatid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfrespatabstr (cfrespatid, cfabstr, cflangcode, cftrans) VALUES (v_cfrespatid, v_cfabstr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfrespatabstr SET cfabstr = v_cfabstr  WHERE cfrespatid = v_cfrespatid and cflangcode = v_cflangcode and cftrans = v_cftrans;
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

CREATE OR REPLACE FUNCTION tocfrespattitle (v_cfrespatid char(128), v_cftitle char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfrespattitle WHERE cfrespatid = v_cfrespatid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfrespattitle (cfrespatid, cftitle, cflangcode, cftrans) VALUES (v_cfrespatid, v_cftitle, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfrespattitle SET cftitle = v_cftitle  WHERE cfrespatid = v_cfrespatid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespat_srv (v_cfrespatid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespat_srv WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cfrespat_srv (cfrespatid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfrespatid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespat_srv SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespat_indic (v_cfindicid char(128), v_cfrespatid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespat_indic WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid) THEN 
		INSERT INTO cfrespat_indic (cfindicid, cfrespatid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfindicid, v_cfrespatid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespat_indic SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespat_meas (v_cfmeasid char(128), v_cfrespatid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespat_meas WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid) THEN 
		INSERT INTO cfrespat_meas (cfmeasid, cfrespatid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmeasid, v_cfrespatid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespat_meas SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_geobbox (v_cfgeobboxid char(128), v_cfresprodid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfresprod_geobbox WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cfgeobboxid = v_cfgeobboxid) THEN 
		INSERT INTO cfresprod_geobbox (cfgeobboxid, cfresprodid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfgeobboxid, v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfresprod_geobbox SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cfgeobboxid = v_cfgeobboxid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_fund (v_cffundid char(128), v_cfresprodid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfresprod_fund WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfresprod_fund (cffundid, cfresprodid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffundid, v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfresprod_fund SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespat_fund (v_cffundid char(128), v_cfrespatid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespat_fund WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid) THEN 
		INSERT INTO cfrespat_fund (cffundid, cfrespatid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffundid, v_cfrespatid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespat_fund SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespatversinfo (v_cfrespatid char(128), v_cfversinfo char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfrespatversinfo WHERE cfrespatid = v_cfrespatid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfrespatversinfo (cfrespatid, cfversinfo, cflangcode, cftrans) VALUES (v_cfrespatid, v_cfversinfo, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfrespatversinfo SET cfversinfo = v_cfversinfo  WHERE cfrespatid = v_cfrespatid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_facil (v_cffacilid char(128), v_cfresprodid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfresprod_facil WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid) THEN 
		INSERT INTO cfresprod_facil (cffacilid, cfresprodid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffacilid, v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfresprod_facil SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespat_medium (v_cfmediumid char(128), v_cfrespatid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespat_medium WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid) THEN 
		INSERT INTO cfrespat_medium (cfmediumid, cfrespatid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmediumid, v_cfrespatid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespat_medium SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_indic (v_cfindicid char(128), v_cfresprodid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfresprod_indic WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfresprod_indic (cfindicid, cfresprodid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfindicid, v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfresprod_indic SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprodaltname (v_cfresprodid char(128), v_cfaltname varchar(255), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfresprodaltname WHERE cfresprodid = v_cfresprodid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfresprodaltname (cfresprodid, cfaltname, cflangcode, cftrans) VALUES (v_cfresprodid, v_cfaltname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfresprodaltname SET cfaltname = v_cfaltname  WHERE cfresprodid = v_cfresprodid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_dc (v_cfdcid char(32), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfdcscheme char(32), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_dc WHERE cfclassid = v_cfclassid and cfdcid = v_cfdcid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid) THEN 
		INSERT INTO cfrespubl_dc (cfdcid, cfrespublid, cfclassid, cfclassschemeid, cfdcscheme, cfstartdate, cfenddate) VALUES (v_cfdcid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfdcscheme, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_dc SET cfdcscheme = v_cfdcscheme, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfdcid = v_cfdcid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprodname (v_cfresprodid char(128), v_cfname char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfresprodname WHERE cfresprodid = v_cfresprodid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfresprodname (cfresprodid, cfname, cflangcode, cftrans) VALUES (v_cfresprodid, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfresprodname SET cfname = v_cfname  WHERE cfresprodid = v_cfresprodid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_srv (v_cfresprodid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfresprod_srv WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cfresprod_srv (cfresprodid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfresprodid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfresprod_srv SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_fund (v_cffundid char(128), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_fund WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid) THEN 
		INSERT INTO cfrespubl_fund (cffundid, cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffundid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_fund SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_indic (v_cfindicid char(128), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_indic WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid) THEN 
		INSERT INTO cfrespubl_indic (cfindicid, cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfindicid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_indic SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_equip (v_cfequipid char(128), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_equip WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid) THEN 
		INSERT INTO cfrespubl_equip (cfequipid, cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_equip SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresproddescr (v_cfresprodid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfresproddescr WHERE cfresprodid = v_cfresprodid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfresproddescr (cfresprodid, cfdescr, cflangcode, cftrans) VALUES (v_cfresprodid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfresproddescr SET cfdescr = v_cfdescr  WHERE cfresprodid = v_cfresprodid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_meas (v_cfmeasid char(128), v_cfresprodid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfresprod_meas WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfresprod_meas (cfmeasid, cfresprodid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmeasid, v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfresprod_meas SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_resprod (v_cfclassname text, v_cfschemename text, v_cfresprodid1 char(128), v_cfresprodid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfresprod_resprod WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfresprod_resprod (cfclassid, cfclassschemeid, cfresprodid1, cfresprodid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfresprodid1, v_cfresprodid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfresprod_resprod SET cfresprodid1 = v_cfresprodid1, cfresprodid2 = v_cfresprodid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_respat (v_cfrespatid char(128), v_cfresprodid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfresprod_respat WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid) THEN 
		INSERT INTO cfresprod_respat (cfrespatid, cfresprodid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfrespatid, v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfresprod_respat SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_event (v_cfeventid char(128), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_event WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid) THEN 
		INSERT INTO cfrespubl_event (cfeventid, cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfeventid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_event SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_facil (v_cffacilid char(128), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_facil WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid and cfrespublid = v_cfrespublid) THEN 
		INSERT INTO cfrespubl_facil (cffacilid, cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffacilid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_facil SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid and cfrespublid = v_cfrespublid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprodkeyw (v_cfresprodid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfresprodkeyw WHERE cfresprodid = v_cfresprodid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfresprodkeyw (cfresprodid, cfkeyw, cflangcode, cftrans) VALUES (v_cfresprodid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfresprodkeyw SET cfkeyw = v_cfkeyw  WHERE cfresprodid = v_cfresprodid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprodversinfo (v_cfresprodid char(128), v_cfversinfo char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfresprodversinfo WHERE cfresprodid = v_cfresprodid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfresprodversinfo (cfresprodid, cfversinfo, cflangcode, cftrans) VALUES (v_cfresprodid, v_cfversinfo, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfresprodversinfo SET cfversinfo = v_cfversinfo  WHERE cfresprodid = v_cfresprodid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_class (v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid) THEN 
		INSERT INTO cfrespubl_class (cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_medium (v_cfmediumid char(128), v_cfresprodid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfresprod_medium WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfresprod_medium (cfmediumid, cfresprodid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmediumid, v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfresprod_medium SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfsrv (v_cfsrvid char(128), v_cfacro char(16), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfsrv WHERE cfsrvid = v_cfsrvid) THEN 
	INSERT INTO cfsrv (cfsrvid, cfacro, cfuri) VALUES (v_cfsrvid, v_cfacro, v_cfuri);
ELSE
	UPDATE cfsrv SET cfacro = v_cfacro, cfuri = v_cfuri  WHERE cfsrvid = v_cfsrvid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespublbiblnote (v_cfrespublid char(128), v_cfbiblnote char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfrespublbiblnote WHERE cfrespublid = v_cfrespublid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfrespublbiblnote (cfrespublid, cfbiblnote, cflangcode, cftrans) VALUES (v_cfrespublid, v_cfbiblnote, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfrespublbiblnote SET cfbiblnote = v_cfbiblnote  WHERE cfrespublid = v_cfrespublid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_respubl (v_cfclassname text, v_cfschemename text, v_cfrespublid1 char(128), v_cfrespublid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_respubl WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfrespubl_respubl (cfclassid, cfclassschemeid, cfrespublid1, cfrespublid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfrespublid1, v_cfrespublid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_respubl SET cfrespublid1 = v_cfrespublid1, cfrespublid2 = v_cfrespublid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespublabstr (v_cfrespublid char(128), v_cfabstr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfrespublabstr WHERE cfrespublid = v_cfrespublid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfrespublabstr (cfrespublid, cfabstr, cflangcode, cftrans) VALUES (v_cfrespublid, v_cfabstr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfrespublabstr SET cfabstr = v_cfabstr  WHERE cfrespublid = v_cfrespublid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespublsubtitle (v_cfrespublid char(128), v_cfsubtitle char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfrespublsubtitle WHERE cfrespublid = v_cfrespublid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfrespublsubtitle (cfrespublid, cfsubtitle, cflangcode, cftrans) VALUES (v_cfrespublid, v_cfsubtitle, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfrespublsubtitle SET cfsubtitle = v_cfsubtitle  WHERE cfrespublid = v_cfrespublid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespublkeyw (v_cfrespublid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfrespublkeyw WHERE cfrespublid = v_cfrespublid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfrespublkeyw (cfrespublid, cfkeyw, cflangcode, cftrans) VALUES (v_cfrespublid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfrespublkeyw SET cfkeyw = v_cfkeyw  WHERE cfrespublid = v_cfrespublid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_metrics (v_cfmetricsid char(128), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_metrics WHERE cfclassid = v_cfclassid and cfmetricsid = v_cfmetricsid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid) THEN 
		INSERT INTO cfrespubl_metrics (cfmetricsid, cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmetricsid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_metrics SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfmetricsid = v_cfmetricsid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfsrv_meas (v_cfmeasid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfsrv_meas WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cfsrv_meas (cfmeasid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmeasid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfsrv_meas SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfsrv_indic (v_cfindicid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfsrv_indic WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cfsrv_indic (cfindicid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfindicid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfsrv_indic SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_resprod (v_cfresprodid char(128), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_resprod WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid) THEN 
		INSERT INTO cfrespubl_resprod (cfresprodid, cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfresprodid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_resprod SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_respat (v_cfrespatid char(128), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_respat WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid and cfrespatid = v_cfrespatid) THEN 
		INSERT INTO cfrespubl_respat (cfrespatid, cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfrespatid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_respat SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid and cfrespatid = v_cfrespatid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubltitle (v_cfrespublid char(128), v_cftitle char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfrespubltitle WHERE cfrespublid = v_cfrespublid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfrespubltitle (cfrespublid, cftitle, cflangcode, cftrans) VALUES (v_cfrespublid, v_cftitle, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfrespubltitle SET cftitle = v_cftitle  WHERE cfrespublid = v_cfrespublid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespublversinfo (v_cfrespublid char(128), v_cfversinfo char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfrespublversinfo WHERE cfrespublid = v_cfrespublid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfrespublversinfo (cfrespublid, cfversinfo, cflangcode, cftrans) VALUES (v_cfrespublid, v_cfversinfo, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfrespublversinfo SET cfversinfo = v_cfversinfo  WHERE cfrespublid = v_cfrespublid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespublnameabbrev (v_cfrespublid char(128), v_cfnameabbrev char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfrespublnameabbrev WHERE cfrespublid = v_cfrespublid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfrespublnameabbrev (cfrespublid, cfnameabbrev, cflangcode, cftrans) VALUES (v_cfrespublid, v_cfnameabbrev, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfrespublnameabbrev SET cfnameabbrev = v_cfnameabbrev  WHERE cfrespublid = v_cfrespublid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_medium (v_cfmediumid char(128), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_medium WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid) THEN 
		INSERT INTO cfrespubl_medium (cfmediumid, cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmediumid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_medium SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfsrv_fund (v_cffundid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfsrv_fund WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cfsrv_fund (cffundid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffundid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfsrv_fund SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfsrv_event (v_cfeventid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfsrv_event WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cfsrv_event (cfeventid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfeventid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfsrv_event SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfsrvdescr (v_cfsrvid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfsrvdescr WHERE cftrans = v_cftrans and cflangcode = v_cflangcode and cfsrvid = v_cfsrvid) THEN 
	INSERT INTO cfsrvdescr (cfsrvid, cfdescr, cflangcode, cftrans) VALUES (v_cfsrvid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfsrvdescr SET cfdescr = v_cfdescr  WHERE cfsrvid = v_cfsrvid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfcite_class (v_cfciteid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfcite_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfciteid = v_cfciteid) THEN 
		INSERT INTO cfcite_class (cfciteid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfciteid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfcite_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfciteid = v_cfciteid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfcite (v_cfciteid char(128), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfcite WHERE cfciteid = v_cfciteid) THEN 
	INSERT INTO cfcite (cfciteid, cfuri) VALUES (v_cfciteid, v_cfuri);
ELSE
	UPDATE cfcite SET cfuri = v_cfuri  WHERE cfciteid = v_cfciteid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfgeobbox_geobbox (v_cfclassname text, v_cfschemename text, v_cfgeobboxid1 char(128), v_cfgeobboxid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfgeobbox_geobbox WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfgeobbox_geobbox (cfclassid, cfclassschemeid, cfgeobboxid1, cfgeobboxid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfgeobboxid1, v_cfgeobboxid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfgeobbox_geobbox SET cfgeobboxid1 = v_cfgeobboxid1, cfgeobboxid2 = v_cfgeobboxid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfcv_class (v_cfcvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfcv_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfcvid = v_cfcvid) THEN 
		INSERT INTO cfcv_class (cfcvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfcvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfcv_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfcvid = v_cfcvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_indic (v_cfindicid char(128), v_cforgunitid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_indic WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_indic (cfindicid, cforgunitid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfindicid, v_cforgunitid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_indic SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_cv (v_cfcvid char(128), v_cfpersid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_cv WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfcvid = v_cfcvid) THEN 
		INSERT INTO cfpers_cv (cfcvid, cfpersid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfcvid, v_cfpersid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_cv SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfcvid = v_cfcvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfeaddr_class (v_cfeaddrid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfeaddr_class WHERE cfclassid = v_cfclassid and cfeaddrid = v_cfeaddrid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfeaddr_class (cfeaddrid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfeaddrid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfeaddr_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfeaddrid = v_cfeaddrid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfevent_class (v_cfeventid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfevent_class WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfevent_class (cfeventid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfeventid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfevent_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfcite_medium (v_cfciteid char(128), v_cfmediumid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfcite_medium WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfciteid = v_cfciteid) THEN 
		INSERT INTO cfcite_medium (cfciteid, cfmediumid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfciteid, v_cfmediumid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfcite_medium SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfciteid = v_cfciteid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_fund (v_cffundid char(128), v_cforgunitid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_fund WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_fund (cffundid, cforgunitid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffundid, v_cforgunitid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_fund SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffacil_indic (v_cffacilid char(128), v_cfindicid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffacil_indic WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid) THEN 
		INSERT INTO cffacil_indic (cffacilid, cfindicid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffacilid, v_cfindicid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffacil_indic SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid and cffacilid = v_cffacilid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmedium_fund (v_cffundid char(128), v_cfmediumid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfmedium_fund WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfmedium_fund (cffundid, cfmediumid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffundid, v_cfmediumid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfmedium_fund SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpers_qual (v_cfpersid char(128), v_cfqualid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpers_qual WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfqualid = v_cfqualid) THEN 
		INSERT INTO cfpers_qual (cfpersid, cfqualid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfpersid, v_cfqualid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpers_qual SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfqualid = v_cfqualid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfproj_pers (v_cfpersid char(128), v_cfprojid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfproj_pers WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid) THEN 
		INSERT INTO cfproj_pers (cfpersid, cfprojid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfpersid, v_cfprojid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfproj_pers SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfprojid = v_cfprojid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfsrv_paddr (v_cfpaddrid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfsrv_paddr WHERE cfclassid = v_cfclassid and cfpaddrid = v_cfpaddrid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cfsrv_paddr (cfpaddrid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfpaddrid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfsrv_paddr SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfpaddrid = v_cfpaddrid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfequip_equip (v_cfclassname text, v_cfschemename text, v_cfequipid1 char(128), v_cfequipid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfequip_equip WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfequip_equip (cfclassid, cfclassschemeid, cfequipid1, cfequipid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfequipid1, v_cfequipid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfequip_equip SET cfequipid1 = v_cfequipid1, cfequipid2 = v_cfequipid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfsrv_srv (v_cfclassname text, v_cfschemename text, v_cfsrvid1 char(128), v_cfsrvid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfsrv_srv WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfsrv_srv (cfclassid, cfclassschemeid, cfsrvid1, cfsrvid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfsrvid1, v_cfsrvid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfsrv_srv SET cfsrvid1 = v_cfsrvid1, cfsrvid2 = v_cfsrvid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfcountry_class (v_cfclassname text, v_cfschemename text, v_cfcountrycode char(2), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfcountry_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfcountry_class (cfclassid, cfclassschemeid, cfcountrycode, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfcountrycode, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfcountry_class SET cfcountrycode = v_cfcountrycode, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfevent_event (v_cfclassname text, v_cfschemename text, v_cfeventid1 char(128), v_cfeventid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfevent_event WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfevent_event (cfclassid, cfclassschemeid, cfeventid1, cfeventid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfeventid1, v_cfeventid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfevent_event SET cfeventid1 = v_cfeventid1, cfeventid2 = v_cfeventid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfexpskills_class (v_cfexpskillsid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfexpskills_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfexpskillsid = v_cfexpskillsid) THEN 
		INSERT INTO cfexpskills_class (cfexpskillsid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfexpskillsid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfexpskills_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfexpskillsid = v_cfexpskillsid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffedid_class (v_cffedidid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffedid_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffedidid = v_cffedidid) THEN 
		INSERT INTO cffedid_class (cffedidid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffedidid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffedid_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cffedidid = v_cffedidid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfsrvkeyw (v_cfsrvid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfsrvkeyw WHERE cftrans = v_cftrans and cflangcode = v_cflangcode and cfsrvid = v_cfsrvid) THEN 
	INSERT INTO cfsrvkeyw (cfsrvid, cfkeyw, cflangcode, cftrans) VALUES (v_cfsrvid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfsrvkeyw SET cfkeyw = v_cfkeyw  WHERE cfsrvid = v_cfsrvid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfcountry (v_cfcountrycode char(2), v_cfuri char(128)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfcountry WHERE cfcountrycode = v_cfcountrycode) THEN 
	INSERT INTO cfcountry (cfcountrycode, cfuri) VALUES (v_cfcountrycode, v_cfuri);
ELSE
	UPDATE cfcountry SET cfuri = v_cfuri  WHERE cfcountrycode = v_cfcountrycode;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfevent_fund (v_cfeventid char(128), v_cffundid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfevent_fund WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfevent_fund (cfeventid, cffundid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfeventid, v_cffundid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfevent_fund SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfeventid = v_cfeventid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfclass (v_cfclassid char(128), v_cfclassschemeid char(128), v_cfuri char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfclass WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
	INSERT INTO cfclass (cfclassid, cfclassschemeid, cfuri, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfuri, v_cfstartdate, v_cfenddate);
ELSE
	UPDATE cfclass SET cfuri = v_cfuri, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcaudience (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcaudience WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdcaudience (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdcaudience SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdccontributor (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdccontributor WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdccontributor (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdccontributor SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdccreator (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdccreator WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdccreator (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdccreator SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcrightsholder (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcrightsholder WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdcrightsholder (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdcrightsholder SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfdcsource (v_cfdcid char(32), v_cfdclangtag char(5), v_cfdcscheme char(32), v_cfdctrans char(1), v_cfdctype char(30), v_cfdcvalue text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfdcsource WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdctrans = v_cfdctrans and cfdcscheme = v_cfdcscheme) THEN 
	INSERT INTO cfdcsource (cfdcid, cfdclangtag, cfdcscheme, cfdctrans, cfdctype, cfdcvalue) VALUES (v_cfdcid, v_cfdclangtag, v_cfdcscheme, v_cfdctrans, v_cfdctype, v_cfdcvalue);
ELSE
	UPDATE cfdcsource SET cfdctype = v_cfdctype, cfdcvalue = v_cfdcvalue  WHERE cfdcid = v_cfdcid and cfdclangtag = v_cfdclangtag and cfdcscheme = v_cfdcscheme and cfdctrans = v_cfdctrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfequip_class (v_cfequipid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfequip_class WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfequip_class (cfequipid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfequip_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffund_class (v_cffundid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffund_class WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cffund_class (cffundid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffundid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffund_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocflang (v_cfuri char(128), v_cflangcode char(5)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cflang WHERE cflangcode = v_cflangcode) THEN 
	INSERT INTO cflang (cfuri, cflangcode) VALUES (v_cfuri, v_cflangcode);
ELSE
	UPDATE cflang SET cfuri = v_cfuri  WHERE cflangcode = v_cflangcode;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfgeobbox_class (v_cfgeobboxid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfgeobbox_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfgeobboxid = v_cfgeobboxid) THEN 
		INSERT INTO cfgeobbox_class (cfgeobboxid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfgeobboxid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfgeobbox_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfgeobboxid = v_cfgeobboxid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfindic_indic (v_cfclassname text, v_cfschemename text, v_cfindicid1 char(128), v_cfindicid2 char(128), v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfindic_indic WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfindic_indic (cfclassid, cfclassschemeid, cfindicid1, cfindicid2, cfstartdate, cfenddate) VALUES (v_cfclassid, v_cfclassschemeid, v_cfindicid1, v_cfindicid2, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfindic_indic SET cfindicid1 = v_cfindicid1, cfindicid2 = v_cfindicid2, cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfsrvname (v_cfsrvid char(128), v_cfname char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfsrvname WHERE cftrans = v_cftrans and cflangcode = v_cflangcode and cfsrvid = v_cfsrvid) THEN 
	INSERT INTO cfsrvname (cfsrvid, cfname, cflangcode, cftrans) VALUES (v_cfsrvid, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfsrvname SET cfname = v_cfname  WHERE cfsrvid = v_cfsrvid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfcountryname (v_cfcountrycode char(2), v_cfname char(64), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfcountryname WHERE cfcountrycode = v_cfcountrycode and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfcountryname (cfcountrycode, cfname, cflangcode, cftrans) VALUES (v_cfcountrycode, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfcountryname SET cfname = v_cfname  WHERE cfcountrycode = v_cfcountrycode and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespat_equip (v_cfequipid char(128), v_cfrespatid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespat_equip WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid) THEN 
		INSERT INTO cfrespat_equip (cfequipid, cfrespatid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cfrespatid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespat_equip SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfclassschemeid = v_cfclassschemeid and cfrespatid = v_cfrespatid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_cite (v_cfciteid char(128), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_cite WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfciteid = v_cfciteid and cfrespublid = v_cfrespublid) THEN 
		INSERT INTO cfrespubl_cite (cfciteid, cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfciteid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_cite SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfciteid = v_cfciteid and cfrespublid = v_cfrespublid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocffund_meas (v_cffundid char(128), v_cfmeasid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cffund_meas WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cffund_meas (cffundid, cfmeasid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cffundid, v_cfmeasid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cffund_meas SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cffundid = v_cffundid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_meas (v_cfmeasid char(128), v_cfrespublid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_meas WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid) THEN 
		INSERT INTO cfrespubl_meas (cfmeasid, cfrespublid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmeasid, v_cfrespublid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_meas SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfsrv_medium (v_cfmediumid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfsrv_medium WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cfsrv_medium (cfmediumid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmediumid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfsrv_medium SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfgeobbox_meas (v_cfgeobboxid char(128), v_cfmeasid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfgeobbox_meas WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid and cfgeobboxid = v_cfgeobboxid) THEN 
		INSERT INTO cfgeobbox_meas (cfgeobboxid, cfmeasid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfgeobboxid, v_cfmeasid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfgeobbox_meas SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid and cfgeobboxid = v_cfgeobboxid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfprize_class (v_cfprizeid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfprize_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfprizeid = v_cfprizeid) THEN 
		INSERT INTO cfprize_class (cfprizeid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfprizeid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfprize_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfprizeid = v_cfprizeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfindic_meas (v_cfindicid char(128), v_cfmeasid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfindic_meas WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfindic_meas (cfindicid, cfmeasid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfindicid, v_cfmeasid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfindic_meas SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfmeasid = v_cfmeasid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfprizedescr (v_cfprizeid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfprizedescr WHERE cftrans = v_cftrans and cfprizeid = v_cfprizeid and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfprizedescr (cfprizeid, cfdescr, cflangcode, cftrans) VALUES (v_cfprizeid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfprizedescr SET cfdescr = v_cfdescr  WHERE cfprizeid = v_cfprizeid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfqual_class (v_cfqualid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfqual_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfqualid = v_cfqualid) THEN 
		INSERT INTO cfqual_class (cfqualid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfqualid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfqual_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfqualid = v_cfqualid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfqualdescr (v_cfqualid char(128), v_cfdescr text, v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfqualdescr WHERE cftrans = v_cftrans and cflangcode = v_cflangcode and cfqualid = v_cfqualid) THEN 
	INSERT INTO cfqualdescr (cfqualid, cfdescr, cflangcode, cftrans) VALUES (v_cfqualid, v_cfdescr, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfqualdescr SET cfdescr = v_cfdescr  WHERE cfqualid = v_cfqualid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfqualkeyw (v_cfqualid char(128), v_cfkeyw char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfqualkeyw WHERE cftrans = v_cftrans and cflangcode = v_cflangcode and cfqualid = v_cfqualid) THEN 
	INSERT INTO cfqualkeyw (cfqualid, cfkeyw, cflangcode, cftrans) VALUES (v_cfqualid, v_cfkeyw, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfqualkeyw SET cfkeyw = v_cfkeyw  WHERE cfqualid = v_cfqualid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_class (v_cfresprodid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfresprod_class WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfresprod_class (cfresprodid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfresprod_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfresprod_equip (v_cfequipid char(128), v_cfresprodid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfresprod_equip WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfresprod_equip (cfequipid, cfresprodid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfequipid, v_cfresprodid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfresprod_equip SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfequipid = v_cfequipid and cfresprodid = v_cfresprodid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl_srv (v_cfrespublid char(128), v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfrespubl_srv WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cfrespubl_srv (cfrespublid, cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfrespublid, v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfrespubl_srv SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfrespublid = v_cfrespublid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmeasname (v_cfmeasid char(128), v_cfname char(254), v_cflangcode char(5), v_cftrans char(1)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfmeasname WHERE cfmeasid = v_cfmeasid and cftrans = v_cftrans and cflangcode = v_cflangcode) THEN 
	INSERT INTO cfmeasname (cfmeasid, cfname, cflangcode, cftrans) VALUES (v_cfmeasid, v_cfname, v_cflangcode, v_cftrans);
ELSE
	UPDATE cfmeasname SET cfname = v_cfname  WHERE cfmeasid = v_cfmeasid and cflangcode = v_cflangcode and cftrans = v_cftrans;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfsrv_class (v_cfsrvid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfsrv_class WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid) THEN 
		INSERT INTO cfsrv_class (cfsrvid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfsrvid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfsrv_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfsrvid = v_cfsrvid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmeas (v_cfmeasid char(128), v_cfcountfloatpchange float8, v_cfcountint integer, v_cfcountintchange integer, v_cfdatetime timestamp, v_cfuri char(128), v_cfvalfloatp float8, v_cfvaljudgenum float8, v_cfvaljudgenumchange float8, v_cfvaljudgetext text, v_cfvaljudgetextchange text) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfmeas WHERE cfmeasid = v_cfmeasid) THEN 
	INSERT INTO cfmeas (cfmeasid, cfcountfloatpchange, cfcountint, cfcountintchange, cfdatetime, cfuri, cfvalfloatp, cfvaljudgenum, cfvaljudgenumchange, cfvaljudgetext, cfvaljudgetextchange) VALUES (v_cfmeasid, v_cfcountfloatpchange, v_cfcountint, v_cfcountintchange, v_cfdatetime, v_cfuri, v_cfvalfloatp, v_cfvaljudgenum, v_cfvaljudgenumchange, v_cfvaljudgetext, v_cfvaljudgetextchange);
ELSE
	UPDATE cfmeas SET cfcountfloatpchange = v_cfcountfloatpchange, cfcountint = v_cfcountint, cfcountintchange = v_cfcountintchange, cfdatetime = v_cfdatetime, cfuri = v_cfuri, cfvalfloatp = v_cfvalfloatp, cfvaljudgenum = v_cfvaljudgenum, cfvaljudgenumchange = v_cfvaljudgenumchange, cfvaljudgetext = v_cfvaljudgetext, cfvaljudgetextchange = v_cfvaljudgetextchange  WHERE cfmeasid = v_cfmeasid;
END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmedium_class (v_cfmediumid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfmedium_class WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfmedium_class (cfmediumid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfmediumid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfmedium_class SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfmedium_indic (v_cfindicid char(128), v_cfmediumid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfmedium_indic WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid) THEN 
		INSERT INTO cfmedium_indic (cfindicid, cfmediumid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfindicid, v_cfmediumid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfmedium_indic SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfmediumid = v_cfmediumid and cfclassid = v_cfclassid and cfindicid = v_cfindicid and cfclassschemeid = v_cfclassschemeid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocforgunit_paddr (v_cforgunitid char(128), v_cfpaddrid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cforgunit_paddr WHERE cfclassid = v_cfclassid and cfpaddrid = v_cfpaddrid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid) THEN 
		INSERT INTO cforgunit_paddr (cforgunitid, cfpaddrid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cforgunitid, v_cfpaddrid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cforgunit_paddr SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfpaddrid = v_cfpaddrid and cfclassschemeid = v_cfclassschemeid and cforgunitid = v_cforgunitid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpaddr_geobbox (v_cfgeobboxid char(128), v_cfpaddrid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpaddr_geobbox WHERE cfclassid = v_cfclassid and cfpaddrid = v_cfpaddrid and cfclassschemeid = v_cfclassschemeid and cfgeobboxid = v_cfgeobboxid) THEN 
		INSERT INTO cfpaddr_geobbox (cfgeobboxid, cfpaddrid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfgeobboxid, v_cfpaddrid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpaddr_geobbox SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfpaddrid = v_cfpaddrid and cfclassschemeid = v_cfclassschemeid and cfgeobboxid = v_cfgeobboxid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfpersname_pers (v_cfpersid char(128), v_cfpersnameid char(128), v_cfclassname text, v_cfschemename text, v_cfstartdate timestamp, v_cfenddate timestamp) RETURNS VOID AS $$
DECLARE
	 v_cfclassid varchar(128);
	 v_cfclassschemeid varchar(128);
BEGIN
	SELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;
	IF NOT EXISTS (SELECT * FROM cfpersname_pers WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfpersnameid = v_cfpersnameid) THEN 
		INSERT INTO cfpersname_pers (cfpersid, cfpersnameid, cfclassid, cfclassschemeid, cfstartdate, cfenddate) VALUES (v_cfpersid, v_cfpersnameid, v_cfclassid, v_cfclassschemeid, v_cfstartdate, v_cfenddate);
	ELSE
		UPDATE cfpersname_pers SET cfstartdate = v_cfstartdate, cfenddate = v_cfenddate  WHERE cfclassid = v_cfclassid and cfclassschemeid = v_cfclassschemeid and cfpersid = v_cfpersid and cfpersnameid = v_cfpersnameid;
	END IF;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tocfrespubl (v_cfrespublid char(128), v_cfedition char(8), v_cfendpage char(8), v_cfisbn char(20), v_cfissn char(16), v_cfissue char(8), v_cfnum char(32), v_cfrespubldate date, v_cfseries char(8), v_cfstartpage char(8), v_cftotalpages char(8), v_cfuri char(128), v_cfvol char(3)) RETURNS VOID AS $$
BEGIN
IF NOT EXISTS (SELECT * FROM cfrespubl WHERE cfrespublid = v_cfrespublid) THEN 
	INSERT INTO cfrespubl (cfrespublid, cfedition, cfendpage, cfisbn, cfissn, cfissue, cfnum, cfrespubldate, cfseries, cfstartpage, cftotalpages, cfuri, cfvol) VALUES (v_cfrespublid, v_cfedition, v_cfendpage, v_cfisbn, v_cfissn, v_cfissue, v_cfnum, v_cfrespubldate, v_cfseries, v_cfstartpage, v_cftotalpages, v_cfuri, v_cfvol);
ELSE
	UPDATE cfrespubl SET cfedition = v_cfedition, cfendpage = v_cfendpage, cfisbn = v_cfisbn, cfissn = v_cfissn, cfissue = v_cfissue, cfnum = v_cfnum, cfrespubldate = v_cfrespubldate, cfseries = v_cfseries, cfstartpage = v_cfstartpage, cftotalpages = v_cftotalpages, cfuri = v_cfuri, cfvol = v_cfvol  WHERE cfrespublid = v_cfrespublid;
END IF;
END; 
$$ LANGUAGE plpgsql;


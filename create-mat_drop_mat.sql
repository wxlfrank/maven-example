--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

DROP MATERIALIZED VIEW public.epos_webservice_with_param CASCADE;
DROP MATERIALIZED VIEW public.epos_webservice_param CASCADE;
DROP MATERIALIZED VIEW public.epos_project CASCADE;
DROP MATERIALIZED VIEW public.epos_person_detail CASCADE;
DROP MATERIALIZED VIEW public.epos_person_qualification CASCADE;
DROP MATERIALIZED VIEW public.epos_person_language CASCADE;
DROP MATERIALIZED VIEW public.epos_person_electronic CASCADE;
DROP MATERIALIZED VIEW public.epos_person_address CASCADE;
DROP MATERIALIZED VIEW public.epos_person CASCADE;
DROP MATERIALIZED VIEW public.epos_person_name CASCADE;
DROP MATERIALIZED VIEW public.epos_organisation_detail CASCADE;
DROP MATERIALIZED VIEW public.epos_organisation_project CASCADE;
DROP MATERIALIZED VIEW public.epos_organisation_person CASCADE;
DROP MATERIALIZED VIEW public.epos_organisation_parent CASCADE;
DROP MATERIALIZED VIEW public.epos_organisation_electronic CASCADE;
DROP MATERIALIZED VIEW public.epos_organisation_address CASCADE;
DROP MATERIALIZED VIEW public.epos_organisation CASCADE;
DROP MATERIALIZED VIEW public.epos_organisation_spatial CASCADE;
DROP MATERIALIZED VIEW public.epos_organisation_name CASCADE;
DROP MATERIALIZED VIEW public.epos_organisation_class CASCADE;
DROP MATERIALIZED VIEW public.epos_keywords CASCADE;
DROP MATERIALIZED VIEW public.epos_facility_finances CASCADE;
DROP MATERIALIZED VIEW public.epos_facility CASCADE;
DROP MATERIALIZED VIEW public.epos_facility_top_detail CASCADE;
DROP MATERIALIZED VIEW public.epos_facility_contact CASCADE;
DROP MATERIALIZED VIEW public.epos_facility_class CASCADE;
DROP MATERIALIZED VIEW public.epos_facility_address CASCADE;
DROP MATERIALIZED VIEW public.epos_equipment CASCADE;
DROP MATERIALIZED VIEW public.epos_equipment_meas CASCADE;
DROP MATERIALIZED VIEW public.epos_equipment_main CASCADE;
DROP MATERIALIZED VIEW public.epos_equipment_geo CASCADE;
DROP MATERIALIZED VIEW public.epos_domains CASCADE;
DROP MATERIALIZED VIEW public.epos_webservice_without_param CASCADE;
DROP MATERIALIZED VIEW public.epos_resprod_top_detail CASCADE;
DROP MATERIALIZED VIEW public.epos_resprod_resprod CASCADE;
DROP MATERIALIZED VIEW public.epos_resprod_person CASCADE;
DROP MATERIALIZED VIEW public.epos_resprod_organisation CASCADE;
DROP MATERIALIZED VIEW public.epos_resprod_meas CASCADE;
DROP MATERIALIZED VIEW public.epos_resprod_geoboundary CASCADE;
DROP MATERIALIZED VIEW public.epos_resprod_class CASCADE;
SET search_path = public, pg_catalog;

--
-- Name: epos_resprod_class; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_resprod_class AS
 SELECT aa.cfresprodid,
    aa.cfname AS prodnameortitle,
    rpc.cfstartdate AS start,
    rpc.cfenddate AS "end",
    ct.cfterm AS classterm,
    csn.cfname AS schemename
   FROM (((cfresprodname aa
     JOIN cfresprod_class rpc ON ((aa.cfresprodid = rpc.cfresprodid)))
     JOIN cfclassterm ct ON ((rpc.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)))
  ORDER BY aa.cfresprodid;


ALTER TABLE epos_resprod_class OWNER TO damian;

--
-- Name: epos_resprod_geoboundary; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_resprod_geoboundary AS
 SELECT aa.cfresprodid,
    ab.cfname AS prodnameortitle,
    gb.cfsblat AS minlat,
    gb.cfnblat AS maxlat,
    gb.cfwblong AS minlon,
    gb.cfeblong AS maxlon,
    gb.cfminelev AS minelev,
    gb.cfmaxelev AS maxelev,
    ca.cfterm AS class,
    cb.cfname AS classscheme
   FROM (((((cfresprod aa
     JOIN cfresprodname ab ON ((aa.cfresprodid = ab.cfresprodid)))
     JOIN cfresprod_geobbox ga ON ((ab.cfresprodid = ga.cfresprodid)))
     JOIN cfgeobbox gb ON ((ga.cfgeobboxid = gb.cfgeobboxid)))
     JOIN cfclassterm ca ON (((ga.cfclassid = ca.cfclassid) AND (ga.cfclassschemeid = ca.cfclassschemeid))))
     JOIN cfclassschemename cb ON ((ga.cfclassschemeid = cb.cfclassschemeid)))
  ORDER BY aa.cfresprodid;


ALTER TABLE epos_resprod_geoboundary OWNER TO damian;

--
-- Name: epos_resprod_meas; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_resprod_meas AS
 SELECT aa.cfresprodid,
    aa.cfname AS prodnameortitle,
    m.cfvaljudgetext AS meastext,
    m.cfdatetime AS measdate,
    ct.cfterm AS classterm,
    csn.cfname AS schemename
   FROM ((((cfresprodname aa
     JOIN cfresprod_meas rpm ON ((aa.cfresprodid = rpm.cfresprodid)))
     JOIN cfmeas m ON ((rpm.cfmeasid = m.cfmeasid)))
     JOIN cfclassterm ct ON ((rpm.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)))
  ORDER BY aa.cfresprodid;


ALTER TABLE epos_resprod_meas OWNER TO damian;

--
-- Name: epos_resprod_organisation; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_resprod_organisation AS
 SELECT cfresprod.cfresprodid,
    aa.cfname AS prodnameortitle,
    ourp.cforgunitid,
    oun.cfname AS organisation,
    cn.cfname AS country,
    ct.cfterm AS classterm,
    csn.cfname AS schemename
   FROM ((((((((((cfresprod
     JOIN cfresprodname aa ON ((cfresprod.cfresprodid = aa.cfresprodid)))
     JOIN cforgunit_resprod ourp ON ((ourp.cfresprodid = cfresprod.cfresprodid)))
     JOIN cforgunit_paddr oupa ON ((oupa.cforgunitid = ourp.cforgunitid)))
     JOIN cfpaddr pa ON ((pa.cfpaddrid = oupa.cfpaddrid)))
     JOIN cfclassterm ctpa ON (((oupa.cfclassid = ctpa.cfclassid) AND (ctpa.cfterm = 'Organisation Legal Postal Address'::bpchar))))
     JOIN cfclassschemename csnpa ON ((((oupa.cfclassschemeid = csnpa.cfclassschemeid) AND (csnpa.cfclassschemeid = ctpa.cfclassschemeid)) AND (csnpa.cfname = 'Organisation Contact Details'::text))))
     JOIN cforgunitname oun ON ((ourp.cforgunitid = oun.cforgunitid)))
     JOIN cfcountryname cn ON ((cn.cfcountrycode = pa.cfcountrycode)))
     JOIN cfclassterm ct ON ((ourp.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON (((ourp.cfclassschemeid = csn.cfclassschemeid) AND (csn.cfclassschemeid = ct.cfclassschemeid))))
  ORDER BY cfresprod.cfresprodid;


ALTER TABLE epos_resprod_organisation OWNER TO damian;

--
-- Name: epos_resprod_person; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_resprod_person AS
 SELECT cfresprod.cfresprodid,
    aa.cfname AS prodnameortitle,
    pers.full_name,
    pers.cfpersid,
    ct.cfterm AS classterm,
    csn.cfname AS schemename
   FROM (((((cfresprod
     JOIN cfresprodname aa ON ((cfresprod.cfresprodid = aa.cfresprodid)))
     JOIN cfpers_resprod prp ON ((aa.cfresprodid = prp.cfresprodid)))
     JOIN ( SELECT a.cfpersid,
            rtrim((b.cffamilynames)::text) AS full_name
           FROM ((cfpersname_pers a
             JOIN cfpersname b ON ((a.cfpersnameid = b.cfpersnameid)))
             JOIN cfclassterm ct_1 ON ((ct_1.cfclassid = a.cfclassid)))
          WHERE (rtrim((ct_1.cfterm)::text) = ANY (ARRAY['Formal Name'::text, 'Full Name'::text]))) pers ON ((pers.cfpersid = prp.cfpersid)))
     JOIN cfclassterm ct ON ((prp.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)))
  ORDER BY cfresprod.cfresprodid;


ALTER TABLE epos_resprod_person OWNER TO damian;

--
-- Name: epos_resprod_resprod; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_resprod_resprod AS
 SELECT aa.cfresprodid,
    ab.cfname AS prodnameortitle,
    ba.cfresprodid AS dependentcfresprodid,
    bb.cfname AS dependentprodnameortitle,
    ct.cfterm AS classterm,
    csn.cfname AS schemename,
    aa.cfuri,
    ba.cfuri AS dependentcfresproduri
   FROM ((((((cfresprod aa
     LEFT JOIN cfresprodname ab ON ((aa.cfresprodid = ab.cfresprodid)))
     JOIN cfresprod_resprod ac ON ((aa.cfresprodid = ac.cfresprodid1)))
     JOIN cfresprod ba ON ((ba.cfresprodid = ac.cfresprodid2)))
     LEFT JOIN cfresprodname bb ON ((ba.cfresprodid = bb.cfresprodid)))
     JOIN cfclassterm ct ON ((ac.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ac.cfclassschemeid = csn.cfclassschemeid)));


ALTER TABLE epos_resprod_resprod OWNER TO damian;

--
-- Name: epos_resprod_top_detail; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_resprod_top_detail AS
 SELECT aa.cfresprodid,
    ab.cfname AS prodnameortitle,
    ac.cfdescr AS abstract,
    ad.cfaltname AS alternativename,
    ae.cfversinfo AS versioninfo,
    aa.cfuri
   FROM ((((cfresprod aa
     JOIN cfresprodname ab ON ((aa.cfresprodid = ab.cfresprodid)))
     JOIN cfresproddescr ac ON ((aa.cfresprodid = ac.cfresprodid)))
     LEFT JOIN cfresprodaltname ad ON ((aa.cfresprodid = ad.cfresprodid)))
     LEFT JOIN cfresprodversinfo ae ON ((aa.cfresprodid = ad.cfresprodid)))
  ORDER BY aa.cfresprodid;


ALTER TABLE epos_resprod_top_detail OWNER TO damian;

--
-- Name: epos_webservice_without_param; Type: VIEW; Schema: public; Owner: damian
--

--
-- Name: epos_domains; Type: VIEW; Schema: public; Owner: damian
--
--

-- Name: epos_equipment_geo; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_equipment_geo AS
 SELECT aa.cfequipid,
    m.cfsblat AS latitude,
    m.cfwblong AS longitude,
    m.cfminelev AS elevation
   FROM (((cfequipname aa
     JOIN cfequip_paddr pa ON ((aa.cfequipid = pa.cfequipid)))
     JOIN cfpaddr_geobbox box ON ((pa.cfpaddrid = box.cfpaddrid)))
     JOIN cfgeobbox m ON ((m.cfgeobboxid = box.cfgeobboxid)));


ALTER TABLE epos_equipment_geo OWNER TO damian;

--
-- Name: epos_equipment_main; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_equipment_main AS
 SELECT aa.cfequipid,
    aa.cfacro AS serialnumber,
    ab.cfname AS instrumentname,
    ac.cfdescr AS description,
    ad.cfkeyw AS abbrev,
    oun.cfname AS manufacturer,
    oun.cforgunitid AS manufacturerurn,
    oucf.cfterm AS associationroleclass,
    oucsn.cfname AS associationclassscheme,
    ct.cfterm AS instrumenttypeclass,
    csn.cfname AS instrumenttypeclassscheme,
    aa.cfuri AS urn
   FROM ((((((((((cfequip aa
     JOIN cfequipname ab ON ((aa.cfequipid = ab.cfequipid)))
     LEFT JOIN cfequipdescr ac ON ((aa.cfequipid = ac.cfequipid)))
     LEFT JOIN cfequipkeyw ad ON ((aa.cfequipid = ad.cfequipid)))
     LEFT JOIN cforgunit_equip ae ON ((aa.cfequipid = ae.cfequipid)))
     LEFT JOIN cforgunitname oun ON ((oun.cforgunitid = ae.cforgunitid)))
     LEFT JOIN cfclassterm oucf ON (((ae.cfclassid = oucf.cfclassid) AND (oucf.cfterm = 'Owner'::bpchar))))
     LEFT JOIN cfclassschemename oucsn ON (((oucsn.cfclassschemeid = oucf.cfclassschemeid) AND (oucsn.cfname = 'Organisation Research Infrastructure Roles'::text))))
     JOIN cfequip_class ouc ON ((aa.cfequipid = ouc.cfequipid)))
     JOIN cfclassterm ct ON ((ouc.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON (((ct.cfclassschemeid = csn.cfclassschemeid) AND (csn.cfname = 'EPOS Equipment Types'::text))));


ALTER TABLE epos_equipment_main OWNER TO damian;

--
-- Name: epos_equipment_meas; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_equipment_meas AS
 SELECT aa.cfequipid,
    m.cfcountint AS measint,
    m.cfdatetime AS measdate,
    m.cfvaljudgetext AS meastext,
    ct.cfterm AS classterm,
    csn.cfname AS schemename
   FROM ((((cfequipname aa
     JOIN cfequip_meas rpm ON ((aa.cfequipid = rpm.cfequipid)))
     JOIN cfmeas m ON ((rpm.cfmeasid = m.cfmeasid)))
     JOIN cfclassterm ct ON ((rpm.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON (((ct.cfclassschemeid = csn.cfclassschemeid) AND (csn.cfname = 'EPOS Equipment Details'::text))));


ALTER TABLE epos_equipment_meas OWNER TO damian;

--
-- Name: epos_equipment; Type: VIEW; Schema: public; Owner: damian
--
--
-- Name: epos_facility_address; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_facility_address AS
 SELECT aa.cffacilid,
    aa.cfname AS name,
    ct.cfterm AS classterm,
    csn.cfname AS schemename,
    ((((rtrim((pa.cfaddrline2)::text) || ', '::text) || rtrim((pa.cfcitytown)::text)) || ', '::text) || rtrim((pa.cfpostcode)::text)) AS paddress,
    cn.cfname AS country
   FROM ((((((cffacilname aa
     JOIN cffacil_paddr fpa ON ((fpa.cffacilid = aa.cffacilid)))
     JOIN cfpaddr pa ON ((pa.cfpaddrid = fpa.cfpaddrid)))
     JOIN cffacilname oun ON ((fpa.cffacilid = oun.cffacilid)))
     JOIN cfclassterm ct ON ((fpa.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)))
     JOIN cfcountryname cn ON ((cn.cfcountrycode = pa.cfcountrycode)));


ALTER TABLE epos_facility_address OWNER TO damian;

--
-- Name: epos_facility_class; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_facility_class AS
 SELECT aa.cffacilid,
    ab.cfname AS name,
    ct.cfterm AS class,
    csn.cfname AS classscheme
   FROM ((((cffacil aa
     JOIN cffacilname ab ON ((aa.cffacilid = ab.cffacilid)))
     JOIN cffacil_class ouc ON ((aa.cffacilid = ouc.cffacilid)))
     JOIN cfclassterm ct ON ((ouc.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)));


ALTER TABLE epos_facility_class OWNER TO damian;

--
-- Name: epos_facility_contact; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_facility_contact AS
 SELECT aa.cffacilid,
    ab.cfname AS title,
    pers.cfpersid AS personid,
    pers.full_name,
    pers.familyname,
    pers.firstname,
    ca.cfterm AS class,
    cb.cfname AS classscheme
   FROM (((((cffacil aa
     JOIN cffacilname ab ON ((aa.cffacilid = ab.cffacilid)))
     JOIN cfpers_facil pa ON ((pa.cffacilid = aa.cffacilid)))
     JOIN ( SELECT a.cfpersid,
            ((rtrim((b.cffamilynames)::text) || ', '::text) || rtrim((b.cffirstnames)::text)) AS full_name,
            b.cffamilynames AS familyname,
            b.cffirstnames AS firstname
           FROM ((cfpersname_pers a
             JOIN cfpersname b ON ((a.cfpersnameid = b.cfpersnameid)))
             JOIN cfclassterm ct_1 ON ((ct_1.cfclassid = a.cfclassid)))
          WHERE (rtrim((ct_1.cfterm)::text) = 'Formal Name'::text)) pers ON ((pers.cfpersid = pa.cfpersid)))
     JOIN cfclassterm ca ON (((pa.cfclassid = ca.cfclassid) AND (pa.cfclassschemeid = ca.cfclassschemeid))))
     JOIN cfclassschemename cb ON ((pa.cfclassschemeid = cb.cfclassschemeid)));


ALTER TABLE epos_facility_contact OWNER TO damian;

--
-- Name: epos_facility_top_detail; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_facility_top_detail AS
 SELECT aa.cffacilid,
    ab.cfname AS name,
    ac.cfdescr AS description,
    ad.cfkeyw AS abbrev,
    oun.cforgunitid AS organisationid,
    oun.cfname AS organisation,
    oucf.cfterm AS organisationroleclass,
    oucsn.cfname AS organisationclassscheme,
    aa.cfuri AS url
   FROM (((((((cffacil aa
     JOIN cffacilname ab ON ((aa.cffacilid = ab.cffacilid)))
     LEFT JOIN cffacildescr ac ON ((aa.cffacilid = ac.cffacilid)))
     LEFT JOIN cffacilkeyw ad ON ((aa.cffacilid = ad.cffacilid)))
     LEFT JOIN cforgunit_facil ae ON ((aa.cffacilid = ae.cffacilid)))
     LEFT JOIN cforgunitname oun ON ((oun.cforgunitid = ae.cforgunitid)))
     LEFT JOIN cfclassterm oucf ON ((ae.cfclassid = oucf.cfclassid)))
     LEFT JOIN cfclassschemename oucsn ON ((oucf.cfclassschemeid = oucsn.cfclassschemeid)));


ALTER TABLE epos_facility_top_detail OWNER TO damian;

--
-- Name: epos_facility; Type: VIEW; Schema: public; Owner: damian
--
--
-- Name: epos_facility_finances; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_facility_finances AS
 SELECT aa.cffacilid,
    aa.cfname AS title,
    f.cfamount AS amountvalue,
    c.cfname AS amountname,
    ct.cfterm AS classterm,
    csn.cfname AS schemename
   FROM (((((cffacilname aa
     JOIN cffacil_fund rpm ON ((aa.cffacilid = rpm.cffacilid)))
     JOIN cffund f ON ((rpm.cffundid = f.cffundid)))
     JOIN cfcurrencyname c ON ((c.cfcurrcode = f.cfcurrcode)))
     JOIN cfclassterm ct ON ((rpm.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)));


ALTER TABLE epos_facility_finances OWNER TO damian;

--
-- Name: epos_keywords; Type: VIEW; Schema: public; Owner: damian
--

--
-- Name: epos_organisation_class; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_organisation_class AS
 SELECT aa.cforgunitid,
    ct.cfterm AS class,
    csn.cfname AS scheme
   FROM (((cforgunit aa
     JOIN cforgunit_class pe ON ((aa.cforgunitid = pe.cforgunitid)))
     JOIN cfclassterm ct ON ((pe.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)));


ALTER TABLE epos_organisation_class OWNER TO damian;

--
-- Name: epos_organisation_name; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_organisation_name AS
 SELECT aa.cforgunitid,
    ou.cfname AS name,
    oualt.cfname AS nativename
   FROM ((cforgunit aa
     JOIN cforgunitname ou ON (((ou.cforgunitid = aa.cforgunitid) AND (ou.cflangcode = ANY (ARRAY['en'::bpchar, 'EN'::bpchar])))))
     LEFT JOIN cforgunitname oualt ON (((oualt.cforgunitid = aa.cforgunitid) AND (oualt.cflangcode <> ALL (ARRAY['en'::bpchar, 'EN'::bpchar])))));


ALTER TABLE epos_organisation_name OWNER TO damian;

--
-- Name: epos_organisation_spatial; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_organisation_spatial AS
 SELECT aa.cforgunitid,
    geo.cfwblong AS longitude,
    geo.cfsblat AS latitude,
    geo.cfminelev AS elevation,
    ct.cfterm AS class,
    csn.cfname AS scheme
   FROM (((((cforgunit aa
     JOIN cforgunit_paddr pp ON ((aa.cforgunitid = pp.cforgunitid)))
     JOIN cfpaddr_geobbox pageo ON ((pageo.cfpaddrid = pp.cfpaddrid)))
     JOIN cfgeobbox geo ON ((geo.cfgeobboxid = pageo.cfgeobboxid)))
     JOIN cfclassterm ct ON ((pageo.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)));


ALTER TABLE epos_organisation_spatial OWNER TO damian;

--
-- Name: epos_organisation; Type: VIEW; Schema: public; Owner: damian
--


--
-- Name: epos_organisation_address; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_organisation_address AS
 SELECT aa.cforgunitid,
    pa.cfaddrline1 AS street,
    pa.cfaddrline2 AS locality,
    pa.cfpostcode AS postcode,
    countryname.cfname AS country,
    ct.cfterm AS class,
    csn.cfname AS scheme
   FROM (((((cforgunit aa
     JOIN cforgunit_paddr pp ON ((aa.cforgunitid = pp.cforgunitid)))
     JOIN cfpaddr pa ON ((pa.cfpaddrid = pp.cfpaddrid)))
     JOIN cfcountryname countryname ON ((pa.cfcountrycode = countryname.cfcountrycode)))
     JOIN cfclassterm ct ON ((pp.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)));


ALTER TABLE epos_organisation_address OWNER TO damian;

--
-- Name: epos_organisation_electronic; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_organisation_electronic AS
 SELECT aa.cforgunitid,
    ea.cfuri AS uri,
    ct.cfterm AS class,
    csn.cfname AS scheme
   FROM ((((cforgunit aa
     JOIN cforgunit_eaddr pe ON ((aa.cforgunitid = pe.cforgunitid)))
     JOIN cfeaddr ea ON ((ea.cfeaddrid = pe.cfeaddrid)))
     JOIN cfclassterm ct ON ((pe.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)));


ALTER TABLE epos_organisation_electronic OWNER TO damian;

--
-- Name: epos_organisation_parent; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_organisation_parent AS
 SELECT aa.cforgunitid,
    parent.cforgunitid AS parentid,
    parent.cfname AS parentname,
    ct.cfterm AS class,
    csn.cfname AS scheme
   FROM ((((cforgunit aa
     JOIN cforgunit_orgunit pp ON ((aa.cforgunitid = pp.cforgunitid2)))
     JOIN cforgunitname parent ON ((parent.cforgunitid = pp.cforgunitid1)))
     JOIN cfclassterm ct ON ((pp.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)));


ALTER TABLE epos_organisation_parent OWNER TO damian;

--
-- Name: epos_organisation_person; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_organisation_person AS
 SELECT aa.cforgunitid,
    oun.cfname AS organame,
    pou.cfpersid,
    cfpersname.cffamilynames AS personfullname,
    nct.cfterm AS nameclass,
    ncsn.cfname AS namescheme,
    rct.cfterm AS roleclass,
    rcsn.cfname AS rolescheme
   FROM ((((((((cforgunit aa
     JOIN cforgunitname oun ON ((aa.cforgunitid = oun.cforgunitid)))
     JOIN cfpers_orgunit pou ON ((aa.cforgunitid = pou.cforgunitid)))
     JOIN cfpersname_pers pn ON ((pn.cfpersid = pou.cfpersid)))
     JOIN cfpersname ON ((pn.cfpersnameid = cfpersname.cfpersnameid)))
     JOIN cfclassterm rct ON ((pou.cfclassid = rct.cfclassid)))
     JOIN cfclassschemename rcsn ON ((rct.cfclassschemeid = rcsn.cfclassschemeid)))
     JOIN cfclassterm nct ON ((pn.cfclassid = nct.cfclassid)))
     JOIN cfclassschemename ncsn ON ((nct.cfclassschemeid = ncsn.cfclassschemeid)));


ALTER TABLE epos_organisation_person OWNER TO damian;

--
-- Name: epos_organisation_project; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_organisation_project AS
 SELECT aa.cforgunitid,
    pt.cfprojid AS projectid,
    pt.cftitle AS projectname,
    ct.cfterm AS class,
    csn.cfname AS scheme
   FROM ((((cforgunit aa
     JOIN cfproj_orgunit pp ON ((aa.cforgunitid = pp.cforgunitid)))
     JOIN cfprojtitle pt ON ((pt.cfprojid = aa.cforgunitid)))
     JOIN cfclassterm ct ON ((pp.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)));


ALTER TABLE epos_organisation_project OWNER TO damian;

--
-- Name: epos_organisation_detail; Type: VIEW; Schema: public; Owner: damian
--


--
-- Name: epos_person_name; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_person_name AS
 SELECT aa.cfpersid,
    ac.cffamilynames AS fullname,
    ac.cffamilynames,
    ac.cffirstnames,
    ac.cfothernames,
    ct.cfterm AS classterm,
    csn.cfname AS schemename
   FROM ((((cfpers aa
     JOIN cfpersname_pers ab ON ((aa.cfpersid = ab.cfpersid)))
     JOIN cfpersname ac ON ((ab.cfpersnameid = ac.cfpersnameid)))
     JOIN cfclassterm ct ON ((ct.cfclassid = ab.cfclassid)))
     JOIN cfclassschemename csn ON ((csn.cfclassschemeid = ct.cfclassschemeid)));


ALTER TABLE epos_person_name OWNER TO damian;

--
-- Name: epos_person; Type: VIEW; Schema: public; Owner: damian
--
--
-- Name: epos_person_address; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_person_address AS
 SELECT aa.cfpersid,
    pa.cfaddrline1 AS street,
    pa.cfaddrline2 AS locality,
    pa.cfpostcode AS postcode,
    countryname.cfname AS country,
    ct.cfterm AS class,
    csn.cfname AS scheme
   FROM (((((cfpers aa
     JOIN cfpers_paddr pp ON ((aa.cfpersid = pp.cfpersid)))
     JOIN cfpaddr pa ON ((pa.cfpaddrid = pp.cfpaddrid)))
     JOIN cfcountryname countryname ON ((pa.cfcountrycode = countryname.cfcountrycode)))
     JOIN cfclassterm ct ON ((pp.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)));


ALTER TABLE epos_person_address OWNER TO damian;

--
-- Name: epos_person_electronic; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_person_electronic AS
 SELECT aa.cfpersid,
    ea.cfuri AS uri,
    ct.cfterm AS class,
    csn.cfname AS scheme
   FROM ((((cfpers aa
     JOIN cfpers_eaddr pe ON ((aa.cfpersid = pe.cfpersid)))
     JOIN cfeaddr ea ON ((ea.cfeaddrid = pe.cfeaddrid)))
     JOIN cfclassterm ct ON ((pe.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)));


ALTER TABLE epos_person_electronic OWNER TO damian;

--
-- Name: epos_person_language; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_person_language AS
 SELECT a.cfpersid,
    b.cflangcode,
    ct.cfterm AS classterm,
    csn.cfname AS schemename
   FROM (((cfpers a
     JOIN cfpers_lang b ON ((a.cfpersid = b.cfpersid)))
     JOIN cfclassterm ct ON ((b.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)));


ALTER TABLE epos_person_language OWNER TO damian;

--
-- Name: epos_person_qualification; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_person_qualification AS
 SELECT a.cfpersid,
    qt.cftitle AS qualification,
    ct.cfterm AS classterm,
    csn.cfname AS schemename
   FROM ((((cfpers a
     JOIN cfpers_qual b ON ((a.cfpersid = b.cfpersid)))
     JOIN cfqualtitle qt ON ((qt.cfqualid = b.cfqualid)))
     JOIN cfclassterm ct ON ((b.cfclassid = ct.cfclassid)))
     JOIN cfclassschemename csn ON ((ct.cfclassschemeid = csn.cfclassschemeid)));


ALTER TABLE epos_person_qualification OWNER TO damian;

--
-- Name: epos_person_detail; Type: VIEW; Schema: public; Owner: damian
--


--
-- Name: epos_project; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_project AS
 SELECT a.cfprojid,
    b.cftitle AS name,
    c.cfabstr AS description
   FROM ((cfproj a
     JOIN cfprojtitle b ON ((a.cfprojid = b.cfprojid)))
     LEFT JOIN cfprojabstr c ON ((a.cfprojid = c.cfprojid)));


ALTER TABLE epos_project OWNER TO damian;

--
-- Name: epos_webservice_param; Type: VIEW; Schema: public; Owner: damian
--

CREATE MATERIALIZED VIEW  epos_webservice_param AS
 SELECT aa.cfresprodid,
    ab.cfname AS prodnameortitle,
    ad.cfvaljudgetext AS measure,
    ad.cfmeasid,
    af.cfvaljudgetext AS relatedmeasure,
    ah.cfname AS classscheme,
    ag.cfterm
   FROM (((((((cfresprod aa
     JOIN cfresprodname ab ON ((aa.cfresprodid = ab.cfresprodid)))
     JOIN cfresprod_meas ac ON ((aa.cfresprodid = ac.cfresprodid)))
     JOIN cfmeas ad ON ((ac.cfmeasid = ad.cfmeasid)))
     JOIN cfmeas_meas ae ON ((ad.cfmeasid = ae.cfmeasd1)))
     JOIN cfmeas af ON ((ae.cfmeasid2 = af.cfmeasid)))
     JOIN cfclassterm ag ON ((ae.cfclassid = ag.cfclassid)))
     JOIN cfclassschemename ah ON ((ae.cfclassschemeid = ah.cfclassschemeid)));


ALTER TABLE epos_webservice_param OWNER TO damian;

-- carlo

--
-- Name: epos_webservice_with_param; Type: VIEW; Schema: public; Owner: damian
--


--
-- PostgreSQL database dump complete
--
CREATE MATERIALIZED VIEW  epos_webservice_without_param AS
SELECT aa.prodnameortitle AS title,
   aa.abstract AS description,
   published.start AS published,
   modified.start AS modified,
   accessanduserestriction.classterm AS accessanduserestriction,
   aa.cfuri AS uri,
   format.classterm AS format,
   publicaccesslimit.meastext AS publicaccesslimit,
   srs.classterm AS spatialreferencesystem,
   aa.cfresprodid AS webserviceid,
   created.start AS created,
   wsdomain.classterm AS domain,
   wssubdomain.classterm AS subdomain,
   keyword.cfkeyw AS keyword,
   operation.classterm AS operation,
   version.meastext AS version,
   documentation.dependentcfresproduri AS documentation,
   contact.cfpersid AS contactid,
   publisher.cforgunitid AS publisherid,
   geo.minlat AS latitude_min,
   geo.maxlat AS latitude_max,
   geo.minlon AS longitude_min,
   geo.maxlon AS longitude_max,
   geo.minelev AS elevation_min,
   geo.maxelev AS elevation_max,
   srt.classterm AS spatialrepresentation,
   temporalstartdate.measdate AS temporalstartdate,
   temporalenddate.measdate AS temporalenddate,
   ddssid.meastext AS ddssid,
   action.classterm AS action
  FROM epos_resprod_top_detail aa
    JOIN epos_resprod_class ac ON ac.cfresprodid = aa.cfresprodid AND ac.classterm = 'Webservice'::bpchar AND ac.schemename = 'EPOS Result Product Types'::text
    LEFT JOIN epos_resprod_class published ON published.cfresprodid = aa.cfresprodid AND published.classterm = 'Publication'::bpchar AND published.schemename = 'EPOS Dates'::text
    LEFT JOIN epos_resprod_class modified ON modified.cfresprodid = aa.cfresprodid AND modified.classterm = 'Revision'::bpchar AND modified.schemename = 'EPOS Dates'::text
    LEFT JOIN epos_resprod_class accessanduserestriction ON accessanduserestriction.cfresprodid = aa.cfresprodid AND accessanduserestriction.schemename = 'Access and Use Restrictions'::text
    LEFT JOIN epos_resprod_class format ON format.cfresprodid = aa.cfresprodid AND format.schemename = 'Distribution Format'::text
    LEFT JOIN epos_resprod_meas publicaccesslimit ON publicaccesslimit.cfresprodid = aa.cfresprodid AND publicaccesslimit.classterm = 'Public Access Limit'::bpchar AND publicaccesslimit.schemename = 'Reuse Information'::text
    LEFT JOIN epos_resprod_class srs ON srs.cfresprodid = aa.cfresprodid AND srs.schemename = 'Spatial Reference System'::text
    LEFT JOIN epos_resprod_class created ON created.cfresprodid = aa.cfresprodid AND created.classterm = 'Creation'::bpchar AND created.schemename = 'EPOS Dates'::text
    LEFT JOIN epos_resprod_class wsdomain ON wsdomain.cfresprodid = aa.cfresprodid AND wsdomain.schemename = 'EPOS Domain'::text
    LEFT JOIN epos_resprod_class wssubdomain ON wssubdomain.cfresprodid = aa.cfresprodid AND wssubdomain.schemename = 'EPOS Subdomain'::text
    LEFT JOIN cfresprodkeyw keyword ON keyword.cfresprodid = aa.cfresprodid
    LEFT JOIN epos_resprod_class operation ON operation.cfresprodid = aa.cfresprodid AND operation.schemename = 'EPOS Webservice Operations'::text
    LEFT JOIN epos_resprod_meas version ON version.cfresprodid = aa.cfresprodid AND version.classterm = 'Webservice Version'::bpchar AND version.schemename = 'Reuse Information'::text
    LEFT JOIN epos_resprod_resprod documentation ON documentation.cfresprodid = aa.cfresprodid AND documentation.classterm = 'Documentation'::bpchar AND documentation.schemename = 'Reuse Information'::text
    LEFT JOIN epos_resprod_person contact ON contact.cfresprodid = aa.cfresprodid AND contact.classterm = 'Contact'::bpchar AND contact.schemename = 'Person Output Contributions'::text
    LEFT JOIN epos_resprod_organisation publisher ON publisher.cfresprodid = aa.cfresprodid AND publisher.classterm = 'Publisher'::bpchar AND publisher.schemename = 'Organisation Output Roles'::text
    LEFT JOIN epos_resprod_geoboundary geo ON geo.cfresprodid = aa.cfresprodid
    LEFT JOIN epos_resprod_class srt ON srt.cfresprodid = aa.cfresprodid AND srt.schemename = 'Spatial Representation Type'::text
    LEFT JOIN epos_resprod_meas temporalstartdate ON temporalstartdate.cfresprodid = aa.cfresprodid AND temporalstartdate.classterm = 'Start Date'::bpchar AND temporalstartdate.schemename = 'EPOS Temporal Extent'::text
    LEFT JOIN epos_resprod_meas temporalenddate ON temporalenddate.cfresprodid = aa.cfresprodid AND temporalenddate.classterm = 'End Date'::bpchar AND temporalenddate.schemename = 'EPOS Temporal Extent'::text
    LEFT JOIN epos_resprod_meas ddssid ON ddssid.cfresprodid = aa.cfresprodid AND ddssid.classterm='DDSSID' AND ddssid.schemename='Charting Information'
    LEFT JOIN epos_resprod_class action ON action.cfresprodid = aa.cfresprodid AND action.schemename = 'EPOS Webservice Actions';


ALTER TABLE epos_webservice_without_param OWNER TO damian;

CREATE MATERIALIZED VIEW  epos_webservice_with_param AS
SELECT *
  FROM epos_webservice_without_param
    JOIN epos_webservice_param ON epos_webservice_without_param.webserviceid = epos_webservice_param.cfresprodid;

ALTER TABLE epos_webservice_with_param OWNER TO damian;


CREATE MATERIALIZED VIEW  epos_domains AS
 SELECT epos_webservice_without_param.domain,
    epos_webservice_without_param.subdomain
   FROM epos_webservice_without_param;


ALTER TABLE epos_domains OWNER TO damian;


CREATE MATERIALIZED VIEW  epos_equipment AS
 SELECT aa.cfequipid,
    aa.urn,
    aa.serialnumber,
    aa.instrumentname,
    aa.manufacturer,
    aa.manufacturerurn,
    aa.description,
    aa.instrumenttypeclass AS equiptype,
    ab.measdate AS validfrom,
    ac.measdate AS validto,
    ad.measint AS quantity,
    geo.latitude AS locationlat,
    geo.longitude AS locationlon,
    geo.elevation AS locationelev
   FROM ((((epos_equipment_main aa
     LEFT JOIN epos_equipment_meas ab ON (((aa.cfequipid = ab.cfequipid) AND (ab.classterm = 'validFrom'::bpchar))))
     LEFT JOIN epos_equipment_meas ac ON (((aa.cfequipid = ac.cfequipid) AND (ac.classterm = 'validTo'::bpchar))))
     LEFT JOIN epos_equipment_meas ad ON (((aa.cfequipid = ad.cfequipid) AND (ad.classterm = 'quantity'::bpchar))))
     LEFT JOIN epos_equipment_geo geo ON ((aa.cfequipid = geo.cfequipid)));


ALTER TABLE epos_equipment OWNER TO damian;


CREATE MATERIALIZED VIEW  epos_facility AS
 SELECT top.cffacilid,
    top.name,
    top.description,
    top.organisationid,
    top.organisation AS organisationname,
    top.organisationroleclass,
    top.organisationclassscheme AS organisationroleclassscheme,
    addr.country,
    contact.personid AS contactid,
    contact.firstname AS contactfirstname,
    contact.familyname AS contactfamilyname,
    manager.personid AS managerid,
    manager.firstname AS managerfirstname,
    manager.familyname AS managerfamilyname,
    ftype.class AS type,
    ftype.classscheme AS typescheme,
    fdomain.class AS domainclass,
    fdomain.classscheme AS domainscheme,
    top.url,
    facaddr.cfpaddrid,
    addrbox.cfgeobboxid,
    bbox.cfeblong AS locationlon,
    bbox.cfsblat AS locationlat,
    bbox.cfmaxelev AS locationelev
   FROM ((((((((epos_facility_top_detail top
     LEFT JOIN epos_facility_class ftype ON (((top.cffacilid = ftype.cffacilid) AND (ftype.class = 'orgunittype'::bpchar))))
     LEFT JOIN epos_facility_class fdomain ON (((top.cffacilid = fdomain.cffacilid) AND (fdomain.class = 'sciencedomain'::bpchar))))
     LEFT JOIN epos_facility_contact contact ON (((top.cffacilid = contact.cffacilid) AND (lower((contact.class)::text) = ('contact'::bpchar)::text))))
     LEFT JOIN epos_facility_contact manager ON (((top.cffacilid = manager.cffacilid) AND (lower((contact.class)::text) = ('manager'::bpchar)::text))))
     LEFT JOIN epos_facility_address addr ON ((top.cffacilid = addr.cffacilid)))
     LEFT JOIN cffacil_paddr facaddr ON ((top.cffacilid = facaddr.cffacilid)))
     LEFT JOIN cfpaddr_geobbox addrbox ON ((facaddr.cfpaddrid = addrbox.cfpaddrid)))
     LEFT JOIN cfgeobbox bbox ON ((addrbox.cfgeobboxid = bbox.cfgeobboxid)));


ALTER TABLE epos_facility OWNER TO damian;


CREATE MATERIALIZED VIEW  epos_keywords AS
 SELECT epos_webservice_without_param.keyword
   FROM epos_webservice_without_param;


ALTER TABLE epos_keywords OWNER TO damian;

CREATE MATERIALIZED VIEW  epos_organisation AS
 SELECT DISTINCT ON (aa.cforgunitid)   aa.name,
    aa.nativename,
    addr.street,
    addr.locality,
    addr.postcode,
    addr.country,
    email.uri as email,
    website.uri as website,
    phone.uri as phone,
    logo.uri as logo,
    aa.cforgunitid as identifier,
    scientific.cfpersid AS scientificcontact,
    spatial.latitude,
    spatial.longitude,
    spatial.elevation,
    orgatype.class as orgatype,
    legal.cfpersid AS legalcontact,
    financial.cfpersid as fincancialcontact,
    parent.cforgunitid AS parentid,
    project.projectid
   FROM  epos_organisation_name aa
LEFT JOIN epos_organisation_address addr ON aa.cforgunitid=addr.cforgunitid AND addr.scheme = 'Organisation Contact Details'::text
LEFT JOIN epos_organisation_electronic email ON email.cforgunitid=aa.cforgunitid AND email.class='Email' AND email.scheme='Organisation Contact Details'
LEFT JOIN epos_organisation_electronic website ON website.cforgunitid=aa.cforgunitid AND website.class='Website' AND website.scheme='Organisation Contact Details'
LEFT JOIN epos_organisation_electronic phone ON phone.cforgunitid=aa.cforgunitid AND phone.class='Phone' AND phone.scheme='Organisation Contact Details'
LEFT JOIN epos_organisation_electronic logo ON logo.cforgunitid=aa.cforgunitid AND logo.class='Logo' AND logo.scheme='Organisation Contact Details'
LEFT JOIN epos_organisation_person scientific ON scientific.cforgunitid=aa.cforgunitid AND scientific.roleclass='Scientific Contact' AND scientific.rolescheme='Organisation Contact Details'
LEFT JOIN epos_organisation_spatial spatial ON spatial.cforgunitid=aa.cforgunitid
LEFT JOIN epos_organisation_class orgatype ON orgatype.cforgunitid=aa.cforgunitid AND orgatype.scheme='Organisation Types'
LEFT JOIN epos_organisation_person legal ON legal.cforgunitid=addr.cforgunitid AND legal.roleclass='Legal Contact' AND legal.rolescheme='Organisation Contact Details'
LEFT JOIN epos_organisation_person financial ON financial.cforgunitid=aa.cforgunitid AND financial.roleclass='Financial Contact' AND financial.rolescheme='Organisation Contact Details'
LEFT JOIN epos_organisation_parent parent ON parent.cforgunitid=aa.cforgunitid
LEFT JOIN epos_organisation_project project ON project.cforgunitid=aa.cforgunitid;
ALTER TABLE epos_organisation OWNER TO damian;


CREATE MATERIALIZED VIEW  epos_organisation_detail AS
 SELECT aa.name,
    aa.nativename,
    addr.street,
    addr.locality,
    addr.postcode,
    addr.country,
    email.uri AS email,
    website.uri AS website,
    phone.uri AS phone,
    logo.uri AS logo,
    aa.cforgunitid AS identifier,
    scientific.cfpersid AS scientificcontact,
    spatial.latitude,
    spatial.longitude,
    spatial.elevation,
    orgatype.class AS orgatype,
    legal.cfpersid AS legalcontact,
    financial.cfpersid AS fincancialcontact,
    parent.cforgunitid AS parentid,
    project.projectid
   FROM ((((((((((((epos_organisation_name aa
     LEFT JOIN epos_organisation_address addr ON (((aa.cforgunitid = addr.cforgunitid) AND (addr.scheme = 'Organisation Contact Details'::text))))
     LEFT JOIN epos_organisation_electronic email ON ((((email.cforgunitid = aa.cforgunitid) AND (email.class = 'Email'::bpchar)) AND (email.scheme = 'Organisation Contact Details'::text))))
     LEFT JOIN epos_organisation_electronic website ON ((((website.cforgunitid = aa.cforgunitid) AND (website.class = 'Website'::bpchar)) AND (website.scheme = 'Organisation Contact Details'::text))))
     LEFT JOIN epos_organisation_electronic phone ON ((((phone.cforgunitid = aa.cforgunitid) AND (phone.class = 'Phone'::bpchar)) AND (phone.scheme = 'Organisation Contact Details'::text))))
     LEFT JOIN epos_organisation_electronic logo ON ((((logo.cforgunitid = aa.cforgunitid) AND (logo.class = 'Logo'::bpchar)) AND (logo.scheme = 'Organisation Contact Details'::text))))
     JOIN epos_organisation_person scientific ON ((((scientific.cforgunitid = aa.cforgunitid) AND (scientific.roleclass = 'Scientific Contact'::bpchar)) AND (scientific.rolescheme = 'Organisation Contact Details'::text))))
     LEFT JOIN epos_organisation_spatial spatial ON ((spatial.cforgunitid = aa.cforgunitid)))
     LEFT JOIN epos_organisation_class orgatype ON (((orgatype.cforgunitid = aa.cforgunitid) AND (orgatype.scheme = 'Organisation Types'::text))))
     JOIN epos_organisation_person legal ON ((((legal.cforgunitid = addr.cforgunitid) AND (legal.roleclass = 'Legal Contact'::bpchar)) AND (legal.rolescheme = 'Organisation Contact Details'::text))))
     JOIN epos_organisation_person financial ON ((((financial.cforgunitid = aa.cforgunitid) AND (financial.roleclass = 'Financial Contact'::bpchar)) AND (financial.rolescheme = 'Organisation Contact Details'::text))))
     LEFT JOIN epos_organisation_parent parent ON ((parent.cforgunitid = aa.cforgunitid)))
     LEFT JOIN epos_organisation_project project ON ((project.cforgunitid = aa.cforgunitid)));
ALTER TABLE epos_organisation_detail OWNER TO damian;


CREATE MATERIALIZED VIEW  epos_person AS
SELECT a.fullname,
   addr.street,
   addr.locality,
   addr.postcode,
   addr.country,
   email.uri AS email,
   phone.uri AS phone,
   a.cfpersid AS identifier,
   employee.cforgunitid AS affiliation,
   lang.cflangcode AS language,
   qual.qualification,
   cv.uri AS cv
  FROM ((((((((cfpers
    JOIN epos_person_name a ON ((((a.cfpersid = cfpers.cfpersid) AND (a.classterm = 'Full Name'::bpchar)) AND (a.schemename = 'Person Names'::text))))
    LEFT JOIN epos_person_address addr ON ((a.cfpersid = addr.cfpersid)))
    LEFT JOIN epos_person_electronic email ON ((((a.cfpersid = email.cfpersid) AND (email.class = 'Email'::bpchar)) AND (email.scheme = 'Person Contact Details'::text))))
    LEFT JOIN epos_person_electronic phone ON ((((a.cfpersid = email.cfpersid) AND (email.class = 'Phone'::bpchar)) AND (email.scheme = 'Person Contact Details'::text))))
    LEFT JOIN epos_organisation_person employee ON ((((a.cfpersid = employee.cfpersid) AND (employee.roleclass = 'Employee'::bpchar)) AND (employee.rolescheme = 'Organisation Contact Details'::text))))
    LEFT JOIN epos_person_language lang ON ((((a.cfpersid = lang.cfpersid) AND (lang.classterm = 'Language'::bpchar)) AND (lang.schemename = 'Person Skills'::text))))
    LEFT JOIN epos_person_qualification qual ON ((((a.cfpersid = qual.cfpersid) AND (qual.classterm = 'Qualification'::bpchar)) AND (qual.schemename = 'Person Skills'::text))))
    LEFT JOIN epos_person_electronic cv ON ((((a.cfpersid = cv.cfpersid) AND (email.class = 'Curriculum Vitae'::bpchar)) AND (email.scheme = 'Person Contact Details'::text))));
ALTER TABLE epos_person OWNER TO damian;


CREATE MATERIALIZED VIEW  epos_person_detail AS
 SELECT a.fullname,
    addr.street,
    addr.locality,
    addr.postcode,
    addr.country,
    email.uri AS email,
    phone.uri AS phone,
    a.cfpersid AS identifier,
    employee.cforgunitid AS affiliation,
    lang.cflangcode AS language,
    qual.qualification,
    cv.uri AS cv
   FROM ((((((((cfpers
     JOIN epos_person_name a ON ((((a.cfpersid = cfpers.cfpersid) AND (a.classterm = 'Full Name'::bpchar)) AND (a.schemename = 'Person Names'::text))))
     LEFT JOIN epos_person_address addr ON ((a.cfpersid = addr.cfpersid)))
     LEFT JOIN epos_person_electronic email ON ((((a.cfpersid = email.cfpersid) AND (email.class = 'Email'::bpchar)) AND (email.scheme = 'Person Contact Details'::text))))
     LEFT JOIN epos_person_electronic phone ON ((((a.cfpersid = email.cfpersid) AND (email.class = 'Phone'::bpchar)) AND (email.scheme = 'Person Contact Details'::text))))
     LEFT JOIN epos_organisation_person employee ON ((((a.cfpersid = employee.cfpersid) AND (employee.roleclass = 'Employee'::bpchar)) AND (employee.rolescheme = 'Organisation Contact Details'::text))))
     LEFT JOIN epos_person_language lang ON ((((a.cfpersid = lang.cfpersid) AND (lang.classterm = 'Language'::bpchar)) AND (lang.schemename = 'Person Skills'::text))))
     LEFT JOIN epos_person_qualification qual ON ((((a.cfpersid = qual.cfpersid) AND (qual.classterm = 'Qualification'::bpchar)) AND (qual.schemename = 'Person Skills'::text))))
     LEFT JOIN epos_person_electronic cv ON ((((a.cfpersid = cv.cfpersid) AND (email.class = 'Curriculum Vitae'::bpchar)) AND (email.scheme = 'Person Contact Details'::text))));
ALTER TABLE epos_person_detail OWNER TO damian;

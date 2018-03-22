/*******************************************************************************
 * Copyright (C) 2018 EPOS - European Plate Observing System
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 ******************************************************************************/
package jsldReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;

public class ToCerif {
	protected Connection connection = null; 
	private List<PreparedStatement> statements = new ArrayList<PreparedStatement>();
	public ToCerif(Connection con){
	connection = con;
	}

public static final String TOCFEADDR = "select tocfeaddr (?, ?, ?);";
public PreparedStatement tocfeaddr (String v_cfeaddrid, String v_cfpaddrid, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEADDR);
		result.setString(0, v_cfeaddrid);
		result.setString(1, v_cfpaddrid);
		result.setString(2, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCPROVENANCE = "select tocfdcprovenance (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdcprovenance (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCPROVENANCE);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_FACIL = "select tocfrespubl_facil (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_facil (String v_cffacilid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_FACIL);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEQUIP_CLASS = "select tocfequip_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfequip_class (String v_cfequipid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEQUIP_CLASS);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_MEAS = "select tocfpers_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_meas (String v_cfmeasid, String v_cfpersid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_MEAS);
		result.setString(0, v_cfmeasid);
		result.setString(1, v_cfpersid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPAT_FACIL = "select tocfrespat_facil (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespat_facil (String v_cffacilid, String v_cfrespatid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPAT_FACIL);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfrespatid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFACIL_PADDR = "select tocffacil_paddr (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffacil_paddr (String v_cffacilid, String v_cfpaddrid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFACIL_PADDR);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfpaddrid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPADDR = "select tocfpaddr (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpaddr (String v_cfpaddrid, String v_cfaddrline1, String v_cfaddrline2, String v_cfaddrline3, String v_cfaddrline4, String v_cfaddrline5, String v_cfcitytown, String v_cfcountrycode, String v_cfpostcode, String v_cfstateofcountry, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPADDR);
		result.setString(0, v_cfpaddrid);
		result.setString(1, v_cfaddrline1);
		result.setString(2, v_cfaddrline2);
		result.setString(3, v_cfaddrline3);
		result.setString(4, v_cfaddrline4);
		result.setString(5, v_cfaddrline5);
		result.setString(6, v_cfcitytown);
		result.setString(7, v_cfcountrycode);
		result.setString(8, v_cfpostcode);
		result.setString(9, v_cfstateofcountry);
		result.setString(10, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPATVERSINFO = "select tocfrespatversinfo (?, ?, ?, ?);";
public PreparedStatement tocfrespatversinfo (String v_cfrespatid, String v_cfversinfo, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPATVERSINFO);
		result.setString(0, v_cfrespatid);
		result.setString(1, v_cfversinfo);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFGEOBBOXDESCR = "select tocfgeobboxdescr (?, ?, ?, ?);";
public PreparedStatement tocfgeobboxdescr (String v_cfgeobboxid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFGEOBBOXDESCR);
		result.setString(0, v_cfgeobboxid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPAT_FUND = "select tocfrespat_fund (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespat_fund (String v_cffundid, String v_cfrespatid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPAT_FUND);
		result.setString(0, v_cffundid);
		result.setString(1, v_cfrespatid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCURRENCYNAME = "select tocfcurrencyname (?, ?, ?, ?);";
public PreparedStatement tocfcurrencyname (String v_cfcurrcode, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCURRENCYNAME);
		result.setString(0, v_cfcurrcode);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_PADDR = "select tocforgunit_paddr (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_paddr (String v_cforgunitid, String v_cfpaddrid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_PADDR);
		result.setString(0, v_cforgunitid);
		result.setString(1, v_cfpaddrid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_RESPUBL = "select tocfpers_respubl (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_respubl (String v_cfpersid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_RESPUBL);
		result.setString(0, v_cfpersid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCITE_CLASS = "select tocfcite_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfcite_class (String v_cfciteid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCITE_CLASS);
		result.setString(0, v_cfciteid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPRIZEDESCR = "select tocfprizedescr (?, ?, ?, ?);";
public PreparedStatement tocfprizedescr (String v_cfprizeid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPRIZEDESCR);
		result.setString(0, v_cfprizeid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEQUIPDESCR = "select tocfequipdescr (?, ?, ?, ?);";
public PreparedStatement tocfequipdescr (String v_cfequipid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEQUIPDESCR);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMETRICSDESCR = "select tocfmetricsdescr (?, ?, ?, ?);";
public PreparedStatement tocfmetricsdescr (String v_cfmetricsid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMETRICSDESCR);
		result.setString(0, v_cfmetricsid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNITNAME = "select tocforgunitname (?, ?, ?, ?);";
public PreparedStatement tocforgunitname (String v_cforgunitid, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNITNAME);
		result.setString(0, v_cforgunitid);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCOUNTRY_CLASS = "select tocfcountry_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfcountry_class (String v_cfclassname, String v_cfschemename, String v_cfcountrycode, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCOUNTRY_CLASS);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfcountrycode);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPROD_EQUIP = "select tocfresprod_equip (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfresprod_equip (String v_cfequipid, String v_cfresprodid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPROD_EQUIP);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfresprodid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEQUIP_FUND = "select tocfequip_fund (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfequip_fund (String v_cfequipid, String v_cffundid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEQUIP_FUND);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cffundid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJTITLE = "select tocfprojtitle (?, ?, ?, ?);";
public PreparedStatement tocfprojtitle (String v_cfprojid, String v_cftitle, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJTITLE);
		result.setString(0, v_cfprojid);
		result.setString(1, v_cftitle);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCRELATION = "select tocfdcrelation (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdcrelation (Timestamp v_cfdcenddate, String v_cfdcid1, String v_cfdcid2, String v_cfdclangtag, String v_cfdcscheme1, String v_cfdcscheme2, Timestamp v_cfdcstartdate, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCRELATION);
		result.setTimestamp(0, v_cfdcenddate);
		result.setString(1, v_cfdcid1);
		result.setString(2, v_cfdcid2);
		result.setString(3, v_cfdclangtag);
		result.setString(4, v_cfdcscheme1);
		result.setString(5, v_cfdcscheme2);
		result.setTimestamp(6, v_cfdcstartdate);
		result.setString(7, v_cfdctrans);
		result.setString(8, v_cfdctype);
		result.setString(9, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_SRV = "select tocfrespubl_srv (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_srv (String v_cfrespublid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_SRV);
		result.setString(0, v_cfrespublid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEVENT_MEAS = "select tocfevent_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfevent_meas (String v_cfeventid, String v_cfmeasid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEVENT_MEAS);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cfmeasid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_MEAS = "select tocforgunit_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_meas (String v_cfmeasid, String v_cforgunitid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_MEAS);
		result.setString(0, v_cfmeasid);
		result.setString(1, v_cforgunitid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_COUNTRY = "select tocfpers_country (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_country (String v_cfpersid, String v_cfclassname, String v_cfschemename, String v_cfcountrycode, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_COUNTRY);
		result.setString(0, v_cfpersid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setString(3, v_cfcountrycode);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPROD_FACIL = "select tocfresprod_facil (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfresprod_facil (String v_cffacilid, String v_cfresprodid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPROD_FACIL);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfresprodid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_LANG = "select tocfpers_lang (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_lang (String v_cfpersid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate, String v_cflangcode){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_LANG);
		result.setString(0, v_cfpersid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
		result.setString(5, v_cflangcode);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFQUAL_CLASS = "select tocfqual_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfqual_class (String v_cfqualid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFQUAL_CLASS);
		result.setString(0, v_cfqualid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFDCRIGHTSMMPRIVACY = "select tocffdcrightsmmprivacy (?, ?, ?, ?, ?);";
public PreparedStatement tocffdcrightsmmprivacy (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cffdcprivacyconstraint, String v_cffdctrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFDCRIGHTSMMPRIVACY);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cffdcprivacyconstraint);
		result.setString(4, v_cffdctrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_RESPROD = "select tocforgunit_resprod (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_resprod (String v_cforgunitid, String v_cfresprodid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_RESPROD);
		result.setString(0, v_cforgunitid);
		result.setString(1, v_cfresprodid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEQUIP_SRV = "select tocfequip_srv (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfequip_srv (String v_cfequipid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEQUIP_SRV);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCCOVERAGETEMPORAL = "select tocfdccoveragetemporal (?, ?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdccoveragetemporal (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdcvalue, Timestamp v_cffdcenddatetime, int v_cffdcprecision, Timestamp v_cffdcstartdatetime){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCCOVERAGETEMPORAL);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdcvalue);
		result.setTimestamp(5, v_cffdcenddatetime);
		result.setInt(6, v_cffdcprecision);
		result.setTimestamp(7, v_cffdcstartdatetime);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFACIL_CLASS = "select tocffacil_class (?, ?, ?, ?, ?);";
public PreparedStatement tocffacil_class (String v_cffacilid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFACIL_CLASS);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFDCRIGHTSMMSECURITY = "select tocffdcrightsmmsecurity (?, ?, ?, ?, ?);";
public PreparedStatement tocffdcrightsmmsecurity (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cffdcsecurityconstraint, String v_cffdctrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFDCRIGHTSMMSECURITY);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cffdcsecurityconstraint);
		result.setString(4, v_cffdctrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_EXPSKILLS = "select tocfpers_expskills (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_expskills (String v_cfexpskillsid, String v_cfpersid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_EXPSKILLS);
		result.setString(0, v_cfexpskillsid);
		result.setString(1, v_cfpersid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEVENTKEYW = "select tocfeventkeyw (?, ?, ?, ?);";
public PreparedStatement tocfeventkeyw (String v_cfeventid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEVENTKEYW);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEAS_MEAS = "select tocfmeas_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfmeas_meas (String v_cfmeasid1, String v_meas_char, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEAS_MEAS);
		result.setString(0, v_cfmeasid1);
		result.setString(1, v_meas_char);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEVENT_INDIC = "select tocfevent_indic (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfevent_indic (String v_cfeventid, String v_cfindicid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEVENT_INDIC);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cfindicid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_EADDR = "select tocforgunit_eaddr (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_eaddr (String v_cfeaddrid, String v_cforgunitid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_EADDR);
		result.setString(0, v_cfeaddrid);
		result.setString(1, v_cforgunitid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_CITE = "select tocfrespubl_cite (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_cite (String v_cfciteid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_CITE);
		result.setString(0, v_cfciteid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCTITLE = "select tocfdctitle (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdctitle (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCTITLE);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_INDIC = "select tocfpers_indic (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_indic (String v_cfindicid, String v_cfpersid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_INDIC);
		result.setString(0, v_cfindicid);
		result.setString(1, v_cfpersid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMETRICS = "select tocfmetrics (?, ?);";
public PreparedStatement tocfmetrics (String v_cfmetricsid, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMETRICS);
		result.setString(0, v_cfmetricsid);
		result.setString(1, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFSRV = "select tocfsrv (?, ?, ?);";
public PreparedStatement tocfsrv (String v_cfsrvid, String v_cfacro, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFSRV);
		result.setString(0, v_cfsrvid);
		result.setString(1, v_cfacro);
		result.setString(2, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_MEAS = "select tocfrespubl_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_meas (String v_cfmeasid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_MEAS);
		result.setString(0, v_cfmeasid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFINDICNAME = "select tocfindicname (?, ?, ?, ?);";
public PreparedStatement tocfindicname (String v_cfindicid, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFINDICNAME);
		result.setString(0, v_cfindicid);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFACIL = "select tocffacil (?, ?, ?);";
public PreparedStatement tocffacil (String v_cffacilid, String v_cfacro, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFACIL);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfacro);
		result.setString(2, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_CLASS = "select tocforgunit_class (?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_class (String v_cforgunitid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_CLASS);
		result.setString(0, v_cforgunitid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_METRICS = "select tocfrespubl_metrics (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_metrics (String v_cfmetricsid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_METRICS);
		result.setString(0, v_cfmetricsid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCOUNTRYNAME = "select tocfcountryname (?, ?, ?, ?);";
public PreparedStatement tocfcountryname (String v_cfcountrycode, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCOUNTRYNAME);
		result.setString(0, v_cfcountrycode);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPRODKEYW = "select tocfresprodkeyw (?, ?, ?, ?);";
public PreparedStatement tocfresprodkeyw (String v_cfresprodid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPRODKEYW);
		result.setString(0, v_cfresprodid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCURRENCY_CLASS = "select tocfcurrency_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfcurrency_class (String v_cfclassname, String v_cfschemename, String v_cfcurrcode, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCURRENCY_CLASS);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfcurrcode);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEQUIP = "select tocfequip (?, ?, ?);";
public PreparedStatement tocfequip (String v_cfequipid, String v_cfacro, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEQUIP);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfacro);
		result.setString(2, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFINDIC_CLASS = "select tocfindic_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfindic_class (String v_cfindicid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFINDIC_CLASS);
		result.setString(0, v_cfindicid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFGEOBBOXKEYW = "select tocfgeobboxkeyw (?, ?, ?, ?);";
public PreparedStatement tocfgeobboxkeyw (String v_cfgeobboxid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFGEOBBOXKEYW);
		result.setString(0, v_cfgeobboxid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCCOVERAGE = "select tocfdccoverage (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdccoverage (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCCOVERAGE);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_ORGUNIT = "select tocfpers_orgunit (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_orgunit (String v_cforgunitid, String v_cfpersid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_ORGUNIT);
		result.setString(0, v_cforgunitid);
		result.setString(1, v_cfpersid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_RESPAT = "select tocfrespubl_respat (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_respat (String v_cfrespatid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_RESPAT);
		result.setString(0, v_cfrespatid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEDIUM_MEAS = "select tocfmedium_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfmedium_meas (String v_cfmeasid, String v_cfmediumid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEDIUM_MEAS);
		result.setString(0, v_cfmeasid);
		result.setString(1, v_cfmediumid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCURRENCYENTNAME = "select tocfcurrencyentname (?, ?, ?, ?);";
public PreparedStatement tocfcurrencyentname (String v_cfcurrcode, String v_cfentname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCURRENCYENTNAME);
		result.setString(0, v_cfcurrcode);
		result.setString(1, v_cfentname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_DC = "select tocfrespubl_dc (?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_dc (String v_cfdcid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, String v_cfdcscheme, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_DC);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setString(4, v_cfdcscheme);
		result.setTimestamp(5, v_cfstartdate);
		result.setTimestamp(6, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPROD_MEAS_TIME = "select tocfresprod_meas_time (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfresprod_meas_time (String v_cfresprodid, Timestamp v_meas_time, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPROD_MEAS_TIME);
		result.setString(0, v_cfresprodid);
		result.setTimestamp(1, v_meas_time);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_RESPROD = "select tocfpers_resprod (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_resprod (String v_cfpersid, String v_cfresprodid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_RESPROD);
		result.setString(0, v_cfpersid);
		result.setString(1, v_cfresprodid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPRODDESCR = "select tocfresproddescr (?, ?, ?, ?);";
public PreparedStatement tocfresproddescr (String v_cfresprodid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPRODDESCR);
		result.setString(0, v_cfresprodid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_PRIZE = "select tocfproj_prize (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_prize (String v_cfprizeid, String v_cfprojid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_PRIZE);
		result.setString(0, v_cfprizeid);
		result.setString(1, v_cfprojid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMETRICS_CLASS = "select tocfmetrics_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfmetrics_class (String v_cfmetricsid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMETRICS_CLASS);
		result.setString(0, v_cfmetricsid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEASNAME = "select tocfmeasname (?, ?, ?, ?);";
public PreparedStatement tocfmeasname (String v_cfmeasid, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEASNAME);
		result.setString(0, v_cfmeasid);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBLABSTR = "select tocfrespublabstr (?, ?, ?, ?);";
public PreparedStatement tocfrespublabstr (String v_cfrespublid, String v_cfabstr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBLABSTR);
		result.setString(0, v_cfrespublid);
		result.setString(1, v_cfabstr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFACIL_MEDIUM = "select tocffacil_medium (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffacil_medium (String v_cffacilid, String v_cfmediumid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFACIL_MEDIUM);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfmediumid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCLANGUAGE = "select tocfdclanguage (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdclanguage (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCLANGUAGE);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFACIL_MEAS = "select tocffacil_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffacil_meas (String v_cffacilid, String v_cfmeasid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFACIL_MEAS);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfmeasid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFUNDDESCR = "select tocffunddescr (?, ?, ?, ?);";
public PreparedStatement tocffunddescr (String v_cffundid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFUNDDESCR);
		result.setString(0, v_cffundid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEAS = "select tocfmeas (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfmeas (String v_cfmeasid, double v_cfcountfloatpchange, int v_cfcountint, int v_cfcountintchange, Timestamp v_cfdatetime, String v_cfuri, double v_cfvalfloatp, double v_cfvaljudgenum, double v_cfvaljudgenumchange, String v_cfvaljudgetext, String v_cfvaljudgetextchange){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEAS);
		result.setString(0, v_cfmeasid);
		result.setDouble(1, v_cfcountfloatpchange);
		result.setInt(2, v_cfcountint);
		result.setInt(3, v_cfcountintchange);
		result.setTimestamp(4, v_cfdatetime);
		result.setString(5, v_cfuri);
		result.setDouble(6, v_cfvalfloatp);
		result.setDouble(7, v_cfvaljudgenum);
		result.setDouble(8, v_cfvaljudgenumchange);
		result.setString(9, v_cfvaljudgetext);
		result.setString(10, v_cfvaljudgetextchange);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_EVENT = "select tocfpers_event (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_event (String v_cfeventid, String v_cfpersid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_EVENT);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cfpersid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFDCRIGHTSMMPRICING = "select tocffdcrightsmmpricing (?, ?, ?, ?, ?);";
public PreparedStatement tocffdcrightsmmpricing (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cffdcpriceconstraint, String v_cffdctrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFDCRIGHTSMMPRICING);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cffdcpriceconstraint);
		result.setString(4, v_cffdctrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_EQUIP = "select tocfrespubl_equip (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_equip (String v_cfequipid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_EQUIP);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCRIGHTSMM = "select tocfdcrightsmm (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdcrightsmm (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCRIGHTSMM);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_MEDIUM = "select tocfrespubl_medium (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_medium (String v_cfmediumid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_MEDIUM);
		result.setString(0, v_cfmediumid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCLASS = "select tocfclass (?, ?, ?, ?, ?);";
public PreparedStatement tocfclass (String v_cfclassid, String v_cfclassschemeid, String v_cfuri, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCLASS);
		result.setString(0, v_cfclassid);
		result.setString(1, v_cfclassschemeid);
		result.setString(2, v_cfuri);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_MEAS = "select tocfproj_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_meas (String v_cfmeasid, String v_cfprojid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_MEAS);
		result.setString(0, v_cfmeasid);
		result.setString(1, v_cfprojid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFACIL_SRV = "select tocffacil_srv (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffacil_srv (String v_cffacilid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFACIL_SRV);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCRIGHTSHOLDER = "select tocfdcrightsholder (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdcrightsholder (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCRIGHTSHOLDER);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFACILDESCR = "select tocffacildescr (?, ?, ?, ?);";
public PreparedStatement tocffacildescr (String v_cffacilid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFACILDESCR);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEAS_CLASS = "select tocfmeas_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfmeas_class (String v_cfmeasid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEAS_CLASS);
		result.setString(0, v_cfmeasid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPATTITLE = "select tocfrespattitle (?, ?, ?, ?);";
public PreparedStatement tocfrespattitle (String v_cfrespatid, String v_cftitle, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPATTITLE);
		result.setString(0, v_cfrespatid);
		result.setString(1, v_cftitle);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS = "select tocfpers (?, ?, ?, ?);";
public PreparedStatement tocfpers (String v_cfpersid, Date v_cfbirthdate, String v_cfgender, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS);
		result.setString(0, v_cfpersid);
		result.setDate(1, v_cfbirthdate);
		result.setString(2, v_cfgender);
		result.setString(3, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPROD_FUND = "select tocfresprod_fund (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfresprod_fund (String v_cffundid, String v_cfresprodid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPROD_FUND);
		result.setString(0, v_cffundid);
		result.setString(1, v_cfresprodid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEQUIPKEYW = "select tocfequipkeyw (?, ?, ?, ?);";
public PreparedStatement tocfequipkeyw (String v_cfequipid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEQUIPKEYW);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFEDID = "select tocffedid (?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffedid (String v_cffedid, String v_cffedidid, String v_cfinstid, String v_cfclassid, String v_cfclassschemeid, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFEDID);
		result.setString(0, v_cffedid);
		result.setString(1, v_cffedidid);
		result.setString(2, v_cfinstid);
		result.setString(3, v_cfclassid);
		result.setString(4, v_cfclassschemeid);
		result.setTimestamp(5, v_cfstartdate);
		result.setTimestamp(6, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String EPOSUUID = "select eposuuid ();";
public PreparedStatement eposuuid (){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(EPOSUUID);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPRIZENAME = "select tocfprizename (?, ?, ?, ?);";
public PreparedStatement tocfprizename (String v_cfprizeid, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPRIZENAME);
		result.setString(0, v_cfprizeid);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBLVERSINFO = "select tocfrespublversinfo (?, ?, ?, ?);";
public PreparedStatement tocfrespublversinfo (String v_cfrespublid, String v_cfversinfo, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBLVERSINFO);
		result.setString(0, v_cfrespublid);
		result.setString(1, v_cfversinfo);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_EQUIP = "select tocfpers_equip (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_equip (String v_cfequipid, String v_cfpersid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_EQUIP);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfpersid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPAT_SRV = "select tocfrespat_srv (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespat_srv (String v_cfrespatid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPAT_SRV);
		result.setString(0, v_cfrespatid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEVENT_MEDIUM = "select tocfevent_medium (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfevent_medium (String v_cfeventid, String v_cfmediumid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEVENT_MEDIUM);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cfmediumid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_EVENT = "select tocfrespubl_event (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_event (String v_cfeventid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_EVENT);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_FACIL = "select tocfpers_facil (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_facil (String v_cffacilid, String v_cfpersid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_FACIL);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfpersid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_PRIZE = "select tocforgunit_prize (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_prize (String v_cforgunitid, String v_cfprizeid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_PRIZE);
		result.setString(0, v_cforgunitid);
		result.setString(1, v_cfprizeid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_DC = "select tocforgunit_dc (?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_dc (String v_cfdcid, String v_cforgunitid, String v_cfclassname, String v_cfschemename, String v_cfdcscheme, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_DC);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cforgunitid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setString(4, v_cfdcscheme);
		result.setTimestamp(5, v_cfstartdate);
		result.setTimestamp(6, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPROD_RESPROD = "select tocfresprod_resprod (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfresprod_resprod (String v_cfclassname, String v_cfschemename, String v_cfresprodid1, String v_cfresprodid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPROD_RESPROD);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfresprodid1);
		result.setString(3, v_cfresprodid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFUND_INDIC = "select tocffund_indic (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffund_indic (String v_cffundid, String v_cfindicid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFUND_INDIC);
		result.setString(0, v_cffundid);
		result.setString(1, v_cfindicid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERSNAME_PERS = "select tocfpersname_pers (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpersname_pers (String v_cfpersid, String v_cfpersnameid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERSNAME_PERS);
		result.setString(0, v_cfpersid);
		result.setString(1, v_cfpersnameid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNITRESACT = "select tocforgunitresact (?, ?, ?, ?);";
public PreparedStatement tocforgunitresact (String v_cforgunitid, String v_cfresact, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNITRESACT);
		result.setString(0, v_cforgunitid);
		result.setString(1, v_cfresact);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPAT = "select tocfrespat (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespat (String v_cfrespatid, Date v_cfapprovdate, String v_cfcountrycode, String v_cfpatentnum, Date v_cfregistrdate, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPAT);
		result.setString(0, v_cfrespatid);
		result.setDate(1, v_cfapprovdate);
		result.setString(2, v_cfcountrycode);
		result.setString(3, v_cfpatentnum);
		result.setDate(4, v_cfregistrdate);
		result.setString(5, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFLANG_CLASS = "select tocflang_class (?, ?, ?, ?, ?);";
public PreparedStatement tocflang_class (String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate, String v_cflangcode){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFLANG_CLASS);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setTimestamp(2, v_cfstartdate);
		result.setTimestamp(3, v_cfenddate);
		result.setString(4, v_cflangcode);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFLANGNAME = "select tocflangname (?, ?, ?, ?);";
public PreparedStatement tocflangname (String v_cflangcodeoflangname, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFLANGNAME);
		result.setString(0, v_cflangcodeoflangname);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String GETSEMANTICS = "select getsemantics (?, ?);";
public PreparedStatement getsemantics (String classhuman, String schemehuman){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(GETSEMANTICS);
		result.setString(0, classhuman);
		result.setString(1, schemehuman);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPAT_CLASS = "select tocfrespat_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfrespat_class (String v_cfrespatid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPAT_CLASS);
		result.setString(0, v_cfrespatid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_INDIC = "select tocfproj_indic (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_indic (String v_cfindicid, String v_cfprojid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_INDIC);
		result.setString(0, v_cfindicid);
		result.setString(1, v_cfprojid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_SRV = "select tocforgunit_srv (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_srv (String v_cforgunitid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_SRV);
		result.setString(0, v_cforgunitid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_CLASS = "select tocfproj_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_class (String v_cfprojid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_CLASS);
		result.setString(0, v_cfprojid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL = "select tocfrespubl (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl (String v_cfrespublid, String v_cfedition, String v_cfendpage, String v_cfisbn, String v_cfissn, String v_cfissue, String v_cfnum, Date v_cfrespubldate, String v_cfseries, String v_cfstartpage, String v_cftotalpages, String v_cfuri, String v_cfvol){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL);
		result.setString(0, v_cfrespublid);
		result.setString(1, v_cfedition);
		result.setString(2, v_cfendpage);
		result.setString(3, v_cfisbn);
		result.setString(4, v_cfissn);
		result.setString(5, v_cfissue);
		result.setString(6, v_cfnum);
		result.setDate(7, v_cfrespubldate);
		result.setString(8, v_cfseries);
		result.setString(9, v_cfstartpage);
		result.setString(10, v_cftotalpages);
		result.setString(11, v_cfuri);
		result.setString(12, v_cfvol);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEVENTNAME = "select tocfeventname (?, ?, ?, ?);";
public PreparedStatement tocfeventname (String v_cfeventid, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEVENTNAME);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCLASSEX = "select tocfclassex (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfclassex (String v_cfclassid, String v_cfclassschemeid, String v_cfex, String v_cfexsrc, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCLASSEX);
		result.setString(0, v_cfclassid);
		result.setString(1, v_cfclassschemeid);
		result.setString(2, v_cfex);
		result.setString(3, v_cfexsrc);
		result.setString(4, v_cflangcode);
		result.setString(5, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFEDID_SRV = "select tocffedid_srv (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffedid_srv (String v_cffedidid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFEDID_SRV);
		result.setString(0, v_cffedidid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCCONTRIBUTOR = "select tocfdccontributor (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdccontributor (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCCONTRIBUTOR);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFSRV_INDIC = "select tocfsrv_indic (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfsrv_indic (String v_cfindicid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFSRV_INDIC);
		result.setString(0, v_cfindicid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEQUIP_PADDR = "select tocfequip_paddr (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfequip_paddr (String v_cfequipid, String v_cfpaddrid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEQUIP_PADDR);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfpaddrid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_RESPROD = "select tocfproj_resprod (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_resprod (String v_cfprojid, String v_cfresprodid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_RESPROD);
		result.setString(0, v_cfprojid);
		result.setString(1, v_cfresprodid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPADDR_GEOBBOX = "select tocfpaddr_geobbox (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpaddr_geobbox (String v_cfgeobboxid, String v_cfpaddrid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPADDR_GEOBBOX);
		result.setString(0, v_cfgeobboxid);
		result.setString(1, v_cfpaddrid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFSRVKEYW = "select tocfsrvkeyw (?, ?, ?, ?);";
public PreparedStatement tocfsrvkeyw (String v_cfsrvid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFSRVKEYW);
		result.setString(0, v_cfsrvid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCITE_MEDIUM = "select tocfcite_medium (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfcite_medium (String v_cfciteid, String v_cfmediumid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCITE_MEDIUM);
		result.setString(0, v_cfciteid);
		result.setString(1, v_cfmediumid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCRESOURCEIDENTIFIER = "select tocfdcresourceidentifier (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdcresourceidentifier (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCRESOURCEIDENTIFIER);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_MEDIUM = "select tocfpers_medium (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_medium (String v_cfmediumid, String v_cfpersid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_MEDIUM);
		result.setString(0, v_cfmediumid);
		result.setString(1, v_cfpersid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCITE = "select tocfcite (?, ?);";
public PreparedStatement tocfcite (String v_cfciteid, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCITE);
		result.setString(0, v_cfciteid);
		result.setString(1, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEXPSKILLSKEYW = "select tocfexpskillskeyw (?, ?, ?, ?);";
public PreparedStatement tocfexpskillskeyw (String v_cfexpskillsid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEXPSKILLSKEYW);
		result.setString(0, v_cfexpskillsid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFUND_FUND = "select tocffund_fund (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffund_fund (String v_cfclassname, String v_cfschemename, String v_cffundid1, String v_cffundid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFUND_FUND);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cffundid1);
		result.setString(3, v_cffundid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String EPOSMAXDATE = "select eposmaxdate ();";
public PreparedStatement eposmaxdate (){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(EPOSMAXDATE);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCLASSSCHEME = "select tocfclassscheme (?, ?);";
public PreparedStatement tocfclassscheme (String v_cfclassschemeid, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCLASSSCHEME);
		result.setString(0, v_cfclassschemeid);
		result.setString(1, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFGEOBBOXNAME = "select tocfgeobboxname (?, ?, ?, ?);";
public PreparedStatement tocfgeobboxname (String v_cfgeobboxid, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFGEOBBOXNAME);
		result.setString(0, v_cfgeobboxid);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ = "select tocfproj (?, ?, ?, ?, ?);";
public PreparedStatement tocfproj (String v_cfprojid, String v_cfacro, String v_cfuri, Date v_cfstartdate, Date v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ);
		result.setString(0, v_cfprojid);
		result.setString(1, v_cfacro);
		result.setString(2, v_cfuri);
		result.setDate(3, v_cfstartdate);
		result.setDate(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPRIZE_CLASS = "select tocfprize_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfprize_class (String v_cfprizeid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPRIZE_CLASS);
		result.setString(0, v_cfprizeid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFSRV_FUND = "select tocfsrv_fund (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfsrv_fund (String v_cffundid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFSRV_FUND);
		result.setString(0, v_cffundid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCRESOURCETYPE = "select tocfdcresourcetype (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdcresourcetype (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCRESOURCETYPE);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCLASSSCHEMEDESCR = "select tocfclassschemedescr (?, ?, ?, ?, ?);";
public PreparedStatement tocfclassschemedescr (String v_cfclassschemeid, String v_cfdescr, String v_cfdescrsrc, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCLASSSCHEMEDESCR);
		result.setString(0, v_cfclassschemeid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cfdescrsrc);
		result.setString(3, v_cflangcode);
		result.setString(4, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEXPSKILLS = "select tocfexpskills (?, ?);";
public PreparedStatement tocfexpskills (String v_cfexpskillsid, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEXPSKILLS);
		result.setString(0, v_cfexpskillsid);
		result.setString(1, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFQUAL = "select tocfqual (?, ?);";
public PreparedStatement tocfqual (String v_cfqualid, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFQUAL);
		result.setString(0, v_cfqualid);
		result.setString(1, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_SRV = "select tocfpers_srv (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_srv (String v_cfpersid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_SRV);
		result.setString(0, v_cfpersid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFGEOBBOX_GEOBBOX = "select tocfgeobbox_geobbox (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfgeobbox_geobbox (String v_cfclassname, String v_cfschemename, String v_cfgeobboxid1, String v_cfgeobboxid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFGEOBBOX_GEOBBOX);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfgeobboxid1);
		result.setString(3, v_cfgeobboxid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCRIGHTSMMACCESSRIGHTS = "select tocfdcrightsmmaccessrights (?, ?, ?, ?, ?);";
public PreparedStatement tocfdcrightsmmaccessrights (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCRIGHTSMMACCESSRIGHTS);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFINDICKEYW = "select tocfindickeyw (?, ?, ?, ?);";
public PreparedStatement tocfindickeyw (String v_cfindicid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFINDICKEYW);
		result.setString(0, v_cfindicid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_RESPUBL = "select tocfproj_respubl (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_respubl (String v_cfprojid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_RESPUBL);
		result.setString(0, v_cfprojid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_RESPROD = "select tocfrespubl_resprod (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_resprod (String v_cfresprodid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_RESPROD);
		result.setString(0, v_cfresprodid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFUND_CLASS = "select tocffund_class (?, ?, ?, ?, ?);";
public PreparedStatement tocffund_class (String v_cffundid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFUND_CLASS);
		result.setString(0, v_cffundid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEQUIP_EVENT = "select tocfequip_event (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfequip_event (String v_cfequipid, String v_cfeventid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEQUIP_EVENT);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfeventid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPRIZEKEYW = "select tocfprizekeyw (?, ?, ?, ?);";
public PreparedStatement tocfprizekeyw (String v_cfprizeid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPRIZEKEYW);
		result.setString(0, v_cfprizeid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCOUNTRY = "select tocfcountry (?, ?);";
public PreparedStatement tocfcountry (String v_cfcountrycode, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCOUNTRY);
		result.setString(0, v_cfcountrycode);
		result.setString(1, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPROD = "select tocfresprod (?, ?);";
public PreparedStatement tocfresprod (String v_cfresprodid, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPROD);
		result.setString(0, v_cfresprodid);
		result.setString(1, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFSRV_PADDR = "select tocfsrv_paddr (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfsrv_paddr (String v_cfpaddrid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFSRV_PADDR);
		result.setString(0, v_cfpaddrid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEQUIP_MEDIUM = "select tocfequip_medium (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfequip_medium (String v_cfequipid, String v_cfmediumid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEQUIP_MEDIUM);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfmediumid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPAT_RESPAT = "select tocfrespat_respat (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespat_respat (String v_cfclassname, String v_cfschemename, String v_cfrespatid1, String v_cfrespatid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPAT_RESPAT);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfrespatid1);
		result.setString(3, v_cfrespatid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEXPSKILLSNAME = "select tocfexpskillsname (?, ?, ?, ?);";
public PreparedStatement tocfexpskillsname (String v_cfexpskillsid, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEXPSKILLSNAME);
		result.setString(0, v_cfexpskillsid);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPAT_MEAS = "select tocfrespat_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespat_meas (String v_cfmeasid, String v_cfrespatid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPAT_MEAS);
		result.setString(0, v_cfmeasid);
		result.setString(1, v_cfrespatid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFEDID_CLASS = "select tocffedid_class (?, ?, ?, ?, ?);";
public PreparedStatement tocffedid_class (String v_cffedidid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFEDID_CLASS);
		result.setString(0, v_cffedidid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCLASSTERM = "select tocfclassterm (?, ?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfclassterm (String v_cfclassid, String v_cfclassschemeid, String v_cfroleexpr, String v_cfroleexpropp, String v_cfterm, String v_cftermsrc, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCLASSTERM);
		result.setString(0, v_cfclassid);
		result.setString(1, v_cfclassschemeid);
		result.setString(2, v_cfroleexpr);
		result.setString(3, v_cfroleexpropp);
		result.setString(4, v_cfterm);
		result.setString(5, v_cftermsrc);
		result.setString(6, v_cflangcode);
		result.setString(7, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPROD_RESPAT = "select tocfresprod_respat (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfresprod_respat (String v_cfrespatid, String v_cfresprodid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPROD_RESPAT);
		result.setString(0, v_cfrespatid);
		result.setString(1, v_cfresprodid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPROD_MEAS_CHAR = "select tocfresprod_meas_char (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfresprod_meas_char (String v_cfresprodid, String v_meas_char, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPROD_MEAS_CHAR);
		result.setString(0, v_cfresprodid);
		result.setString(1, v_meas_char);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEQUIPNAME = "select tocfequipname (?, ?, ?, ?);";
public PreparedStatement tocfequipname (String v_cfequipid, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEQUIPNAME);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_FUND = "select tocfpers_fund (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_fund (String v_cffundid, String v_cfpersid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_FUND);
		result.setString(0, v_cffundid);
		result.setString(1, v_cfpersid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_PADDR = "select tocfpers_paddr (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_paddr (String v_cfpaddrid, String v_cfpersid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_PADDR);
		result.setString(0, v_cfpaddrid);
		result.setString(1, v_cfpersid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPRODALTNAME = "select tocfresprodaltname (?, ?, ?, ?);";
public PreparedStatement tocfresprodaltname (String v_cfresprodid, String v_cfaltname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPRODALTNAME);
		result.setString(0, v_cfresprodid);
		result.setString(1, v_cfaltname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFGEOBBOX_MEAS = "select tocfgeobbox_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfgeobbox_meas (String v_cfgeobboxid, String v_cfmeasid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFGEOBBOX_MEAS);
		result.setString(0, v_cfgeobboxid);
		result.setString(1, v_cfmeasid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDC = "select tocfdc (?, ?, ?);";
public PreparedStatement tocfdc (String v_cfdcid, String v_cfdcscheme, String v_cfdcschemeuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDC);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdcscheme);
		result.setString(2, v_cfdcschemeuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERSRESINT = "select tocfpersresint (?, ?, ?, ?);";
public PreparedStatement tocfpersresint (String v_cfpersid, String v_cfresint, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERSRESINT);
		result.setString(0, v_cfpersid);
		result.setString(1, v_cfresint);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEQUIP_MEAS = "select tocfequip_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfequip_meas (String v_cfequipid, String v_cfmeasid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEQUIP_MEAS);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfmeasid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERSNAME = "select tocfpersname (?, ?, ?, ?);";
public PreparedStatement tocfpersname (String v_cfpersnameid, String v_cffamilynames, String v_cffirstnames, String v_cfothernames){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERSNAME);
		result.setString(0, v_cfpersnameid);
		result.setString(1, v_cffamilynames);
		result.setString(2, v_cffirstnames);
		result.setString(3, v_cfothernames);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_INDIC = "select tocfrespubl_indic (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_indic (String v_cfindicid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_INDIC);
		result.setString(0, v_cfindicid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_EADDR = "select tocfpers_eaddr (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_eaddr (String v_cfeaddrid, String v_cfpersid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_EADDR);
		result.setString(0, v_cfeaddrid);
		result.setString(1, v_cfpersid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEASDESCR = "select tocfmeasdescr (?, ?, ?, ?);";
public PreparedStatement tocfmeasdescr (String v_cfmeasid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEASDESCR);
		result.setString(0, v_cfmeasid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_RESPAT = "select tocforgunit_respat (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_respat (String v_cforgunitid, String v_cfrespatid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_RESPAT);
		result.setString(0, v_cforgunitid);
		result.setString(1, v_cfrespatid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEDIUMKEYW = "select tocfmediumkeyw (?, ?, ?, ?);";
public PreparedStatement tocfmediumkeyw (String v_cfmediumid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEDIUMKEYW);
		result.setString(0, v_cfmediumid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_FUND = "select tocforgunit_fund (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_fund (String v_cffundid, String v_cforgunitid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_FUND);
		result.setString(0, v_cffundid);
		result.setString(1, v_cforgunitid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCLASSSCHEMENAME = "select tocfclassschemename (?, ?, ?, ?, ?);";
public PreparedStatement tocfclassschemename (String v_cfclassschemeid, String v_cfname, String v_cfnamesrc, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCLASSSCHEMENAME);
		result.setString(0, v_cfclassschemeid);
		result.setString(1, v_cfname);
		result.setString(2, v_cfnamesrc);
		result.setString(3, v_cflangcode);
		result.setString(4, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCV = "select tocfcv (?, ?, ?);";
public PreparedStatement tocfcv (String v_cfcvid, byte v_cfcvdoc, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCV);
		result.setString(0, v_cfcvid);
		result.setByte(1, v_cfcvdoc);
		result.setString(2, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPAT_INDIC = "select tocfrespat_indic (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespat_indic (String v_cfindicid, String v_cfrespatid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPAT_INDIC);
		result.setString(0, v_cfindicid);
		result.setString(1, v_cfrespatid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFSRV_CLASS = "select tocfsrv_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfsrv_class (String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFSRV_CLASS);
		result.setString(0, v_cfsrvid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCITETITLE = "select tocfcitetitle (?, ?, ?, ?);";
public PreparedStatement tocfcitetitle (String v_cfciteid, String v_cftitle, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCITETITLE);
		result.setString(0, v_cfciteid);
		result.setString(1, v_cftitle);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEVENT_FUND = "select tocfevent_fund (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfevent_fund (String v_cfeventid, String v_cffundid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEVENT_FUND);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cffundid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPAT_MEDIUM = "select tocfrespat_medium (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespat_medium (String v_cfmediumid, String v_cfrespatid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPAT_MEDIUM);
		result.setString(0, v_cfmediumid);
		result.setString(1, v_cfrespatid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCLASSDEF = "select tocfclassdef (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfclassdef (String v_cfclassid, String v_cfclassschemeid, String v_cfdef, String v_cfdefsrc, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCLASSDEF);
		result.setString(0, v_cfclassid);
		result.setString(1, v_cfclassschemeid);
		result.setString(2, v_cfdef);
		result.setString(3, v_cfdefsrc);
		result.setString(4, v_cflangcode);
		result.setString(5, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCLASSDESCR = "select tocfclassdescr (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfclassdescr (String v_cfclassid, String v_cfclassschemeid, String v_cfdescr, String v_cfdescrsrc, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCLASSDESCR);
		result.setString(0, v_cfclassid);
		result.setString(1, v_cfclassschemeid);
		result.setString(2, v_cfdescr);
		result.setString(3, v_cfdescrsrc);
		result.setString(4, v_cflangcode);
		result.setString(5, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_RESPAT = "select tocfproj_respat (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_respat (String v_cfprojid, String v_cfrespatid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_RESPAT);
		result.setString(0, v_cfprojid);
		result.setString(1, v_cfrespatid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPROD_MEDIUM = "select tocfresprod_medium (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfresprod_medium (String v_cfmediumid, String v_cfresprodid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPROD_MEDIUM);
		result.setString(0, v_cfmediumid);
		result.setString(1, v_cfresprodid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCDESCRIPTION = "select tocfdcdescription (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdcdescription (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCDESCRIPTION);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_MEDIUM = "select tocforgunit_medium (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_medium (String v_cfmediumid, String v_cforgunitid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_MEDIUM);
		result.setString(0, v_cfmediumid);
		result.setString(1, v_cforgunitid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_CLASS = "select tocfpers_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_class (String v_cfpersid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_CLASS);
		result.setString(0, v_cfpersid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEDIUM_MEDIUM = "select tocfmedium_medium (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfmedium_medium (String v_cfclassname, String v_cfschemename, String v_cfmediumid1, String v_cfmediumid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEDIUM_MEDIUM);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfmediumid1);
		result.setString(3, v_cfmediumid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJKEYW = "select tocfprojkeyw (?, ?, ?, ?);";
public PreparedStatement tocfprojkeyw (String v_cfprojid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJKEYW);
		result.setString(0, v_cfprojid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFUNDNAME = "select tocffundname (?, ?, ?, ?);";
public PreparedStatement tocffundname (String v_cffundid, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFUNDNAME);
		result.setString(0, v_cffundid);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_EVENT = "select tocfproj_event (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_event (String v_cfeventid, String v_cfprojid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_EVENT);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cfprojid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFACIL_INDIC = "select tocffacil_indic (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffacil_indic (String v_cffacilid, String v_cfindicid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFACIL_INDIC);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfindicid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEVENT_CLASS = "select tocfevent_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfevent_class (String v_cfeventid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEVENT_CLASS);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCDATE = "select tocfdcdate (?, ?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdcdate (String v_cfdcid, Timestamp v_cfdcdatebegin, Timestamp v_cfdcdateend, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCDATE);
		result.setString(0, v_cfdcid);
		result.setTimestamp(1, v_cfdcdatebegin);
		result.setTimestamp(2, v_cfdcdateend);
		result.setString(3, v_cfdclangtag);
		result.setString(4, v_cfdcscheme);
		result.setString(5, v_cfdctrans);
		result.setString(6, v_cfdctype);
		result.setString(7, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBLTITLE = "select tocfrespubltitle (?, ?, ?, ?);";
public PreparedStatement tocfrespubltitle (String v_cfrespublid, String v_cftitle, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBLTITLE);
		result.setString(0, v_cfrespublid);
		result.setString(1, v_cftitle);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEVENTDESCR = "select tocfeventdescr (?, ?, ?, ?);";
public PreparedStatement tocfeventdescr (String v_cfeventid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEVENTDESCR);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFINDIC_INDIC = "select tocfindic_indic (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfindic_indic (String v_cfclassname, String v_cfschemename, String v_cfindicid1, String v_cfindicid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFINDIC_INDIC);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfindicid1);
		result.setString(3, v_cfindicid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_CV = "select tocfpers_cv (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_cv (String v_cfcvid, String v_cfpersid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_CV);
		result.setString(0, v_cfcvid);
		result.setString(1, v_cfpersid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFACILKEYW = "select tocffacilkeyw (?, ?, ?, ?);";
public PreparedStatement tocffacilkeyw (String v_cffacilid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFACILKEYW);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_EVENT = "select tocforgunit_event (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_event (String v_cfeventid, String v_cforgunitid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_EVENT);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cforgunitid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPROD_INDIC = "select tocfresprod_indic (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfresprod_indic (String v_cfindicid, String v_cfresprodid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPROD_INDIC);
		result.setString(0, v_cfindicid);
		result.setString(1, v_cfresprodid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_EXPSKILLS = "select tocforgunit_expskills (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_expskills (String v_cfexpskillsid, String v_cforgunitid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_EXPSKILLS);
		result.setString(0, v_cfexpskillsid);
		result.setString(1, v_cforgunitid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_PERS = "select tocfproj_pers (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_pers (String v_cfpersid, String v_cfprojid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_PERS);
		result.setString(0, v_cfpersid);
		result.setString(1, v_cfprojid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCAUDIENCE = "select tocfdcaudience (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdcaudience (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCAUDIENCE);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_FUND = "select tocfrespubl_fund (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_fund (String v_cffundid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_FUND);
		result.setString(0, v_cffundid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_PERS = "select tocfpers_pers (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_pers (String v_cfclassname, String v_cfschemename, String v_cfpersid1, String v_cfpersid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_PERS);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfpersid1);
		result.setString(3, v_cfpersid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEXPSKILLS_CLASS = "select tocfexpskills_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfexpskills_class (String v_cfexpskillsid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEXPSKILLS_CLASS);
		result.setString(0, v_cfexpskillsid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_PRIZE = "select tocfpers_prize (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_prize (String v_cfpersid, String v_cfprizeid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_PRIZE);
		result.setString(0, v_cfpersid);
		result.setString(1, v_cfprizeid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBLSUBTITLE = "select tocfrespublsubtitle (?, ?, ?, ?);";
public PreparedStatement tocfrespublsubtitle (String v_cfrespublid, String v_cfsubtitle, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBLSUBTITLE);
		result.setString(0, v_cfrespublid);
		result.setString(1, v_cfsubtitle);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCCREATOR = "select tocfdccreator (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdccreator (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCCREATOR);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPROD_CLASS = "select tocfresprod_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfresprod_class (String v_cfresprodid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPROD_CLASS);
		result.setString(0, v_cfresprodid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_INDIC = "select tocforgunit_indic (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_indic (String v_cfindicid, String v_cforgunitid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_INDIC);
		result.setString(0, v_cfindicid);
		result.setString(1, v_cforgunitid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_MEDIUM = "select tocfproj_medium (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_medium (String v_cfmediumid, String v_cfprojid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_MEDIUM);
		result.setString(0, v_cfmediumid);
		result.setString(1, v_cfprojid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJABSTR = "select tocfprojabstr (?, ?, ?, ?);";
public PreparedStatement tocfprojabstr (String v_cfprojid, String v_cfabstr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJABSTR);
		result.setString(0, v_cfprojid);
		result.setString(1, v_cfabstr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFQUALTITLE = "select tocfqualtitle (?, ?, ?, ?);";
public PreparedStatement tocfqualtitle (String v_cfqualid, String v_cftitle, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFQUALTITLE);
		result.setString(0, v_cfqualid);
		result.setString(1, v_cftitle);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMETRICSNAME = "select tocfmetricsname (?, ?, ?, ?);";
public PreparedStatement tocfmetricsname (String v_cfmetricsid, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMETRICSNAME);
		result.setString(0, v_cfmetricsid);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEDIUMTITLE = "select tocfmediumtitle (?, ?, ?, ?);";
public PreparedStatement tocfmediumtitle (String v_cfmediumid, String v_cftitle, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEDIUMTITLE);
		result.setString(0, v_cfmediumid);
		result.setString(1, v_cftitle);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_ORGUNIT = "select tocfproj_orgunit (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_orgunit (String v_cforgunitid, String v_cfprojid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_ORGUNIT);
		result.setString(0, v_cforgunitid);
		result.setString(1, v_cfprojid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPROD_SRV = "select tocfresprod_srv (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfresprod_srv (String v_cfresprodid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPROD_SRV);
		result.setString(0, v_cfresprodid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFSRVNAME = "select tocfsrvname (?, ?, ?, ?);";
public PreparedStatement tocfsrvname (String v_cfsrvid, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFSRVNAME);
		result.setString(0, v_cfsrvid);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFINDIC = "select tocfindic (?, ?);";
public PreparedStatement tocfindic (String v_cfindicid, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFINDIC);
		result.setString(0, v_cfindicid);
		result.setString(1, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT = "select tocforgunit (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit (String v_cforgunitid, String v_cfacro, String v_cfcurrcode, int v_cfheadcount, double v_cfturn, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT);
		result.setString(0, v_cforgunitid);
		result.setString(1, v_cfacro);
		result.setString(2, v_cfcurrcode);
		result.setInt(3, v_cfheadcount);
		result.setDouble(4, v_cfturn);
		result.setString(5, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEDIUM_FUND = "select tocfmedium_fund (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfmedium_fund (String v_cffundid, String v_cfmediumid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEDIUM_FUND);
		result.setString(0, v_cffundid);
		result.setString(1, v_cfmediumid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEQUIP_EQUIP = "select tocfequip_equip (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfequip_equip (String v_cfclassname, String v_cfschemename, String v_cfequipid1, String v_cfequipid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEQUIP_EQUIP);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfequipid1);
		result.setString(3, v_cfequipid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCPUBLISHER = "select tocfdcpublisher (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdcpublisher (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCPUBLISHER);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_FUND = "select tocfproj_fund (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_fund (String v_cffundid, String v_cfprojid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_FUND);
		result.setString(0, v_cffundid);
		result.setString(1, v_cfprojid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFUND = "select tocffund (?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffund (String v_cffundid, String v_cfacro, double v_cfamount, String v_cfcurrcode, String v_cfuri, Date v_cfstartdate, Date v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFUND);
		result.setString(0, v_cffundid);
		result.setString(1, v_cfacro);
		result.setDouble(2, v_cfamount);
		result.setString(3, v_cfcurrcode);
		result.setString(4, v_cfuri);
		result.setDate(5, v_cfstartdate);
		result.setDate(6, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFACIL_EVENT = "select tocffacil_event (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffacil_event (String v_cfeventid, String v_cffacilid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFACIL_EVENT);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cffacilid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFACIL_FUND = "select tocffacil_fund (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffacil_fund (String v_cffacilid, String v_cffundid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFACIL_FUND);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cffundid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFQUALKEYW = "select tocfqualkeyw (?, ?, ?, ?);";
public PreparedStatement tocfqualkeyw (String v_cfqualid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFQUALKEYW);
		result.setString(0, v_cfqualid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCV_CLASS = "select tocfcv_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfcv_class (String v_cfcvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCV_CLASS);
		result.setString(0, v_cfcvid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFSRVDESCR = "select tocfsrvdescr (?, ?, ?, ?);";
public PreparedStatement tocfsrvdescr (String v_cfsrvid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFSRVDESCR);
		result.setString(0, v_cfsrvid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBLBIBLNOTE = "select tocfrespublbiblnote (?, ?, ?, ?);";
public PreparedStatement tocfrespublbiblnote (String v_cfrespublid, String v_cfbiblnote, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBLBIBLNOTE);
		result.setString(0, v_cfrespublid);
		result.setString(1, v_cfbiblnote);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCRIGHTSMMLICENSE = "select tocfdcrightsmmlicense (?, ?, ?, ?, ?);";
public PreparedStatement tocfdcrightsmmlicense (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCRIGHTSMMLICENSE);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_RESPUBL = "select tocforgunit_respubl (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_respubl (String v_cforgunitid, String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_RESPUBL);
		result.setString(0, v_cforgunitid);
		result.setString(1, v_cfrespublid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNITKEYW = "select tocforgunitkeyw (?, ?, ?, ?);";
public PreparedStatement tocforgunitkeyw (String v_cforgunitid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNITKEYW);
		result.setString(0, v_cforgunitid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBLNAMEABBREV = "select tocfrespublnameabbrev (?, ?, ?, ?);";
public PreparedStatement tocfrespublnameabbrev (String v_cfrespublid, String v_cfnameabbrev, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBLNAMEABBREV);
		result.setString(0, v_cfrespublid);
		result.setString(1, v_cfnameabbrev);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_QUAL = "select tocfpers_qual (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_qual (String v_cfpersid, String v_cfqualid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_QUAL);
		result.setString(0, v_cfpersid);
		result.setString(1, v_cfqualid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_CLASS = "select tocfrespubl_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_class (String v_cfrespublid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_CLASS);
		result.setString(0, v_cfrespublid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEDIUM = "select tocfmedium (?, ?, ?, ?, ?);";
public PreparedStatement tocfmedium (String v_cfmediumid, String v_cfmediumcreationdate, String v_cfmimetype, double v_cfsize, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEDIUM);
		result.setString(0, v_cfmediumid);
		result.setString(1, v_cfmediumcreationdate);
		result.setString(2, v_cfmimetype);
		result.setDouble(3, v_cfsize);
		result.setString(4, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFGEOBBOX_CLASS = "select tocfgeobbox_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfgeobbox_class (String v_cfgeobboxid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFGEOBBOX_CLASS);
		result.setString(0, v_cfgeobboxid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPROD_MEAS = "select tocfresprod_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfresprod_meas (String v_cfmeasid, String v_cfresprodid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPROD_MEAS);
		result.setString(0, v_cfmeasid);
		result.setString(1, v_cfresprodid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFLANG = "select tocflang (?, ?);";
public PreparedStatement tocflang (String v_cfuri, String v_cflangcode){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFLANG);
		result.setString(0, v_cfuri);
		result.setString(1, v_cflangcode);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFSRV_SRV = "select tocfsrv_srv (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfsrv_srv (String v_cfclassname, String v_cfschemename, String v_cfsrvid1, String v_cfsrvid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFSRV_SRV);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfsrvid1);
		result.setString(3, v_cfsrvid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPROD_GEOBBOX = "select tocfresprod_geobbox (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfresprod_geobbox (String v_cfresprodid, double v_minlat, double v_maxlat, double v_minlon, double v_maxlon, double v_minelev, double v_maxelev, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPROD_GEOBBOX);
		result.setString(0, v_cfresprodid);
		result.setDouble(1, v_minlat);
		result.setDouble(2, v_maxlat);
		result.setDouble(3, v_minlon);
		result.setDouble(4, v_maxlon);
		result.setDouble(5, v_minelev);
		result.setDouble(6, v_maxelev);
		result.setString(7, v_cfclassname);
		result.setString(8, v_cfschemename);
		result.setTimestamp(9, v_cfstartdate);
		result.setTimestamp(10, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCSOURCE = "select tocfdcsource (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdcsource (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCSOURCE);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEXPSKILLSDESCR = "select tocfexpskillsdescr (?, ?, ?, ?);";
public PreparedStatement tocfexpskillsdescr (String v_cfexpskillsid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEXPSKILLSDESCR);
		result.setString(0, v_cfexpskillsid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCLASS_CLASS = "select tocfclass_class (?, ?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfclass_class (String v_cfclassname, String v_cfschemename, String v_cfclassid1, String v_cfclassid2, String v_cfclassschemeid1, String v_cfclassschemeid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCLASS_CLASS);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfclassid1);
		result.setString(3, v_cfclassid2);
		result.setString(4, v_cfclassschemeid1);
		result.setString(5, v_cfclassschemeid2);
		result.setTimestamp(6, v_cfstartdate);
		result.setTimestamp(7, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFINDICDESCR = "select tocfindicdescr (?, ?, ?, ?);";
public PreparedStatement tocfindicdescr (String v_cfindicid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFINDICDESCR);
		result.setString(0, v_cfindicid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEDIUMDESCR = "select tocfmediumdescr (?, ?, ?, ?);";
public PreparedStatement tocfmediumdescr (String v_cfmediumid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEDIUMDESCR);
		result.setString(0, v_cfmediumid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEQUIP_INDIC = "select tocfequip_indic (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfequip_indic (String v_cfequipid, String v_cfindicid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEQUIP_INDIC);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfindicid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPRIZE = "select tocfprize (?, ?);";
public PreparedStatement tocfprize (String v_cfprizeid, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPRIZE);
		result.setString(0, v_cfprizeid);
		result.setString(1, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCURRENCY = "select tocfcurrency (?, ?, ?);";
public PreparedStatement tocfcurrency (String v_cfcurrcode, String v_cfnumcurrcode, String v_cfuri){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCURRENCY);
		result.setString(0, v_cfcurrcode);
		result.setString(1, v_cfnumcurrcode);
		result.setString(2, v_cfuri);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERSKEYW = "select tocfperskeyw (?, ?, ?, ?);";
public PreparedStatement tocfperskeyw (String v_cfpersid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERSKEYW);
		result.setString(0, v_cfpersid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCCOVERAGESPATIAL = "select tocfdccoveragespatial (?, ?, ?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdccoveragespatial (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdcvalue, int v_cffdcprecision, int v_cffdcxcoordinate, int v_cffdcycoordinate, int v_cffdczcoordinate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCCOVERAGESPATIAL);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdcvalue);
		result.setInt(5, v_cffdcprecision);
		result.setInt(6, v_cffdcxcoordinate);
		result.setInt(7, v_cffdcycoordinate);
		result.setInt(8, v_cffdczcoordinate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_DC = "select tocfpers_dc (?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_dc (String v_cfdcid, String v_cfpersid, String v_cfclassname, String v_cfschemename, String v_cfdcscheme, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_DC);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfpersid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setString(4, v_cfdcscheme);
		result.setTimestamp(5, v_cfstartdate);
		result.setTimestamp(6, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEVENT = "select tocfevent (?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfevent (String v_cfeventid, String v_cfcitytown, String v_cfcountrycode, String v_cffeeorfree, String v_cfuri, Date v_cfstartdate, Date v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEVENT);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cfcitytown);
		result.setString(2, v_cfcountrycode);
		result.setString(3, v_cffeeorfree);
		result.setString(4, v_cfuri);
		result.setDate(5, v_cfstartdate);
		result.setDate(6, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPATABSTR = "select tocfrespatabstr (?, ?, ?, ?);";
public PreparedStatement tocfrespatabstr (String v_cfrespatid, String v_cfabstr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPATABSTR);
		result.setString(0, v_cfrespatid);
		result.setString(1, v_cfabstr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEVENT_EVENT = "select tocfevent_event (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfevent_event (String v_cfclassname, String v_cfschemename, String v_cfeventid1, String v_cfeventid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEVENT_EVENT);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfeventid1);
		result.setString(3, v_cfeventid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFQUALDESCR = "select tocfqualdescr (?, ?, ?, ?);";
public PreparedStatement tocfqualdescr (String v_cfqualid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFQUALDESCR);
		result.setString(0, v_cfqualid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFDCRIGHTSMMRIGHTS = "select tocffdcrightsmmrights (?, ?, ?, ?, ?);";
public PreparedStatement tocffdcrightsmmrights (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cffdcrightsconstraint){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFDCRIGHTSMMRIGHTS);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cffdcrightsconstraint);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFINDIC_MEAS = "select tocfindic_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfindic_meas (String v_cfindicid, String v_cfmeasid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFINDIC_MEAS);
		result.setString(0, v_cfindicid);
		result.setString(1, v_cfmeasid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPATKEYW = "select tocfrespatkeyw (?, ?, ?, ?);";
public PreparedStatement tocfrespatkeyw (String v_cfrespatid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPATKEYW);
		result.setString(0, v_cfrespatid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBL_RESPUBL = "select tocfrespubl_respubl (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespubl_respubl (String v_cfclassname, String v_cfschemename, String v_cfrespublid1, String v_cfrespublid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBL_RESPUBL);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfrespublid1);
		result.setString(3, v_cfrespublid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFSRV_MEDIUM = "select tocfsrv_medium (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfsrv_medium (String v_cfmediumid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFSRV_MEDIUM);
		result.setString(0, v_cfmediumid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEDIUM_CLASS = "select tocfmedium_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfmedium_class (String v_cfmediumid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEDIUM_CLASS);
		result.setString(0, v_cfmediumid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMETRICSKEYW = "select tocfmetricskeyw (?, ?, ?, ?);";
public PreparedStatement tocfmetricskeyw (String v_cfmetricsid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMETRICSKEYW);
		result.setString(0, v_cfmetricsid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEDIUM_INDIC = "select tocfmedium_indic (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfmedium_indic (String v_cfindicid, String v_cfmediumid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEDIUM_INDIC);
		result.setString(0, v_cfindicid);
		result.setString(1, v_cfmediumid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFACILNAME = "select tocffacilname (?, ?, ?, ?);";
public PreparedStatement tocffacilname (String v_cffacilid, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFACILNAME);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_PROJ = "select tocfproj_proj (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_proj (String v_cfclassname, String v_cfschemename, String v_cfprojid1, String v_cfprojid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_PROJ);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfprojid1);
		result.setString(3, v_cfprojid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPADDR_CLASS = "select tocfpaddr_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfpaddr_class (String v_cfpaddrid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPADDR_CLASS);
		result.setString(0, v_cfpaddrid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_FACIL = "select tocforgunit_facil (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_facil (String v_cffacilid, String v_cforgunitid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_FACIL);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cforgunitid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_EQUIP = "select tocforgunit_equip (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_equip (String v_cfequipid, String v_cforgunitid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_EQUIP);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cforgunitid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPRODVERSINFO = "select tocfresprodversinfo (?, ?, ?, ?);";
public PreparedStatement tocfresprodversinfo (String v_cfresprodid, String v_cfversinfo, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPRODVERSINFO);
		result.setString(0, v_cfresprodid);
		result.setString(1, v_cfversinfo);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFEADDR_CLASS = "select tocfeaddr_class (?, ?, ?, ?, ?);";
public PreparedStatement tocfeaddr_class (String v_cfeaddrid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFEADDR_CLASS);
		result.setString(0, v_cfeaddrid);
		result.setString(1, v_cfclassname);
		result.setString(2, v_cfschemename);
		result.setTimestamp(3, v_cfstartdate);
		result.setTimestamp(4, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFUND_MEAS = "select tocffund_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffund_meas (String v_cffundid, String v_cfmeasid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFUND_MEAS);
		result.setString(0, v_cffundid);
		result.setString(1, v_cfmeasid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCITEDESCR = "select tocfcitedescr (?, ?, ?, ?);";
public PreparedStatement tocfcitedescr (String v_cfciteid, String v_cfdescr, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCITEDESCR);
		result.setString(0, v_cfciteid);
		result.setString(1, v_cfdescr);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCFORMAT = "select tocfdcformat (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdcformat (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCFORMAT);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPRODNAME = "select tocfresprodname (?, ?, ?, ?);";
public PreparedStatement tocfresprodname (String v_cfresprodid, String v_cfname, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPRODNAME);
		result.setString(0, v_cfresprodid);
		result.setString(1, v_cfname);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFCLASSSCHEME_CLASSSCHEME = "select tocfclassscheme_classscheme (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfclassscheme_classscheme (String v_cfclassname, String v_cfschemename, String v_cfclassschemeid1, String v_cfclassschemeid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFCLASSSCHEME_CLASSSCHEME);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cfclassschemeid1);
		result.setString(3, v_cfclassschemeid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFSRV_EVENT = "select tocfsrv_event (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfsrv_event (String v_cfeventid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFSRV_EVENT);
		result.setString(0, v_cfeventid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPAT_EQUIP = "select tocfrespat_equip (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfrespat_equip (String v_cfequipid, String v_cfrespatid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPAT_EQUIP);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfrespatid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFACIL_FACIL = "select tocffacil_facil (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffacil_facil (String v_cfclassname, String v_cfschemename, String v_cffacilid1, String v_cffacilid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFACIL_FACIL);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cffacilid1);
		result.setString(3, v_cffacilid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFACIL_EQUIP = "select tocffacil_equip (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocffacil_equip (String v_cfequipid, String v_cffacilid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFACIL_EQUIP);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cffacilid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFGEOBBOX = "select tocfgeobbox (?, ?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfgeobbox (String v_cfgeobboxid, double v_cfeblong, double v_cfmaxelev, double v_cfminelev, double v_cfnblat, double v_cfsblat, String v_cfuri, double v_cfwblong){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFGEOBBOX);
		result.setString(0, v_cfgeobboxid);
		result.setDouble(1, v_cfeblong);
		result.setDouble(2, v_cfmaxelev);
		result.setDouble(3, v_cfminelev);
		result.setDouble(4, v_cfnblat);
		result.setDouble(5, v_cfsblat);
		result.setString(6, v_cfuri);
		result.setDouble(7, v_cfwblong);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String EPOSMINDATE = "select eposmindate ();";
public PreparedStatement eposmindate (){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(EPOSMINDATE);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFMEASKEYW = "select tocfmeaskeyw (?, ?, ?, ?);";
public PreparedStatement tocfmeaskeyw (String v_cfmeasid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFMEASKEYW);
		result.setString(0, v_cfmeasid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFFUNDKEYW = "select tocffundkeyw (?, ?, ?, ?);";
public PreparedStatement tocffundkeyw (String v_cffundid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFFUNDKEYW);
		result.setString(0, v_cffundid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_EQUIP = "select tocfproj_equip (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_equip (String v_cfequipid, String v_cfprojid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_EQUIP);
		result.setString(0, v_cfequipid);
		result.setString(1, v_cfprojid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_SRV = "select tocfproj_srv (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_srv (String v_cfprojid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_SRV);
		result.setString(0, v_cfprojid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFSRV_MEAS = "select tocfsrv_meas (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfsrv_meas (String v_cfmeasid, String v_cfsrvid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFSRV_MEAS);
		result.setString(0, v_cfmeasid);
		result.setString(1, v_cfsrvid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFORGUNIT_ORGUNIT = "select tocforgunit_orgunit (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocforgunit_orgunit (String v_cfclassname, String v_cfschemename, String v_cforgunitid1, String v_cforgunitid2, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFORGUNIT_ORGUNIT);
		result.setString(0, v_cfclassname);
		result.setString(1, v_cfschemename);
		result.setString(2, v_cforgunitid1);
		result.setString(3, v_cforgunitid2);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_DC = "select tocfproj_dc (?, ?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_dc (String v_cfdcid, String v_cfprojid, String v_cfclassname, String v_cfschemename, String v_cfdcscheme, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_DC);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfprojid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setString(4, v_cfdcscheme);
		result.setTimestamp(5, v_cfstartdate);
		result.setTimestamp(6, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFDCSUBJECT = "select tocfdcsubject (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfdcsubject (String v_cfdcid, String v_cfdclangtag, String v_cfdcscheme, String v_cfdctrans, String v_cfdctype, String v_cfdcvalue){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFDCSUBJECT);
		result.setString(0, v_cfdcid);
		result.setString(1, v_cfdclangtag);
		result.setString(2, v_cfdcscheme);
		result.setString(3, v_cfdctrans);
		result.setString(4, v_cfdctype);
		result.setString(5, v_cfdcvalue);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPROJ_FACIL = "select tocfproj_facil (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfproj_facil (String v_cffacilid, String v_cfprojid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPROJ_FACIL);
		result.setString(0, v_cffacilid);
		result.setString(1, v_cfprojid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFRESPUBLKEYW = "select tocfrespublkeyw (?, ?, ?, ?);";
public PreparedStatement tocfrespublkeyw (String v_cfrespublid, String v_cfkeyw, String v_cflangcode, String v_cftrans){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFRESPUBLKEYW);
		result.setString(0, v_cfrespublid);
		result.setString(1, v_cfkeyw);
		result.setString(2, v_cflangcode);
		result.setString(3, v_cftrans);
	}
	catch (SQLException e) {
	}
	return result;
}

public static final String TOCFPERS_RESPAT = "select tocfpers_respat (?, ?, ?, ?, ?, ?);";
public PreparedStatement tocfpers_respat (String v_cfpersid, String v_cfrespatid, String v_cfclassname, String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate){
	PreparedStatement result = null;
	try {
		result = connection.prepareStatement(TOCFPERS_RESPAT);
		result.setString(0, v_cfpersid);
		result.setString(1, v_cfrespatid);
		result.setString(2, v_cfclassname);
		result.setString(3, v_cfschemename);
		result.setTimestamp(4, v_cfstartdate);
		result.setTimestamp(5, v_cfenddate);
	}
	catch (SQLException e) {
	}
	return result;
}

public List<PreparedStatement> getStatements() { return statements; }}

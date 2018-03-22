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

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.logging.Logger;

import org.epos.system.UpdateMaterialized;

public class Map2Cerif {
    
    /*
     * 
     * Webservice
     * 
     */
	private final static Logger LOGGER = Logger.getLogger(Logger.GLOBAL_LOGGER_NAME);
	
    OutputStreamWriter os;
    Connection conn;
    HashMap<String, PreparedStatement> statements;
    
    public void setDBConnection(Connection conn) throws SQLException{
	this.conn = conn;
	conn.setAutoCommit(false);
	statements=new HashMap<String, PreparedStatement>();
    }
    
    public void commit() throws SQLException{
	if (conn!=null)
	    conn.commit();
    }
    
    public void rollback() throws SQLException{
	if (conn!=null)
	    conn.rollback();
    }
    
    public void setOutputStreamWriter(OutputStreamWriter os) {
	this.os = os;
    }
    public void closeFile() throws IOException{
	if (os!=null)
	    os.close();
    }
    
    protected String quote(String s) {
	return "'"+s.replaceAll("'", "''")+"'";
    }
    protected String quote(Date d) {
	if (d==null)
	    return "null";
	else
	    return "'"+d.toString()+"'";
    }
    protected String quote(Timestamp t) {
	if (t==null)
	    return "null";
	else
	    return "'"+t.toString()+"'";
    }
    /*
     *create a hash of prepared statements for reuse 
     * */
    protected PreparedStatement prepareStatement(String s) throws SQLException, IOException {
	PreparedStatement ps = statements.get(s);
	if (ps == null) {
	    ps = conn.prepareStatement(s);
	    statements.put(s, ps);
	}
	return ps;
    }
    
    public static final String WEBSERVICE = "select webservice (?, ?, ?, ?);";
    
    public void map2Webservice(String uuidwebservice, String title, String description, String uri)
	    throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICE);
	    result.setString(1, uuidwebservice);
	    result.setString(2, title);
	    result.setString(3, description);
	    result.setString(4, uri);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservice ("+quote(uuidwebservice)+", "+quote(title)+", "+quote(description)+", "+quote(uri)+");\n");
	}
    }
    
    public static final String WEBSERVICEKEYWORD = "select webservicekeyword (?, ?);";
    
    public void map2Webservicekeyword(String uuidwebservice, String keyword) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICEKEYWORD);
	    result.setString(1, uuidwebservice);
	    result.setString(2, keyword);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservicekeyword ("+quote(uuidwebservice)+", "+quote(keyword)+");\n");
	}
    }
    
    public static final String WEBSERVICEVERSION = "select webserviceversion (?, ?);";
    
    public void map2Webserviceversion(String uuidwebservice, String version) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICEVERSION);
	    result.setString(1, uuidwebservice);
	    result.setString(2, version);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webserviceversion ("+quote(uuidwebservice)+", "+quote(version)+");\n");
	}
    }
    
    public static final String WEBSERVICEDOCUMENTATION = "select  webservicedocumentation (?, ?);";
    
    public void map2Webservicedocumentation(String uuidwebservice, String doc) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICEDOCUMENTATION);
	    result.setString(1, uuidwebservice);
	    result.setString(2, doc);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservicedocumentation ("+quote(uuidwebservice)+", "+quote(doc)+");\n");
	}
    }
    
    public static final String WEBSERVICEOPERATION = "select  webserviceoperation (?, ?);";
    
    public void map2Webserviceoperation(String uuidwebservice, String op) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICEOPERATION);
	    result.setString(1, uuidwebservice);
	    result.setString(2, op);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webserviceoperation ("+quote(uuidwebservice)+", "+quote(op)+");\n");
	}
    }
    
    public static final String WEBSERVICETHESAURUSKEYWORD = "select webservicethesauruskeyword (?, ?, ?);";
    
    public void map2Webservicekeyword(String uuidwebservice, String keyword, String thesaurus) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICETHESAURUSKEYWORD);
	    result.setString(1, uuidwebservice);
	    result.setString(2, keyword);
	    result.setString(3, thesaurus);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservicethesauruskeyword ("+quote(uuidwebservice)+", "+quote(keyword)+", "+quote(thesaurus)+");\n");
	}
    }
    
    public static final String WEBSERVICEPERSON = "select webservicperson (?, ?, ?);";
    
    public void map2Webserviceperson(String uuidwebservice, String uuidpers, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICEPERSON);
	    result.setString(1, uuidwebservice);
	    result.setString(2, uuidpers);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservicperson ("+quote(uuidwebservice)+", "+quote(uuidpers)+", "+quote(role)+");\n");
	}
    }
    
    public static final String WEBSERVICEORGANISATION = "select webserviceorganisation (?, ?, ?);";
    
    public void map2Webserviceorganisation(String uuidwebservice, String uuidorgunit, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICEORGANISATION);
	    result.setString(1, uuidwebservice);
	    result.setString(2, uuidorgunit);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webserviceorganisation ("+quote(uuidwebservice)+", "+quote(uuidorgunit)+", "+quote(role)+");\n");
	}
    }
    
    public static final String WEBSERVICEDATES = "select webservicedates (?, ?, ?, ?);";
    
    public void map2Webservicedates(String uuidwebservice, Date creation, Date revision, Date publication)
	    throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICEDATES);
	    result.setString(1, uuidwebservice);
	    result.setDate(2, creation);
	    result.setDate(3, revision);
	    result.setDate(4, publication);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservicedates ("+quote(uuidwebservice)+", "+quote(creation)+", "+quote(revision)+", "+quote(publication)+");\n");
	}
    }
    
    public static final String WEBSERVICERESOLUTION = "select webserviceresolution (?, ?);";
    
    public void map2Webserviceresolution(String uuidwebservice, String resolution) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICERESOLUTION);
	    result.setString(1, uuidwebservice);
	    result.setString(2, resolution);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webserviceresolution ("+quote(uuidwebservice)+", "+quote(resolution)+");\n");
	}
    }
    
    public static final String WEBSERVICESPATIALREPRESENTATIONTYPE = "select webservicespatialrepresentationtype (?, ?);";
    
    public void map2Webservicespatialrepresentationtype(String uuidwebservice, String spatialrepresentationtype)
	    throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICESPATIALREPRESENTATIONTYPE);
	    result.setString(1, uuidwebservice);
	    result.setString(2, spatialrepresentationtype);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservicespatialrepresentationtype ("+quote(uuidwebservice)+", "+quote(spatialrepresentationtype)+");\n");
	}
    }
    
    public static final String WEBSERVICESPATIALREFERENCESYSTEM = "select webservicespatialreferencesystem (?, ?);";
    
    public void map2Webservicespatialreferencesystem(String uuidwebservice, String spatialreferencesystem)
	    throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICESPATIALREFERENCESYSTEM);
	    result.setString(1, uuidwebservice);
	    result.setString(2, spatialreferencesystem);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservicespatialreferencesystem ("+quote(uuidwebservice)+", "+quote(spatialreferencesystem)+");\n");
	}
    }
    
    public static final String WEBSERVICEISOTOPIC = "select webserviceisotopic (?, ?);";
    
    public void map2Webserviceisotopic(String uuidwebservice, String isotopic) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICEISOTOPIC);
	    result.setString(1, uuidwebservice);
	    result.setString(2, isotopic);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webserviceisotopic ("+quote(uuidwebservice)+", "+quote(isotopic)+");\n");
	}
    }
    
    public static final String WEBSERVICEFORMAT = "select webserviceformat (?, ?);";
    
    public void map2Webserviceformat(String uuidwebservice, String format) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICEFORMAT);
	    result.setString(1, uuidwebservice);
	    result.setString(2, format);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webserviceformat ("+quote(uuidwebservice)+", "+quote(format)+");\n");
	}
    }
    
    public static final String WEBSERVICETYPE = "select webservicetype (?, ?);";
    
    public void map2Webservicetype(String uuidwebservice, String servicetype) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICETYPE);
	    result.setString(1, uuidwebservice);
	    result.setString(2, servicetype);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservicetype ("+quote(uuidwebservice)+", "+quote(servicetype)+");\n");
	}
    }
    
    public static final String WEBSERVICEDOMAIN = "select webservicedomain (?, ?);";
    
    public void map2Webservicedomain(String uuidwebservice, String domain) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICEDOMAIN);
	    result.setString(1, uuidwebservice);
	    result.setString(2, domain);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservicedomain ("+quote(uuidwebservice)+", "+quote(domain)+");\n");
	}
    }
    
    public static final String WEBSERVICESUBDOMAIN = "select webservicesubdomain (?, ?);";
    
    public void map2Webservicesubdomain(String uuidwebservice, String subdomain) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICESUBDOMAIN);
	    result.setString(1, uuidwebservice);
	    result.setString(2, subdomain);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservicesubdomain ("+quote(uuidwebservice)+", "+quote(subdomain)+");\n");
	}
    }
    
    public static final String WEBSERVICEACCESSANDUSERESTRICTION = "select webserviceaccessanduserestriction (?, ?);";
    
    public void map2Webserviceaccessanduserestriction(String uuidwebservice, String restriction) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICEACCESSANDUSERESTRICTION);
	    result.setString(1, uuidwebservice);
	    result.setString(2, restriction);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webserviceaccessanduserestriction ("+quote(uuidwebservice)+", "+quote(restriction)+");\n");
	}
    }
    
    public static final String WEBSERVICEPUBLICACCESSLIMIT = "select webservicepublicaccesslimit (?, ?);";
    
    public void map2Webservicepublicaccesslimit(String uuidwebservice, String accesslimit) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICEPUBLICACCESSLIMIT);
	    result.setString(1, uuidwebservice);
	    result.setString(2, accesslimit);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservicepublicaccesslimit ("+quote(uuidwebservice)+", "+quote(accesslimit)+");\n");
	}
    }
    
    public static final String WEBSERVICEDDSSID = "select webserviceddssid (?, ?);";
    public void map2Webserviceddssid(String uuidwebservice, String ddssid) throws SQLException, IOException {
	
	if (conn != null) {
	    System.out.println(uuidwebservice+"  ddss "+ddssid);
	    PreparedStatement result = prepareStatement(WEBSERVICEDDSSID);
	    result.setString(1, uuidwebservice);
	    result.setString(2, ddssid);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webserviceddssid ("+quote(uuidwebservice)+", "+quote(ddssid)+");\n");
	}
    }
    
    public static final String WEBSERVICEACTION = "select webserviceaction (?, ?);";
    public void map2Webserviceaction(String uuidwebservice, String action) throws SQLException, IOException {
	
	if (conn != null) {
	    System.out.println(uuidwebservice+"  action "+action);
	    PreparedStatement result = prepareStatement(WEBSERVICEACTION);
	    result.setString(1, uuidwebservice);
	    result.setString(2, action);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webserviceaction ("+quote(uuidwebservice)+", "+quote(action)+");\n");
	}
    }
    
    public static final String WEBSERVICELINEAGE = "select webservicelineage (?, ?);";
    public void map2Webservicelineage(String uuidwebservice, String lineage) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICELINEAGE);
	    result.setString(1, uuidwebservice);
	    result.setString(2, lineage);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservicelineage ("+quote(uuidwebservice)+", "+quote(lineage)+");\n");
	}
    }
    
    public static final String WEBSERVICETEMPORALEXTENT = "select webservicetemporalextent (?, ?, ?);";
    
    public void map2Webservicetemporalextent(String uuidwebservice, Timestamp start, Timestamp end)
	    throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICETEMPORALEXTENT);
	    result.setString(1, uuidwebservice);
	    result.setTimestamp(2, start);
	    result.setTimestamp(3, end);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservicetemporalextent ("+quote(uuidwebservice)+", "+quote(start)+", "+quote(end)+");\n");
	}
    }
    
    public static final String WEBSERVICELOCATION = "select webservicelocation (?, ?, ?, ?, ?, ?, ?);";
    
    public void map2Webservicelocation(String uuidwebservice, Double minlat, Double maxlat, Double minlon,
	    Double maxlon, Double minelev, Double maxelev) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(WEBSERVICELOCATION);
	    result.setString(1, uuidwebservice);
	    
	    if (minlat == null)
		result.setNull(2, java.sql.Types.DOUBLE);
	    else
		result.setDouble(2, minlat);
	    
	    if (maxlat == null)
		result.setNull(3, java.sql.Types.DOUBLE);
	    else
		result.setDouble(3, maxlat);
	    
	    if (minlon == null)
		result.setNull(4, java.sql.Types.DOUBLE);
	    else
		result.setDouble(4, minlon);
	    
	    if (maxlon == null)
		result.setNull(5, java.sql.Types.DOUBLE);
	    else
		result.setDouble(5, maxlon);
	    
	    if (minelev == null)
		result.setNull(6, java.sql.Types.DOUBLE);
	    else
		result.setDouble(6, minelev);
	    
	    if (maxelev == null)
		result.setNull(7, java.sql.Types.DOUBLE);
	    else
		result.setDouble(7, maxelev);
	    
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webservicelocation ("+quote(uuidwebservice)+", "+minlat+", "+maxlat+", "+minlon+", "+maxlon+", "+minelev+", "+maxelev+");\n");
	}
    }
    
    public static final String WEBSERVICEPARAMETER = "select webserviceparameter (?, ?, ?, ?);";
    
    public void map2Webserviceparameter(String webservicuri, String paramgroupid, String paramclasshuman, String param)
	    throws SQLException, IOException {
	
	if (conn != null) {
	    System.out.println("PARAMID" + webservicuri +"  "+ paramgroupid+"PARAMETER "+ param);
	    PreparedStatement result = prepareStatement(WEBSERVICEPARAMETER);
	    result.setString(1, webservicuri);
	    result.setString(2, paramgroupid);
	    result.setString(3, paramclasshuman);
	    result.setString(4, param);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select webserviceparameter ("+quote(webservicuri)+", "+quote(paramgroupid)+", "+quote(paramclasshuman)+", "+quote(param)+");\n");
	}
    }
    
    public static final String DEL_WEBSERVICEPARAMETER = "select del_webserviceparameter (?);";
    
    public void map2DelWebserviceparameter(String webservicuri) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DEL_WEBSERVICEPARAMETER);
	    result.setString(1, webservicuri);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select del_webserviceparameter ("+quote(webservicuri)+");\n");
	}
    }
    
    public static final String DEL_WEBSERVICE = "select del_webservice (?);";
    
    public void map2DelWebservice(String uuidwebservice) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DEL_WEBSERVICE);
	    result.setString(1, uuidwebservice);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select del_webservice ("+quote(uuidwebservice)+");\n");
	}
    }
    
    /*
     * 
     * Organisation
     * 
     */
    public static final String ORGANISATION = "select organisation (?, ?);";
    
    public void map2Organisation(String uuidorgunit, String name) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(ORGANISATION);
	    result.setString(1, uuidorgunit);
	    result.setString(2, name);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select organisation ("+quote(uuidorgunit)+", "+quote(name)+");\n");
	}
    }
    
    public static final String ORGANISATIONPARENT = "select organisationparent (?, ?);";
    
    public void map2Organisationparent(String uuidparent, String uuidchild) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(ORGANISATIONPARENT);
	    result.setString(1, uuidparent);
	    result.setString(2, uuidchild);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select organisationparent ("+quote(uuidparent)+", "+quote(uuidchild)+");\n");
	}
    }
    
    public static final String ORGANISATIONWEBSITE = "select organisationwebsite (?, ?);";
    
    public void map2Organisationwebsite(String uuidorgunit, String url) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(ORGANISATIONWEBSITE);
	    result.setString(1, uuidorgunit);
	    result.setString(2, url);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select organisationwebsite ("+quote(uuidorgunit)+", "+quote(url)+");\n");
	}
    }
    
    public static final String ORGANISATIONNATIVENAME = "select organisationnativename (?, ?, ?);";
    
    public void map2Organisationnativename(String uuidorgunit, String nativename, String lang) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(ORGANISATIONNATIVENAME);
	    result.setString(1, uuidorgunit);
	    result.setString(2, nativename);
	    result.setString(3, lang);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select organisationnativename ("+quote(uuidorgunit)+", "+quote(nativename)+", "+quote(lang)+");\n");
	}
    }
    
    public static final String ORGANISATIONADDRESS = "select organisationaddress (?,?,?,?,?);";
    
    public void map2Organisationaddress(String uuidorgunit, String street, String locality, String postcode,
	    String country) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(ORGANISATIONADDRESS);
	    result.setString(1, uuidorgunit);
	    result.setString(2, street);
	    result.setString(3, locality);
	    result.setString(4, postcode);
	    result.setString(5, country);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select organisationaddress ("+quote(uuidorgunit)+", "+quote(street)+", "+quote(locality)+", "+quote(postcode)+", "+quote(country)+");\n");
	}
    }
    
    public static final String ORGANISATIONLOCATION = "select organisationlocation (?, ?, ?, ?);";
    
    public void map2Organisationlocation(String uuidorgunit, Double lat, Double lon, Double elev) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(ORGANISATIONLOCATION);
	    result.setString(1, uuidorgunit);
	    
	    if (lat == null)
		result.setNull(2, java.sql.Types.DOUBLE);
	    else
		result.setDouble(2, lat);
	    
	    if (lon == null)
		result.setNull(3, java.sql.Types.DOUBLE);
	    else
		result.setDouble(3, lon);
	    
	    if (elev == null)
		result.setNull(4, java.sql.Types.DOUBLE);
	    else
		result.setDouble(4, elev);
	    
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select organisationlocation ("+quote(uuidorgunit)+", "+lat+", "+lon+", "+elev+");\n");
	}
    }
    
    public static final String ORGANISATIONEMAIL = "select organisationemail (?, ?);";
    
    public void map2Organisationemail(String uuidorgunit, String email) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(ORGANISATIONEMAIL);
	    result.setString(1, uuidorgunit);
	    result.setString(2, email);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select organisationemail ("+quote(uuidorgunit)+", "+quote(email)+");\n");
	}
    }
    
    public static final String ORGANISATIONLOGO = "select organisationlogo (?, ?);";
    
    public void map2Organisationlogo(String uuidorgunit, String logo) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(ORGANISATIONLOGO);
	    result.setString(1, uuidorgunit);
	    result.setString(2, logo);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select organisationlogo ("+quote(uuidorgunit)+", "+quote(logo)+");\n");
	}
    }
    
    public static final String ORGANISATIONTYPE = "select organisationtype (?, ?);";
    
    public void map2Organisationtype(String uuidorgunit, String orgtype) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(ORGANISATIONTYPE);
	    result.setString(1, uuidorgunit);
	    result.setString(2, orgtype);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select organisationtype ("+quote(uuidorgunit)+", "+quote(orgtype)+");\n");
	}
    }
    
    public static final String ORGANISATIONPROJECT = "select organisationproject (?, ?, ?);";
    
    public void map2Organisationproject(String uuidorgunit, String project, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(ORGANISATIONPROJECT);
	    result.setString(1, uuidorgunit);
	    result.setString(2, project);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select organisationproject ("+quote(uuidorgunit)+", "+quote(project)+", "+quote(role)+");\n");
	}
    }
    
    public static final String ORGANISATIONPERSON = "select organisationperson (?, ?, ?);";
    
    public void map2Organisationperson(String uuidpers, String uuidorgunit, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(ORGANISATIONPERSON);
	    result.setString(1, uuidpers);
	    result.setString(2, uuidorgunit);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select organisationperson ("+quote(uuidpers)+", "+quote(uuidorgunit)+", "+quote(role)+");\n");
	}
    }
    
    /*
     * 
     * Project
     * 
     */
    public static final String PROJECT = "select project (?, ?, ?);";
    
    public void map2Project(String uuidproject, String name, String description) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PROJECT);
	    result.setString(1, uuidproject);
	    result.setString(2, name);
	    result.setString(3, description);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select project ("+quote(uuidproject)+", "+quote(name)+", "+quote(description)+");\n");
	}
    }
    /*
     * 
     * Equipment
     * 
     */
    
    public static final String EQUIPMENT = "select equipment (?, ?, ?);";
    
    public void map2Equipment(String uuidequip, String name, String description) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENT);
	    result.setString(1, uuidequip);
	    result.setString(2, name);
	    result.setString(3, description);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipment ("+quote(uuidequip)+", "+quote(name)+", "+quote(description)+");\n");
	}
    }
    
    public static final String EQUIPMENTLOCATION = "select equipmentlocation (?, ?, ?, ?);";
    
    public void map2Equipmentlocation(String uuidequip, Double lat, Double lon, Double elev) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENTLOCATION);
	    result.setString(1, uuidequip);
	    result.setDouble(2, lat);
	    result.setDouble(3, lon);
	    if (elev == null)
		result.setNull(4, java.sql.Types.DOUBLE);
	    else
		result.setDouble(4, elev);
	    
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipmentlocation ("+quote(uuidequip)+", "+lat+", "+lon+", "+elev+");\n");
	}
    }
    
    public static final String EQUIPMENTORGANISATION = "select equipmentorganisation (?, ?, ?);";
    
    public void map2Equipmentorganisation(String uuidequip, String uuidorgunit, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENTORGANISATION);
	    result.setString(1, uuidequip);
	    result.setString(2, uuidorgunit);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipmentorganisation ("+quote(uuidequip)+", "+quote(uuidorgunit)+", "+quote(role)+");\n");
	}
    }
    
    public static final String EQUIPMENTTYPE = "select equipmenttype (?, ?);";
    
    public void map2Equipmenttype(String uuidequip, String type) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENTTYPE);
	    result.setString(1, uuidequip);
	    result.setString(2, type);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipmenttype ("+quote(uuidequip)+", "+quote(type)+");\n");
	}
    }
    
    public static final String EQUIPMENTPERSON = "select equipmentperson (?, ?, ?);";
    
    public void map2Equipmentperson(String uuidequip, String uuidperson, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENTPERSON);
	    result.setString(1, uuidequip);
	    result.setString(2, uuidperson);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipmentperson ("+quote(uuidequip)+", "+quote(uuidperson)+", "+quote(role)+");\n");
	}
    }
    
    public static final String EQUIPMENTFACILITY = "select equipmentfacility (?, ?, ?);";
    
    public void map2Equipmentfacility(String uuidequip, String uuidfacility, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENTFACILITY);
	    result.setString(1, uuidequip);
	    result.setString(2, uuidfacility);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipmentfacility ("+quote(uuidequip)+", "+quote(uuidfacility)+", "+quote(role)+");\n");
	}
    }
    
    public static final String EQUIPMENTCOUNT = "select equipmentcount (?, ?);";
    
    public void map2Equipmentcount(String uuidequip, Integer count) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENTCOUNT);
	    result.setString(1, uuidequip);
	    result.setInt(2, count);
	    
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipmentcount ("+quote(uuidequip)+", "+count+");\n");
	}
    }
    
    public static final String EQUIPMENTSERIAL = "select equipmentserial (?, ?);";
    
    public void map2Equipmentserial(String uuidequip, String serial) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENTSERIAL);
	    result.setString(1, uuidequip);
	    result.setString(2, serial);
	    
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipmentserial ("+quote(uuidequip)+", "+quote(serial)+");\n");
	}
    }
    
    public static final String EQUIPMENTFILTER = "select equipmentfilter (?, ?);";
    
    public void map2Equipmentfilter(String uuidequip, String filter) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENTFILTER);
	    result.setString(1, uuidequip);
	    result.setString(2, filter);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipmentfilter ("+quote(uuidequip)+", "+quote(filter)+");\n");
	}
    }
    
    public static final String EQUIPMENTORIENTATION = "select equipmentorientation (?, ?);";
    
    public void map2Equipmentorientation(String uuidequip, String orientation) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENTORIENTATION);
	    result.setString(1, uuidequip);
	    result.setString(2, orientation);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipmentorientation ("+quote(uuidequip)+", "+quote(orientation)+");\n");
	}
    }
    
    public static final String EQUIPMENTPARENT = "select equipmentparent (?, ?);";
    
    public void map2Equipmentparent(String uuidparent, String uuidchild) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENTPARENT);
	    result.setString(1, uuidparent);
	    result.setString(2, uuidchild);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipmentparent ("+quote(uuidparent)+", "+quote(uuidchild)+");\n");
	}
    }
    
    public static final String EQUIPMENTRESOLUTION = "select equipmentresolution (?, ?);";
    
    public void map2Equipmentresolution(String uuidequip, Double res) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENTRESOLUTION);
	    result.setString(1, uuidequip);
	    result.setDouble(2, res);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipmentresolution ("+quote(uuidequip)+", "+res+");\n");
	}
    }
    
    public static final String EQUIPMENTDYNAMICRANGE = "select equipmentdynamicrange (?, ?, ?);";
    
    public void map2Equipmentdynamicrange(String uuidequip, Double value, String unit) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENTDYNAMICRANGE);
	    result.setString(1, uuidequip);
	    result.setDouble(2, value);
	    result.setString(3, unit);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipmentdynamicrange ("+quote(uuidequip)+", "+value+", "+quote(unit)+");\n");
	}
    }
    
    public static final String EQUIPMENTSAMPLEPERIOD = "select equipmentsampleperiod (?, ?, ?);";
    
    public void map2Equipmentsampleperiod(String uuidequip, Double value, String unit) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENTSAMPLEPERIOD);
	    result.setString(1, uuidequip);
	    result.setDouble(2, value);
	    result.setString(3, unit);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipmentsampleperiod ("+quote(uuidequip)+", "+value+", "+quote(unit)+");\n");
	}
    }
    
    public static final String EQUIPMENTVALDIDDATERANGE = "select equipmentvaliddaterange (?, ?, ?);";
    
    public void map2Equipmentvaliddaterange(String uuidequip, Timestamp start, Timestamp end) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(EQUIPMENTVALDIDDATERANGE);
	    result.setString(1, uuidequip);
	    result.setTimestamp(2, start);
	    result.setTimestamp(3, end);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select equipmentvaliddaterange ("+quote(uuidequip)+", "+quote(start)+", "+quote(end)+");\n");
	}
    }
    
    /*
     * 
     * Publication
     * 
     */
    public static final String PUBLICATION = "select publication (?, ?, ?, ?);";
    
    public void map2Publication(String uuidrespubl, String title, String description, Date pubdate)
	    throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PUBLICATION);
	    result.setString(1, uuidrespubl);
	    result.setString(2, title);
	    result.setString(3, description);
	    result.setDate(4, pubdate);
	    
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select publication ("+quote(uuidrespubl)+", "+quote(title)+", "+quote(description)+", "+quote(pubdate)+");\n");
	}
    }
    
    public static final String PUBLICATIONPERSON = "select publicationperson (?, ?, ?);";
    
    public void map2Publicationperson(String uuidrespubl, String uuidpers, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PUBLICATIONPERSON);
	    result.setString(1, uuidrespubl);
	    result.setString(2, uuidpers);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select publicationperson ("+quote(uuidrespubl)+", "+quote(uuidpers)+", "+quote(role)+");\n");
	}
    }
    
    public static final String PUBLICATIONORGANISATION = "select publicationorganisation (?, ?, ?);";
    
    public void map2Publicationorganisation(String uuidrespubl, String uuidorgunit, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PUBLICATIONORGANISATION);
	    result.setString(1, uuidrespubl);
	    result.setString(2, uuidorgunit);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select publicationorganisation ("+quote(uuidrespubl)+", "+quote(uuidorgunit)+", "+quote(role)+");\n");
	}
    }
    
    public static final String PUBLICATIONLICENSE = "select publicationlicense (?, ?);";
    
    public void map2Publicationlicense(String uuidrespubl, String license) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PUBLICATIONLICENSE);
	    result.setString(1, uuidrespubl);
	    result.setString(2, license);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select publicationlicense ("+quote(uuidrespubl)+", "+quote(license)+");\n");
	}
    }
    
    public static final String PUBLICATIONFORMAT = "select publicationformat (?, ?);";
    
    public void map2Publicationformat(String uuidrespubl, String format) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PUBLICATIONFORMAT);
	    result.setString(1, uuidrespubl);
	    result.setString(2, format);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select publicationformat ("+quote(uuidrespubl)+", "+quote(format)+");\n");
	}
    }
    
    public static final String PUBLICATIONKEYWORD = "select publicationkeyword (?, ?);";
    
    public void map2Publicationkeyword(String uuidrespubl, String keyword) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PUBLICATIONKEYWORD);
	    result.setString(1, uuidrespubl);
	    result.setString(2, keyword);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select publicationkeyword ("+quote(uuidrespubl)+", "+quote(keyword)+");\n");
	}
    }
    
    public static final String PUBLICATIONJOURNALARTICLEDETAILS = "select publicationjournalarticledetails (?, ?, ?,?,?);";
    
    public void map2Publicationjournalarticledetails(String uuidrespubl, String issn, String issue, String vol,
	    String numpage) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PUBLICATIONJOURNALARTICLEDETAILS);
	    result.setString(1, uuidrespubl);
	    result.setString(2, issn);
	    result.setString(3, issue);
	    result.setString(4, vol);
	    result.setString(5, numpage);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select publicationjournalarticledetails ("+quote(uuidrespubl)+", "+quote(issn)+", "+quote(issue)+", "+quote(vol)+", "+quote(numpage)+");\n");
	}
    }
    
    /*
     * 
     * Service
     * 
     * 
     */
    public static final String SERVICE = "select service (?, ?, ?, ?);";
    
    public void map2Service(String uuidsrv, String name, String description) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(SERVICE);
	    result.setString(1, uuidsrv);
	    result.setString(2, name);
	    result.setString(3, description);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select service ("+quote(uuidsrv)+", "+quote(name)+", "+quote(description)+");\n");
	}
    }
    
    public static final String SERVICETYPE = "select servicetype (?, ?);";
    
    public void map2Servicetype(String uuidsrv, String type) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(SERVICETYPE);
	    result.setString(1, uuidsrv);
	    result.setString(2, type);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select servicetype ("+quote(uuidsrv)+", "+quote(type)+");\n");
	}
    }
    
    public static final String SERVICELICENSE = "select servicelicense (?, ?);";
    
    public void map2Servicelicense(String uuidsrv, String license) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(SERVICELICENSE);
	    result.setString(1, uuidsrv);
	    result.setString(2, license);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select servicelicense ("+quote(uuidsrv)+", "+quote(license)+");\n");
	}
    }
    
    public static final String SERVICEORGANISATION = "select serviceorganisation (?, ?, ?);";
    
    public void map2Serviceorganisation(String uuidsrv, String uuidorgunit, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(SERVICEORGANISATION);
	    result.setString(1, uuidsrv);
	    result.setString(2, uuidorgunit);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select serviceorganisation ("+quote(uuidsrv)+", "+quote(uuidorgunit)+", "+quote(role)+");\n");
	}
    }
    
    public static final String SERVICEPERSON = "select serviceperson (?, ?, ?);";
    
    public void map2Serviceperson(String uuidsrv, String uuidpers, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(SERVICEPERSON);
	    result.setString(1, uuidsrv);
	    result.setString(2, uuidpers);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select serviceperson ("+quote(uuidsrv)+", "+quote(uuidpers)+", "+quote(role)+");\n");
	}
    }
    
    /*
     * 
     * Person
     * 
     */
    public static final String PERSON = "select person (?, ?, ?);";
    
    public void map2Person(String uuidpers, String firstname, String familyname) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PERSON);
	    result.setString(1, uuidpers);
	    result.setString(2, firstname);
	    result.setString(3, familyname);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select person ("+quote(uuidpers)+", "+quote(firstname)+", "+quote(familyname)+");\n");
	}
    }
    
    public static final String PERSONFULLNAME = "select personfullname (?, ?);";
    
    public void map2Personfullname(String uuidpers, String fullname) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PERSONFULLNAME);
	    result.setString(1, uuidpers);
	    result.setString(2, fullname);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select personfullname ("+quote(uuidpers)+", "+quote(fullname)+");\n");
	}
    }
    
    public static final String PERSONADDRESS = "select personaddress (?,?,?,?,?);";
    
    public void map2Personaddress(String uuidpers, String street, String locality, String postcode, String country)
	    throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PERSONADDRESS);
	    result.setString(1, uuidpers);
	    result.setString(2, street);
	    result.setString(3, locality);
	    result.setString(4, postcode);
	    result.setString(5, country);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select personaddress ("+quote(uuidpers)+", "+quote(street)+", "+quote(locality)+", "+quote(postcode)+", "+quote(country)+");\n");
	}
    }
    
    public static final String PERSONEMAIL = "select personemail (?,?);";
    
    public void map2Personemail(String uuidpers, String email) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PERSONEMAIL);
	    result.setString(1, uuidpers);
	    result.setString(2, email);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select personemail ("+quote(uuidpers)+", "+quote(email)+");\n");
	}
    }
    
    public static final String PERSONPHONE = "select personphone (?,?);";
    
    public void map2Personphone(String uuidpers, String phone) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PERSONPHONE);
	    result.setString(1, uuidpers);
	    result.setString(2, phone);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select personphone ("+quote(uuidpers)+", "+quote(phone)+");\n");
	}
    }
    
    public static final String PERSONCV = "select personcv (?,?);";
    
    public void map2Personcv(String uuidpers, String cv) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PERSONCV);
	    result.setString(1, uuidpers);
	    result.setString(2, cv);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select personcv ("+quote(uuidpers)+", "+quote(cv)+");\n");
	}
    }
    
    public static final String PERSONLANGUAGE = "select personlanguage (?,?);";
    
    public void map2Personlanguage(String uuidpers, String language) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PERSONLANGUAGE);
	    result.setString(1, uuidpers);
	    result.setString(2, language);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select personlanguage ("+quote(uuidpers)+", "+quote(language)+");\n");
	}
    }
    
    public static final String PERSONQUALIFICATION = "select personqualification (?,?);";
    
    public void map2Personqualification(String uuidpers, String qualification) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(PERSONQUALIFICATION);
	    result.setString(1, uuidpers);
	    result.setString(2, qualification);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select personqualification ("+quote(uuidpers)+", "+quote(qualification)+");\n");
	}
    }
    
    /*
     * 
     * Dataset
     * 
     */
    public static final String DATASET = "select dataset (?, ?, ?, ?);";
    
    public void map2Dataset(String uuiddataset, String title, String description, String uri) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASET);
	    result.setString(1, uuiddataset);
	    result.setString(2, title);
	    result.setString(3, description);
	    result.setString(4, uri);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select dataset ("+quote(uuiddataset)+", "+quote(title)+", "+quote(description)+", "+quote(uri)+");\n");
	}
    }
    
    public static final String DEL_DATASET = "select del_dataset (?);";
    
    public void map2DelDataset(String uuiddataset) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DEL_DATASET);
	    result.setString(1, uuiddataset);
	    
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select del_dataset ("+quote(uuiddataset)+");\n");
	}
    }
    
    public static final String DATASETPUBLICACCESSLIMIT = "select datasetpublicaccesslimit (?, ?);";
    
    public void map2Datasetpublicaccesslimit(String uuiddataset, String publicaccesslimit) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETPUBLICACCESSLIMIT);
	    result.setString(1, uuiddataset);
	    result.setString(2, publicaccesslimit);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetpublicaccesslimit ("+quote(uuiddataset)+", "+quote(publicaccesslimit)+");\n");
	}
    }
    
    public static final String DATASETORGANISATION = "select datasetorganisation (?, ?, ?);";
    
    public void map2Datasetorganisation(String uuiddataset, String uuidorgunit, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETORGANISATION);
	    result.setString(1, uuiddataset);
	    result.setString(2, uuidorgunit);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetorganisation ("+quote(uuiddataset)+", "+quote(uuidorgunit)+", "+quote(role)+");\n");
	}
    }
    
    public static final String DATASETACCESSANDUSERESTRICTION = "select datasetaccessanduserestriction (?, ?);";
    
    public void map2Datasetaccessanduserestriction(String uuiddataset, String accessanduse) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETACCESSANDUSERESTRICTION);
	    result.setString(1, uuiddataset);
	    result.setString(2, accessanduse);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetaccessanduserestriction ("+quote(uuiddataset)+", "+quote(accessanduse)+");\n");
	}
    }
    
    public static final String DATASETDATES = "select datasetdates (?, ?, ?, ?);";
    
    public void map2Datasetdates(String uuiddataset, Date creation, Date revision, Date publication)
	    throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETDATES);
	    result.setString(1, uuiddataset);
	    result.setDate(2, creation);
	    result.setDate(3, revision);
	    result.setDate(4, publication);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetdates ("+quote(uuiddataset)+", "+quote(creation)+", "+quote(revision)+", "+quote(publication)+");\n");
	}
    }
    
    public static final String DATASETLINEAGE = "select datasetlineage (?, ?);";
    
    public void map2Datasetlineage(String uuiddataset, String lineage) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETLINEAGE);
	    result.setString(1, uuiddataset);
	    result.setString(2, lineage);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetlineage ("+quote(uuiddataset)+", "+quote(lineage)+");\n");
	}
    }
    
    public static final String DATASETFORMAT = "select datasetformat (?, ?);";
    
    public void map2Datasetformat(String uuiddataset, String format) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETFORMAT);
	    result.setString(1, uuiddataset);
	    result.setString(2, format);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetformat ("+quote(uuiddataset)+", "+quote(format)+");\n");
	}
    }
    
    public static final String DATASETLOCATION = "select datasetlocation (?, ?, ?, ?, ?, ?, ?);";
    
    public void map2Datasetlocation(String uuiddataset, Double minlat, Double maxlat, Double minlon, Double maxlon,
	    Double minelev, Double maxelev) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETLOCATION);
	    result.setString(1, uuiddataset);
	    
	    if (minlat == null)
		result.setNull(2, java.sql.Types.DOUBLE);
	    else
		result.setDouble(2, minlat);
	    
	    if (maxlat == null)
		result.setNull(3, java.sql.Types.DOUBLE);
	    else
		result.setDouble(3, maxlat);
	    
	    if (minlon == null)
		result.setNull(4, java.sql.Types.DOUBLE);
	    else
		result.setDouble(4, minlon);
	    
	    if (maxlon == null)
		result.setNull(5, java.sql.Types.DOUBLE);
	    else
		result.setDouble(5, maxlon);
	    
	    if (minelev == null)
		result.setNull(6, java.sql.Types.DOUBLE);
	    else
		result.setDouble(6, minelev);
	    
	    if (maxelev == null)
		result.setNull(7, java.sql.Types.DOUBLE);
	    else
		result.setDouble(7, maxelev);
	    
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetlocation ("+quote(uuiddataset)+", "+minlat+", "+maxlat+", "+minlon+", "+maxlon+", "+minelev+", "+minelev+");\n");
	}
    }
    
    public static final String DATASETKEYWORD = "select datasetkeyword (?, ?);";
    
    public void map2Datasetkeyword(String uuiddataset, String keyword) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETKEYWORD);
	    result.setString(1, uuiddataset);
	    result.setString(2, keyword);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetkeyword ("+quote(uuiddataset)+", "+quote(keyword)+");\n");
	}
    }
    
    public static final String DATASETTEMPORALEXTENT = "select datasettemporalextent (?, ?, ?);";
    
    public void map2Datasettemporalextent(String uuiddataset, Timestamp start, Timestamp end) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETTEMPORALEXTENT);
	    result.setString(1, uuiddataset);
	    result.setTimestamp(2, start);
	    result.setTimestamp(3, end);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasettemporalextent ("+quote(uuiddataset)+", "+quote(start)+", "+quote(end)+");\n");
	}
    }
    
    public static final String DATASETTHESAURUSKEYWORD = "select datasetthesauruskeyword (?, ?, ?);";
    
    public void map2Datasetthesauruskeyword(String uuiddataset, String keyword, String thesaurus) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETTHESAURUSKEYWORD);
	    result.setString(1, uuiddataset);
	    result.setString(2, keyword);
	    result.setString(3, thesaurus);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetthesauruskeyword ("+quote(uuiddataset)+", "+quote(keyword)+", "+quote(thesaurus)+");\n");
	}
    }
    
    public static final String DATASETSPATIALREPRESENTATIONTYPE = "select datasetspatialrepresentationtype (?, ?);";
    
    public void map2Datasetspatialrepresentationtype(String uuiddataset, String type) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETSPATIALREPRESENTATIONTYPE);
	    result.setString(1, uuiddataset);
	    result.setString(2, type);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetspatialrepresentationtype ("+quote(uuiddataset)+", "+quote(type)+");\n");
	}
    }
    
    public static final String DATASETSPATIALREFERENCESYSTEM = "select datasetspatialreferencesystem (?, ?);";
    
    public void map2Datasetspatialreferencesystem(String uuiddataset, String referencesystem) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETSPATIALREFERENCESYSTEM);
	    result.setString(1, uuiddataset);
	    result.setString(2, referencesystem);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetspatialreferencesystem ("+quote(uuiddataset)+", "+quote(referencesystem)+");\n");
	}
    }
    
    public static final String DATASETDOMAIN = "select datasetdomain (?, ?);";
    
    public void map2Datasetdomain(String uuiddataset, String domain) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETDOMAIN);
	    result.setString(1, uuiddataset);
	    result.setString(2, domain);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetdomain ("+quote(uuiddataset)+", "+quote(domain)+");\n");
	}
    }
    
    public static final String DATASETSUBDOMAIN = "select datasetsubdomain (?, ?);";
    
    public void map2Datasetsubdomain(String uuiddataset, String subdomain) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETSUBDOMAIN);
	    result.setString(1, uuiddataset);
	    result.setString(2, subdomain);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetsubdomain ("+quote(uuiddataset)+", "+quote(subdomain)+");\n");
	}
    }
    
    public static final String DATASETACCESSURL = "select datasetaccessurl (?, ?);";
    
    public void map2Datasetaccessurl(String uuiddataset, String url) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETACCESSURL);
	    result.setString(1, uuiddataset);
	    result.setString(2, url);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetaccessurl ("+quote(uuiddataset)+", "+quote(url)+");\n");
	}
    }
    
    public static final String DATASETDOWNLOADURL = "select datasetdownloadurl (?, ?);";
    
    public void map2Datasetdownloadurl(String uuiddataset, String url) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETDOWNLOADURL);
	    result.setString(1, uuiddataset);
	    result.setString(2, url);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetdownloadurl ("+quote(uuiddataset)+", "+quote(url)+");\n");
	}
    }
    
    public static final String DATASETLANGUAGE = "select datasetlanguage (?, ?);";
    
    public void map2Datasetlanguage(String uuiddataset, String lang) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETLANGUAGE);
	    result.setString(1, uuiddataset);
	    result.setString(2, lang);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetlanguage ("+quote(uuiddataset)+", "+quote(lang)+");\n");
	}
    }
    
    public static final String DATASETRESOURCETYPE = "select datasetresourcetype (?, ?);";
    
    public void map2Datasetresourcetype(String uuiddataset, String resourcetype) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETRESOURCETYPE);
	    result.setString(1, uuiddataset);
	    result.setString(2, resourcetype);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetresourcetype ("+quote(uuiddataset)+", "+quote(resourcetype)+");\n");
	}
    }
    
    public static final String DATASETCHARSET = "select datasetcharset (?, ?);";
    
    public void map2Datasetcharset(String uuiddataset, String charset) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETCHARSET);
	    result.setString(1, uuiddataset);
	    result.setString(2, charset);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetcharset ("+quote(uuiddataset)+", "+quote(charset)+");\n");
	}
    }
    
    public static final String DATASETISOTOPIC = "select datasetisotopic (?, ?);";
    
    public void map2Datasetisotopic(String uuiddataset, String topic) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETISOTOPIC);
	    result.setString(1, uuiddataset);
	    result.setString(2, topic);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetisotopic ("+quote(uuiddataset)+", "+quote(topic)+");\n");
	}
    }
    
    public static final String DATASETRESOLUTION = "select datasetresolution (?, ?);";
    
    public void map2Datasetresolution(String uuiddataset, String resolution) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETRESOLUTION);
	    result.setString(1, uuiddataset);
	    result.setString(2, resolution);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetresolution ("+quote(uuiddataset)+", "+quote(resolution)+");\n");
	}
    }
    
    public static final String DATASETPERSON = "select datasetperson (?, ?, ?);";
    
    public void map2Datasetperson(String uuiddataset, String uuidpers, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETPERSON);
	    result.setString(1, uuiddataset);
	    result.setString(2, uuidpers);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetperson ("+quote(uuiddataset)+", "+quote(uuidpers)+", "+quote(role)+");\n");
	}
    }
    
    public static final String DATASETMETADATA = "select datasetmetadata (?, ?);";
    
    public void map2Datasetmetadata(String uuiddataset, String uuidmeta) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(DATASETMETADATA);
	    result.setString(1, uuiddataset);
	    result.setString(2, uuidmeta);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select datasetmetadata ("+quote(uuiddataset)+", "+quote(uuidmeta)+");\n");
	}
    }
    
    /*
     * 
     * Facility
     * 
     * 
     */
    public static final String FACILITY = "select facility (?, ?, ?);";
    
    public void map2Facility(String uuidfacil, String name, String descr) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(FACILITY);
	    result.setString(1, uuidfacil);
	    result.setString(2, name);
	    result.setString(3, descr);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select facility ("+quote(uuidfacil)+", "+quote(name)+", "+quote(descr)+");\n");
	}
    }
    
    public static final String FACILITYPERSON = "select facilityperson (?, ?, ?);";
    
    public void map2Facilityperson(String uuidfacil, String uuidpers, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(FACILITYPERSON);
	    result.setString(1, uuidfacil);
	    result.setString(2, uuidpers);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select facilityperson ("+quote(uuidfacil)+", "+quote(uuidpers)+", "+quote(role)+");\n");
	}
    }
    
    public static final String FACILITYORGANISATION = "select facilityorganisation (?, ?, ?);";
    
    public void map2Facilityorganisation(String uuidfacil, String uuidorgunit, String role) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(FACILITYORGANISATION);
	    result.setString(1, uuidfacil);
	    result.setString(2, uuidorgunit);
	    result.setString(3, role);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select facilityorganisation ("+quote(uuidfacil)+", "+quote(uuidorgunit)+", "+quote(role)+");\n");
	}
    }
    
    public static final String FACILITYWEBSITE = "select facilitywebsite (?, ?);";
    
    public void map2Facilitywebsite(String uuidfacil, String url) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(FACILITYWEBSITE);
	    result.setString(1, uuidfacil);
	    result.setString(2, url);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select facilitywebsite ("+quote(uuidfacil)+", "+quote(url)+");\n");
	}
    }
    
    public static final String FACILITYADDRESS = "select facilityaddress (?,?,?,?,?);";
    
    public void map2Facilityaddress(String uuidfacil, String street, String locality, String postcode,
	    String country) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(FACILITYADDRESS);
	    result.setString(1, uuidfacil);
	    result.setString(2, street);
	    result.setString(3, locality);
	    result.setString(4, postcode);
	    result.setString(5, country);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select facilityaddress ("+quote(uuidfacil)+", "+quote(street)+", "+quote(locality)+", "+quote(postcode)+", "+quote(country)+");\n");
	}
    }
    
    public static final String FACILITYTYPE = "select facilitytype (?, ?);";
    
    public void map2Facilitytype(String uuidfacil, String type) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(FACILITYTYPE);
	    result.setString(1, uuidfacil);
	    result.setString(2, type);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select facilitytype ("+quote(uuidfacil)+", "+quote(type)+");\n");
	}
    }
    
    public static final String FACILITYSCIENCEDOMAIN = "select facilitysciencedomain (?, ?);";
    
    public void map2Facilitysciencedomain(String uuidfacil, String domain) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(FACILITYSCIENCEDOMAIN);
	    result.setString(1, uuidfacil);
	    result.setString(2, domain);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select facilitysciencedomain ("+quote(uuidfacil)+", "+quote(domain)+");\n");
	}
    }
    
    /*
     * 
     * Webservice and data meta information
     */
    public static final String ISOMETA = "select isometa (?, ?, ?, ?);";
    
    public void map2Isometa(String uuidmeta, String fileidentifier, String language, String charset)
	    throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(ISOMETA);
	    result.setString(1, uuidmeta);
	    result.setString(2, fileidentifier);
	    result.setString(3, language);
	    result.setString(4, charset);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select isometa ("+quote(uuidmeta)+", "+quote(fileidentifier)+", "+quote(language)+", "+quote(charset)+");\n");
	}
    }
    
    public static final String ISOMETADETAILS = "select isometadetails (?, ?, ?);";
    
    public void map2Isometadetails(String uuidmeta, String standardname, String standardversion) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(ISOMETADETAILS);
	    result.setString(1, uuidmeta);
	    result.setString(2, standardname);
	    result.setString(3, standardversion);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select isometadetails ("+quote(uuidmeta)+", "+quote(standardname)+", "+quote(standardversion)+");\n");
	}
    }
    
    public static final String ISOMETADATES = "select isometadates (?, ?, ?);";
    
    public void map2Isometadates(String uuidmeta, Date created, Date updated) throws SQLException, IOException {
	
	if (conn != null) {
	    PreparedStatement result = prepareStatement(ISOMETADATES);
	    result.setString(1, uuidmeta);
	    result.setDate(2, created);
	    result.setDate(3, updated);
	    result.executeQuery();
	}
	if (os != null) {
	    os.write("select isometadetails ("+quote(uuidmeta)+", "+quote(created)+", "+quote(updated)+");\n");
	}
    }
    
    public void updateMaterialized(String query) throws SQLException, IOException {
	if (conn != null) {
	    PreparedStatement result = prepareStatement(query);
	    //result.executeQuery();
	    result.execute();
	}
    }
}

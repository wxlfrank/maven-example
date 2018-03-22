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

import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.xml.datatype.XMLGregorianCalendar;

import org.epos_ip.dcatflat.Baseline;
import org.epos_ip.dcatflat.Catalog;
import org.epos_ip.dcatflat.Dataset;
import org.epos_ip.dcatflat.DatasetDistribution;
import org.epos_ip.dcatflat.Location;
import org.epos_ip.dcatflat.Organisation;
import org.epos_ip.dcatflat.Person;
import org.epos_ip.dcatflat.ServiceParameter;
import org.epos_ip.dcatflat.TimePeriod;
import org.epos_ip.dcatflat.Webservice;

import junit.framework.Assert;

@SuppressWarnings("deprecation")
public class Transform {

	private ToCerif tocerif = new ToCerif(null);

	public List<PreparedStatement> mapBaseline2Cerif(Baseline baseline) {
		for (Catalog catalog : baseline.getCatalogs()) {
			for (Dataset dataset : catalog.getDatasets())
				mapDatabase2Cerif(dataset);
		}
		return tocerif.getStatements();
	}

	private static final String ENGLISH = "en";
	private static final String TRANS_DEFAULT = "h";
	private static final Timestamp EPOS_MIN_DATE = Timestamp.valueOf("1901-01-01 00:00:00.000000000");
	private static final Timestamp EPOS_MAX_DATE = Timestamp.valueOf("2099-12-31 23:59:59.999999999");

	public void mapDatabase2Cerif(Dataset dataset) {
		String id = dataset.getIdentifier();

		/*
		 * DCAT-AP mapping: Unique Resource Identifier --> dct:identifier 
		 * 					on-line resource --> dcat:landingPage
		 * CERIF mapping: Unique Resource Identifier --> resprod.cfresprodid
		 * 				  on-line resource --> resprod.cfuri
		 */
//		tocerif.tocfresprod(id, dataset.getOnlineresource().get(0));

		/*
		 * DCAT-AP mapping: title --> dct:title
		 * CERIF mapping: title --> resprodname.cfname
		 */
		tocerif.tocfresprodname(id, dataset.getTitle().get(0), ENGLISH, TRANS_DEFAULT);

		/*
		 * DCAT-AP mapping: abstract --> dct:description 
		 * CERIF mapping: abstract --> resproddescr.cfdescr
		 */
		for (String description : dataset.getDescription()) {
			tocerif.tocfresproddescr(id, description, ENGLISH, TRANS_DEFAULT);
		}

		/*
		 * DCAT-AP mapping: date of publication --> dct:issued
		 * CERIF mapping: date of publication --> resprod_class.cfstartdate
		 * 
		 * DCAT-AP mapping: data of revision --> dct:modified 
		 * CERIF mapping: data of revision --> resprod_class.cfstartdate
		 *
		 * DCAT-AP mapping: data of creation --> dct:created
		 * CERIF mapping: data of creation --> resprod_class.cfstartdate
		 */
		mapTemporalReference(id, dataset.getCreated(), dataset.getModified(), dataset.getIssued());

		/*
		 * DCAT-AP mapping: responsible party --> eposap:responsibleParty 
		 * CERIF mapping: Responsible party --> orgunit_resprod
		 * TODO the schemename and classname is not right???
		 */
		for (String party : dataset.getResponsibleparty()) {
			tocerif.tocforgunit_resprod(party, id, "Responsible Party", "Organisation Output Roles", EPOS_MIN_DATE,
					EPOS_MAX_DATE);
		}

		/*
		 * DCAT-AP mapping: contact --> dcat:contactPoint
		 * CERIF mapping: contact --> pers_resprod
		 */
		for (String contact : dataset.getContact()) {
			tocerif.tocfpers_resprod(contact, id, "Contact", "Person Output Contributions", EPOS_MIN_DATE,
					EPOS_MAX_DATE);
		}

		/*
		 * DCAT-AP mapping: Geographic Location/spatial extent/bounding box --> dct:spatial
		 * CERIF mapping: Geographic Location/spatial extent/bounding box --> resprod_geobox (cfeblong, cfmaxelev, cfminelev, cfnblat, cfsblat, cfuri, cfwblong)
		 */
		mapSpatialExtent(id, dataset.getSpatialextent());

		/*
		 * DCAT-AP mapping: Spatial resolution --> rdfs:comment
		 * CERIF mapping: Spatial resolution --> cfresprod_meas.cfvaljudgetext ?? cfresprod_meas.cfvaljudtext
		 * TODO DCAT-AP mapping miss map spatial resolution
		 */
		// tocfresprod_class(id, dataset.getSpatialResolution(), "Spatial
		// Resolution", null, null);

		/*
		 * DCAT-AP mapping: Spatial representation type --> adms:representationTechnique 
		 * CERIF mapping: Spatial representation type --> resprod_class.cfclassid
		 */
		tocfresprod_class(id, dataset.getSpatialrepresentation(), "Spatial Representation Type", null, null);

		/*
		 * DCAT-AP mapping: Spatial Reference System --> dct:conformsTo 
		 * CERIF mapping: Spatial Reference System --> resprod_class.cfclassid
		 */
//		for (String system : dataset.getSpatialReferenceSystem())
//			tocfresprod_class(id, system, "Spatial Reference System", null, null);

		/*
		 * DCAT-AP mapping: Temporal extent.start date  --> dct:temporal.start
		 * CERIF mapping: Temporal extent.start date --> resprod_meas.cfdatetime
		 *
		 * DCAT-AP mapping: Temporal extent.end date  --> dct:temporal.end 
		 * CERIF mapping: Temporal extent.end date --> resprod_meas.cfdatetime
		 */
		mapTemporalExtent(id, dataset.getTemporalextent());

		/*
		 * DCAT-AP mapping: Language --> dct:language
		 * CERIF mapping: Language --> resprod_class.cfclassid
		 * TODO miss map lauguage
		 */

		/*
		 * DCAT-AP mapping: characterset --> cnt:characterEncoding
		 * CERIF mapping: characterset --> resprod_class.cfclassid
		 * TODO miss map characterset
		 */

		/*
		 * DCAT-AP mapping: topic category --> dct:subject
		 * CERIF mapping: topic category --> resprod_class.cfclassid
		 * TODO DCAT-AP mapping miss map topic category
		 */
		// tocfresprod_class(id, dataset.getTopicCategory(), "ISO Topic", null,
		// null);

		/*
		 * DCAT-AP mapping: distribution format --> eposap:distribution/dcat:Distribution/dct:format
		 * CERIF mapping: distribution format --> resprod_class.cfclassid
		 * DCAT-AP mapping: Access and Use Restrictions --> eposap:distribution/dcat:Distribution/dct:license
		 * CERIF mapping: Access and Use Restrictions --> resprod_class.cfclassid
		 */
/*		List<DatasetDistribution> distributions = dataset.getDistribution();
		if (distributions != null) {
			for (DatasetDistribution distribution : distributions) {
				for (String format : distribution.getFormat())
					tocfresprod_class(id, format, "Distribution Format", null, null);
				for (String license : distribution.getLicense())
					tocfresprod_class(id, license, "Access and Use Restrictions", null, null);
			}
		}
*/
		/*
		 * DCAT-AP mapping: Lineage --> dct:provenance 
		 * CERIF mapping: Lineage --> cfresprod_meas.cfvaljudtext
		 */
		tocfresprod_meas_char(id, dataset.getLineage(), "Lineage", "Reuse Information");

		/*
		 * DCAT-AP mapping: Resource Type --> dct:type
		 * CERIF mapping: Resource Type --> resprod_class
		 */
		tocfresprod_class(id, "Dataset", "EPOS Result Product Types", null, null);

		/*
		 * DCAT-AP mapping: Keywords (Key-phrase) --> dcat:keyword 
		 * CERIF mapping: Keywords (Key-phrase) --> resprodkeyw
		 */
/*		List<String> keywords = dataset.getKeyword();
		if (keywords != null && !keywords.isEmpty()) {
			tocerif.tocfresprodkeyw(id, String.join(", ", keywords), ENGLISH, TRANS_DEFAULT);
		}
*/
		/*
		 * DCAT-AP mapping: Domain --> eposap:domain 
		 * CERIF mapping: Domain --> ????
		 * TODO miss map Domain
		 */

		/*
		 * DCAT-AP mapping: subDomain --> eposap:subdomain 
		 * CERIF mapping: subDomain --> ????
		 * TODO miss map subDomain
		 */

		/*
		 * DCAT-AP mapping: providedBy --> eposap:providedBy 
		 * CERIF mapping: providedBy --> ????
		 * TODO miss map providedBy
		 */

		/*
		 * DCAT-AP mapping: public access limitations --> dct:accessRights 
		 * CERIF mapping: public access limitations --> cfresprod_meas.cfvaljudtext
		 */
		tocfresprod_meas_char(id, dataset.getAccesslimit(), "Public Access Limit", "Reuse Information");

	}

	private void tocfresprod_class(String v_cfresprodid, String v_cfclassname, String v_cfschemename,
			Timestamp v_cfstartdate, Timestamp v_cfenddate) {
		if (v_cfclassname == null) {
			return;
		}
		if (v_cfstartdate == null)
			v_cfstartdate = EPOS_MIN_DATE;
		if (v_cfenddate == null)
			v_cfenddate = EPOS_MAX_DATE;
		tocerif.tocfresprod_class(v_cfresprodid, v_cfclassname, v_cfschemename, v_cfstartdate, v_cfenddate);
	}

	private void tocfresprod_meas_char(String id, String string, String classname, String schemaname) {
		if (string != null)
			tocerif.tocfresprod_meas_char(id, string, classname, schemaname, EPOS_MIN_DATE, EPOS_MAX_DATE);

	}

	private void mapSpatialExtent(String id, Location spatial) {
		if (spatial != null) {
			tocerif.tocfresprod_geobbox(id, spatial.getMinlat().doubleValue(), spatial.getMaxlat().doubleValue(),
					spatial.getMinlon().doubleValue(), spatial.getMaxlon().doubleValue(),
					spatial.getMinelev().doubleValue(), spatial.getMaxelev().doubleValue(), "Location",
					"EPOS Dataset Details", EPOS_MIN_DATE, EPOS_MAX_DATE);
		}
	}

	private void mapTemporalExtent(String id, TimePeriod temporalextent) {
		if (temporalextent != null) {
			tocfresprod_meas_time(id, temporalextent.getStart(), "Start Date", "EPOS Temporal Extent", EPOS_MIN_DATE,
					EPOS_MAX_DATE);
			tocfresprod_meas_time(id, temporalextent.getEnd(), "End Date", "EPOS Temporal Extent", EPOS_MIN_DATE,
					EPOS_MAX_DATE);
		}
	}

	private void tocfresprod_meas_time(String id, XMLGregorianCalendar calendar, String v_cfclassname,
			String v_cfschemename, Timestamp v_cfstartdate, Timestamp v_cfenddate) {
		if (calendar != null)
			tocerif.tocfresprod_meas_time(id, toTimestamp(calendar), v_cfclassname, v_cfschemename, v_cfstartdate,
					v_cfenddate);
	}

	private void mapTemporalReference(String id, XMLGregorianCalendar creation, XMLGregorianCalendar revision,
			XMLGregorianCalendar publication) {
		if (publication != null)
			tocerif.tocfresprod_class(id, "Publication", "EPOS Dates", toTimestamp(publication), null);
		if (revision != null)
			tocerif.tocfresprod_class(id, "Revision", "EPOS Dates", toTimestamp(revision), null);
		if (creation != null)
			tocerif.tocfresprod_class(id, "Creation", "EPOS Dates", toTimestamp(creation), null);
	}

	private Timestamp toTimestamp(XMLGregorianCalendar calendar) {
		return new Timestamp(calendar.toGregorianCalendar().getTimeInMillis());
	}

	public void mapPerson2Cerif(Person person) {
		String id = person.getIdentifier();
		tocerif.tocfpers(id, null, null, null);
		tocerif.tocfpers_class(id, "Person", "EPOS Result Product Types", EPOS_MIN_DATE, EPOS_MAX_DATE);

		PersonName name = new PersonName(person.getName());
		String name_id = getRandomID();
		tocerif.tocfpersname(name_id, name.familyName, name.firstName, name.othername);
		tocerif.tocfpersname_pers(id, name_id, "Formal Name", "Person Names", EPOS_MIN_DATE, EPOS_MAX_DATE);
	}

	public void mapOrganziation2Cerif(Organisation organisation) {
		String id = organisation.getIdentifier();
	//	tocerif.tocforgunit(id, null, null, 0, 0, organisation.getWebsite());
		tocerif.tocforgunitname(id, organisation.getName_en(), ENGLISH, TRANS_DEFAULT);
	//	String parent = organisation.getParentorganisation();
	//	tocerif.tocforgunit_orgunit("Part", "Inter-Organisational Structure", parent, id, EPOS_MIN_DATE, EPOS_MAX_DATE);
	}

	public void mapWebservice2Cerif(Webservice webservice) {
		String id = webservice.getIdentifier();

		/*
		 * DCAT-AP mapping: Unique Resource Identifier --> dct:identifier 
		 * 					URI --> foaf:page
		 * CERIF mapping: Unique Resource Identifier --> resprod.cfresprodid
		 * 				  URI --> resprod.cfuri
		 */
		tocerif.tocfresprod(id, webservice.getURI());

		/*
		 * DCAT-AP mapping: title --> dct:title
		 * CERIF mapping: title --> resprodname.cfname
		 */
		tocerif.tocfresprodname(id, webservice.getTitle().get(0), ENGLISH, TRANS_DEFAULT);

		/*
		 * DCAT-AP mapping: abstract --> dct:description 
		 * CERIF mapping: abstract --> resproddescr.cfdescr
		 */
		for (String description : webservice.getDescription()) {
			tocerif.tocfresproddescr(id, description, ENGLISH, TRANS_DEFAULT);
		}

		/*
		 * DCAT-AP mapping: date of publication --> dct:issued
		 * CERIF mapping: date of publication --> resprod_class.cfstartdate
		 * 
		 * DCAT-AP mapping: data of revision --> dct:modified 
		 * CERIF mapping: data of revision --> resprod_class.cfstartdate
		 *
		 * DCAT-AP mapping: data of creation --> dct:created
		 * CERIF mapping: data of creation --> resprod_class.cfstartdate
		 */
		mapTemporalReference(id, webservice.getCreated(), webservice.getModified(), webservice.getPublished());

		/*
		 * DCAT-AP mapping: responsible party --> eposap:responsibleParty 
		 * CERIF mapping: Responsible party --> orgunit_resprod
		 * TODO the schemename and classname is not right???
		 */
	//	for (String party : webservice.getResponsibleparty()) {
	//		tocerif.tocforgunit_resprod(party, id, "Responsible Party", "Organisation Output Roles", EPOS_MIN_DATE,
	//				EPOS_MAX_DATE);
	//	}

		/*
		 * DCAT-AP mapping: contact --> dcat:contactPoint
		 * CERIF mapping: contact --> pers_resprod
		 */
		for (String contact : webservice.getContactpoint()) {
			tocerif.tocfpers_resprod(contact, id, "Contact", "Person Output Contributions", EPOS_MIN_DATE,
					EPOS_MAX_DATE);
		}

		/*
		 * DCAT-AP mapping: Geographic Location/spatial extent/bounding box --> dct:spatial
		 * CERIF mapping: Geographic Location/spatial extent/bounding box --> resprod_geobox (cfeblong, cfmaxelev, cfminelev, cfnblat, cfsblat, cfuri, cfwblong)
		 */
		mapSpatialExtent(id, webservice.getSpatialextent());

		/*
		 * DCAT-AP mapping: Spatial resolution --> rdfs:comment
		 * CERIF mapping: Spatial resolution --> cfresprod_meas.cfvaljudgetext ?? cfresprod_meas.cfvaljudtext
		 * TODO DCAT-AP mapping miss map spatial resolution
		 */
		// tocfresprod_class(id, dataset.getSpatialResolution(), "Spatial
		// Resolution", null, null);

		/*
		 * DCAT-AP mapping: Spatial representation type --> adms:representationTechnique 
		 * CERIF mapping: Spatial representation type --> resprod_class.cfclassid
		 */
		tocfresprod_class(id, webservice.getSpatialrepresentation(), "Spatial Representation Type", null, null);

		/*
		 * DCAT-AP mapping: Spatial Reference System --> dct:conformsTo 
		 * CERIF mapping: Spatial Reference System --> resprod_class.cfclassid
		 */
		tocfresprod_class(id, webservice.getSpatialReferenceSystem(), "Spatial Reference System", null, null);

		/*
		 * DCAT-AP mapping: Temporal extent.start date  --> dct:temporal.start
		 * CERIF mapping: Temporal extent.start date --> resprod_meas.cfdatetime
		 *
		 * DCAT-AP mapping: Temporal extent.end date  --> dct:temporal.end 
		 * CERIF mapping: Temporal extent.end date --> resprod_meas.cfdatetime
		 */
		mapTemporalExtent(id, webservice.getTemporalextent());

		/*
		 * DCAT-AP mapping: distribution format --> eposap:distribution/dcat:Distribution/dct:format
		 * CERIF mapping: distribution format --> resprod_class.cfclassid
		 */
	//	for (String format : webservice.getFormat())
//			tocfresprod_class(id, format, "Distribution Format", null, null);

		/*
		 * DCAT-AP mapping: Lineage --> dct:provenance 
		 * CERIF mapping: Lineage --> cfresprod_meas.cfvaljudtext
		 */
	//	tocfresprod_meas_char(id, webservice.getLineage(), "Lineage", "Reuse Information");
		
		/*
		 * DCAT-AP mapping: Resource Type --> dct:type
		 * CERIF mapping: Resource Type --> resprod_class
		 */
		tocfresprod_class(id, "Webservice", "EPOS Result Product Types", null, null);
		
		/*
		 * DCAT-AP mapping: Coupled Resource --> dct:source 
		 * CERIF mapping: Coupled Resource --> resprod_resprod
		 * TODO miss map Coupled Resource
		 */
		
		/*
		 * DCAT-AP mapping: Data Service Type --> eposap:domain 
		 * CERIF mapping: Data Service Type --> resprod_class
		 */		
	//	tocfresprod_class(id, webservice.getServicetype(), "EPOS Webservice Types", null, null);
		
		/*
		 * DCAT-AP mapping: Keywords (Key-phrase) --> dcat:keyword 
		 * CERIF mapping: Keywords (Key-phrase) --> resprodkeyw
		 */
		List<String> keywords = webservice.getKeyword();
		if (keywords != null && !keywords.isEmpty()) {
			tocerif.tocfresprodkeyw(id, String.join(", ", keywords), ENGLISH, TRANS_DEFAULT);
		}
		
		/* 
		 * DCAT-AP mapping: Access and Use Restrictions --> eposap:distribution/dcat:Distribution/dct:license
		 * CERIF mapping: Access and Use Restrictions --> resprod_class.cfclassid
		 */
		for (String license : webservice.getLicense())
			tocfresprod_class(id, license, "Access and Use Restrictions", null, null);

		/*
		 * DCAT-AP mapping: parameter (name, value, type, version) --> eposap:parameter (http:paramName, http:paramValue, dct:type, owl:versionInfo)
		 * CERIF mapping: parameter --> resprod_meas
		 * 				 	name --> meas_meas
		 * 				 	value --> meas_meas
		 * 				 	type --> meas_meas
		 * 				 	version --> meas_meas
		 */
		//tocfresprod_meas_char(id, webservice.getAccesslimit(), "Public Access Limit", "Reuse Information");

		for(ServiceParameter parameter : webservice.getParameter()){
			String measid = getRandomID();
			tocerif.tocfresprod_meas(measid, id, "Parameter Group", "Webservice Information", EPOS_MIN_DATE, EPOS_MAX_DATE);
			tocerif.tocfmeas_meas(measid, parameter.getName(), "Parameter Name","Webservice Information", EPOS_MIN_DATE, EPOS_MAX_DATE);
			tocerif.tocfmeas_meas(measid, parameter.getType(), "Parameter Type","Webservice Information", EPOS_MIN_DATE, EPOS_MAX_DATE);
		//	tocerif.tocfmeas_meas(measid, parameter.getValue(), "Parameter Value","Webservice Information", EPOS_MIN_DATE, EPOS_MAX_DATE);
			tocerif.tocfmeas_meas(measid, parameter.getVersion(), "Parameter Version","Webservice Information", EPOS_MIN_DATE, EPOS_MAX_DATE);
		}
	}

	static class PersonName {
		private String firstName, familyName, othername;

		public PersonName(String name) {
			name.replaceAll(" *", " ");
			String[] names = name.split(" ");
			Assert.assertTrue(names.length > 2);
			firstName = names[0];
			familyName = names[names.length - 1];
			if (names.length > 2)
				othername = String.join(" ", Arrays.copyOfRange(names, 1, names.length - 1));
		}
	}

	private String getRandomID() {
		return UUID.randomUUID().toString();
	}
}

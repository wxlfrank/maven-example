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

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.xml.bind.JAXBException;
import org.epos_ip.dcatflat.Baseline;
import org.epos_ip.dcatflat.Catalog;
import org.epos_ip.dcatflat.Dataset;
import org.epos_ip.dcatflat.DatasetDistribution;
import org.epos_ip.dcatflat.Equipment;
import org.epos_ip.dcatflat.Facility;
import org.epos_ip.dcatflat.Location;
import org.epos_ip.dcatflat.Organisation;
import org.epos_ip.dcatflat.Person;
import org.epos_ip.dcatflat.Project;
import org.epos_ip.dcatflat.Publication;
import org.epos_ip.dcatflat.Service;
import org.epos_ip.dcatflat.ServiceParameter;
import org.epos_ip.dcatflat.ValueAndUnit;
import org.epos_ip.dcatflat.Webservice;
import org.postgresql.util.PSQLException;

public class Reader {
	private final static Logger LOGGER = Logger.getLogger(Logger.GLOBAL_LOGGER_NAME);
    static String url = "jdbc:postgresql://postgresCERIF/cerif";
    static String user = "damian";
    static String pass = "superdam";
    //static Logger logger = Logger.getLogger(Reader.class.getName());
    static EPOSXMLReader reader;
    static Map2Cerif m2c;
    
    public static String termFromUri(String uristring){
	String term=null;
	try{
	    URI uri=new URI(uristring);
	    String fragment=uri.getFragment();
	    if (fragment!=null){
		term=fragment;
	    }
	    else{
		String path=uri.getPath();
		term=path.substring(path.lastIndexOf('/'));
	    }
	}catch (URISyntaxException e){	
	    term=uristring;
	}
	return term;
    }
    public static String uriFromUri(String uristring){
	String uri=Reader.termFromUri(uristring);		
	if (uristring.equals(uri)){
	    return null;
	}
	return uristring;
    }
    
    public static void ingest(String filename) throws JAXBException, ClassNotFoundException, SQLException, IOException{
	Locale.setDefault(Locale.ENGLISH);
	reader = new EPOSXMLReader();
	
	Properties props = new Properties();
	props.setProperty("user", user);
	props.setProperty("password", pass);
	
	m2c = new Map2Cerif();
	
	Class.forName("org.postgresql.Driver");
	Connection conn = DriverManager.getConnection(url, props);
	m2c.setDBConnection(conn);
	
	//Baseline bsl = reader.readXML(new FileReader(filename));
	URL url = new URL(filename);
	InputStream is = url.openConnection().getInputStream();
	LOGGER.log(Level.INFO, "connection opened and stream taken");
	InputStreamReader isr = new InputStreamReader(is);
	LOGGER.log(Level.INFO,"input stream reader created");
	Baseline bsl = reader.readXML(isr);
	LOGGER.log(Level.INFO,"file read");
	try {
	    
	    
	    if (bsl.getPersons()!=null){
		for (Person person : bsl.getPersons()) {
		    String uuidpers=person.getIdentifier();
		    m2c.map2Personfullname(uuidpers, person.getName());
		    if (person.getAddress()!=null){
			String postcode=person.getAddress().getPostcode();
			if (postcode.length()>16)
			    postcode=postcode.substring(0, 15);
			m2c.map2Personaddress(uuidpers, person.getAddress().getStreet(), 
				person.getAddress().getLocality(), postcode, person.getAddress().getCountry());
		    }
		    if (person.getEmail()!=null)
			m2c.map2Personemail(uuidpers, person.getEmail());
		    if (person.getPhone()!=null)
			m2c.map2Personphone(uuidpers, person.getPhone());
		    for (String language : person.getLanguage().split(","))
			m2c.map2Personlanguage(uuidpers, language);
		    if (person.getQualification()!=null)
			m2c.map2Personqualification(uuidpers, person.getQualification());
		    if (person.getCv()!=null)
			m2c.map2Personcv(uuidpers, person.getCv());
		    
		}
	    }
	    
	    if (bsl.getProjects()!=null){
		for (Project project : bsl.getProjects())
		    m2c.map2Project(project.getIdentifier(), project.getTitle(), project.getDescription());	
	    }
	    
	    if (bsl.getOrganisations()!=null){
		for (Organisation organisation : bsl.getOrganisations()){
		    String uuidorgunit=organisation.getIdentifier();
		    m2c.map2Organisation(uuidorgunit, organisation.getName_en());
		    if (organisation.getName_native()!=null)
			m2c.map2Organisationnativename(uuidorgunit, organisation.getName_native(),"en");
		    if (organisation.getWebsite()!=null)
			for (String website : organisation.getWebsite())
			    m2c.map2Organisationwebsite(uuidorgunit, website);
		    m2c.map2Organisationperson(organisation.getScientificcontact(), uuidorgunit, "Scientific Contact");
		    m2c.map2Organisationperson(organisation.getLegalcontact(), uuidorgunit, "Legal Contact");
		    m2c.map2Organisationperson(organisation.getFinancialcontact(), uuidorgunit, "Financial Contact");
		    if (organisation.getAddress()!=null){
			String postcode=organisation.getAddress().getPostcode();
			if (postcode.length()>16)
			    postcode=postcode.substring(0, 15);
			m2c.map2Organisationaddress(uuidorgunit, organisation.getAddress().getStreet(), 
				organisation.getAddress().getLocality(), postcode, organisation.getAddress().getCountry());
		    }
		    if (organisation.getLocation()!=null){
			m2c.map2Organisationlocation(uuidorgunit, organisation.getLocation().getMinlat(), 
				organisation.getLocation().getMinlon(), organisation.getLocation().getMinelev());
		    }
		    if (organisation.getEmail()!=null)
			m2c.map2Organisationemail(uuidorgunit, organisation.getEmail());
		    if (organisation.getLogo()!=null)
			m2c.map2Organisationlogo(uuidorgunit, organisation.getLogo());
		    m2c.map2Organisationtype(uuidorgunit, organisation.getType());
		    if (organisation.getProjects()!=null){
			for (String project : organisation.getProjects())
			    m2c.map2Organisationproject(uuidorgunit, project, "Participant");
		    }
		}
		//do this here to guarantee that parents exist in database
		for (Organisation organisation : bsl.getOrganisations()){
		    String uuidorgunit=organisation.getIdentifier();
		    if (organisation.getParentorganisation()!=null){
			for (String parent : organisation.getParentorganisation())
			    m2c.map2Organisationparent( parent, uuidorgunit);
		    }
		}				
	    }
	    
	    //do this after organisations are in database
	    if (bsl.getPersons()!=null){
		for (Person person : bsl.getPersons()) {
		    String uuidpers=person.getIdentifier();
		    m2c.map2Organisationperson(uuidpers, person.getAffiliation(), "Employee");					
		}	
	    }
	    
	    if (bsl.getWebservices()!=null){
		for (Webservice ws : bsl.getWebservices()){
		    
		    String wsidentifier=ws.getIdentifier();
		    
		    
		    m2c.map2DelWebservice(wsidentifier);
		    
		    m2c.map2Webservice(wsidentifier, ws.getTitle().get(0), ws.getDescription().get(0), ws.getURI());
		    
		    m2c.map2Webserviceddssid(wsidentifier,ws.getDdssid());
		    
		    m2c.map2Webserviceaction(wsidentifier, ws.getActions());
		    
		    Date created=null, published=null, modified=null;				    
		    if (ws.getCreated()!=null)
			created=new Date(ws.getCreated().toGregorianCalendar().getTimeInMillis());
		    if (ws.getModified()!=null)
			modified=new Date(ws.getModified().toGregorianCalendar().getTimeInMillis());
		    if (ws.getPublished()!=null)
			published=new Date(ws.getPublished().toGregorianCalendar().getTimeInMillis());					
		    m2c.map2Webservicedates(wsidentifier, created, modified, published);
		    
		    if (ws.getTemporalextent()!=null){
			Timestamp start=null,end=null;
			if (ws.getTemporalextent().getStart()!=null)
			    start=new Timestamp(ws.getTemporalextent().getStart().toGregorianCalendar().getTimeInMillis());
			if (ws.getTemporalextent().getEnd()!=null)
			    end=new Timestamp(ws.getTemporalextent().getStart().toGregorianCalendar().getTimeInMillis());
			m2c.map2Webservicetemporalextent(wsidentifier, start, end);
		    }
		    
		    if (ws.getSpatialextent()!=null){
			
			m2c.map2Webservicelocation(wsidentifier, 
				ws.getSpatialextent().getMinlat(), ws.getSpatialextent().getMaxlat(),
				ws.getSpatialextent().getMinlon(), ws.getSpatialextent().getMaxlon(), 
				ws.getSpatialextent().getMinelev(), ws.getSpatialextent().getMaxelev());
		    }
		    
		    List<String> wskeywords=ws.getKeyword();
		    if (wskeywords!=null && !wskeywords.isEmpty()){
			String keywords=String.join(",", wskeywords);						
			m2c.map2Webservicekeyword(wsidentifier, keywords);
		    }
		    
		    for (String contact : ws.getContactpoint())
			m2c.map2Webserviceperson(wsidentifier, contact, "Contact");
		    
		    if (ws.getSpatialrepresentation()!=null)
			m2c.map2Webservicespatialrepresentationtype(wsidentifier, ws.getSpatialrepresentation());
		    
		    if (ws.getSpatialReferenceSystem()!=null)
			m2c.map2Webservicespatialreferencesystem(wsidentifier, ws.getSpatialReferenceSystem());
		    
		    if (ws.getAccesslimit() !=null && ws.getAccesslimit().size()>0)
			for (String accesslimit : ws.getAccesslimit())
			    m2c.map2Webservicepublicaccesslimit(wsidentifier, accesslimit);
		    
		    if (ws.getLicense() !=null && ws.getLicense().size()>0)
			for (String license : ws.getLicense())
			    m2c.map2Webserviceaccessanduserestriction(wsidentifier, license);
		    
		    if (ws.getParameter()!=null && ws.getParameter().size()>0){
			String wsuri=ws.getURI();
			//						m2c.map2DelWebserviceparameter(wsuri);						
			for (ServiceParameter param : ws.getParameter()){
			    String parameterid=UUID.randomUUID().toString();
			    m2c.map2Webserviceparameter(wsuri, parameterid, "Parameter Name",param.getName());
			    m2c.map2Webserviceparameter(wsuri, parameterid, "Parameter Type",param.getType());
			    m2c.map2Webserviceparameter(wsuri, parameterid, "Parameter Label",param.getLabel());							
			    if (param.getVersion()!=null)
				m2c.map2Webserviceparameter(wsuri, parameterid, "Parameter Version",param.getVersion());
			    if (param.getValue()!=null)
				for (String paramvalue : param.getValue())
				    m2c.map2Webserviceparameter(wsuri, parameterid, "Parameter Valid Value",paramvalue);
			    if (param.getMinValue()!=null)
				m2c.map2Webserviceparameter(wsuri, parameterid, "Parameter Minimum Value",param.getMinValue());
			    if (param.getMaxValue()!=null)
				m2c.map2Webserviceparameter(wsuri, parameterid, "Parameter Maximum Value",param.getMaxValue());			
			}
		    }
		    
		    if (ws.getFormat()!=null)
			m2c.map2Webserviceformat(wsidentifier, ws.getFormat());
		    
		    if (ws.getDomain()!=null)
			m2c.map2Webservicedomain(wsidentifier, ws.getDomain());
		    
		    if (ws.getSubDomain()!=null)
			m2c.map2Webservicesubdomain(wsidentifier, ws.getSubDomain());
		    
		    if (ws.getPublisher()!=null)
			for (String publisher : ws.getPublisher())
			    m2c.map2Webserviceorganisation(wsidentifier, publisher, "Publisher");
		    
		    if (ws.getVersion()!=null)
			m2c.map2Webserviceversion(wsidentifier, ws.getVersion());
		    
		    if (ws.getDocumentation()!=null)
			for (String documentation : ws.getDocumentation())
			    m2c.map2Webservicedocumentation(wsidentifier, documentation);
		    
		    if (ws.getOperation()!=null)
			m2c.map2Webserviceoperation(wsidentifier, ws.getOperation());
		    
		}
	    }
	    
	    if (bsl.getCatalogs()!=null){
		for ( Catalog catalog : bsl.getCatalogs()){
		    if (catalog.getDatasets()!=null){
			for (Dataset dataset : catalog.getDatasets()){
			    
			    String uuiddataset=dataset.getIdentifier();
			    
			    m2c.map2DelDataset(uuiddataset);
			    
			    m2c.map2Dataset(uuiddataset, dataset.getTitle().get(0),
				    dataset.getDescription().get(0), dataset.getOnlineresource());
			    
			    Date created=null, published=null, modified=null;				    
			    if (dataset.getCreated()!=null)
				created=new Date(dataset.getCreated().toGregorianCalendar().getTimeInMillis());
			    if (dataset.getModified()!=null)
				modified=new Date(dataset.getModified().toGregorianCalendar().getTimeInMillis());
			    if (dataset.getIssued()!=null)
				published=new Date(dataset.getIssued().toGregorianCalendar().getTimeInMillis());	
			    m2c.map2Datasetdates(uuiddataset, created, modified, published);
			    
			    if (dataset.getLanguage()!=null)
				for (String lang : dataset.getLanguage())
				    m2c.map2Datasetlanguage(uuiddataset,lang);
			    
			    if (dataset.getLineage()!=null)
				m2c.map2Datasetlineage(uuiddataset, dataset.getLineage());	
			    
			    if (dataset.getResourcetype()!=null)
				m2c.map2Datasetresourcetype(uuiddataset,dataset.getResourcetype());
			    
			    if (dataset.getKeyword().length()>0){
				m2c.map2Datasetkeyword(uuiddataset, dataset.getKeyword());
			    }
			    
			    if (dataset.getAccesslimit()!=null)
				m2c.map2Datasetpublicaccesslimit(uuiddataset, dataset.getAccesslimit());
			    
			    if (dataset.getSpatialReferenceSystem()!=null)
				m2c.map2Datasetspatialreferencesystem(uuiddataset, dataset.getSpatialReferenceSystem());
			    
			    if (dataset.getSpatialextent()!=null){
				Location loc = dataset.getSpatialextent();
				
				m2c.map2Datasetlocation(uuiddataset, loc.getMinlat(), loc.getMaxlat(),
					loc.getMinlon(), loc.getMaxlon(), loc.getMinelev(), loc.getMaxelev());
			    }	
			    
			    if (dataset.getTemporalextent()!=null){
				Timestamp start=null,end=null;
				if (dataset.getTemporalextent().getStart()!=null)
				    start=new Timestamp(dataset.getTemporalextent().getStart().toGregorianCalendar().getTimeInMillis());
				if (dataset.getTemporalextent().getEnd()!=null)
				    end=new Timestamp(dataset.getTemporalextent().getStart().toGregorianCalendar().getTimeInMillis());
				m2c.map2Datasettemporalextent(uuiddataset, start, end);
			    }
			    
			    DatasetDistribution distribution = dataset.getDistribution();
			    if (distribution != null){
				
				if (distribution.getAccessurl()!=null)
				    m2c.map2Datasetaccessurl(uuiddataset, distribution.getAccessurl());
				
				if (distribution.getDownloadurl()!=null)
				    m2c.map2Datasetdownloadurl(uuiddataset, distribution.getDownloadurl());
				
				if (distribution.getFormat()!=null && distribution.getFormat().size()>0);
				m2c.map2Datasetformat(uuiddataset, distribution.getFormat().get(0));
				
				if (distribution.getLicense()!=null && distribution.getLicense().size()>0);
				m2c.map2Datasetaccessanduserestriction(uuiddataset, distribution.getLicense().get(0));
			    }
			    
			    if (dataset.getDomain()!=null)
				m2c.map2Datasetdomain(uuiddataset, dataset.getDomain());
			    
			    if (dataset.getSubDomain()!=null)
				m2c.map2Datasetsubdomain(uuiddataset, dataset.getSubDomain());
			    
			    if (dataset.getSubject()!=null)
				for (String subject : dataset.getSubject())
				    m2c.map2Datasetisotopic(uuiddataset, subject);
			    
			    if (dataset.getCharacterset()!=null)
				m2c.map2Datasetcharset(uuiddataset,dataset.getCharacterset());
			    
			    for (String contact : dataset.getContact()) 
				m2c.map2Datasetperson(uuiddataset, contact, "Contact");
			    
			    for (String responsibleparty : dataset.getResponsibleparty())
				m2c.map2Datasetperson(uuiddataset, responsibleparty, "Responsible Party");
			    
			    if (dataset.getSpatialresolution() !=null)
				m2c.map2Datasetresolution(uuiddataset, dataset.getSpatialresolution());
			    
			    if (dataset.getSpatialrepresentation()!=null)
				m2c.map2Datasetspatialrepresentationtype(uuiddataset, dataset.getSpatialrepresentation());
			    
			    if (dataset.getProvidedBy()!=null)
				m2c.map2Datasetorganisation(uuiddataset, dataset.getProvidedBy(), "Data Provider");
			    
			}
		    }
		}
	    }
	    
	    //equipment can be part of facilities - so create this first
	    if (bsl.getFacilities()!=null){
		for (Facility facil : bsl.getFacilities()){
		    String uuidfacility=facil.getIdentifier();
		    
		    m2c.map2Facility(uuidfacility, facil.getName(),facil.getDescription());
		    
		    if (facil.getContact()!=null)
			m2c.map2Facilityperson(uuidfacility, facil.getContact(), "Contact");
		    
		    if (facil.getManager()!=null)
			m2c.map2Facilityperson(uuidfacility, facil.getManager(), "Manager");
		    
		    if (facil.getOwner()!=null)
			m2c.map2Facilityorganisation(uuidfacility, facil.getOwner(), "Owner");
		    
		    if (facil.getWebaddress()!=null)
			m2c.map2Facilitywebsite(uuidfacility, facil.getWebaddress());
		    
		    if (facil.getAddress()!=null){
			String postcode=facil.getAddress().getPostcode();
			if (postcode.length()>16)
			    postcode=postcode.substring(0, 15);
			m2c.map2Facilityaddress(uuidfacility, facil.getAddress().getStreet(), 
				facil.getAddress().getLocality(), postcode, facil.getAddress().getCountry());
		    }
		    
		    for (String type : facil.getType())
			m2c.map2Facilitytype(uuidfacility, type);
		    
		    for (String domain : facil.getSciencedomain())
			m2c.map2Facilitysciencedomain(uuidfacility, domain);
		    
		}
	    }
	    
	    if (bsl.getEquipments()!=null){
		for (Equipment equip : bsl.getEquipments()){
		    
		    String uuidequip=equip.getIdentifier();
		    
		    m2c.map2Equipment(uuidequip, equip.getTitle(), equip.getDescription());
		    
		    m2c.map2Equipmenttype(uuidequip, equip.getType());
		    
		    if (equip.getLocation()!=null){
			Location loc = equip.getLocation();
			m2c.map2Equipmentlocation(uuidequip, loc.getMinlat(), loc.getMinlon(),  loc.getMinelev());
		    }						
		    
		    if (equip.getManufacturer()!=null){
			String uuidorgunit=UUID.randomUUID().toString();
			m2c.map2Organisation(uuidorgunit, equip.getManufacturer());
			m2c.map2Organisationtype(uuidorgunit, "Manufacturer");
			m2c.map2Equipmentorganisation(uuidequip, uuidorgunit , "Manufacturer");
		    }
		    
		    if (equip.getOwner()!=null)
			m2c.map2Equipmentorganisation(uuidequip, equip.getOwner(), "Owner");
		    
		    if (equip.getContactpoint()!=null)
			m2c.map2Equipmentperson(uuidequip, equip.getContactpoint(), "Contact");
		    
		    if (equip.getCount()!=null)
			m2c.map2Equipmentcount(uuidequip, equip.getCount());
		    
		    if (equip.getDynamicRange()!=null){
			ValueAndUnit dr=equip.getDynamicRange();
			m2c.map2Equipmentdynamicrange(uuidequip, dr.getValue(),dr.getUnit());	
		    }
		    
		    if (equip.getFilter()!=null)
			m2c.map2Equipmentfilter(uuidequip, equip.getFilter());	
		    
		    if (equip.getOrientation()!=null)
			m2c.map2Equipmentorientation(uuidequip, equip.getOrientation());
		    
		    if (equip.getResolution()!=null)
			m2c.map2Equipmentresolution(uuidequip, equip.getResolution());	
		    
		    if (equip.getSamplePeriod()!=null){
			ValueAndUnit dr=equip.getSamplePeriod();
			m2c.map2Equipmentsampleperiod(uuidequip, dr.getValue(),dr.getUnit());	
		    }
		    
		    if (equip.getSerial()!=null)
			m2c.map2Equipmentserial(uuidequip, equip.getSerial());						
		    
		    if (equip.getTimeperiod()!=null){
			Timestamp start=null, end=null;
			
			if (equip.getTimeperiod().getStart()!=null)
			    start=new Timestamp(equip.getTimeperiod().getStart().toGregorianCalendar().getTimeInMillis());
			
			if (equip.getTimeperiod().getEnd()!=null)
			    end=new Timestamp(equip.getTimeperiod().getEnd().toGregorianCalendar().getTimeInMillis());
			
			m2c.map2Equipmentvaliddaterange(uuidequip, start, end);						
		    }
		    
		    for (String parent : equip.getPartof()) //equipment
			m2c.map2Equipmentparent(uuidequip, parent);
		    
		    for (String facility : equip.getRelated())//facility
			m2c.map2Equipmentfacility(uuidequip,facility,"Provision");
		}
	    }
	    
	    if (bsl.getPublications()!=null){
		for (Publication pub : bsl.getPublications()){
		    
		    String uuidrespubl=pub.getIdentifier();
		    
		    Date issued=null;				    
		    if (pub.getIssued()!=null)
			issued=new Date(pub.getIssued().toGregorianCalendar().getTimeInMillis());
		    
		    String title=pub.getTitle().get(0);
		    String description=pub.getDescription().get(0);
		    
		    m2c.map2Publication(uuidrespubl, title, description, issued);
		    
		    for (String author : pub.getAuthors())
			m2c.map2Publicationperson(uuidrespubl, author, "Author");
		    
		    for (String contributor : pub.getContributors())
			m2c.map2Publicationperson(uuidrespubl, contributor, "Contributor");
		    
		    if (pub.getPublisher()!=null)
			m2c.map2Publicationorganisation(uuidrespubl, pub.getPublisher(), "Publisher");
		    
		    for (String license : pub.getAccesslimit())
			m2c.map2Publicationlicense(uuidrespubl,license);
		    
		    for (String format : pub.getFormat())
			m2c.map2Publicationformat(uuidrespubl,format);
		    
		    if (pub.getKeywords()!=null)
			m2c.map2Publicationkeyword(uuidrespubl,pub.getKeywords());
		    
		    if (pub.getIssn() !=null || pub.getIssueNumber()!=null || pub.getNumberOfPages() !=null || pub.getVolumeNumber() !=null){
			
			m2c.map2Publicationjournalarticledetails(
				uuidrespubl,
				pub.getIssn(),
				pub.getIssueNumber(),
				pub.getVolumeNumber(),
				pub.getNumberOfPages());
		    }
		}
	    }
	    
	    
	    // at the moment there are no services
	    
	    if (bsl.getServices()!=null){
		for (Service srv : bsl.getServices()){
		    
		    String uuidsrv=srv.getIdentifier();
		    m2c.map2Service(uuidsrv, srv.getName(), srv.getDescription());
		    for (String type : srv.getType())
			m2c.map2Servicetype(uuidsrv,type);
		    for (String license : srv.getLicense())
			m2c.map2Servicelicense(uuidsrv, license);
		    m2c.map2Serviceperson(uuidsrv, srv.getContact(), "Contact");
		    
		}
	    }
	    
	    
	    m2c.updateMaterialized(updateMaterializedRoutine());
	    
	    m2c.commit();
	    
	} catch (PSQLException e) {
	    if (e.getSQLState().equals("P0001")) {
	    	LOGGER.log(Level.SEVERE,e.getServerErrorMessage().getMessage());
	    } else {
	    	LOGGER.log(Level.INFO,e.toString());
	    }
	    try {
	    	LOGGER.log(Level.INFO,"Transaction is being rolled back");
		m2c.rollback();
	    } catch (SQLException excep) {
	    	LOGGER.log(Level.SEVERE,excep.getMessage());
	    }
	} catch (SQLException e) {
		LOGGER.log(Level.SEVERE,e.toString());
	    try {
	    	LOGGER.log(Level.SEVERE,"Transaction is being rolled back");
		m2c.rollback();
	    } catch (SQLException excep) {
	    	LOGGER.log(Level.SEVERE,excep.getMessage());
	    }
	}
	
	LOGGER.log(Level.INFO,"done");
	//System.out.println("materizalized view update");
	//System.out.println("materizalized view updated!!");
	m2c.closeFile();
	
    }
    public static void main(String[] args) {
    	
    	
	/*
	Locale.setDefault(Locale.ENGLISH);
	reader = new EPOSXMLReader();
	
	Properties props = new Properties();
	props.setProperty("user", user);
	props.setProperty("password", pass);
	
	m2c = new Map2Cerif();
	
	try {
	    Class.forName("org.postgresql.Driver");
	    Connection conn = DriverManager.getConnection(url, props);
	    m2c.setDBConnection(conn);
	    //m2c.setOutputStreamWriter(new FileWriter("/tmp/test.sql"));	
	    
	    String [] files={
		    
		    "EPOS-DCAT-AP/examples/WP08/EDSF_crustalfaults-WFS-DCAT-AP.xml",
		    "EPOS-DCAT-AP/examples/WP08/EDSF_crustalfaults-WMS-DCAT-AP.xml",
		    "EPOS-DCAT-AP/examples/WP08/EDSF_subductions-WFS-DCAT-AP.xml",
		    "EPOS-DCAT-AP/examples/WP08/EDSF_subductions-WMS-DCAT-AP.xml",
		    "EPOS-DCAT-AP/examples/WP08/EPOS-DCAT-AP_WP08_GFZ.xml",
		    "EPOS-DCAT-AP/examples/WP08/EPOS-DCAT-AP_WP08_INGV_AHEAD.xml",
		    "EPOS-DCAT-AP/examples/WP08/EPOS-DCAT-AP_WP08_INGV_event_v1.xml",
		    "EPOS-DCAT-AP/examples/WP08/EPOS-DCAT-AP_WP08_INGV_shakemap_v1.xml",
		    "EPOS-DCAT-AP/examples/WP08/EPOS-DCAT-AP_WP08_INGV.xml",
		    "EPOS-DCAT-AP/examples/WP09/EPOS-DCAT-AP_WP09_IRPINIA.xml",
		    "EPOS-DCAT-AP/examples/WP09/EPOS-DCAT-AP_WP09_NIEP_EVENT.xml",
		    "EPOS-DCAT-AP/examples/WP09/EPOS-DCAT-AP_WP09_NIEP_VPVS.xml",
		    "EPOS-DCAT-AP/examples/WP09/EPOS-DCAT-AP_WP09_TABOO_CO2.xml",
		    "EPOS-DCAT-AP/examples/WP09/EPOS-DCAT-AP_WP09_TABOO_event.xml",
		    "EPOS-DCAT-AP/examples/WP09/EPOS-DCAT-AP_WP09_TABOO_RADON.xml",
		    "EPOS-DCAT-AP/examples/WP09/EPOS-DCAT-AP_WP09_TABOO_VPVS.xml",
		    "EPOS-DCAT-AP/examples/WP10/EPOS-DCAT-AP_WP10.xml",
		    "EPOS-DCAT-AP/examples/WP11/Bulk_Rock_Analysis.xml",
		    "EPOS-DCAT-AP/examples/WP11/DynVolc.xml",
		    "EPOS-DCAT-AP/examples/WP11/EPOS-DCAT-AP_WP11_IPGP_sesimic_wavforms.xml",
		    "EPOS-DCAT-AP/examples/WP11/Volcanic_Tremor.xml",
		    "EPOS-DCAT-AP/examples/WP11/WP11-DDSS-036_GAZVOLC.xml",
		    "EPOS-DCAT-AP/examples/WP11/WP11-DDSS-049_HOTVOLC_Lava_products.xml",
		    "EPOS-DCAT-AP/examples/WP12/EPOS-DCAT-AP_WP12.xml",
		    "EPOS-DCAT-AP/examples/WP13/EPOS-DCAT-AP_wp13_WorldMagneticModel.xml",
		    "EPOS-DCAT-AP/examples/WP14/EPOS-DCAT-AP_WP14.xml",
		    "EPOS-DCAT-AP/examples/WP15/BoreholeDataIndex_WFS-EPOS-DCAT-AP.xml",
		    "EPOS-DCAT-AP/examples/WP15/BoreholeDataIndex_WMS-EPOS-DCAT-AP.xml",
		    "EPOS-DCAT-AP/examples/WP15/WP15_CSW-EPOS-DCAT-AP.xml",
		    "EPOS-DCAT-AP/examples/WP16/EPOS-DCAT-AP_WP16.xml"
		    
	    };
	    
	    for (String filename : files){
	    	LOGGER.log(Level.INFO,"reading "+filename);
		ingest("/home/damian/"+filename);		
	    }	
	    m2c.closeFile();
	    
	} catch (FileNotFoundException e) {
		LOGGER.log(Level.SEVERE,e.getMessage());
	} catch (JAXBException e) {
		LOGGER.log(Level.SEVERE,e.getMessage());
	    e.printStackTrace();
	} catch (SQLException e) {
		LOGGER.log(Level.SEVERE,e.getMessage());
	} catch (IOException e) {
		LOGGER.log(Level.SEVERE,e.getMessage());
	} catch (ClassNotFoundException e) {
		LOGGER.log(Level.SEVERE,"Can not find class :" + e.getMessage());
	    
	}
	*/
    }
    
    public static String updateMaterializedRoutine()
    {
	String routine = "";
	BufferedReader br = null;
	FileReader fr = null;
	try {
	    File f = new File("create-mat_drop_mat.sql");
	    fr = new FileReader(f.getAbsolutePath());
	    br = new BufferedReader(fr);
	    
	    String sCurrentLine;
	    
	    while ((sCurrentLine = br.readLine()) != null) {
		routine+=sCurrentLine+ " ";
	    }
	} catch (IOException e) {
	    e.printStackTrace();
	} finally {
	    try {
		if (br != null)
		    br.close();
		if (fr != null)
		    fr.close();
	    } catch (IOException ex) {
		ex.printStackTrace();
	    }
	}
	LOGGER.log(Level.INFO,routine);
	return routine;
    }
}

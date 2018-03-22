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
package org.epos_ip.dcatflat;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

import org.eclipse.persistence.oxm.annotations.XmlPath;

@XmlRootElement(name = "Epos", namespace = "http://www.epos-ip.org/terms.html")
@XmlAccessorType(XmlAccessType.FIELD)
public class Baseline {

	@XmlPath("eposap:Catalog")
	private List<Catalog> catalogs;

	@XmlPath("eposap:Person")
	private List<Person> persons;

	@XmlPath("eposap:Organisation")
	private List<Organisation> organisations;

	@XmlPath("eposap:Project")
	private List<Project> projects;

	@XmlPath("eposap:WebService")
	private List<Webservice> webservices;

	@XmlPath("eposap:Publication")
	private List<Publication> publications;

	@XmlPath("eposap:Service")
	private List<Service> services;

	@XmlPath("eposap:Equipment")
	private List<Equipment> equipments;

	@XmlPath("eposap:Facility")
	private List<Facility> facilities;

	public List<Webservice> getWebservices() {
		return webservices;
	}

	public List<Catalog> getCatalogs() {
		if (catalogs == null)
			return new ArrayList<Catalog>();
		return catalogs;
	}

	public void setCatalogs(List<Catalog> catalogs) {
		this.catalogs = catalogs;
	}

	public List<Person> getPersons() {
		return persons;
	}

	public void setPersons(List<Person> persons) {
		this.persons = persons;
	}

	public List<Organisation> getOrganisations() {
		return organisations;
	}

	public void setOrganisations(List<Organisation> organisations) {
		this.organisations = organisations;
	}

	public List<Project> getProjects() {
		return projects;
	}

	public void setProjects(List<Project> projects) {
		this.projects = projects;
	}

	public List<Publication> getPublications() {
		return publications;
	}

	public void setPublications(List<Publication> publications) {
		this.publications = publications;
	}

	public List<Service> getServices() {
		return services;
	}

	public void setServices(List<Service> services) {
		this.services = services;
	}

	public List<Equipment> getEquipments() {
		return equipments;
	}

	public void setEquipments(List<Equipment> equipments) {
		this.equipments = equipments;
	}

	public List<Facility> getFacilities() {
		return facilities;
	}

	public void setFacilities(List<Facility> facilities) {
		this.facilities = facilities;
	}

	public void setWebservices(List<Webservice> webservices) {
		this.webservices = webservices;
	}

}

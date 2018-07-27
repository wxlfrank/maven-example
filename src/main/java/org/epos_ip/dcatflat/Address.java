package org.epos_ip.dcatflat;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;

import org.eclipse.persistence.oxm.annotations.XmlPath;

@XmlAccessorType(XmlAccessType.FIELD)
public class Address {

	@XmlPath("vcard:street-address/text()")
	private String street;

	@XmlPath("vcard:locality/text()")
	private String locality;

	@XmlPath("vcard:postal-code/text()")
	private String postcode;

	@XmlPath("vcard:country-name/text()")
	private String country;

	public String getStreet() {
		System.out.println(street);
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getLocality() {
		return locality;
	}

	public void setLocality(String locality) {
		this.locality = locality;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	@Override
	public String toString() {
		return "Address [street=" + street + ", locality=" + locality + ", postcode=" + postcode + ", country="
				+ country + "]";
	}

}

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

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlTransient;

import org.eclipse.persistence.oxm.annotations.XmlPath;

@XmlAccessorType(XmlAccessType.FIELD)
public class Location {

	@XmlPath("locn:geometry/text()")
	private String locationstring;

	@XmlTransient
	Double minlat = Double.MAX_VALUE;
	@XmlTransient
	Double maxlat = Double.MIN_VALUE;
	@XmlTransient
	Double minlon = Double.MAX_VALUE;
	@XmlTransient
	Double maxlon = Double.MIN_VALUE;
	@XmlTransient
	Double minelev = Double.MAX_VALUE;
	@XmlTransient
	Double maxelev = Double.MIN_VALUE;

	void afterUnmarshal(Unmarshaller u, Object parent) {

		String[] st = locationstring.split("\\(");
		String[] st1 = st[1].split("\\)");

		if (locationstring.startsWith("POINT")) {

			String points = st1[0].replace(",", " ");
			String[] numbers = points.split("\\s+");

			if (numbers.length >= 2) {

				double lon = Double.parseDouble(numbers[0]);
				double lat = Double.parseDouble(numbers[1]);

				minlat = (lat < minlat) ? lat : minlat;
				maxlat = (lat > maxlat) ? lat : maxlat;
				minlon = (lon < minlon) ? lon : minlon;
				maxlon = (lon > maxlon) ? lon : maxlon;


				if (numbers.length > 2) {
					double elev = Double.parseDouble(numbers[2]);
					minelev = (elev < minelev) ? elev : minelev;
					maxelev = (elev > maxelev) ? elev : maxelev;
				}
			}

		} else if (locationstring.startsWith("POLYGON")) {

			String[] points = st1[0].split(",");

			for (int i = 0; i < points.length; i++) {
				String[] numbers = points[i].trim().split("\\s+");

				if (numbers.length < 2)
					continue;

				double lon = Double.parseDouble(numbers[0]);
				double lat = Double.parseDouble(numbers[1]);

				minlat = (lat < minlat) ? lat : minlat;
				maxlat = (lat > maxlat) ? lat : maxlat;
				minlon = (lon < minlon) ? lon : minlon;
				maxlon = (lon > maxlon) ? lon : maxlon;

			}
		}
	}

	boolean beforeMarshal(Marshaller m) {
		if (minlon.equals(maxlon) && minlat.equals(maxlat)) {
			locationstring = "POINT(" + fmt(minlon) + " " + fmt(minlat);
			if (minelev != null)
				locationstring += " " + fmt(minelev);
			locationstring += ")";

		} else {
			locationstring = "POLYGON(";
			locationstring += fmt(minlon) + " " + fmt(minlat) + ",";
			locationstring += fmt(maxlon) + " " + fmt(minlat) + ",";
			locationstring += fmt(maxlon) + " " + fmt(maxlat) + ",";
			locationstring += fmt(minlon) + " " + fmt(maxlat) + ",";
			locationstring += fmt(minlon) + " " + fmt(minlat);
			locationstring += ")";
		}

		return true;
	}

	protected String fmt(double d) {

		NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);
		((DecimalFormat) numberFormat).applyPattern("###.##");
		return numberFormat.format(d);

	}

	public String getLocationstring() {
		return locationstring;
	}

	public void setLocationstring(String locationstring) {
		this.locationstring = locationstring;
	}

	public Double getMinlat() {
		if (minlat.equals(Double.MAX_VALUE))
			return null;
		return minlat;
	}

	public void setMinlat(Double minlat) {
		this.minlat = minlat;
	}

	public Double getMaxlat() {
		if (maxlat.equals(Double.MIN_VALUE))
			return null;
		return maxlat;
	}

	public void setMaxlat(Double maxlat) {
		this.maxlat = maxlat;
	}

	public Double getMinlon() {
		if (minlon.equals(Double.MAX_VALUE))
			return null;
		return minlon;
	}

	public void setMinlon(Double minlon) {
		this.minlon = minlon;
	}

	public Double getMaxlon() {
		if (maxlon.equals(Double.MIN_VALUE))
			return null;
		return maxlon;
	}

	public void setMaxlon(Double maxlon) {
		this.maxlon = maxlon;
	}

	public Double getMinelev() {
		if (minelev.equals(Double.MAX_VALUE))
			return null;
		return minelev;
	}

	public void setMinelev(Double minelev) {
		this.minelev = minelev;
	}

	public Double getMaxelev() {
		if (maxelev.equals(Double.MIN_VALUE))
			return null;
		return maxelev;
	}

	public void setMaxelev(Double maxelev) {
		this.maxelev = maxelev;
	}

}

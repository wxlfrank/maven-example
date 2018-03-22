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

import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.datatype.XMLGregorianCalendar;

import org.eclipse.persistence.oxm.annotations.XmlPath;

@XmlAccessorType(XmlAccessType.FIELD)
public class DatasetDistribution {

	@XmlPath("dct:title/text()")
	private List<String> title;

	@XmlPath("dct:description/text()")
	private List<String> description;

	@XmlPath("dct:accessURL/text()")
	private String accessurl;
	
	@XmlPath("dct:dowloadURL/text()")
	private String downloadurl;	
	
	@XmlPath("dct:issued/text()")
	private XMLGregorianCalendar issued;

	@XmlPath("dct:modified/text()")
	private XMLGregorianCalendar modified;

	@XmlPath("dct:format/dct:MediaTypeOrExtent/text()")
	private List<String> format;

	@XmlPath("dct:license/text()")
	private List<String> license;

	public List<String> getTitle() {
		return title;
	}

	public void setTitle(List<String> title) {
		this.title = title;
	}

	public List<String> getDescription() {
		return description;
	}

	public void setDescription(List<String> description) {
		this.description = description;
	}

	public XMLGregorianCalendar getIssued() {
		return issued;
	}

	public void setIssued(XMLGregorianCalendar issued) {
		this.issued = issued;
	}

	public XMLGregorianCalendar getModified() {
		return modified;
	}

	public void setModified(XMLGregorianCalendar modified) {
		this.modified = modified;
	}

	public List<String> getFormat() {
		return format;
	}

	public void setFormat(List<String> format) {
		this.format = format;
	}

	public List<String> getLicense() {
		return license;
	}

	public void setLicense(List<String> license) {
		this.license = license;
	}

	public String getAccessurl() {
		return accessurl;
	}

	public void setAccessurl(String accessurl) {
		this.accessurl = accessurl;
	}

	public String getDownloadurl() {
		return downloadurl;
	}

	public void setDownloadurl(String downloadurl) {
		this.downloadurl = downloadurl;
	}

}

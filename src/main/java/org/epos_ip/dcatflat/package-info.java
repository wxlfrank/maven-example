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
@javax.xml.bind.annotation.XmlSchema(namespace = "http://www.epos-ip.org/", xmlns = {
		@javax.xml.bind.annotation.XmlNs(prefix = "eposap", namespaceURI = "http://www.epos-ip.org/terms.html"),
		@javax.xml.bind.annotation.XmlNs(prefix = "dct", namespaceURI = "http://purl.org/dc/terms/"),
		@javax.xml.bind.annotation.XmlNs(prefix = "foaf", namespaceURI = "http://xmlns.com/foaf/0.1/"),
		@javax.xml.bind.annotation.XmlNs(prefix = "skos", namespaceURI = "http://www.w3.org/2004/02/skos/core#"),
		@javax.xml.bind.annotation.XmlNs(prefix = "adms", namespaceURI = "http://www.w3.org/ns/adms#"),
		@javax.xml.bind.annotation.XmlNs(prefix = "cnt", namespaceURI = "http://www.w3.org/2008/content#"),
		@javax.xml.bind.annotation.XmlNs(prefix = "http", namespaceURI = "http://www.w3.org/2006/http#"),
		@javax.xml.bind.annotation.XmlNs(prefix = "locn", namespaceURI = "http://www.w3.org/ns/locn#"),
		@javax.xml.bind.annotation.XmlNs(prefix = "rdf", namespaceURI = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"),
		@javax.xml.bind.annotation.XmlNs(prefix = "skos", namespaceURI = "http://www.w3.org/2004/02/skos/core#"),
		@javax.xml.bind.annotation.XmlNs(prefix = "vcard", namespaceURI = "http://www.w3.org/2006/vcard/ns#"),
		@javax.xml.bind.annotation.XmlNs(prefix = "xml", namespaceURI = "http://www.w3.org/XML/1998/namespace"),
		@javax.xml.bind.annotation.XmlNs(prefix = "xsi", namespaceURI = "http://www.w3.org/2001/XMLSchema-instance"),
		@javax.xml.bind.annotation.XmlNs(prefix = "dcat", namespaceURI = "http://www.w3.org/ns/dcat#"),
		@javax.xml.bind.annotation.XmlNs(prefix = "owl", namespaceURI = "http://www.w3.org/2002/07/owl#"),
		@javax.xml.bind.annotation.XmlNs(prefix = "schema", namespaceURI = "http://schema.org/")

}, elementFormDefault = javax.xml.bind.annotation.XmlNsForm.QUALIFIED)

@XmlJavaTypeAdapter(value = StringTrimXmlAdapter.class, type = String.class)
package org.epos_ip.dcatflat;

import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

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

import java.io.InputStreamReader;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.stream.XMLStreamWriter;

import org.epos_ip.dcatflat.Baseline;

public class EPOSXMLReader {
	private final static Logger LOGGER = Logger.getLogger(Logger.GLOBAL_LOGGER_NAME);
	static public JAXBContext jaxbContext = initContext();

	static private JAXBContext initContext() {
		try {
			return JAXBContext.newInstance(org.epos_ip.dcatflat.Baseline.class);
		} catch (JAXBException e) {
			return null;
		}
	}

	public EPOSXMLReader() {
		jaxbContext = initContext();
	}

	public Baseline readXML(InputStreamReader infile) throws JAXBException {
		LOGGER.log(Level.INFO, "Getting xml");
		Unmarshaller unmarshaller = jaxbContext.createUnmarshaller();
		Object obj = unmarshaller.unmarshal(infile);
		if (obj instanceof Baseline) {
			return (Baseline) obj;
		}
		return null;
	}

	public void writeXML(Baseline obj, XMLStreamWriter sw) throws JAXBException {
		Marshaller marshaller = jaxbContext.createMarshaller();
		marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
		marshaller.marshal(obj, sw);

	}

}

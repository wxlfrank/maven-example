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

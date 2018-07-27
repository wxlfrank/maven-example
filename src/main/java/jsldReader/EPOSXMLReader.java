package jsldReader;

import java.io.Reader;
import java.io.Writer;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.bind.helpers.DefaultValidationEventHandler;

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

	public Baseline readXML(Reader infile) throws JAXBException {
		LOGGER.log(Level.INFO, "Getting xml");
		Unmarshaller unmarshaller = jaxbContext.createUnmarshaller();
		unmarshaller.setEventHandler(new DefaultValidationEventHandler());
		Object obj = unmarshaller.unmarshal(infile);
		if (obj instanceof Baseline) {
			return (Baseline) obj;
		}
		return null;
	}

	public void writeXML(Baseline obj, Writer sw) throws JAXBException {
		Marshaller marshaller = jaxbContext.createMarshaller();
		marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
		marshaller.setEventHandler(new DefaultValidationEventHandler());
		marshaller.marshal(obj, sw);
	}

}

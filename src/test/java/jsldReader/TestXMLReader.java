package jsldReader;

import java.io.FileNotFoundException;
import java.io.FileReader;

import javax.xml.bind.JAXBException;

import org.epos_ip.dcatflat.Baseline;
import org.junit.Assert;
import org.junit.Test;

public class TestXMLReader {

	@Test
	public void test() {
		EPOSXMLReader reader = new EPOSXMLReader();
		try {
			Baseline baseline = reader
					.readXML(new FileReader("examples/EPOS-DCAT-AP_WP08_INGV_shakemap_v1.xml"));
			Assert.assertNotNull(baseline);
			Assert.assertNotNull(baseline.getPersons());
			Assert.assertTrue(baseline.getPersons().size() == 1);
		} catch (FileNotFoundException | JAXBException e) {
			e.printStackTrace();
		}
	}
}

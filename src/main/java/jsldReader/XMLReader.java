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

import java.io.IOException;
import java.io.PrintStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import java.util.logging.Level;
import java.util.logging.Logger;

import org.w3c.dom.Document;
import org.w3c.dom.DocumentType;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class XMLReader {

	private final static Logger LOGGER = Logger.getLogger(Logger.GLOBAL_LOGGER_NAME);
	
	public static void main(String[] args) {
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder;
		try {
			dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse("src/main/xsd/EPOS_DCAT-AP.xml");
			doc.normalizeDocument();
			PrintStream stream = new PrintStream("result");
			printNode(stream, doc, 0);
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	static String[] types = { "ELEMENT", "ATTRIBUTE", "TEXT", "CDATA_SECTION", "ENTITY_REFERENCE", "ENTITY",
			"PROCESSING_INSTRUCTION", "COMMENT", "DOCUMENT", "DOCUMENT_TYPE", "DOCUMENT_FRAGMENT", "NOTATION" };
	static String tab = "|--";
	static String[] tabs = new String[10];
	static {
		for (int i = 0; i < tabs.length; i++) {
			tabs[i] = new String(new char[i * 3]).replaceAll("\0\0\0", tab);
		}
	}
	static String pattern = "%1$s |%2$s |%3$s\n";

	/**
	 * @param node
	 */
	private static void printNode(PrintStream stream, Node node, int level) {
		if (node == null)
			return;
		int type = node.getNodeType();
		if (type == Node.TEXT_NODE && node.getNodeValue().trim().isEmpty())
			return;
		String result = tabs[level] + pattern;
		stream.format(result, types[type - 1], node.getNodeName(), node.getNodeValue());
		if (type == Node.ATTRIBUTE_NODE)
			return;
		if (type == Node.DOCUMENT_NODE) {
			Document doc = (Document) node;
			stream.println(doc.getXmlEncoding());
			stream.println(doc.getXmlStandalone());
			stream.println(doc.getXmlVersion());
			DocumentType docType = doc.getDoctype();
			printNode(stream, docType, level + 1);
		}
		NamedNodeMap map = node.getAttributes();
		if (map != null)
			for (int index = 0; index < map.getLength(); ++index) {
				printNode(stream, map.item(index), level + 1);
			}
		NodeList list = node.getChildNodes();
		for (int index = 0; index < list.getLength(); ++index) {
			printNode(stream, list.item(index), level + 1);
		}
	}

	private static void printNote(NodeList nodeList) {

		for (int count = 0; count < nodeList.getLength(); count++) {

			Node tempNode = nodeList.item(count);

			// make sure it's element node.
			if (tempNode.getNodeType() == Node.ELEMENT_NODE) {

				// get node name and value
				LOGGER.log(Level.INFO,"\nNode Name =" + tempNode.getNodeName() + " [OPEN]");
				LOGGER.log(Level.INFO,"Node Value =" + tempNode.getTextContent());

				if (tempNode.hasAttributes()) {

					// get attributes names and values
					NamedNodeMap nodeMap = tempNode.getAttributes();

					for (int i = 0; i < nodeMap.getLength(); i++) {

						Node node = nodeMap.item(i);
						LOGGER.log(Level.INFO,"attr name : " + node.getNodeName());
						LOGGER.log(Level.INFO,"attr value : " + node.getNodeValue());

					}

				}

				if (tempNode.hasChildNodes()) {

					// loop again if has child nodes
					printNote(tempNode.getChildNodes());

				}

				LOGGER.log(Level.INFO,"Node Name =" + tempNode.getNodeName() + " [CLOSE]");

			}

		}

	}
}

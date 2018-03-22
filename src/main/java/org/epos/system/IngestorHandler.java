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
package org.epos.system;


import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.xml.bind.JAXBException;

import org.epos.jsonmessage.JsonMessage;
import org.epos.mq.Handler;

import jsldReader.Reader;

public class IngestorHandler extends Handler
{
	private final static Logger LOGGER = Logger.getLogger(Logger.GLOBAL_LOGGER_NAME);
    public String handle(String message) {
	//Reader r = new Reader();
	String output = null;
	try {
	    Reader.ingest(message);
	    output = "File "+message+" added to database";
	} catch (ClassNotFoundException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	    output = "Something wrong: "+e.getMessage();
	} catch (JAXBException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	    output = "Something wrong: "+e.getMessage();
	} catch (SQLException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	    output = "Something wrong: "+e.getMessage();
	} catch (IOException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	    output = "Something wrong: "+e.getMessage();
	}
	LOGGER.log(Level.INFO, "DONE");
	LOGGER.log(Level.INFO, output);
	return output;
    }
    
    @Override
    public String getSendQueue() {
	return "ToWebApi";
    }
}

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
package org.epos_ip.jaxb;

import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.List;

import org.junit.Test;

public class DBScriptTest {
/*
	@Test
	public void test() throws FileNotFoundException {
		DBColumnReader reader = new DBColumnReader("jdbc:postgresql://localhost/cerif", "postgres", "escidoc");
		List<Table> tables = reader.getDBColumns();
		TableToSQLFunction transform = new TableToSQLFunction();
		PrintWriter function_writer = new PrintWriter("cerf.functions.generated.sql");
		for (Table iter : tables) {
			function_writer.println(transform.toSQLFunction(iter));
		}
		function_writer.close();
		
		function_writer = new PrintWriter("src/main/java/jsldReader/ToCerif.java");
		SQLFunction2JavaFunction transform_2 = new SQLFunction2JavaFunction();
		function_writer.println(transform_2.toJavaFunction("cerf.functions.generated.sql"));
		function_writer.close();
	}
	
	@Test
	public void generateDamian() throws FileNotFoundException {
		PrintWriter function_writer = new PrintWriter("src/main/java/jsldReader/Map2Cerif.java");
		SQLFunction2JavaFunction transform_2 = new SQLFunction2JavaFunction();
		function_writer.println(transform_2.toJavaFunction("damian.sql"));
		function_writer.close();
	}
*/
}

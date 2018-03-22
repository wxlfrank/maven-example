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

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.junit.Assert;

class SQLFunction2JavaFunction {

	private static final Map<String, String> TYPE_SQL2JAVA = new HashMap<String, String>();
	static {
		TYPE_SQL2JAVA.put("varchar", "String");
		TYPE_SQL2JAVA.put("char", "String");
		TYPE_SQL2JAVA.put("text", "String");
		TYPE_SQL2JAVA.put("double precision", "double");
		TYPE_SQL2JAVA.put("float8", "double");
		TYPE_SQL2JAVA.put("timestamp", "Timestamp");
		TYPE_SQL2JAVA.put("date", "Date");
		TYPE_SQL2JAVA.put("numeric", "int");
		TYPE_SQL2JAVA.put("integer", "int");
		TYPE_SQL2JAVA.put("bytea", "byte");
	}

	private static final String JAVA_HEADER = String.format("package jsldReader;%n" + "import java.sql.Connection;%n"
			+ "import java.sql.PreparedStatement;%n" + "import java.sql.SQLException;%n" + "import java.sql.Date;%n"
			+ "import java.util.ArrayList;%n" + "import java.util.List;%n" + "import java.sql.Timestamp;%n%n"
			+ "public class ToCerif {%n" + "\tprotected Connection connection = null; %n"
			+ "\tprivate List<PreparedStatement> statements = new ArrayList<PreparedStatement>();%n"
			+ "\tpublic ToCerif(Connection con){%n" + "\tconnection = con;%n" + "\t}%n%n");
	private static final String JAVA_FOOTER = "public List<PreparedStatement> getStatements() { return statements; }}";

	private static final int SQL_DECLARATION_PARAMETERS_LENGTH = 50;
	private static final String[] SQL_DECLARATION_PARAMETERS = new String[SQL_DECLARATION_PARAMETERS_LENGTH];
	static {
		String init = "?";
		SQL_DECLARATION_PARAMETERS[0] = " ()";
		SQL_DECLARATION_PARAMETERS[1] = " (?)";
		for (int i = 2; i < SQL_DECLARATION_PARAMETERS_LENGTH; i++) {
			init = init + ", ?";
			SQL_DECLARATION_PARAMETERS[i] = " (" + init + ")";
		}
	}

	private static final String[] java_keywords = new String[] { "abstract", "assert", "boolean", "break", "byte",
			"case", "switch", "case", "default", "switch", "case", "switch", "catch", "try", "finally", "catch", "try",
			"char", "class", "Object", "const", "final", "continue", "default", "case", "switch", "do", "while", "true",
			"false", "double", "else", "if", "true", "if", "false", "else", "enum", "Enum", "extends", "final",
			"finally", "try", "finally", "try", "catch", "try", "catch", "return", "float", "for", "true", "false",
			"for", "Iterable", "goto", "if", "true", "else", "implements", "import", "static", "instanceof", "int",
			"interface", "static final", "static", "implements", "long", "native", "new", "package", "private",
			"protected", "public", "return", "short", "static", "strictfp", "super", "switch", "case", "default",
			"case", "default", "synchronized", "Class", "this", "throw", "catch", "throws", "RuntimeException",
			"throws", "transient", "try", "catch", "finally", "try", "catch", "try", "catch", "finally", "void",
			"volatile", "while", "true", "false", "do", "true", "null", "false" };
	private static final Set<String> JAVA_KEYWORDS = new HashSet<String>();
	private static final String FUNCTION_DECLARATION = "CREATE OR REPLACE FUNCTION ";
	private static final int FUNCTION_DECLARATION_LENGTH = FUNCTION_DECLARATION.length();
	private static final int PARAMETER_SIZE = 50;
	private static final String[] parameters = new String[PARAMETER_SIZE];
	static {
		String init = "?";
		parameters[0] = " ()";
		parameters[1] = " (?)";
		for (int i = 2; i < PARAMETER_SIZE; i++) {
			init = init + ", ?";
			parameters[i] = " (" + init + ")";
		}
		JAVA_KEYWORDS.addAll(Arrays.asList(java_keywords));
	}

	private void getName2Function(String file, Map<String, String> name2function) {
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new FileReader(file));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		String line = null;
		try {
			while ((line = reader.readLine()) != null) {
				if (!line.startsWith(FUNCTION_DECLARATION))
					continue;
				int index_of_resturns = line.indexOf("RETURNS");
				if (index_of_resturns != -1)
					line = line.substring(0, index_of_resturns);
				int index_of_last_parenthesis = line.lastIndexOf(')');
				if (index_of_last_parenthesis < 0)
					continue;
				line = line.substring(FUNCTION_DECLARATION_LENGTH, index_of_last_parenthesis).trim();

				int index_of_first_parenthesis = line.indexOf('(');
				if (index_of_first_parenthesis < 0)
					continue;
				name2function.put(line.substring(0, index_of_first_parenthesis).trim(),
						line.substring(index_of_first_parenthesis + 1).trim());
			}
			reader.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String toJavaFunction(String sql_function_file) {
		StringBuilder builder = new StringBuilder();
		builder.append(JAVA_HEADER);
		Set<String> types = new HashSet<String>();
		Map<String, List<String[]>> function2parameters = new HashMap<String, List<String[]>>();

		Map<String, String> name2function = new HashMap<String, String>();
		getName2Function(sql_function_file, name2function);
		getName2Function("ex." + sql_function_file, name2function);
		
		for (Entry<String, String> iter : name2function.entrySet()) {
			String function_name = iter.getKey();
			String parameter_string = iter.getValue().replaceAll("\\([^\\)]*\\)", "").replaceAll("  *", " ").trim();
			String[] parameters = parameter_string.isEmpty() ? new String[0] : parameter_string.split(",");

			List<String[]> typed_parameters = new ArrayList<String[]>();
			for (int i = 0; i < parameters.length; i++) {
				String parameter = parameters[i].trim();
				if (parameter.startsWith("out "))
					continue;
				int index_of_space = parameter.indexOf(' ');
				String parameter_name = parameter.substring(0, index_of_space);
				if (JAVA_KEYWORDS.contains(parameter_name))
					parameter_name = "_" + parameter_name;

				String parameter_type = parameter.substring(index_of_space + 1).trim();
				int index_of_parenthesis = parameter_type.indexOf('(');
				if (index_of_parenthesis != -1)
					parameter_type = parameter_type.substring(0, index_of_parenthesis);
				types.add(parameter_type);
				typed_parameters.add(new String[] { parameter_name, TYPE_SQL2JAVA.get(parameter_type) });
			}
			function2parameters.put(function_name, typed_parameters);
		}
		for (String type : types) {
			Assert.assertNotNull(TYPE_SQL2JAVA.get(type));
		}

		for (Entry<String, List<String[]>> entry : function2parameters.entrySet()) {
			String key = entry.getKey();
			List<String[]> value = entry.getValue();
			String sql = String.format(SQL_STATEMENT, key.toUpperCase(), key + parameters[value.size()]);
			builder.append(sql);
			String[] java_function_parameters = new String[value.size()];
			int index = 0;
			for (String[] par : value) {
				java_function_parameters[index++] = par[1] + " " + par[0];
			}
			builder.append(String.format(JAVA_FUNCTION_HEADER, key, String.join(", ", java_function_parameters),
					key.toUpperCase()));

			String set_parameter = "";
			for (int i = 0; i < value.size(); i++) {
				String[] par = value.get(i);
				set_parameter += String.format(SET_PARAMETER, UPPERCASE_FIRST_CHARACTER(par[1]), i, par[0]);
			}
			builder.append(set_parameter);
			builder.append(JAVA_FUNCTION_FOOTER);

		}
		builder.append(JAVA_FOOTER);
		return builder.toString();
	}

	private static final String SQL_STATEMENT = "public static final String %1$s = \"select %2$s;\";%n";
	private static final String JAVA_FUNCTION_HEADER = "public PreparedStatement %1$s (%2$s){%n"
			+ "\tPreparedStatement result = null;%n" + "\ttry {%n"
			+ "\t\tresult = connection.prepareStatement(%3$s);%n";
	private static final String SET_PARAMETER = "\t\tresult.set%1$s(%2$d, %3$s);%n";
	private static final String JAVA_FUNCTION_FOOTER = String
			.format("\t}%n" + "\tcatch (SQLException e) {%n" + "\t}%n" + "\treturn result;%n" + "}%n%n");

	public static String UPPERCASE_FIRST_CHARACTER(String str) {
		if (str == null)
			return null;
		return str.substring(0, 1).toUpperCase() + str.substring(1);
	}

}

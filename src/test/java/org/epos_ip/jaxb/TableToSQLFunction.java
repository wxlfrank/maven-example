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

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.junit.Assert;

/**
 * @author wxlfrank
 *
 */
class TableToSQLFunction {

	private static final String FUNCTION = "CREATE OR REPLACE FUNCTION to%1$s (%2$s) RETURNS VOID AS $$%n" + "BEGIN%n"
			+ "IF NOT EXISTS (SELECT * FROM %1$s WHERE %3$s) THEN %n" + "\tINSERT INTO %1$s (%4$s) VALUES (%5$s);%n"
			+ "ELSE%n" + "\tUPDATE %1$s SET %6$s  WHERE %7$s;%n" + "END IF;%n" + "END; %n" + "$$ LANGUAGE plpgsql;%n";
	private static final String FUNCTION_RELATION = "CREATE OR REPLACE FUNCTION to%1$s (%2$s) RETURNS VOID AS $$%n"
			+ "DECLARE%n\t v_cfclassid varchar(128);%n\t v_cfclassschemeid varchar(128);%n" + "BEGIN%n"
			+ "\tSELECT s.schemeid, s.classid into v_cfclassschemeid, v_cfclassid from getsemantics(v_cfclassname, v_cfschemename) s;%n"
			+ "\tIF NOT EXISTS (SELECT * FROM %1$s WHERE %3$s) THEN %n" + "\t\tINSERT INTO %1$s (%4$s) VALUES (%5$s);%n"
			+ "\tELSE%n" + "\t\tUPDATE %1$s SET %6$s  WHERE %7$s;%n\tEND IF;%n" + "END; %n" + "$$ LANGUAGE plpgsql;%n";

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
	private static final Set<String> SPECIAL_IDS = new HashSet<String>();
	static {
		String[] SPECIAL_IDS = { "cfclassid", "cfclassschemeid" };
		TableToSQLFunction.SPECIAL_IDS.addAll(Arrays.asList(SPECIAL_IDS));
	}
	private static final Map<String, Integer> ORDER = new HashMap<String, Integer>();
	static {
		ORDER.put("language", 8);
		ORDER.put("cffraction", 7);
		ORDER.put("cfenddate", 6);
		ORDER.put("cfstartdate", 5);
		ORDER.put("normal", 4);
		ORDER.put("cfclassschemeid", 3);
		ORDER.put("cfclassid", 2);
		ORDER.put("id", 1);
	}
	private static final Comparator<Entry<String, String>> COMPARATOR = new Comparator<Map.Entry<String, String>>() {

		private int index(String a) {
			Integer integer = ORDER.get(a);
			if (integer == null) {
				if (a.endsWith("id"))
					return 1;
				if (a.equals("cflangcode"))
					return 8;
				if (a.equals("cftrans"))
					return 8;
				return 4;
			}
			return integer;
		}

		public int compare(Entry<String, String> o1, Entry<String, String> o2) {
			String entry0 = o1.getKey(), entry1 = o2.getKey();
			int result = index(entry0) - index(entry1);
			if (result == 0)
				return entry0.compareTo(entry1);
			return result;
		}
	};

	public String toSQLFunction(Table table) {
		String table_name = table.getName();

		Set<Entry<String, String>> column2type = table.getColumns();
		@SuppressWarnings("unchecked")
		Map.Entry<String, String>[] columns = new Map.Entry[column2type.size()];
		column2type.toArray(columns);
		Arrays.sort(columns, COMPARATOR);

		Set<String> primarykeys = table.getPrimary();
		boolean isRelation = table_name.contains("_");

		/*
		 * Parameters of PL/pgsql script functions
		 */
		List<String> insert_column_clause = new ArrayList<String>();
		List<String> function_parameters = new ArrayList<String>();
		for (Entry<String, String> column : columns) {
			String parameter_name = column.getKey();
			if (isRelation) {
				if (!parameter_name.endsWith("_id") && !primarykeys.contains(parameter_name))
					continue;
			}
			insert_column_clause.add(parameter_name);
			if (isRelation) {
				if (parameter_name.equals("cfclassid")) {
					function_parameters.add("v_cfclassname text");
					continue;
				} else if (parameter_name.equals("cfclassschemeid")) {
					function_parameters.add("v_cfschemename text");
					continue;
				}
			}
			function_parameters.add("v_" + parameter_name + " " + column.getValue());
		}

		/*
		 * SELECT * FROM table_name WHERE where_clause
		 */
		String[] relations = isRelation ? table_name.substring(2).split("_") : null;
		Set<String> relation_set = null;
		if (relations != null) {
			relations[0] = "cf" + relations[0] + "id";
			relations[1] = "cf" + relations[1] + "id";
			relation_set = new HashSet<String>();
			relation_set.addAll(Arrays.asList(relations));
			relation_set.addAll(SPECIAL_IDS);
		}
		List<String> select_where_clause = new ArrayList<String>();
		for (String primary : primarykeys) {
			if (primary.endsWith("date"))
				continue;
			if (isRelation && !relation_set.contains(primary))
				continue;
			select_where_clause.add(primary + " = v_" + primary);
		}

		/*
		 * INSERT INTO table_name (sorted_columns) VALUES (value_clause)
		 */
		String[] insert_value_clause = new String[insert_column_clause.size()];
		int index = 0;
		for (String value : insert_column_clause) {
			insert_value_clause[index++] = "v_" + value;
		}

		/*
		 * UPDATE table_name SET set_clause WHERE where_clause
		 */
		List<String> update_set_clause = new ArrayList<String>();
		List<String> update_where_clause = new ArrayList<String>();
		if (isRelation) {
			update_where_clause = select_where_clause;
			for (String column : insert_column_clause) {
				update_set_clause.add(column + " = v_" + column);
			}
			update_set_clause.removeAll(update_where_clause);
		} else {
			for (String column : insert_column_clause) {
				if (primarykeys.contains(column)) {
					if (!column.endsWith("date"))
						update_where_clause.add(column + " = v_" + column);
					continue;
				}
				update_set_clause.add(column + " = v_" + column);
			}
		}
		if (function_parameters.isEmpty()) {
			Assert.assertFalse(table_name + " function parameter is empty", true);
		}
		if (select_where_clause.isEmpty()) {
			Assert.assertFalse(table_name + " select where clause is empty", true);
		}
		if (insert_column_clause.isEmpty()) {
			Assert.assertFalse(table_name + " insert column clause is empty", true);
		}
		if (insert_value_clause.length == 0) {
			Assert.assertFalse(table_name + " insert value clause is empty", true);
		}
		if (update_set_clause.isEmpty()) {
			Assert.assertFalse(table_name + " update set clause is empty", true);
		}
		if (update_where_clause.isEmpty()) {
			Assert.assertFalse(table_name + " update where clause is empty", true);
		}
		return String.format(isRelation ? FUNCTION_RELATION : FUNCTION, table_name,
				String.join(", ", function_parameters), String.join(" and ", select_where_clause),
				String.join(", ", insert_column_clause), String.join(", ", insert_value_clause),
				String.join(", ", update_set_clause), String.join(" and ", update_where_clause));
	}

}

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

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class DBColumnReader {

	private String url, username, password;

	public DBColumnReader(String url, String user, String pass) {
		this.url = url;
		this.username = user;
		this.password = pass;
	}

	private static final String GET_TABLE_COLUMN_NAME_TYPE = "select column_name, case "
			+ "when data_type='character' THEN 'char('||character_maximum_length||')' "
			+ "when data_type='character varying' THEN 'varchar('||character_maximum_length||')' "
			+ "when data_type='numeric' THEN 'numeric('||numeric_precision||','||numeric_scale||')' "
			+ "when data_type='timestamp without time zone' THEN 'timestamp' "
			+ "when data_type='double precision' THEN 'float8' "
			+ "else data_type end as myType from information_schema.columns where table_schema = 'public' AND table_name = '%1$s';";

	private static final String GET_TABLE_NAMES = "select table_name from information_schema.tables where table_schema='public';";
	private static final String GET_TABLE_PRIMARY_KEYS = "SELECT a.attname FROM  pg_index i JOIN  pg_attribute a ON a.attrelid = i.indrelid AND a.attnum = ANY(i.indkey) WHERE i.indrelid = '%1$s'::regclass AND i.indisprimary;";

	public List<Table> getDBColumns() {
		List<Table> tables = new ArrayList<Table>();
		Connection conn = getDBConnection();
		ResultSet rs = null;
		ResultSet result = null;
		try {
			rs = conn.createStatement().executeQuery(GET_TABLE_NAMES);
			while (rs.next()) {
				String table_name = rs.getString(1);
				Table table = new Table(table_name);
				result = conn.createStatement().executeQuery(String.format(GET_TABLE_COLUMN_NAME_TYPE, table_name));
				while (result.next()) {
					table.addColumn(result.getString(1), result.getString(2));
				}
				result = conn.createStatement().executeQuery(String.format(GET_TABLE_PRIMARY_KEYS, table_name));
				while (result.next()) {
					table.addPrimary(result.getString(1));
				}
				tables.add(table);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return tables;
	}

	private Connection getDBConnection() {
		Connection conn = null;
		try {
			Class.forName("org.postgresql.Driver");
			Properties props = new Properties();
			props.setProperty("user", username);
			props.setProperty("password", password);
			conn = DriverManager.getConnection(url, props);
			conn.setAutoCommit(false);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
}

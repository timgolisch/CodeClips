using System;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Data.OleDb;

/// <summary>
/// Manages the execution of SQL queries
/// </summary>
public class DbHelper
{
    static string ConnectionString = "Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Data Source=" + Enum_Code_Generator.Properties.Settings.Default.Server;

	public static int Execute(string sql, List<OleDbParameter> parameters)
	{
		return Execute(sql, parameters, CommandType.StoredProcedure);
	}

	public static int Execute(string sql, List<OleDbParameter> parameters, CommandType commandType)
	{
		int rows = 0;

		using (OleDbConnection conn = new OleDbConnection(ConnectionString))
		{
			OleDbCommand cmd = new OleDbCommand(sql, conn);
			cmd.CommandType = commandType;

			if (parameters != null)
			{
				foreach (OleDbParameter entry in parameters)
				{
					cmd.Parameters.Add(entry);
				}
			}

			conn.Open();
			rows = cmd.ExecuteNonQuery();
		}

		return rows;
	}

	public static OleDbDataReader ExecuteReader(string sql, List<OleDbParameter> parameters)
	{
		return ExecuteReader(sql, parameters, CommandType.StoredProcedure);
	}

	public static OleDbDataReader ExecuteReader(string sql, List<OleDbParameter> parameters, CommandType commandType)
	{
		OleDbConnection conn = new OleDbConnection(ConnectionString);
		OleDbCommand cmd = new OleDbCommand(sql, conn);
		cmd.CommandType = commandType;

		if (parameters != null)
		{
			foreach (OleDbParameter entry in parameters)
			{
				cmd.Parameters.Add(entry);
			}
		}

		conn.Open();
		return cmd.ExecuteReader(CommandBehavior.CloseConnection);
	}

	public static DataTable ExecuteTable(string sql)
	{
		return ExecuteTable(sql, null, CommandType.StoredProcedure);
	}

	public static DataTable ExecuteTable(string sql, List<OleDbParameter> parameters)
	{
		return ExecuteTable(sql, parameters, CommandType.StoredProcedure);
	}

	public static DataTable ExecuteTable(string sql, List<OleDbParameter> parameters, CommandType commandType)
	{
		OleDbConnection conn = new OleDbConnection(ConnectionString);
		OleDbCommand cmd = new OleDbCommand(sql, conn);
		cmd.CommandType = commandType;
        OleDbDataAdapter da = new OleDbDataAdapter(cmd);
        DataTable dtOut = new DataTable();

		if (parameters != null)
		{
			foreach (OleDbParameter entry in parameters)
			{
				cmd.Parameters.Add(entry);
			}
		}

		conn.Open();
        da.Fill(dtOut);
        conn.Close();

        return dtOut;
	}

	public static object ExecuteScalar(string sql, List<OleDbParameter> parameters)
	{
		return ExecuteScalar(sql, parameters, CommandType.StoredProcedure);
	}

	public static object ExecuteScalar(string sql, List<OleDbParameter> parameters, CommandType commandType)
	{
		object ret = null;

		using (OleDbConnection conn = new OleDbConnection(ConnectionString))
		{
			OleDbCommand cmd = new OleDbCommand(sql, conn);
			cmd.CommandType = commandType;

			if (parameters != null)
			{
				foreach (OleDbParameter entry in parameters)
				{
					cmd.Parameters.Add(entry);
				}
			}

			conn.Open();
			ret = cmd.ExecuteScalar();
		}

		return ret;
	}

    public static DataSet ExecuteDataSet(string spName)
    {
        //setup the DB
        OleDbConnection cn = new OleDbConnection(ConnectionString);
        cn.Open();
        OleDbCommand cmd = cn.CreateCommand();
        cmd.CommandText = spName;
        cmd.CommandType = CommandType.StoredProcedure;
        DataSet ds = new DataSet();
        OleDbDataAdapter da = new OleDbDataAdapter(cmd);
        da.Fill(ds);

        return ds;
    }
}

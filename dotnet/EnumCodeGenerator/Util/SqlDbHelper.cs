using System;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

/// <summary>
/// Manages the execution of SQL queries
/// </summary>
public class DbHelper : IDisposable
{
    //public static variables (to simulate a const, pulled from the .config file)
    static string ConnectionString = "Integrated Security=SSPI;Persist Security Info=False;Data Source=" + EnumCodeGenerator.Properties.Settings.Default.Server;

    //private instance variables
    private SqlConnection _conn;
    private SqlTransaction _tran;

    #region Public Instance Functions (for use with Transactions, etc)
    #region Constructor/Destructor
    //Constructor.  Open the data connection.
    public DbHelper()
    {
        CreateConn();
    }

    //Destructor.  Close the connection, clean up resources
    ~DbHelper()
    {
        this.Dispose();
    }

    public void Dispose()
    {
        if (_tran != null)
        {
            //This next line of code does an auto-rollback.  Here is the rationale for that instead of an auto-commit
            //If you take a look at the Commit() function, you will see that it sets the _tran object to null after committing.
            //Any programmer who would use DbHelper with a transaction, will surely have a BeginTran call and a matching Commit call.
            //Therefore, if Dispose is exec'd and _tran isn't null, then a transaction was started and never committed.  This implies 
            //that an error probably occurred and this is running as part of garbage collection, etc.  In which case, it is WAY safer 
            //to rollback instead of feeling optimistic and auto-committing.  
            //Hence the next line is a RollbackTran instead of CommitTran.
            RollbackTran();
            _tran = null;
        }         
        if (_conn != null)
        {
            //if the connection is still open.  then close it
            try 
            {
                if (_conn.State != ConnectionState.Closed && _conn.State != ConnectionState.Broken) _conn.Close();
            } 
            catch (Exception ex)
            { 
                System.Diagnostics.Debug.Write("DbHelper: Error in Dispose while closing db conn. State was:" + _conn.State.ToString() + "\n" + ex.Message);
                //ignore any other errors that might happen here
            } 
            _conn.Dispose();
            _conn = null;
        }        
    }
    #endregion

    public int ExecuteWithTran(string sql, List<SqlParameter> parameters, CommandType commandType)
    {
        int rows = 0;

        SqlCommand cmd = new SqlCommand(sql, _conn);
        cmd.CommandType = commandType;
        //join the transaction if needed
        if (_tran != null) cmd.Transaction = _tran;

        if (parameters != null)
        {
            foreach (SqlParameter entry in parameters)
            {
                cmd.Parameters.Add(entry);
            }
        }

        rows = cmd.ExecuteNonQuery();
        cmd.Dispose();

        return rows;
    }

    public object ExecuteScalarWithTran(string sql, List<SqlParameter> parameters, CommandType commandType)
    {
        object ret = null;

        SqlCommand cmd = new SqlCommand(sql, _conn);
        cmd.CommandType = commandType;
        //join the transaction if needed
        if (_tran != null) cmd.Transaction = _tran;

        if (parameters != null)
        {
            foreach (SqlParameter entry in parameters)
            {
                cmd.Parameters.Add(entry);
                //cmd.Parameters.AddWithValue(entry.ParameterName, entry.Value);
            }
        }

        ret = cmd.ExecuteScalar();
        cmd.Dispose();

        return ret;
    }

    #region Transactions
    public void BeginTran()
    {
        _tran = _conn.BeginTransaction();
    }
    public void CommitTran()
    {
        _tran.Commit();
        _tran.Dispose();
        _tran = null;
    }
    public void RollbackTran()
    {
        _tran.Rollback();
        _tran.Dispose();
        _tran = null;
    }
    #endregion
    #endregion

    #region Public Instance Functions (for use with Transactions, etc)
    private void CreateConn()
    {
        if (_conn == null)
        {
            _conn = new SqlConnection(ConnectionString);
            _conn.Open();
        }
    }
    #endregion

    #region Public Static Functions
    public static int Execute(string sql, List<SqlParameter> parameters)
    {
        return Execute(sql, parameters, CommandType.StoredProcedure);
    }

    public static int Execute(string sql, List<SqlParameter> parameters, CommandType commandType)
    {
        int rows = 0;

        using (SqlConnection conn = new SqlConnection(ConnectionString))
        {
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = commandType;

            if (parameters != null)
            {
                foreach (SqlParameter entry in parameters)
                {
                    cmd.Parameters.Add(entry);
                }
            }

            conn.Open();
            rows = cmd.ExecuteNonQuery();
        }

        return rows;
    }

    public static SqlDataReader ExecuteReader(string sql, List<SqlParameter> parameters)
    {
        return ExecuteReader(sql, parameters, CommandType.StoredProcedure);
    }

    public static SqlDataReader ExecuteReader(string sql, List<SqlParameter> parameters, CommandType commandType)
    {
        SqlConnection conn = new SqlConnection(ConnectionString);
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = commandType;

        if (parameters != null)
        {
            foreach (SqlParameter entry in parameters)
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

    public static DataTable ExecuteQuery(string sql)
    {
        return ExecuteTable(sql, null, CommandType.Text);
    }

    public static DataTable ExecuteTable(string sql, List<SqlParameter> parameters)
    {
        return ExecuteTable(sql, parameters, CommandType.StoredProcedure);
    }

    public static DataTable ExecuteTable(string sql, List<SqlParameter> parameters, CommandType commandType)
    {

        SqlConnection conn = new SqlConnection(ConnectionString);
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = commandType;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dtOut = new DataTable();

        if (parameters != null)
        {
            foreach (SqlParameter entry in parameters)
            {
                cmd.Parameters.Add(entry);
            }
        }

        conn.Open();
        da.Fill(dtOut);
        conn.Close();

        return dtOut;
    }

    public static object ExecuteScalar(string sql, List<SqlParameter> parameters)
    {
        return ExecuteScalar(sql, parameters, CommandType.StoredProcedure);
    }

    public static object ExecuteScalar(string sql, List<SqlParameter> parameters, CommandType commandType)
    {
        object ret = null;

        using (SqlConnection conn = new SqlConnection(ConnectionString))
        {
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = commandType;

            if (parameters != null)
            {
                foreach (SqlParameter entry in parameters)
                {
                    if (entry.Value == null) entry.Value = DBNull.Value;
                    cmd.Parameters.AddWithValue(entry.ParameterName, entry.Value);
                    
                    // Corey Lasley -- Added the following for inserting of GeoSpatial Data
                    if (entry.UdtTypeName != "")
                    {
                        cmd.Parameters[cmd.Parameters.Count - 1].UdtTypeName = entry.UdtTypeName;
                    }
                }
            }

            conn.Open();
            ret = cmd.ExecuteScalar();
        }

        return ret;
    }


    public static object ExecuteScalar(SqlCommand cmd)
    {
        object ret = null;

        using (SqlConnection conn = new SqlConnection(ConnectionString))
        {
            conn.Open();
            cmd.Connection = conn;
            ret = cmd.ExecuteScalar();
        }

        return ret;
    }

    public static DataSet ExecuteDataSet(string spName)
    {
        //setup the DB
        SqlConnection cn = new SqlConnection(ConnectionString);
        cn.Open();
        SqlCommand cmd = cn.CreateCommand();
        cmd.CommandText = spName;
        cmd.CommandType = CommandType.StoredProcedure;
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(ds);

        return ds;
    }

    public static DataSet ExecuteDataSet(string spName, List<SqlParameter> parameters)
    {
        //setup the DB
        SqlConnection cn = new SqlConnection(ConnectionString);
        cn.Open();
        SqlCommand cmd = cn.CreateCommand();
        cmd.CommandText = spName;
        cmd.CommandType = CommandType.StoredProcedure;

        if (parameters != null)
        {
            foreach (SqlParameter entry in parameters)
            {
                cmd.Parameters.AddWithValue(entry.ParameterName, entry.Value);
            }
        }

        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(ds);

        return ds;
    }

    /// <summary>
    /// Translates a parameterized query into a standard (plain-text) SQL query.
    /// </summary>
    /// <param name="sql">A parameterized SQL query string.</param>
    /// <param name="parameters">A (generic) list of SqlParameter objects</param>
    /// <returns>a plain-text SQL string</returns>
    public static string ToSQLText(string sql, List<SqlParameter> parameters)
    {
        string strText = sql;

        foreach (SqlParameter param in parameters)
        {
            try
            {
                //don't attempt to convert NULL values
                if (param.SqlValue != DBNull.Value && param.SqlValue != null && param.Value != DBNull.Value && param.Value != null)
                {
                    strText = strText.Replace(param.ParameterName, ParameterToText(param.Value.ToString(), param.DbType));
                }
                else
                {
                    strText = strText.Replace(param.ParameterName, "NULL");
                }
            }
            catch
            {
                // Swallow the error because this is used to help in logging details of a 
                // db error, so we dont really care about an error here. An error here
                // should never happen anyway!
            }
        }

        return strText;
    }

    /// <summary>
    /// This function will delimit a value with quotes if it is appropriate.  It is called by the ToSQLText() function.
    /// </summary>
    /// <param name="paramValue">The value of a SQL parameter</param>
    /// <param name="type">The DbType of the value</param>
    /// <returns>a SQL formatted/delimited string</returns>
    private static string ParameterToText(string paramValue, DbType type)
    {
        switch (type)
        {
            case DbType.AnsiString:
            case DbType.AnsiStringFixedLength: 
            case DbType.Binary: 
            case DbType.Date: 
            case DbType.DateTime: 
            case DbType.DateTime2: 
            case DbType.DateTimeOffset: 
            case DbType.Guid: 
            case DbType.Object: 
            case DbType.String: 
            case DbType.StringFixedLength: 
            case DbType.Time: 
            case DbType.Xml: 
                paramValue = "'" + paramValue + "'";
                break;
        }
        return paramValue;
    }

    #endregion
}

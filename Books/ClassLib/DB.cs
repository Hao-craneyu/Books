using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace NIUKits
{
     public class DBCon
     {
          public (bool results, string Msg) Query(SqlCommand SqlCmd)
          {
               String connStr = WebConfigurationManager.ConnectionStrings["Books"].ConnectionString;

               using (SqlConnection conn = new SqlConnection(connStr))
               {
                    try
                    {
                         conn.Open();
                         SqlCmd.Connection = conn;
                         SqlCmd.ExecuteNonQuery();
                         return (true, string.Empty);
                    }
                    catch (Exception ex)
                    {
                         return (false, ex.Message);
                         throw;
                    }
               }
          }

          public (bool result, DataTable DT, string Msg) Select(SqlCommand SQLCmd)
          {
               SqlDataAdapter DataAdapter = new SqlDataAdapter();
               DataTable Dt = new DataTable();

               string connStr = WebConfigurationManager.ConnectionStrings["Books"].ConnectionString;

               using (SqlConnection conn = new SqlConnection(connStr))
               {
                    try
                    {
                         SQLCmd.Connection = conn;
                         DataAdapter.SelectCommand = SQLCmd;
                         conn.Open();
                         DataAdapter.Fill(Dt);
                         return (true, Dt, string.Empty);
                    }
                    catch (Exception ex)
                    {
                         return (false, Dt, ex.Message);
                         throw;
                    }
               }
          }


     }
}
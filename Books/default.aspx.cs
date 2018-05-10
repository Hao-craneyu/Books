using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NIUKits;
using System.Data.SqlClient;
using System.Data;

namespace Books
{
     public partial class _default : System.Web.UI.Page
     {
        private DBCon db = new DBCon();

        protected void Page_Load(object sender, EventArgs e)
        {
            RD_List();
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            Hid_EditMode.Value = "New";
        }

        #region Read DataList

        private void RD_List()
        {
            if (string.IsNullOrEmpty(txt_bookNM.Value.Trim()))
            {
                SqlData.SelectCommand = @"SELECT * FROM [Books]";
            }
            else
            {
                SqlData.SelectParameters.Clear();
                SqlData.SelectCommand = @"SELECT * FROM [Books] where BookTitle like @title";
                SqlData.SelectParameters.Add("title", "%" + txt_bookNM.Value.Trim() + "%" );
            }

        }

        #endregion

        #region Save

        protected void But_Save_Click(object sender, EventArgs e)
        {
            SqlCommand Cmd = new SqlCommand();

            if (Hid_EditMode.Value == "New")
            {
                try
                {
                    Cmd.CommandText = @"Insert into Books (BookTitle, ISBN, Arthur, Publicher, PublichYear, Price) values
                                        (@title, @isbn, @arthur, @publicher, @year, @price)";

                    //Cmd.Parameters.AddWithValue("title", txt_Booktitle.Value);
                    Cmd.Parameters.AddWithValue("isbn", txt_isbn.Value);
                    Cmd.Parameters.AddWithValue("arthur", txt_Arthur.Value);
                    Cmd.Parameters.AddWithValue("publicher", txt_Publisher.Value);
                    //Cmd.Parameters.AddWithValue("year", txt_Year.Value);
                    //Cmd.Parameters.AddWithValue("price", txt_Price.Value);

                    Cmd.Parameters.Add("title", SqlDbType.NVarChar);
                    Cmd.Parameters["title"].Value = txt_Booktitle.Value;

                    Cmd.Parameters.Add("year", SqlDbType.VarChar, 4);
                    Cmd.Parameters["year"].Value = txt_Year.Value;

                    Cmd.Parameters.Add("price", SqlDbType.Decimal, 5).Value = txt_Price.Value;

                    var (results, Msg) = db.Query(Cmd);

                    if (results)
                    {
                        Response.Redirect("default.aspx");
                    }
                    else
                    {
                        Lab_Msg.Text = Msg;
                    }
                }
                catch (Exception ex)
                {
                    Lab_Msg.Text = ex.Message;
                    throw;
                }

            }
            else if (Hid_EditMode.Value == "Modify")
            {
                try
                {
                    Cmd.CommandText = @"Update Books set BookTitle = @title, ISBN = @isbn, Arthur = @arthur, 
                                        Publicher = @publicher, PublichYear =  @year, Price = @price where No = @no";

                    Cmd.Parameters.AddWithValue("isbn", txt_isbn.Value);
                    Cmd.Parameters.AddWithValue("arthur", txt_Arthur.Value);
                    Cmd.Parameters.AddWithValue("publicher", txt_Publisher.Value);

                    Cmd.Parameters.Add("title", SqlDbType.NVarChar);
                    Cmd.Parameters["title"].Value = txt_Booktitle.Value;

                    Cmd.Parameters.Add("year", SqlDbType.VarChar, 4);
                    Cmd.Parameters["year"].Value = txt_Year.Value;

                    Cmd.Parameters.Add("price", SqlDbType.Decimal, 5).Value = txt_Price.Value;
                    Cmd.Parameters.AddWithValue("no", Hid_ModifyNo.Value);

                    var (results, Msg) = db.Query(Cmd);

                    if (results)
                    {
                        Response.Redirect("default.aspx");
                    }
                    else
                    {
                        Lab_Msg.Text = Msg;
                    }
                }
                catch (Exception ex)
                {
                    Lab_Msg.Text = ex.Message;
                    throw;
                }

            }

        }

        #endregion

        #region GridView RowCommand

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GridView1.Rows[rowIndex];
            SqlCommand Cmd = new SqlCommand();

            switch (e.CommandName)
            {
                case "modify":

                    Hid_EditMode.Value = "Modify";
                    Hid_ModifyNo.Value = ((HiddenField)row.FindControl("Hid_No")).Value;
                    txt_Booktitle.Value = row.Cells[1].Text;
                    txt_isbn.Value = row.Cells[2].Text;
                    txt_Arthur.Value = row.Cells[3].Text;
                    txt_Publisher.Value = row.Cells[4].Text;
                    txt_Year.Value = row.Cells[5].Text;
                    txt_Price.Value = row.Cells[6].Text;


                    break;
                case "Delete":

                    //string no = (row.FindControl("Hid_No") as HiddenField).Value;
                    string no = ((HiddenField)row.FindControl("Hid_No")).Value;

                    Cmd.CommandText = @"Delete from Books where NO = @no";
                    //Cmd.Parameters.AddWithValue("no", row.Cells[0].Text);
                    Cmd.Parameters.AddWithValue("no", no);

                    var (results, Msg) = db.Query(Cmd);

                    if (results)
                    {
                        Response.Redirect("default.aspx");
                    }
                    else
                    {
                        Lab_Msg.Text = Msg;

                    }

                    break;
                default:
                    break;
            }
        }

        #endregion

        protected void But_Search_Click(object sender, EventArgs e)
        {
            RD_List();
        }
    }
}
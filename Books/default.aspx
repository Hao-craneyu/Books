<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Books._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-top:20px;">

            編輯欄位<br />
            <br />
            書名：<input id="txt_Booktitle" runat="server" type="text" /><br />
            ISBN：<input id="txt_isbn" runat="server" type="text" /><br />
            作者：<input id="txt_Arthur" runat="server" type="text" /><br />
            出版社：<input id="txt_Publisher" runat="server" type="text" /><br />
            出版年度：<input id="txt_Year" runat="server" type="text" /><br />
            售價：<input id="txt_Price" runat="server" type="text" /><br />
            <asp:Button ID="But_Save" runat="server" Text="儲存" OnClick="But_Save_Click" />
            <asp:HiddenField runat="server" ID="Hid_EditMode" />
            <asp:HiddenField runat="server" ID="Hid_ModifyNo" />

        </div>
        <div id="msg">
            <asp:Label id="Lab_Msg" runat="server" />
        </div>

        <div id="search" style="margin-top:20px;">
            以書名進行查尋：
            <input type="text" id="txt_bookNM" value="" runat="server" />
            <asp:Button Text="查尋" runat="server" ID="But_Search" OnClick="But_Search_Click" />
        </div>
        <div style="margin-top:40px">
             <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="NO" DataSourceID="SqlData" OnRowCommand="GridView1_RowCommand">
                  <Columns>
                       <asp:BoundField DataField="NO" HeaderText="NO" InsertVisible="False" ReadOnly="True" 
                           SortExpression="NO" Visible="false"/>
                       <asp:BoundField DataField="BookTitle" HeaderText="BookTitle" SortExpression="BookTitle" />
                       <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
                       <asp:BoundField DataField="Arthur" HeaderText="Arthur" SortExpression="Arthur" />
                       <asp:BoundField DataField="Publicher" HeaderText="Publicher" SortExpression="Publicher" />
                       <asp:BoundField DataField="PublichYear" HeaderText="PublichYear" SortExpression="PublichYear" />
                       <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                      <asp:TemplateField HeaderText="管理">
                          <ItemTemplate>
                              <asp:HiddenField  runat="server" ID="Hid_No" Value='<%# Eval("NO") %>' />
                              <asp:Button ID="Button1" runat="server" CommandName="modify" Text="編輯" CommandArgument='<%# Container.DataItemIndex %>' />
                              <asp:Button ID="Button2" runat="server" CommandName="Delete" Text="刪除" CommandArgument='<%# Container.DataItemIndex %>' />

                          </ItemTemplate>
                      </asp:TemplateField>
                  </Columns>
             </asp:GridView>
             <asp:SqlDataSource ID="SqlData" runat="server" ConnectionString="<%$ ConnectionStrings:Books %>" ></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>

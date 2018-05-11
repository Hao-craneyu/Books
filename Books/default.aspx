<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Books._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>Title Page</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<!--[if lt IE 9]>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script></head>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
<body>
    <form id="form1" name="myForm" runat="server" ng-controller="validateCtrl">
        <div class="container" style="margin-top:20px;">
            <div class="row">
                <div class="col-sm-12">
                    <h1 class="text-center">以 SqlCommand 進行操作</h1>
                    編輯欄位<br />
                    <br />
                    <div class="form-group form-inline">
                        <label class="control-label">書名：</label>
                        <input id="txt_Booktitle" name="txt_Booktitle" runat="server" type="text" 
                            class="form-control" placeholder="請填寫書名" ng-model="BookName" required />
                    </div>
                    <div class="form-group form-inline">
                        <label class="control-label">ISBN：</label>
                        <input id="txt_isbn" runat="server" type="text" class="form-control" />
                    </div>
                    <div class="form-group form-inline">
                        <label class="control-label">作者：</label>
                        <input id="txt_Arthur" runat="server" type="text" class="form-control" />
                    </div>
                    <div class="form-group form-inline">
                        <label class="control-label">出版社：</label>
                        <input id="txt_Publisher" runat="server" type="text" class="form-control" />
                    </div>
                    <div class="form-group form-inline">
                        <label class="control-label">出版年度：</label>
                        <input id="txt_Year" runat="server" type="text" class="form-control" />
                    </div>
                    <div class="form-group form-inline">
                        <label class="control-label">售價：</label>
                        <input id="txt_Price" runat="server" type="text" class="form-control" />
                    </div>
                    <asp:Button ID="But_Save" runat="server" Text="儲存" OnClick="But_Save_Click"
                        CssClass="btn btn-primary" />
                    <asp:HiddenField runat="server" ID="Hid_EditMode" />
                    <asp:HiddenField runat="server" ID="Hid_ModifyNo" />
                </div>
                <div class="col-sm-12">

                    <div id="msg">
                        <asp:Label id="Lab_Msg" runat="server" ForeColor="red" />
                    </div>

                    <div id="search" style="margin-top:20px;">
                        以書名進行查尋：
                        <input type="text" id="txt_bookNM" value="" runat="server" />
                        <asp:Button Text="查尋" runat="server" ID="But_Search" OnClick="But_Search_Click"
                            CssClass="btn btn-primary" />
                    </div>
                    <div style="margin-top:40px">
                         <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="NO" OnRowCommand="GridView1_RowCommand">
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
                </div>
            </div>
        </div>
    </form>
</body>
</html>

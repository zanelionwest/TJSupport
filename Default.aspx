<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="TJSupport._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Welcome to TJ Books Support</h1>
        <p class="lead"></p>
        <a href="~\LogTicket.aspx" class="btn btn-primary btn-lg">Log Support Ticket</a>
    </div>

    <div class="row">
        <div class="col-md-4">
            <asp:Panel ID="pnlSupportTickets" runat="server">
                <asp:Repeater ID="rptSupport" runat="server">
                    <ItemTemplate>
                        <div class="flx-line flx-auto rpt-row">

                            <asp:Panel ID="pnlSupportId" CssClass="flx-item" runat="server"
                                data-col="1" data-item="ID">
                                <asp:Label ID="lblSupportID" CssClass="lbl" runat="server" AssociatedControlID="txtSupportId" Text="Ticket Number" /> 
                                <asp:TextBox ID="txtSupportId" CssClass="flx-auto" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ID") %>' Enabled="false" />
                            </asp:Panel>

                            <asp:Panel ID="pnlSupportTitle" CssClass="flx-item" runat="server" data-col="2" data-item="Title" >
                                <asp:Label ID="lblSupportTitle" CssClass="lbl" runat="server" AssociatedControlID="txtSupportTitle" Text="Title" />
                                <asp:TextBox ID="txtSupportTitle" CssClass="flx-auto" runat="server" Text=<%# DataBinder.Eval(Container.DataItem, "Title") %> type="text" MaxLength="100" Enabled="false" />
                            </asp:Panel>

                            <asp:Panel ID="pnlSupportRequest"





                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </asp:Panel>

        </div>
    </div>

</asp:Content>

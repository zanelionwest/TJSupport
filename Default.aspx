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

                            <asp:Panel ID="pnlSupportOpen" CssClass="flx-auto" runat="server">
                                <asp:HyperLink ID="hypSupport" runat="server" NavigateUrl='<%# "~/SupportTicket.aspx/Support?ID= " & CType(DataBinder.Eval(Container.DataItem, "ID"), String) %>'>
                                       <svg class="icon icn-translate"><use href="icn-open"></svg>
                                </asp:HyperLink>
                                <asp:HiddenField ID="hidSupportID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' />
                            </asp:Panel>

                            <asp:Panel ID="pnlSupportId" CssClass="flx-item" runat="server"
                                data-col="1" data-item="ID">
                                <asp:Label ID="lblSupportID" CssClass="lbl" runat="server" AssociatedControlID="txtSupportId" Text="Ticket Number" />
                                <asp:TextBox ID="txtSupportId" CssClass="flx-auto" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ID") %>' Enabled="false" />
                            </asp:Panel>

                            <asp:Panel ID="pnlSupportTitle" CssClass="flx-item" runat="server" data-col="2" data-item="Title">
                                <asp:Label ID="lblSupportTitle" CssClass="lbl" runat="server" AssociatedControlID="txtSupportTitle" Text="Title" />
                                <asp:TextBox ID="txtSupportTitle" CssClass="flx-auto" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Title") %>' type="text" MaxLength="100" Enabled="false" />
                            </asp:Panel>

                            <asp:Panel ID="pnlSupportRequest" CssClass="flx-item" runat="server" data-col="3" data-item="SupportRequest">
                                <asp:Label ID="lblSupportRequest" CssClass="lbl" runat="server" AssociatedControlID="txtSupportRequest" Text="SupportRequest" />
                                <asp:TextBox ID="txtSupportRequest" CssClass="flx-auto" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SupportRequest") %>' type="text" MaxLength="200" Enabled="false" />
                            </asp:Panel>

                            <asp:Panel ID="pnlSupportDate" CssClass="flx-item" runat="server" data-col="3" data-item="SupportDate">
                                <asp:Label ID="lblSupportDate" CssClass="lbl" runat="server" AssociatedControlID="txtSupportDate" Text="Date Logged" />
                                <asp:TextBox ID="txtSupportDate" CssClass="flx-auto" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DateLogged") %>' type="date" Enabled="false" />
                            </asp:Panel>


                            <asp:Panel ID="pnlSupportStatus" CssClass="flx-item" runat="server" data-col="4" data-item="SupportStatus">
                                <asp:Label ID="lblSupportStatus" CssClass="lbl" runat="server" AssociatedControlID="txtSupportStatus" Text="Support Status" />
                                <asp:TextBox ID="txtSupportStatus" CssClass="flx-auto" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Status") %>' type="date" Enabled="false" />
                            </asp:Panel>

                            <asp:Panel ID="pnlSupportClosed" CssClass="flx-item" runat="server" data-col="5" data-item="Closed">
                                <asp:Label ID="lblSupportClosed" CssClass="lbl" runat="server" AssociatedControlID="cbSupportClosed" Text="Open" />
                                <asp:CheckBox ID="cbSupportClosed" runat="server" Checked='<%# DataBinder.Eval(Container.DataItem, "Closed") %>' OnCheckedChanged="Update_Data" AutoPostBack="true" />
                                <asp:Label AssociatedControlID="cbSupportClosed" runat="server">
                                    <svg class="icon"><use href="#icn-tick"></svg>
                                </asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="pnlSupportInvestigator" CssClass="flx-item" runat="server" data-col="6" data-item="Investigator">
                                <asp:Label ID="lblSupportInvestigator" CssClass="lbl" runat="server" AssociatedControlID="txtSupportInvestigator" Text="Investigator" />
                                <asp:TextBox ID="txtSupportInvestigator" CssClass="flx-auto" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Status") %>' type="date" Enabled="false" />
                            </asp:Panel>





                            <%--                            <asp:Panel ID="pnlSupportStatus" CssClass="flx-item" runat="server" data-col="4" data-item="SupportStatus" >
                                <asp:Label ID="lblSupportStatus" CssClass="lbl" runat="server" AssociatedControlID="ddlSupportStatus" Text="Support Status" />
                                <asp:DropDownList ID="ddlSupportStatus" runat="server" DataValueField="Status" DataTextField="Status" type="text" />
                            </asp:Panel>

                            <asp:Panel ID="pnlSupportClosed" CssClass="flx-item" runat="server" data-col="5" data-item="Closed" >
                                <asp:Label ID="lblSupportClosed" CssClass="lbl" runat="server" AssociatedControlID="ddlSupportClosed" Text="Open" />
                                <asp:DropDownList ID="ddlSupportClosed" runat="server" DataValueField="ID" DataTextField="SupportClosed" type="text" />
                            </asp:Panel>

                            <asp:Panel ID="pnlSupportInvestigator" CssClass="flx-item" runat="server" data-col="6" data-item="Investigator" >
                                <asp:Label ID="lblSupportInvestigator" CssClass="lbl" runat="server" AssociatedControlID="txtSupportInvestigator" Text="Investigator" />
                                <asp:DropDownList ID="ddlSupportInvestigator" CssClass="flx-auto" runat="server" DataValueField="ID" DataTextField="SupportInvestigator" type="text" />
                            </asp:Panel>
                            --%>

                            <asp:Panel ID="pnlSupportLoggedBy" CssClass="flx-item" runat="server" data-col="7" data-item="LoggedBy">
                                <asp:Label ID="lblSupportLoggedBy" CssClass="lbl" runat="server" AssociatedControlID="txtSupportLoggedBy" Text="Logged By" />
                                <asp:TextBox ID="txtSupportLoggedBy" CssClass="flx-auto" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "LoggedBy") %>' type="text" Enabled="false" />
                            </asp:Panel>

                            <asp:Panel ID="pnlSupportNotes" CssClass="flx-item" runat="server" data-col="8" data-item="Notes">
                                <asp:Label ID="lblSupportNotes" CssClass="lbl" runat="server" AssociatedControlID="txtSupportNotes" Text="Notes" />
                                <asp:TextBox ID="txtSupportNotes" CssClass="flx-auto" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Notes") %>' type="text" Enabled="false" />
                            </asp:Panel>


                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </asp:Panel>

        </div>
    </div>

</asp:Content>

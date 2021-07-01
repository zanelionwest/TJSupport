Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports TJSupport.SharedMethods


Public Class _Default
    Inherits Page

    Dim lstParamsSupport As List(Of String)
    Dim lstParamsStatus As List(Of String)
    Dim lstParamsClosed As List(Of String)
    Dim lstParamsInvestigator As List(Of String)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        'set lstparams
        lstParamsStatus = New List(Of String) From {
            0
        }

        lstParamsClosed = New List(Of String) From {
            0
        }
        lstParamsInvestigator = New List(Of String) From {
            0
        }

        If Not IsPostBack Then
            BindData()
            'Exec_SP("spSupportStatus", lstParamsStatus, "", ddlSupportStatus)
            'Exec_SP("spSupportClosed", lstParamsClosed, "", ddlSupportClosed)
            Exec_SP("spSupport", lstParamsSupport, "", rptSupport)
        End If


    End Sub

    Private Sub rptSupport_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles rptSupport.ItemDataBound

        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then

            Dim ddlSupportStatus As DropDownList = e.Item.FindControl("ddlSupportStatus")
            Dim ddlSupportClosed As DropDownList = e.Item.FindControl("ddlSupportClosed")

            Exec_SP("spSupportStatus", lstParamsStatus, "", ddlSupportStatus)
            ddlSupportStatus.SelectedValue = e.Item.DataItem("SupportStatus")
            Exec_SP("spSupportClosed", lstParamsClosed, "", ddlSupportClosed)
            ddlSupportClosed.SelectedValue = e.Item.DataItem("SupportClosed")

        End If

    End Sub

    Protected Sub Update_Data(sender As Object, e As EventArgs)

        Dim rptItem As RepeaterItem = sender.NamingContainer
        Dim rptIndex As Integer = rptItem.ItemIndex
        Dim rpt As Repeater = rptItem.Parent
        Dim intErrCount As Integer
        Dim strErrMsg_OUT As String = ""
        Dim hidSupportID As HiddenField = DirectCast(rpt.Items(rptIndex).FindControl("hidSupportID"), HiddenField)
        Dim txtSupportID As TextBox = DirectCast(rpt.Items(rptIndex).FindControl("txtSupportID"), TextBox)
        Dim txtSupportTitle As TextBox = DirectCast(rpt.Items(rptIndex).FindControl("txtSupportTitle"), TextBox)
        Dim txtSupportRequest As TextBox = DirectCast(rpt.Items(rptIndex).FindControl("txtSupportRequest"), TextBox)
        Dim txtSupportDate As TextBox = DirectCast(rpt.Items(rptIndex).FindControl("txtSupportDate"), TextBox)
        Dim txtSupportStatus As TextBox = DirectCast(rpt.Items(rptIndex).FindControl("txtSupportStatus"), TextBox)
        Dim cbSupportClosed As CheckBox = DirectCast(rpt.Items(rptIndex).FindControl("cbSupportClosed"), CheckBox)
        Dim txtSupportInvestigator As TextBox = DirectCast(rpt.Items(rptIndex).FindControl("txtSupportInvestigator"), TextBox)
        Dim txtSupportLoggedBy As TextBox = DirectCast(rpt.Items(rptIndex).FindControl("txtSupportLoggedBy"), TextBox)
        Dim txtSupportNotes As TextBox = DirectCast(rpt.Items(rptIndex).FindControl("txtSupportNotes"), TextBox)

        ValidateObj(txtSupportTitle, intErrCount)

        If intErrCount = 0 Then
            'Update Support Ticket
            Using con As New SqlConnection(ConfigurationManager.ConnectionStrings("Con").ConnectionString)
                Using cmd As New SqlCommand("spSupport", con) With {.CommandType = CommandType.StoredProcedure}






                End Using
            End Using
        End If



    End Sub



End Class
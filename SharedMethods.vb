Imports System
Imports System.Collections.Generic
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.IO
Imports System.Linq
Imports System.Security.Cryptography
Imports System.Web.UI.WebControls

Public Class SharedMethods

    Public Shared Sub Exec_SP(strSP As String, params As List(Of String), Optional ByRef strMsg_OUT As String = "", Optional obj As Object = Nothing, Optional sortExp As String = "", Optional sortDir As String = "")
        Dim dt As New DataTable()

        'Obtain sql parameter for Stored Procedure
        Using con As New SqlConnection(ConfigurationManager.ConnectionStrings("CON").ConnectionString)
            Using cmd As New SqlCommand("__spSqlCommand", con) With {.CommandType = CommandType.StoredProcedure}

                cmd.Parameters.Add("@StoredProcedureName", SqlDbType.NVarChar, 100).Value = strSP

                'Outputs
                Dim strErrMsg_OUT As New SqlParameter("@ErrMsg_OUT", SqlDbType.NVarChar, 100) With {.Direction = ParameterDirection.Output}
                cmd.Parameters.Add(strErrMsg_OUT).Value = ""

                Using sda As New SqlDataAdapter(cmd)
                    sda.Fill(dt)
                End Using

            End Using

            'Build sql parameter collection list
            Using cmd As New SqlCommand(strSP, con) With {.CommandType = CommandType.StoredProcedure}
                For Each r As DataRow In dt.Rows
                    If String.IsNullOrEmpty(r.Item("ParameterDataLength")) Then
                        cmd.Parameters.Add(New SqlParameter With {
                          .ParameterName = r.Item("ParameterName"),
                          .Value = params(dt.Rows.IndexOf(r)),
                          .SqlDbType = [Enum].Parse(GetType(SqlDbType), r.Item("ParameterDataType"), True),
                          .Direction = If(r.Item("ParameterMode") = "IN", ParameterDirection.Input, ParameterDirection.InputOutput)
                        })
                    Else
                        cmd.Parameters.Add(New SqlParameter With {
                          .ParameterName = r.Item("ParameterName"),
                          .Value = params(dt.Rows.IndexOf(r)),
                          .SqlDbType = [Enum].Parse(GetType(SqlDbType), r.Item("ParameterDataType"), True),
                          .Size = r.Item("ParameterDataLength"),
                          .Direction = If(r.Item("ParameterMode") = "IN", ParameterDirection.Input, ParameterDirection.InputOutput)
                        })
                    End If
                Next

                If obj IsNot Nothing Then
                    Using sda As New SqlDataAdapter(cmd)
                        If obj.GetType() Is GetType(DropDownList) Then
                            Using ds As New DataSet()
                                sda.Fill(ds)
                                obj.DataSource = ds
                                obj.DataBind()
                            End Using
                            If obj.Items.Count = 1 Then
                                obj.Enabled = False
                            Else
                                obj.Items.Insert(0, New ListItem("Select ...", ""))
                                obj.Enabled = True
                            End If
                        Else
                            Dim dt2 As New DataTable
                            sda.Fill(dt2)
                            If dt2.Rows.Count > 0 Then
                                Dim dv As DataView = dt2.DefaultView
                                If sortExp <> String.Empty Then
                                    dv.Sort = String.Format("{0} {1}", sortExp, sortDir)
                                End If
                                obj.DataSource = dv
                                obj.DataBind()
                            End If
                        End If
                    End Using
                Else
                    con.Open()
                    cmd.ExecuteNonQuery()

                    If cmd.Parameters.Contains("@ErrMsg_OUT") Then
                        strMsg_OUT = cmd.Parameters.Item("@ErrMsg_OUT").Value
                    End If
                End If

            End Using

        End Using

    End Sub

    Public Shared Sub Bind_rptColumns(rpt As Repeater, obj As Object)
        Dim ds As New DataSet()
        Dim dt As New DataTable("SortColumn")
        Dim dr As DataRow

        dt.Columns.Add("Value", Type.GetType("System.String"))
        dt.Columns.Add("Text", Type.GetType("System.String"))
        ds.Tables.Add(dt)

        For Each rptItem As RepeaterItem In rpt.Items
            If rptItem.ItemType = ListItemType.Item OrElse rptItem.ItemType = ListItemType.AlternatingItem Then
                If rptItem.ItemIndex = 0 Then 'First item only
                    For Each ctrl As Panel In rptItem.Controls.OfType(Of Panel)
                        If ctrl.Attributes("data-item") IsNot Nothing Then
                            dr = dt.NewRow()
                            dr("Value") = ctrl.Attributes("data-item")
                            If ctrl.HasControls Then
                                For Each childCtrl As Label In ctrl.Controls.OfType(Of Label)
                                    dr("Text") = childCtrl.Text
                                Next
                            End If
                            dt.Rows.Add(dr)
                        End If
                    Next
                End If
            End If
        Next

        obj.DataSource = ds
        obj.DataBind()
    End Sub

    Public Shared Sub ValidateObj(FieldName As Object, ByRef ErrCount As Integer)
        FieldName.CssClass = FieldName.CssClass.Replace("err-focus", "").Trim()

        If TypeOf FieldName Is DropDownList OrElse TypeOf FieldName Is RadioButtonList Then
            If FieldName.SelectedValue = "0" OrElse FieldName.SelectedValue = "" Then
                FieldName.CssClass += " err-focus"
                ErrCount += 1
            End If
        ElseIf TypeOf FieldName Is TextBox Then
            If FieldName.Text = "" Then
                FieldName.CssClass += " err-focus"
                ErrCount += 1
            End If
        End If

    End Sub


End Class

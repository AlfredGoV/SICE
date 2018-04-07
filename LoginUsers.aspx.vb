
Imports System.Data.Sql
Imports System.Data
Public Class LoginUsers
    Inherits System.Web.UI.Page


    Dim db2 As Persistencia = New Persistencia
    Dim persis As Persistencia = New Persistencia()
    Public ls_usuario As String = ""
    Public ls_idSucursalCm As String = "0"
    Dim id_Docto As Integer
    Dim id_SucursalCmDocto As Integer
    Dim Modulo As Char
    Dim AplicaA As Char
    Public tipo As String
    Dim SQLData As DataTable

    Private Sub LoginUsers_Load(sender As Object, e As EventArgs) Handles Me.Load


        Dim persisS As Persistencia = New Persistencia()
        Dim SQLDataS As DataTable

        Dim sUsuario As String = UCase(Request("txtUsuario"))
        Dim sPassword As String = UCase(Request("txtPassword"))

        SQLDataS = persisS.GetDataTable(" exec ('select * from tc_usuario ') ")

        If SQLDataS.Rows.Count > 0 Then

            Response.Redirect("Default.aspx")
        Else
            Response.Redirect("Default.aspx")
        End If



    End Sub
End Class

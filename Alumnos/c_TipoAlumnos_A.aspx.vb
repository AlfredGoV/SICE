Imports System.Web.Services
Imports System.Type
Imports System.Data.Common
Imports LinqToExcel
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.Data

Public Class Alumnos_c_TipoAlumnos_A
    Inherits System.Web.UI.Page
    Dim db2 As Persistencia = New Persistencia
    Dim gvUniqueID As String = String.Empty
    Dim gvNewPageIndex As Integer = 0
    Dim gvEditIndex As Integer = -1
    Dim gvSortExp As String = String.Empty
    Dim li_idEmpresa As Int32 = 0
    Dim li_idSucursal As Int32 = 0
    Dim li_idejercicio As Int32 = 0
    Dim li_idperiodo As Int32 = 0
    Dim lstgv As New List(Of GridView)
    Public ls_tipo As String = ""
    Public ls_mascara_local As String = ""
    Public ls_mascara_global As String = ""
    'Dim lst_claves
    Dim ll_ctaperiodo As Int64 = 0
    Dim idNivelLocal() As Int64
    Dim idNivelGlobal() As Int64
    Public sUsuario As String = ""
    Public sRFC As String = ""
    Dim myCookie As HttpCookie
    Dim SQLTable As DataTable
    Dim SQLCuenta As DataTable
    Dim SQLSubCuenta As DataTable

    Protected Sub Alumnos_c_TipoAlumnos_A_Load(sender As Object, e As EventArgs) Handles Me.Load
        'btnAlta. = True

        If Not Page.IsPostBack Then

            myCookie = HttpContext.Current.Request.Cookies("UserSettings")
            If Not IsNothing(Request.QueryString("sUsuario")) Then
                sUsuario = Request.QueryString("sUsuario")
            ElseIf Not IsNothing(myCookie) Then
                sUsuario = myCookie("Usuario")
            End If


            SQLTable = db2.GetDataTable("select ISNULL(RFC,'XAXX010101000') from tbco_config")
            If SQLTable.Rows.Count > 0 Then
                sRFC = CInt(SQLTable.Rows(0).Item("RFC"))
            Else
                sRFC = "XAXX010101000"
            End If

            Select Case (GlobalVariables.m_ESTADODB)
                Case "A"

                    GridView1.Columns(0).Visible = True
                    btnAlta.Visible = True
                    ImageButton2.Visible = True
                    ImageButton3.Visible = True

                Case Else
                    GridView1.Columns(0).Visible = False
                    btnAlta.Visible = False
                    ImageButton2.Visible = False
                    ImageButton3.Visible = False

            End Select
        End If


        If Not IsNothing(Session("sPerfil")) Then

            Select Case Session("sPerfil").ToString.Trim.ToUpper

                Case "CONTAAUX"
                    GridView1.Columns(0).Visible = False
                    btnAlta.Attributes.Add("disabled", "disabled")
                    ImageButton2.Visible = False
                    ImageButton3.Visible = False
            End Select

        End If


        CargarParametros()

        Select Case (Request.QueryString("sResult"))

            Case "1"
                'GuardarDatos()

            Case "catalogo"

                'IMPORTAR CATALOGO LOCAL
                If Session("Carga") = Nothing Then

                    'MARCAR ESTATUS DE SALDOS INICIALES
                    db2.EjecutarSQL("update tbco_PeriodosSucursal set Inicial = ''")
                    db2.EjecutarSQL("update tbco_PeriodosSucursal set Status = 'A', Inicial = 'C' where idPeriodo = " + li_idperiodo.ToString + " And idEjercicio = " + li_idejercicio.ToString)
                    db2.EjecutarSQL("update tbco_PeriodosSucursal set Status = 'A', Inicial = 'S' where idPeriodo = " + (li_idperiodo + 1).ToString + " And idEjercicio = " + li_idejercicio.ToString)

                    'Importar()
                    'Session("Carga") = "True"

                End If

            Case "global"
                CargarRC()

        End Select


        ls_tipo = "Local"

        idEval.Value = 0

        If Not Page.IsPostBack Then


        End If

        Buscar()
    End Sub

    Protected Sub Buscar()

        GridView1.DataSourceID = ""
        GridView1.DataSource = db2.GetDataTable("select isnull(idCta,'') as idcta, isnull(CuentaNum,'') as CuentaNum, isnull(tipo,'') as tipo, isnull(grupo,'') as grupo, isnull(Cuenta,'') as Cuenta, isnull(subcuenta,'') as subcuenta, isnull(analitica,'') as analitica, isnull(subanalitica,'') as subanalitica, isnull(razonsocial,'') as razonsocial, isnull(distribuidor,'') as distribuidor, isnull(SUCURSAL,'') as sucursal, isnull(departamento,'') as departamento, isnull(moneda,'') as moneda, isnull(Clave,'') as Clave, isnull(CodigoSat,'') as CodigoSat, isnull(Nombre,'') as Nombre, isnull(idPadre,'') as idPadre, isnull(cuentamin,'') as cuentamin, isnull(cuentamax,'') as cuentamax, isnull(idEmpresa,'') as idEmpresa, isnull(idSucursal,'') as idSucursal, isnull(Naturaleza,'') as Naturaleza, isnull(Nivel,'') as Nivel, isnull(EF,'') as EF, isnull(Usuario,'') as Usuario, isnull(FechaAlta,'') as FechaAlta, isnull(Ejercicio,'') as Ejercicio, isnull(Periodo,'') as Periodo, isnull(cuenta10,'') as cuenta10, isnull(cuenta6,'') as cuenta6, isnull(acumuladora,'') as acumuladora, isnull(eq,'') as eq from tbco_catalogo where nombre like '%" + ctalocal.Value.Trim + "%' and nivel like '%" + DDLNivel.SelectedValue + "%' and naturaleza like '%" + DDLNaturaleza.SelectedValue + "%' order by clave")

        GridView1.DataBind()

    End Sub


    Public Sub CargarParametros()

        'Dim Parametros = (From pa In db.Tbcm_parametros
        '                  Select pa)
        'If Not IsNothing(Parametros) Then
        '    Dim Sucursal = (From su In db.Tbco_Sucursal
        '                    Where su.ClaveSucursal.Trim = Parametros.First.IdSucursal.Trim
        '                    Select su).FirstOrDefault

        '    li_idEmpresa = Parametros.First.IdEmpresa
        '    'CHECAR JORCH li_idSucursal = Sucursal.IdSucursal

        'End If

        If Not IsNothing(Request.QueryString("idEjercicio")) And Convert.ToInt32(Request.QueryString("idEjercicio")) > 0 Then li_idejercicio = Convert.ToInt32(Request.QueryString("idEjercicio"))

        ' If Not IsNothing(Request.QueryString("idPeriodo")) And Convert.ToInt32(Request.QueryString("idPeriodo")) > 0 Then
        'li_idperiodo = Convert.ToInt32(Request.QueryString("idPeriodo"))

        'End If


    End Sub

    Public Sub CargarRC()
        Dim ll_count_nivel As Int32
        ReDim idNivelLocal(9)
        ReDim idNivelGlobal(9)
        'Valores fijos provicionales de empresa y sucursal que se deben de obtener al momento de entrar al modulo de claves
        'Se obtienen mascara de clave local
        'lst_claves = From p In db.Tbco_abcClave
        '             Where p.IdEmpresa = 1 And p.IdSucursal = 2 And p.Tipo = "L"
        '             Order By p.Nivel Ascending
        '             Select p

        'll_count_nivel = 1
        'For Each claves In lst_claves
        '    If (claves.Nivel = ll_count_nivel) Then
        '        ls_mascara_local = ls_mascara_local + claves.Mascara + claves.Separador.Trim
        '        idNivelLocal(ll_count_nivel - 1) = claves.idRC
        '        ll_count_nivel += 1
        '    Else
        '        'Response.Write("<div style='position: absolute; float: top' ><script type='text/javascript'>alert('Las reglas del la clave local\nno estan completas');</script></div>")
        '        ls_mascara_local = ""
        '        Exit For
        '    End If

        'Next

        'Se obtienen mascara de clave global
        'lst_claves = From p In db.Tbco_abcClave
        '             Where p.IdEmpresa = 1 And p.IdSucursal = 2 And p.Tipo = "G"
        '             Order By p.Nivel Ascending
        '             Select p

        'll_count_nivel = 1

        'For Each claves In lst_claves
        '    If (claves.Nivel = ll_count_nivel) Then
        '        ls_mascara_global = ls_mascara_global + claves.Mascara + claves.Separador.Trim
        '        idNivelGlobal(ll_count_nivel - 1) = claves.idRC
        '        ll_count_nivel += 1
        '    Else
        '        'Response.Write("<div style='position: absolute; float: top' ><script type='text/javascript'>alert('Las reglas del la clave global\nno estan completas');</script></div>")
        '        ls_mascara_global = ""
        '        Exit For
        '    End If

        'Next

        Session("ArrayNivelLocal") = idNivelLocal
        Session("ArrayNivelGlobal") = idNivelGlobal

    End Sub

    Public Function WhichDB() As Boolean

        If GlobalVariables.m_ESTADODB = "A" Then
            Return True
        Else
            Return False
        End If

    End Function

    Public Function WhichDB2() As String

        If GlobalVariables.m_ESTADODB = "A" Then
            Return "display:block"
        Else
            Return "display:none"
        End If

    End Function

    Function ComputeEstadoF(ByVal iedo As String) As String


        If iedo = "BG" Then

            Return "BALANCE GENERAL"
        Else

            Return "ESTADO DE RESULTADOS"

        End If
    End Function

End Class

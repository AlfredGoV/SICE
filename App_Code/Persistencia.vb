
Imports System.Data.SqlClient
Imports System.Data
Imports System.Web
Imports System.IO
Imports System.Runtime.Serialization.Formatters.Binary
Imports System.Xml

Public Class Persistencia

    Protected strCon As String = ""
    Dim myCookie As HttpCookie
    Dim strConXML As String = ""
    Dim strbaseXML As String = ""


    Dim doc As XmlDocument = New XmlDocument()


    Sub New()

        doc.Load(HttpContext.Current.Server.MapPath("~/App_Data/testCon.xml"))
        Dim reader As XmlNodeReader = New XmlNodeReader(doc.DocumentElement)

        If doc.GetElementsByTagName("Cadena").Count > 0 Then
            strConXML = doc.GetElementsByTagName("Cadena").Item(0).InnerText
        End If


        If strConXML <> "" And (GlobalVariables.m_SC = "" Or GlobalVariables.m_SC <> strConXML) Then
            GlobalVariables.m_SC = strConXML
            GlobalVariables.m_DB = doc.GetElementsByTagName("Base").Item(0).InnerText
            strCon = GlobalVariables.m_SC
        Else
            strCon = GlobalVariables.m_SC

        End If




    End Sub

    Sub New(ByVal sXml As String)

        doc.Load(HttpContext.Current.Server.MapPath(sXml))
        Dim reader As XmlNodeReader = New XmlNodeReader(doc.DocumentElement)

        If doc.GetElementsByTagName("Cadena").Count > 0 Then
            strConXML = doc.GetElementsByTagName("Cadena").Item(0).InnerText
        End If


        If strConXML <> "" And (GlobalVariables.m_SC = "" Or GlobalVariables.m_SC <> strConXML) Then
            GlobalVariables.m_SC = strConXML
            GlobalVariables.m_DB = doc.GetElementsByTagName("Base").Item(0).InnerText
            strCon = GlobalVariables.m_SC
        Else
            strCon = GlobalVariables.m_SC

        End If



    End Sub

    Sub New(ByVal myC As HttpCookie, ByVal sXml As String)

        doc.Load(sXml)
        Dim reader As XmlNodeReader = New XmlNodeReader(doc.DocumentElement)

        If doc.GetElementsByTagName("Cadena").Count > 0 Then
            strConXML = doc.GetElementsByTagName("Cadena").Item(0).InnerText
            strCon = strConXML
        End If

    End Sub

    'OBJETIVO: Generar una consulta a la base de datos y obtener sus datos en un DataTable
    'ENTRADAS: Una cadena con la consulta deseada
    'SALIDAS: Un Datatable con los datos de la consulta
    Public Function GetDataTable(ByVal Query As String, Optional ByVal conexion As String = "") As DataTable

        Dim dtSalida = New DataTable()

        'Generamos la conexion a la base de datos
        Using conn As SqlConnection = New SqlConnection(strCon)
            Try
                conn.Open()
                'Generasmos la consulta que se envia como parametro con un DataAdapter
                Dim da As SqlDataAdapter = New SqlDataAdapter(" SET LANGUAGE ENGLISH " + Query, strCon)
                da.SelectCommand.CommandTimeout = 500000
                da.Fill(dtSalida)
                conn.Close()
            Catch ex As Exception
                Console.WriteLine(ex.Message)
            End Try
        End Using

        Return dtSalida

    End Function

    'Cadena de conexión
    Public Function ConsultaSQL(ByRef Qry As String) As DataTable

        Dim dtSalida = New DataTable()
        Try
            Using cn As SqlConnection = New SqlConnection(strCon)
                cn.Open()
                Using cmd As SqlCommand = New SqlCommand()
                    cmd.Connection = cn
                    cmd.CommandText = Qry
                    cmd.CommandTimeout = 500000
                    Using myReader As SqlDataReader = cmd.ExecuteReader()
                        Try
                            dtSalida.Load(myReader)
                            Return dtSalida
                        Catch ex As Exception
                            Return Nothing
                        End Try

                    End Using
                End Using
                cn.Close()
            End Using
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try

        Return dtSalida

    End Function

    Public Function GetDataByte(ByVal Query As String, Optional ByVal conexion As String = "") As Byte()

        Dim dtSalida = New DataTable()
        'Generamos la conexion a la base de datos
        Using conn As SqlConnection = New SqlConnection(strCon)
            Try
                conn.Open()
                'Generasmos la consulta que se envia como parametro con un DataAdapter
                Dim da As SqlDataAdapter = New SqlDataAdapter(" SET LANGUAGE ENGLISH " + Query, strCon)
                da.SelectCommand.CommandTimeout = 500000
                da.Fill(dtSalida)
            Catch ex As Exception
                Console.WriteLine(ex.Message)
            End Try
        End Using

        Return ConvertDataSetToByteArray(dtSalida)

    End Function




    Public Function EjecutarSQL(ByVal Query As String, Optional ByVal conexion As String = "") As Integer
        Dim sqlCmd As SqlCommand
        Dim filas As Integer = 0
        Using conn As SqlConnection = New SqlConnection(strCon)
            Try
                conn.Open()
                'Generamos el comando que se envia como parametro 
                sqlCmd = New SqlCommand(" SET LANGUAGE ENGLISH " + Query, conn)
                sqlCmd.CommandTimeout = 500000
                'Obtenemos el número de filas afectadas por el comando
                filas = sqlCmd.ExecuteNonQuery()
            Catch ex As Exception

                Console.WriteLine(ex.Message)
            End Try

        End Using

        Return filas

    End Function

    Private Declare Auto Function GetPrivateProfileString Lib "kernel32" (ByVal lpAppName As String,
            ByVal lpKeyName As String,
            ByVal lpDefault As String,
            ByVal lpReturnedString As StringBuilder,
            ByVal nSize As Integer,
            ByVal lpFileName As String) As Integer

    Private Function ConvertDataSetToByteArray(ByVal dt As DataTable) As Byte()
        Dim binaryDataResult As Byte() = Nothing
        Dim dataSet As DataSet = Nothing
        dataSet.Tables.Add(dt)
        Using memStream As New MemoryStream()
            Dim brFormatter As New BinaryFormatter()
            dataSet.RemotingFormat = SerializationFormat.Binary
            brFormatter.Serialize(memStream, dataSet)
            binaryDataResult = memStream.ToArray()
        End Using
        Return binaryDataResult
    End Function



    Public Function GetstrCon() As String
        Return strCon
    End Function

End Class

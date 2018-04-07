Public Class GlobalVariables

    Public Property USUARIO() As String
        Get
            Return m_USUARIO
        End Get
        Set(ByVal value As String)
            m_USUARIO = value
        End Set
    End Property
    Public Shared m_USUARIO As String

    Public Property PASSWORD() As String
        Get
            Return m_PASSWORD
        End Get
        Set(ByVal value As String)
            m_PASSWORD = value
        End Set
    End Property
    Public Shared m_PASSWORD As String

    Public Property SC() As String
        Get
            Return m_SC
        End Get
        Set(ByVal value As String)
            m_SC = value
        End Set
    End Property
    Public Shared m_SC As String = "Data Source=localhost;Initial Catalog=" + m_DB + ";Persist Security Info=True;User ID=SA;"

	Public Property Consolidacion() As Integer
        Get
            Return m_Consolidacion
        End Get
        Set(ByVal value As Integer)
            m_Consolidacion = value
        End Set
    End Property
    Public Shared m_Consolidacion As Integer	
		
    Public Property URLConsolida() As String
        Get
            Return m_URLConsolida
        End Get
        Set(ByVal value As String)
            m_URLConsolida = value
        End Set
    End Property
    Public Shared m_URLConsolida As String = "http://localhost/ConsolidaService/Consolida.asmx"

    Public Property DB() As String
        Get
            Return m_DB
        End Get
        Set(ByVal value As String)
            m_DB = value
        End Set
    End Property
    Public Shared m_DB As String = "Control"

    Public Property ETIQUETADB() As String
        Get
            Return m_ETIQUETADB
        End Get
        Set(ByVal value As String)
            m_ETIQUETADB = value
        End Set
    End Property
    Public Shared m_ETIQUETADB As String = "VIGENTE"


    Public Property ESTADODB() As String
        Get
            Return m_ESTADODB
        End Get
        Set(ByVal value As String)
            m_ESTADODB = value
        End Set
    End Property
    Public Shared m_ESTADODB As String = "A"

    Public Property SESSIONTIMEOUT() As Integer
        Get
            Return m_SESSIONTIMEOUT
        End Get
        Set(ByVal value As Integer)
            m_SESSIONTIMEOUT = value
        End Set
    End Property
    Public Shared m_SESSIONTIMEOUT As Integer

End Class

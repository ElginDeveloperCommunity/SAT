Attribute VB_Name = "Module1"
Public Declare Function AbreCupomCancelamento Lib "E1_SAT01.dll" (ByVal path_file As String, ByVal chCanc As String, ByVal CNPJ As String, ByVal signAC As String, ByVal numeroCaixa As Integer) As Integer
Public Declare Function FechaCupomCancelamento Lib "E1_SAT01.dll" (ByVal path_file As String, ByVal codigo_ativacao As String) As Long

Public Declare Function AbreCupomVenda Lib "E1_SAT01.dll" (ByVal path_file As String, ByVal versaoDadosEnt As String, ByVal CNPJ_SH As String, ByVal signAC As String, ByVal numeroCaixa As Integer, ByVal CNPJ_emit As String, ByVal IE As String, ByVal IM As String, ByVal cRegTribISSQN As String, ByVal indRatISSQN As String, ByVal CNPJ_dest As String, ByVal CPF_dest As String, ByVal xNome_dest As String) As Integer
Public Declare Function InformaProduto Lib "E1_SAT01.dll" (ByVal path_file As String, ByVal cProd As String, ByVal cEAN As String, ByVal xProd As String, ByVal NCM As String, ByVal CEST As String, ByVal CFOP As String, ByVal uCom As String, ByVal qCom As String, ByVal vUnCom As String, ByVal indRegra As String, ByVal vDesc As String, ByVal vOutro As String) As Integer
Public Declare Function InformaImposto Lib "E1_SAT01.dll" (ByVal path_file As String, ByVal nItem As Integer, ByVal vItem12741 As String) As Integer
Public Declare Function InformaICMS40 Lib "E1_SAT01.dll" (ByVal path_file As String, ByVal nItem As Integer, ByVal Orig As Integer, ByVal CST As String) As Integer
Public Declare Function InformaPISNT Lib "E1_SAT01.dll" (ByVal path_file As String, ByVal nItem As Integer, ByVal CST As String) As Integer
Public Declare Function InformaCOFINSNT Lib "E1_SAT01.dll" (ByVal path_file As String, ByVal nItem As Integer, ByVal CST As String) As Integer
Public Declare Function InformaTotal Lib "E1_SAT01.dll" (ByVal path_file As String, ByVal vDescSubtot As String, ByVal vAcresSubtot As String, ByVal vCFeLei12741 As String) As Integer
Public Declare Function InformaPgto Lib "E1_SAT01.dll" (ByVal path_file As String, ByVal cMP As String, ByVal vMP As String, ByVal cAdmC As String) As Integer
Public Declare Function FechaCupomVenda Lib "E1_SAT01.dll" (ByVal path_file As String, ByVal codigo_ativacao As String) As Long

'Public Declare Function EnviarDadosVenda Lib "dllsat.dll" (ByVal numSessao As Long, ByVal codAtivacao As String, ByVal dadosVenda As String) As String

Public Declare Function lstrlenA Lib "kernel32" (ByVal lpString As Long) As Long
Public Declare Function SysAllocStringByteLen Lib "oleaut32.dll" (ByVal m_pBase As Long, ByVal l As Long) As String

'Função para conversão de ponteiro para String
Public Function StrPtrToString(ByVal ponteiro As Long) As String

    Dim Saida As String

    Saida = SysAllocStringByteLen(ponteiro, lstrlenA(ponteiro))

    StrPtrToString = Saida

End Function

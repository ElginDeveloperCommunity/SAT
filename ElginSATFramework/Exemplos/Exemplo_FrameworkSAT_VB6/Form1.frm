VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Framework SAT"
   ClientHeight    =   3090
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   11100
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   11100
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame2 
      Caption         =   "Cancelamento"
      Height          =   2535
      Left            =   4440
      TabIndex        =   1
      Top             =   240
      Width           =   6375
      Begin VB.CommandButton Command4 
         Caption         =   "Processar cancelamento"
         Height          =   495
         Left            =   240
         TabIndex        =   6
         Top             =   1800
         Width           =   2535
      End
      Begin VB.TextBox Text1 
         Height          =   375
         Left            =   240
         TabIndex        =   5
         Top             =   1200
         Width           =   5895
      End
      Begin VB.CommandButton Command3 
         Caption         =   "Gerar XML Cancelamento"
         Height          =   495
         Left            =   240
         TabIndex        =   4
         Top             =   480
         Width           =   2535
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Venda"
      Height          =   2535
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   3855
      Begin VB.CommandButton Command2 
         Caption         =   "Processar Venda"
         Height          =   495
         Left            =   360
         TabIndex        =   3
         Top             =   1200
         Width           =   3135
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Gerar XML Venda"
         Height          =   495
         Left            =   360
         TabIndex        =   2
         Top             =   480
         Width           =   3135
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Dim nItem As Integer
Dim aux As Integer
Dim path As String

path = "ArquivoVenda.xml"

aux = AbreCupomVenda(path, "0.08", "16716114000172", "SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT", 123, "14200166000166", "111111111111", "123123", "", "n", "", "", "")

nItem = InformaProduto(path, "0001", "", "CEST", "47061000", "1234567", "5757", "kg", "1.0000", "100.00", "a", "", "")

aux = InformaImposto(path, nItem, "1.00")
aux = InformaICMS40(path, nItem, 3, "40")
aux = InformaPISNT(path, nItem, "04")
aux = InformaCOFINSNT(path, nItem, "04")
aux = InformaTotal(path, "", "", "")
aux = InformaPgto(path, "01", "100.00", "")

MsgBox "OK"

End Sub

Private Sub Command2_Click()
Dim retorno As String
Dim ptr As Long
Dim val() As String

ptr = FechaCupomVenda("ArquivoVenda.xml", "123456789")

retorno = StrPtrToString(ptr)

val = Split(retorno, "|")

If UBound(val) > 1 Then
    If val(1) = "06000" Then
        Text1.Text = val(8)
    End If
End If


MsgBox retorno
End Sub

Private Sub Command3_Click()
Dim retorno As Integer

If Text1.Text = "" Then
    MsgBox "Preencha a chave de acesso", vbCritical, "Erro"
    Exit Sub
End If

retorno = AbreCupomCancelamento("ArquivoCancelamento.xml", Text1.Text, "14200166000166", "SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT", 123)
MsgBox "OK"
End Sub

Private Sub Command4_Click()
Dim ptr As Long
Dim retorno As String

ptr = FechaCupomCancelamento("ArquivoCancelamento.xml", "123456789")

retorno = StrPtrToString(ptr)

MsgBox retorno

End Sub

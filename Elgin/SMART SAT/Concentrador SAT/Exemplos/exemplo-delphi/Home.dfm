object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Delphi - Linker SAT II Elgin'
  ClientHeight = 695
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 441
    Height = 209
    Caption = 'Dados'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 96
      Height = 13
      Caption = 'C'#243'digo de ativa'#231#227'o:'
    end
    object Label2: TLabel
      Left = 16
      Top = 51
      Width = 76
      Height = 13
      Caption = 'CNPJ Software:'
    end
    object Label3: TLabel
      Left = 16
      Top = 78
      Width = 91
      Height = 13
      Caption = 'CNPJ Contribuinte:'
    end
    object Label4: TLabel
      Left = 16
      Top = 105
      Width = 55
      Height = 13
      Caption = 'Assinatura:'
    end
    object Label5: TLabel
      Left = 16
      Top = 159
      Width = 94
      Height = 13
      Caption = 'XML Cancelamento:'
    end
    object Label6: TLabel
      Left = 16
      Top = 132
      Width = 56
      Height = 13
      Caption = 'XML Venda:'
    end
    object codAtivacao: TEdit
      Left = 144
      Top = 21
      Width = 161
      Height = 21
      TabOrder = 0
      Text = '123456789'
    end
    object cnpjSH: TEdit
      Left = 144
      Top = 48
      Width = 161
      Height = 21
      TabOrder = 1
      Text = '14200166000166'
    end
    object cnpjContri: TEdit
      Left = 144
      Top = 75
      Width = 161
      Height = 21
      TabOrder = 2
      Text = '14200166000166'
    end
    object xmlVenda: TEdit
      Left = 144
      Top = 129
      Width = 161
      Height = 21
      TabOrder = 3
    end
    object xmlCancelamento: TEdit
      Left = 144
      Top = 156
      Width = 161
      Height = 21
      TabOrder = 4
    end
    object btnXmlVenda: TButton
      Left = 311
      Top = 129
      Width = 26
      Height = 23
      Caption = '...'
      TabOrder = 5
      OnClick = btnXmlVendaClick
    end
    object btnXmlCanc: TButton
      Left = 311
      Top = 156
      Width = 26
      Height = 21
      Caption = '...'
      TabOrder = 6
      OnClick = btnXmlCancClick
    end
  end
  object Button1: TButton
    Left = 8
    Top = 215
    Width = 106
    Height = 41
    Caption = 'Consultar SAT'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 120
    Top = 215
    Width = 106
    Height = 41
    Caption = 'Status operacional'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 232
    Top = 215
    Width = 106
    Height = 41
    Caption = 'Efetuar Venda'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 343
    Top = 215
    Width = 106
    Height = 41
    Caption = 'Cancelar venda'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 262
    Width = 106
    Height = 41
    Caption = 'Teste fim a afim'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 120
    Top = 262
    Width = 106
    Height = 41
    BiDiMode = bdLeftToRight
    Caption = 'Trocar codigo de ativa'#231#227'o'
    DoubleBuffered = False
    ParentBiDiMode = False
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 6
    WordWrap = True
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 232
    Top = 262
    Width = 106
    Height = 41
    Caption = 'Consultar numero de sessao'
    TabOrder = 7
    WordWrap = True
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 344
    Top = 262
    Width = 106
    Height = 42
    Caption = 'Configurar rede'
    TabOrder = 8
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 8
    Top = 309
    Width = 106
    Height = 42
    Caption = 'Associar assinatura'
    TabOrder = 9
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 120
    Top = 309
    Width = 106
    Height = 42
    Caption = 'Atualizar software'
    TabOrder = 10
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 232
    Top = 309
    Width = 106
    Height = 42
    Caption = 'Extrair Log'
    TabOrder = 11
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 344
    Top = 308
    Width = 106
    Height = 43
    Caption = 'Bloquear SAT'
    TabOrder = 12
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 8
    Top = 357
    Width = 106
    Height = 43
    Caption = 'Desbloquear SAT'
    TabOrder = 13
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 120
    Top = 357
    Width = 106
    Height = 43
    Caption = 'Ativar Sat'
    TabOrder = 14
    OnClick = Button14Click
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 406
    Width = 441
    Height = 280
    Caption = 'Retorno'
    TabOrder = 15
    object Retorno: TMemo
      Left = 16
      Top = 24
      Width = 409
      Height = 241
      Lines.Strings = (
        'Retorno')
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object AssinaturaAC: TEdit
    Left = 152
    Top = 102
    Width = 161
    Height = 21
    TabOrder = 16
    Text = 'SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT'
  end
  object OpenDialog1: TOpenDialog
    Left = 400
    Top = 120
  end
end

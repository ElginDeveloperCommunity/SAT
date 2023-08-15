object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Configura'#231#227'o de rede'
  ClientHeight = 305
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label13: TLabel
    Left = 8
    Top = 16
    Width = 93
    Height = 13
    Caption = 'Codigo de Ativa'#231#227'o'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 48
    Width = 473
    Height = 249
    Caption = 'Configurar Rede - SAT'
    TabOrder = 0
    object Label1: TLabel
      Left = 13
      Top = 35
      Width = 45
      Height = 13
      Caption = 'Interface'
    end
    object Label2: TLabel
      Left = 13
      Top = 62
      Width = 10
      Height = 13
      Caption = 'IP'
    end
    object Label3: TLabel
      Left = 13
      Top = 89
      Width = 83
      Height = 13
      Caption = 'M'#225'scara de Rede'
    end
    object Label4: TLabel
      Left = 13
      Top = 116
      Width = 43
      Height = 13
      Caption = 'Gateway'
    end
    object Label5: TLabel
      Left = 13
      Top = 143
      Width = 20
      Height = 13
      Caption = 'DNS'
    end
    object Label6: TLabel
      Left = 13
      Top = 170
      Width = 76
      Height = 13
      Caption = 'DNS Secund'#225'rio'
    end
    object Label7: TLabel
      Left = 248
      Top = 35
      Width = 63
      Height = 13
      Caption = 'Tipo de Rede'
    end
    object Label8: TLabel
      Left = 248
      Top = 62
      Width = 28
      Height = 13
      Caption = 'Proxy'
    end
    object Label9: TLabel
      Left = 248
      Top = 89
      Width = 56
      Height = 13
      Caption = 'IP do proxy'
    end
    object Label10: TLabel
      Left = 248
      Top = 143
      Width = 82
      Height = 13
      Caption = 'Usu'#225'rio do proxy'
    end
    object Label11: TLabel
      Left = 248
      Top = 170
      Width = 76
      Height = 13
      Caption = 'Senha do proxy'
    end
    object Label12: TLabel
      Left = 248
      Top = 116
      Width = 72
      Height = 13
      Caption = 'Porta do proxy'
    end
    object ComboBox1: TComboBox
      Left = 104
      Top = 32
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'IP Fixo'
      Items.Strings = (
        'IP Fixo'
        'DHCP')
    end
    object ComboBox2: TComboBox
      Left = 336
      Top = 32
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'Ethernet'
      Items.Strings = (
        'Ethernet')
    end
    object ComboBox3: TComboBox
      Left = 336
      Top = 59
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 2
      Text = 'Nenhum'
      Items.Strings = (
        'Nenhum'
        'Com configura'#231#227'o'
        'Transparente')
    end
    object Edit1: TEdit
      Left = 104
      Top = 59
      Width = 121
      Height = 21
      TabOrder = 3
    end
    object Edit2: TEdit
      Left = 104
      Top = 86
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object Edit3: TEdit
      Left = 104
      Top = 113
      Width = 121
      Height = 21
      TabOrder = 5
    end
    object Edit4: TEdit
      Left = 104
      Top = 140
      Width = 121
      Height = 21
      TabOrder = 6
    end
    object Edit5: TEdit
      Left = 104
      Top = 167
      Width = 121
      Height = 21
      TabOrder = 7
    end
    object Edit6: TEdit
      Left = 336
      Top = 86
      Width = 121
      Height = 21
      TabOrder = 8
    end
    object Edit7: TEdit
      Left = 336
      Top = 113
      Width = 121
      Height = 21
      TabOrder = 9
    end
    object Edit8: TEdit
      Left = 336
      Top = 140
      Width = 121
      Height = 21
      TabOrder = 10
    end
    object Edit9: TEdit
      Left = 336
      Top = 167
      Width = 121
      Height = 21
      TabOrder = 11
    end
    object Button1: TButton
      Left = 382
      Top = 208
      Width = 75
      Height = 25
      Caption = 'Configurar'
      TabOrder = 12
      OnClick = Button1Click
    end
  end
  object Edit10: TEdit
    Left = 107
    Top = 13
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '123456789'
  end
end

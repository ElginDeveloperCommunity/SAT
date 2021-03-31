object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Form1'
  ClientHeight = 157
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 215
    Top = 8
    Width = 402
    Height = 129
    Caption = 'Cancelamento'
    TabOrder = 0
    object Button1: TButton
      Left = 3
      Top = 82
      Width = 143
      Height = 25
      Caption = 'Processa Cancelamento'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 3
      Top = 55
      Width = 375
      Height = 21
      TabOrder = 1
      TextHint = 'Chave de acesso cupom venda'
    end
    object Button4: TButton
      Left = 3
      Top = 24
      Width = 143
      Height = 25
      Caption = 'Gera XML Cancelamento'
      TabOrder = 2
      OnClick = Button4Click
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 201
    Height = 129
    Caption = 'Venda'
    TabOrder = 1
    object Button3: TButton
      Left = 3
      Top = 24
      Width = 195
      Height = 25
      Caption = 'Gera XML Venda'
      TabOrder = 0
      OnClick = Button3Click
    end
    object Button2: TButton
      Left = 3
      Top = 55
      Width = 195
      Height = 25
      Caption = 'Processa Venda'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
end

object frmCarro: TfrmCarro
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Carro'
  ClientHeight = 184
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Padding.Left = 1
  Position = poScreenCenter
  OnActivate = FormActivate
  TextHeight = 15
  object pnlCarro: TPanel
    Left = 1
    Top = 0
    Width = 583
    Height = 154
    Align = alClient
    TabOrder = 0
    object lblCodigo: TLabel
      Left = 8
      Top = 8
      Width = 39
      Height = 15
      Caption = 'C'#243'digo'
    end
    object lblNome: TLabel
      Left = 95
      Top = 8
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object lblMarca: TLabel
      Left = 8
      Top = 56
      Width = 33
      Height = 15
      Caption = 'Marca'
    end
    object lblPlaca: TLabel
      Left = 231
      Top = 56
      Width = 28
      Height = 15
      Caption = 'Placa'
    end
    object lblCor: TLabel
      Left = 367
      Top = 56
      Width = 19
      Height = 15
      Caption = 'Cor'
    end
    object lblPotencia: TLabel
      Left = 8
      Top = 104
      Width = 46
      Height = 15
      Caption = 'Pot'#234'ncia'
    end
    object lblAno: TLabel
      Left = 135
      Top = 104
      Width = 22
      Height = 15
      Caption = 'Ano'
    end
    object edtCodigo: TEdit
      Left = 8
      Top = 26
      Width = 81
      Height = 23
      Enabled = False
      MaxLength = 9
      NumbersOnly = True
      TabOrder = 0
    end
    object edtNome: TEdit
      Left = 95
      Top = 26
      Width = 480
      Height = 23
      TabOrder = 1
    end
    object edtMarca: TEdit
      Left = 8
      Top = 74
      Width = 217
      Height = 23
      TabOrder = 2
    end
    object edtPlaca: TEdit
      Left = 231
      Top = 74
      Width = 130
      Height = 23
      MaxLength = 7
      TabOrder = 3
    end
    object edtCor: TEdit
      Left = 367
      Top = 74
      Width = 208
      Height = 23
      TabOrder = 4
    end
    object edtPotencia: TEdit
      Left = 8
      Top = 122
      Width = 121
      Height = 23
      MaxLength = 5
      TabOrder = 5
      OnKeyPress = edtPotenciaKeyPress
    end
    object edtAno: TEdit
      Left = 135
      Top = 122
      Width = 90
      Height = 23
      MaxLength = 4
      NumbersOnly = True
      TabOrder = 6
    end
  end
  object pnlRodape: TPanel
    Left = 1
    Top = 154
    Width = 583
    Height = 30
    Align = alBottom
    BevelInner = bvLowered
    Padding.Left = 1
    Padding.Top = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 1
    object btnCancelar: TButton
      Left = 494
      Top = 3
      Width = 86
      Height = 24
      Align = alRight
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
    object btnGravar: TButton
      Left = 408
      Top = 3
      Width = 86
      Height = 24
      Align = alRight
      Caption = '&Gravar'
      TabOrder = 0
      OnClick = btnGravarClick
    end
  end
end

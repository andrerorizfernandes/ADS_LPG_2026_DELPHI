object frmAluguel: TfrmAluguel
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Aluguel'
  ClientHeight = 118
  ClientWidth = 599
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  TextHeight = 15
  object pnlRodape: TPanel
    Left = 0
    Top = 88
    Width = 599
    Height = 30
    Align = alBottom
    BevelInner = bvLowered
    Padding.Left = 1
    Padding.Top = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 0
    ExplicitLeft = 1
    ExplicitTop = 154
    ExplicitWidth = 583
    object btnCancelar: TButton
      Left = 510
      Top = 3
      Width = 86
      Height = 24
      Align = alRight
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
      ExplicitLeft = 494
    end
    object btnGravar: TButton
      Left = 424
      Top = 3
      Width = 86
      Height = 24
      Align = alRight
      Caption = '&Gravar'
      TabOrder = 0
      OnClick = btnGravarClick
      ExplicitLeft = 408
    end
  end
  object pnlAluguel: TPanel
    Left = 0
    Top = 0
    Width = 599
    Height = 88
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 193
    object lblCarro: TLabel
      Left = 8
      Top = 8
      Width = 29
      Height = 15
      Caption = 'Carro'
    end
    object lblValor: TLabel
      Left = 406
      Top = 8
      Width = 26
      Height = 15
      Caption = 'Valor'
    end
    object lblDias: TLabel
      Left = 533
      Top = 8
      Width = 22
      Height = 15
      Caption = 'Dias'
    end
    object dblCarro: TDBLookupComboBox
      Left = 8
      Top = 24
      Width = 392
      Height = 23
      DataField = 'CODIGOCARRO'
      DataSource = DM.dsrAluguel
      KeyField = 'CODIGO'
      ListField = 'NOME'
      ListSource = DM.dsrCarro
      TabOrder = 0
    end
    object dbeValor: TDBEdit
      Left = 406
      Top = 24
      Width = 121
      Height = 23
      DataField = 'VALOR'
      DataSource = DM.dsrAluguel
      TabOrder = 1
    end
    object dbeDias: TDBEdit
      Left = 533
      Top = 24
      Width = 58
      Height = 23
      DataField = 'DIAS'
      DataSource = DM.dsrAluguel
      TabOrder = 2
    end
    object chkPago: TDBCheckBox
      Left = 8
      Top = 58
      Width = 177
      Height = 17
      Caption = 'Aluguel pago pelo cliente'
      DataField = 'PAGO'
      DataSource = DM.dsrAluguel
      TabOrder = 3
    end
  end
end

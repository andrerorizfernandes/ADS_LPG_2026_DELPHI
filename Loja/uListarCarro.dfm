object frmListarCarro: TfrmListarCarro
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Carro'
  ClientHeight = 354
  ClientWidth = 586
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pnlRodape: TPanel
    Left = 0
    Top = 325
    Width = 586
    Height = 29
    Align = alBottom
    TabOrder = 0
    object btnExcluir: TButton
      Left = 504
      Top = 1
      Width = 81
      Height = 27
      Align = alRight
      Caption = 'E&xcluir'
      TabOrder = 0
    end
    object btnEditar: TButton
      Left = 423
      Top = 1
      Width = 81
      Height = 27
      Align = alRight
      Caption = '&Editar'
      TabOrder = 1
      ExplicitLeft = 504
    end
    object btnInserir: TButton
      Left = 342
      Top = 1
      Width = 81
      Height = 27
      Align = alRight
      Caption = '&Inserir'
      TabOrder = 2
      ExplicitLeft = 504
    end
  end
  object dbgListarCarro: TDBGrid
    Left = 0
    Top = 0
    Width = 586
    Height = 325
    Align = alClient
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
end

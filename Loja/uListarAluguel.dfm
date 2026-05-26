object frmListarAluguel: TfrmListarAluguel
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Aluguel'
  ClientHeight = 354
  ClientWidth = 718
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  TextHeight = 15
  object lblQuantidadeRegistros: TLabel
    Left = 0
    Top = 310
    Width = 718
    Height = 15
    Align = alBottom
    Alignment = taRightJustify
    Caption = '0 Registros '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitLeft = 653
    ExplicitWidth = 65
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 325
    Width = 718
    Height = 29
    Align = alBottom
    Padding.Left = 1
    Padding.Top = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 0
    object btnExcluir: TButton
      Left = 635
      Top = 2
      Width = 81
      Height = 25
      Align = alRight
      Caption = 'E&xcluir'
      TabOrder = 0
      OnClick = btnExcluirClick
    end
    object btnEditar: TButton
      Left = 554
      Top = 2
      Width = 81
      Height = 25
      Align = alRight
      Caption = '&Editar'
      TabOrder = 1
      OnClick = btnEditarClick
    end
    object btnInserir: TButton
      Left = 473
      Top = 2
      Width = 81
      Height = 25
      Align = alRight
      Caption = '&Inserir'
      TabOrder = 2
      OnClick = btnInserirClick
    end
  end
  object dbgListarAluguel: TDBGrid
    Left = 0
    Top = 0
    Width = 718
    Height = 310
    Align = alClient
    DataSource = DM.dsrAluguel
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = [fsBold]
    OnDrawColumnCell = dbgListarAluguelDrawColumnCell
    OnDblClick = dbgListarAluguelDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGOALUGUEL'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PLACA'
        Title.Caption = 'Placa'
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Carro'
        Width = 266
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Title.Caption = 'Valor'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DIAS'
        Title.Caption = 'Dias'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'StatusPagamento'
        Title.Caption = 'Pago'
        Width = 45
        Visible = True
      end>
  end
end

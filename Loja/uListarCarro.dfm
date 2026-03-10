object frmListarCarro: TfrmListarCarro
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Carro'
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
  TextHeight = 15
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
      ExplicitLeft = 636
      ExplicitTop = 1
      ExplicitHeight = 27
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
      ExplicitLeft = 555
      ExplicitTop = 1
      ExplicitHeight = 27
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
      ExplicitLeft = 474
      ExplicitTop = 1
      ExplicitHeight = 27
    end
  end
  object dbgListarCarro: TDBGrid
    Left = 0
    Top = 0
    Width = 718
    Height = 325
    Align = alClient
    DataSource = DM.dsrCarro
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
    OnDrawColumnCell = dbgListarCarroDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        Title.Caption = 'C'#243'digo'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        Width = 210
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Marca'
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Placa'
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cor'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Potencia'
        Title.Caption = 'Pot'#234'ncia'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Ano'
        Visible = True
      end>
  end
end

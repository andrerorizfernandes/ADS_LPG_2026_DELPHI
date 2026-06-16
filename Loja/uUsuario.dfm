object frmUsuario: TfrmUsuario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Usu'#225'rio'
  ClientHeight = 103
  ClientWidth = 729
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
    Top = 73
    Width = 729
    Height = 30
    Align = alBottom
    BevelInner = bvLowered
    Padding.Left = 1
    Padding.Top = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 0
    ExplicitTop = 88
    ExplicitWidth = 599
    object btnCancelar: TButton
      Left = 640
      Top = 3
      Width = 86
      Height = 24
      Align = alRight
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
      ExplicitLeft = 510
    end
    object btnGravar: TButton
      Left = 554
      Top = 3
      Width = 86
      Height = 24
      Align = alRight
      Caption = '&Gravar'
      TabOrder = 0
      OnClick = btnGravarClick
      ExplicitLeft = 424
    end
  end
  object pnlUsuario: TPanel
    Left = 0
    Top = 0
    Width = 729
    Height = 73
    Align = alClient
    TabOrder = 1
    ExplicitTop = -3
    ExplicitWidth = 599
    ExplicitHeight = 166
    object lblCpf: TLabel
      Left = 8
      Top = 16
      Width = 19
      Height = 15
      Caption = 'Cpf'
    end
    object lblNome: TLabel
      Left = 143
      Top = 16
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object lblSenha: TLabel
      Left = 469
      Top = 16
      Width = 32
      Height = 15
      Caption = 'Senha'
    end
    object lblConfirmarSenha: TLabel
      Left = 600
      Top = 16
      Width = 88
      Height = 15
      Caption = 'Confirmar senha'
    end
    object dbeCpf: TDBEdit
      Left = 8
      Top = 33
      Width = 129
      Height = 23
      DataField = 'CPF'
      DataSource = DM.dsrUsuario
      TabOrder = 0
      OnKeyPress = dbeCpfKeyPress
    end
    object dbeNome: TDBEdit
      Left = 143
      Top = 33
      Width = 320
      Height = 23
      DataField = 'NOME'
      DataSource = DM.dsrUsuario
      TabOrder = 1
    end
    object dbeSenha: TDBEdit
      Left = 469
      Top = 33
      Width = 125
      Height = 23
      DataField = 'SENHA'
      DataSource = DM.dsrUsuario
      PasswordChar = '*'
      TabOrder = 2
    end
    object edtConfirmarSenha: TEdit
      Left = 600
      Top = 33
      Width = 121
      Height = 23
      PasswordChar = '*'
      TabOrder = 3
    end
  end
end

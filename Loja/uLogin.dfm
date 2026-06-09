object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 150
  ClientWidth = 272
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 13
  object lblDominio: TLabel
    Left = 0
    Top = 117
    Width = 184
    Height = 33
    Align = alClient
    ExplicitWidth = 3
    ExplicitHeight = 13
  end
  object btnAcessar: TButton
    Left = 184
    Top = 117
    Width = 88
    Height = 33
    Align = alRight
    Caption = 'Acessar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnAcessarClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 272
    Height = 117
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 23
      Height = 17
      Caption = 'CPF'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 60
      Width = 37
      Height = 17
      Caption = 'Senha'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSenha2: TLabel
      Left = 111
      Top = 60
      Width = 109
      Height = 17
      Caption = 'Confirme a Senha'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label4: TLabel
      Left = 113
      Top = 8
      Width = 47
      Height = 17
      Caption = 'Usu'#225'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtSenha1: TEdit
      Left = 8
      Top = 83
      Width = 97
      Height = 21
      PasswordChar = '*'
      TabOrder = 2
      OnKeyPress = edtSenha1KeyPress
    end
    object edtSenha2: TEdit
      Left = 111
      Top = 83
      Width = 97
      Height = 21
      PasswordChar = '*'
      TabOrder = 3
      Visible = False
      OnKeyPress = edtSenha2KeyPress
    end
    object edtCPF: TMaskEdit
      Left = 8
      Top = 32
      Width = 97
      Height = 21
      EditMask = '999.999.999-99;0;_'
      MaxLength = 14
      TabOrder = 0
      Text = ''
      OnChange = edtCPFChange
    end
    object edtUsuario: TEdit
      Left = 111
      Top = 32
      Width = 153
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
  end
end

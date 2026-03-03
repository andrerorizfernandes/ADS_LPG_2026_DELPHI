object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Sistema de loja'
  ClientHeight = 461
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = menModulo
  Position = poScreenCenter
  TextHeight = 15
  object menModulo: TMainMenu
    Left = 48
    Top = 40
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Carro1: TMenuItem
        Caption = '&Carro'
        OnClick = Carro1Click
      end
      object Cidade1: TMenuItem
        Caption = 'C&liente'
      end
    end
    object Relatrio1: TMenuItem
      Caption = 'Relat'#243'rio'
    end
    object Sair1: TMenuItem
      Caption = 'Sair'
    end
  end
end

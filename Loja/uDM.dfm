object DM: TDM
  Height = 480
  Width = 640
  object dsrCarro: TDataSource
    DataSet = qryCarro
    Left = 112
    Top = 104
  end
  object Conexao: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Andre Roriz\Downloads\ADS_LPG_2026_DELPHI\Loja' +
        '\database\LOJA.FDB'
      'User_Name=SYSDBA'
      'Password=18071988'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object qryCarro: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'SELECT'
      '  c.codigo,'
      '  c.nome,'
      '  c.marca,'
      '  c.placa,'
      '  c.cor,'
      '  c.potencia,'
      '  c.ano'
      'FROM carro c')
    Left = 48
    Top = 104
    object qryCarroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryCarroNOME: TWideStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 50
    end
    object qryCarroMARCA: TWideStringField
      FieldName = 'MARCA'
      Origin = 'MARCA'
      Required = True
      Size = 30
    end
    object qryCarroPLACA: TWideStringField
      FieldName = 'PLACA'
      Origin = 'PLACA'
      Required = True
      Size = 7
    end
    object qryCarroCOR: TWideStringField
      FieldName = 'COR'
      Origin = 'COR'
      Required = True
    end
    object qryCarroPOTENCIA: TFMTBCDField
      FieldName = 'POTENCIA'
      Origin = 'POTENCIA'
      Required = True
      Precision = 18
      Size = 2
    end
    object qryCarroANO: TIntegerField
      FieldName = 'ANO'
      Origin = 'ANO'
      Required = True
    end
  end
end

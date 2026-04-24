object DM: TDM
  Height = 480
  Width = 640
  object cdsCarro: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 416
    Top = 120
    object cdsCarroCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cdsCarroNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object cdsCarroMarca: TStringField
      FieldName = 'Marca'
      Size = 30
    end
    object cdsCarroPlaca: TStringField
      FieldName = 'Placa'
      Size = 7
    end
    object cdsCarroCor: TStringField
      FieldName = 'Cor'
      Size = 15
    end
    object cdsCarroPotencia: TFloatField
      FieldName = 'Potencia'
    end
    object cdsCarroAno: TIntegerField
      FieldName = 'Ano'
    end
  end
  object dsrCarro: TDataSource
    DataSet = cdsCarro
    Left = 472
    Top = 120
  end
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=ads2026'
      'User_Name=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object lnkMySql: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\Andre Roriz\Downloads\ADS_LPG_2026_DELPHI\Loja\lib\libm' +
      'ysql.dll'
    Left = 112
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
    object qryCarrocodigo: TFDAutoIncField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = False
      IdentityInsert = True
    end
    object qryCarronome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 50
    end
    object qryCarromarca: TStringField
      FieldName = 'marca'
      Origin = 'marca'
      Required = True
      Size = 30
    end
    object qryCarroplaca: TStringField
      FieldName = 'placa'
      Origin = 'placa'
      Required = True
      Size = 7
    end
    object qryCarrocor: TStringField
      FieldName = 'cor'
      Origin = 'cor'
      Required = True
    end
    object qryCarropotencia: TBCDField
      FieldName = 'potencia'
      Origin = 'potencia'
      Required = True
      Precision = 10
      Size = 2
    end
    object qryCarroano: TIntegerField
      FieldName = 'ano'
      Origin = 'ano'
      Required = True
    end
  end
end

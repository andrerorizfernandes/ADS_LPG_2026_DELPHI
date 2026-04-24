object DM: TDM
  Height = 480
  Width = 640
  object cdsCarro: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 328
    Top = 144
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
    Left = 384
    Top = 144
  end
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=ads2026'
      'User_Name=root'
      'DriverID=MySQL')
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
end

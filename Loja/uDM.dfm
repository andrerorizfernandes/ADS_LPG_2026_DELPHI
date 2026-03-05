object DM: TDM
  Height = 480
  Width = 640
  object cdsCarro: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 80
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
    Left = 88
    Top = 80
  end
end

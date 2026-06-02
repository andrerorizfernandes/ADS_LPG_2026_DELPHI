object DM: TDM
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object dsrCarro: TDataSource
    DataSet = qryCarro
    Left = 112
    Top = 104
  end
  object Conexao: TFDConnection
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
      '  c.codigomarca,'
      '  m.nome marca,'
      '  c.placa,'
      '  c.cor,'
      '  c.potencia,'
      '  c.ano,'
      '  c.excluido'
      'FROM carro c'
      'INNER JOIN MARCA m ON c.CODIGOMARCA = m.CODIGO'
      'WHERE c.excluido = False')
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
    object qryCarroCODIGOMARCA: TIntegerField
      FieldName = 'CODIGOMARCA'
      Origin = 'CODIGOMARCA'
      Required = True
    end
    object qryCarroMARCA: TWideStringField
      FieldName = 'MARCA'
      Origin = 'MARCA'
      ProviderFlags = []
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
    object qryCarroEXCLUIDO: TBooleanField
      FieldName = 'EXCLUIDO'
      Origin = 'EXCLUIDO'
    end
  end
  object qryMarca: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'SELECT'
      '  m.CODIGO,'
      '  m.NOME '
      'FROM marca m'
      'ORDER BY m.NOME')
    Left = 48
    Top = 176
    object qryMarcaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryMarcaNOME: TWideStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 60
    end
  end
  object dsrMarca: TDataSource
    DataSet = qryMarca
    Left = 113
    Top = 176
  end
  object qryAluguel: TFDQuery
    OnCalcFields = qryAluguelCalcFields
    Connection = Conexao
    SQL.Strings = (
      'SELECT'
      '  a.CODIGOALUGUEL,'
      '  a.CODIGOCARRO,'
      '  c.NOME,'
      '  c.PLACA,'
      '  a.VALOR,'
      '  a.DIAS,'
      '  a.PAGO,'
      '  a.EXCLUIDO'
      'FROM aluguel a'
      
        'INNER JOIN CARRO c ON c.CODIGO = a.CODIGOCARRO AND c.EXCLUIDO = ' +
        'FALSE '
      'WHERE a.EXCLUIDO = FALSE')
    Left = 48
    Top = 248
    object qryAluguelCODIGOALUGUEL: TIntegerField
      FieldName = 'CODIGOALUGUEL'
      Origin = 'CODIGOALUGUEL'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryAluguelCODIGOCARRO: TIntegerField
      FieldName = 'CODIGOCARRO'
      Origin = 'CODIGOCARRO'
      Required = True
    end
    object qryAluguelNOME: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object qryAluguelPLACA: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'PLACA'
      Origin = 'PLACA'
      ProviderFlags = []
      ReadOnly = True
      Size = 7
    end
    object qryAluguelVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      currency = True
      Precision = 18
      Size = 2
    end
    object qryAluguelDIAS: TIntegerField
      FieldName = 'DIAS'
      Origin = 'DIAS'
      Required = True
    end
    object qryAluguelPAGO: TBooleanField
      FieldName = 'PAGO'
      Origin = 'PAGO'
      Required = True
    end
    object qryAluguelEXCLUIDO: TBooleanField
      FieldName = 'EXCLUIDO'
      Origin = 'EXCLUIDO'
    end
    object qryAluguelStatusPagamento: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'StatusPagamento'
      Size = 3
    end
  end
  object dsrAluguel: TDataSource
    DataSet = qryAluguel
    Left = 114
    Top = 248
  end
  object qryUsuarioLogado: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'SELECT'
      #9'u.CODIGO,'
      #9'u.CPF,'
      #9'u.NOME,'
      #9'u.SENHA'
      'FROM USUARIO u'
      'WHERE u.CPF =:CPF')
    Left = 48
    Top = 328
    ParamData = <
      item
        Name = 'CPF'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsrUsuarioLogado: TDataSource
    DataSet = qryUsuarioLogado
    Left = 112
    Top = 328
  end
end

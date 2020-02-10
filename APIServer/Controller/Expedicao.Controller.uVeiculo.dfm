object VeiculoController: TVeiculoController
  OldCreateOrder = False
  Height = 324
  Width = 374
  object tblVeiculo: TFDQuery
    Connection = DataModule1.cnMysql
    SQL.Strings = (
      'SELECT * FROM `PD2.0`.veiculo')
    Left = 143
    Top = 28
    object tblVeiculoVEICULOOID: TFDAutoIncField
      FieldName = 'VEICULOOID'
      Origin = 'VEICULOOID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object tblVeiculoMARCA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'MARCA'
      Origin = 'MARCA'
      Size = 50
    end
    object tblVeiculoMODELO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'MODELO'
      Origin = 'MODELO'
      Size = 50
    end
    object tblVeiculoPLACA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'PLACA'
      Origin = 'PLACA'
      FixedChar = True
      Size = 8
    end
    object tblVeiculoRENAVAM: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'RENAVAM'
      Origin = 'RENAVAM'
      Size = 30
    end
    object tblVeiculoCOR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COR'
      Origin = 'COR'
    end
    object tblVeiculoANO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ANO'
      Origin = 'ANO'
      FixedChar = True
      Size = 4
    end
  end
  object tblVeiculoCombustivel: TFDQuery
    MasterSource = dsVeiculoMasterCombustivel
    MasterFields = 'VEICULOOID'
    DetailFields = 'VEICULOID'
    Connection = DataModule1.cnMysql
    FetchOptions.AssignedValues = [evDetailCascade, evDetailServerCascade]
    FetchOptions.DetailCascade = True
    FetchOptions.DetailServerCascade = True
    SQL.Strings = (
      
        'SELECT * FROM `PD2.0`.veiculocombustivel WHERE VeiculoID = :Veic' +
        'uloOID')
    Left = 73
    Top = 189
    ParamData = <
      item
        Name = 'VEICULOOID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object tblVeiculoCombustivelVEICULOID: TIntegerField
      FieldName = 'VEICULOID'
      Origin = 'VEICULOID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tblVeiculoCombustivelCOMBUSTIVELID: TIntegerField
      FieldName = 'COMBUSTIVELID'
      Origin = 'COMBUSTIVELID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object tblVeiculoSeguro: TFDQuery
    MasterSource = dsVeiculoMasterSeguro
    MasterFields = 'VEICULOOID'
    DetailFields = 'VEICULOOID'
    Connection = DataModule1.cnMysql
    FetchOptions.AssignedValues = [evDetailCascade, evDetailServerCascade]
    FetchOptions.DetailCascade = True
    FetchOptions.DetailServerCascade = True
    SQL.Strings = (
      'SELECT * FROM `PD2.0`.seguroveiculo'
      'WHERE VEICULOOID = :VeiculoOID')
    Left = 231
    Top = 168
    ParamData = <
      item
        Name = 'VEICULOOID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object tblVeiculoSeguroSEGUROOID: TIntegerField
      FieldName = 'SEGUROOID'
      Origin = 'SEGUROOID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tblVeiculoSeguroVEICULOOID: TIntegerField
      FieldName = 'VEICULOOID'
      Origin = 'VEICULOOID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
  end
  object dsVeiculoMasterCombustivel: TDataSource
    AutoEdit = False
    DataSet = tblVeiculo
    Left = 88
    Top = 120
  end
  object tblSeguro: TFDQuery
    Connection = DataModule1.cnMysql
    SQL.Strings = (
      'SELECT * FROM `PD2.0`.seguro'
      'WHERE SeguroOID = :SeguroOID')
    Left = 231
    Top = 249
    ParamData = <
      item
        Name = 'SEGUROOID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object tblSeguroSEGUROOID: TFDAutoIncField
      FieldName = 'SEGUROOID'
      Origin = 'SEGUROOID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object tblSeguroSEGURADORAOID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'SEGURADORAOID'
      Origin = 'SEGURADORAOID'
    end
    object tblSeguroDATAINICIO: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'DATAINICIO'
      Origin = 'DATAINICIO'
    end
    object tblSeguroDATAFIM: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'DATAFIM'
      Origin = 'DATAFIM'
    end
    object tblSeguroCOBERTURA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COBERTURA'
      Origin = 'COBERTURA'
      Size = 1000
    end
  end
  object tblCombustivel: TFDQuery
    Connection = DataModule1.cnMysql
    SQL.Strings = (
      'SELECT * FROM `PD2.0`.combustivel'
      'WHERE CombustivelOID = :CombustivelOID')
    Left = 80
    Top = 245
    ParamData = <
      item
        Name = 'COMBUSTIVELOID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object tblCombustivelCOMBUSTIVELOID: TFDAutoIncField
      FieldName = 'COMBUSTIVELOID'
      Origin = 'COMBUSTIVELOID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object tblCombustivelDESCRICAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 100
    end
    object tblCombustivelVALOR: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Precision = 10
      Size = 2
    end
    object tblCombustivelUNIDADEMEDIDAOID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'UNIDADEMEDIDAOID'
      Origin = 'UNIDADEMEDIDAOID'
    end
  end
  object dsVeiculoMasterSeguro: TDataSource
    DataSet = tblVeiculo
    Left = 224
    Top = 104
  end
  object saVeiculo: TFDSchemaAdapter
    Left = 232
    Top = 56
  end
end

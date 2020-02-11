object RomaneioController: TRomaneioController
  OldCreateOrder = False
  Height = 155
  Width = 332
  object tblRomaneio: TFDQuery
    Connection = DataModule1.cnMysql
    SQL.Strings = (
      'SELECT * FROM `PD2.0`.romaneio')
    Left = 51
    Top = 90
    object tblRomaneioROMANEIOOID: TFDAutoIncField
      FieldName = 'ROMANEIOOID'
      Origin = 'ROMANEIOOID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object tblRomaneioVEICULOOID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'VEICULOOID'
      Origin = 'VEICULOOID'
    end
    object tblRomaneioCONDUTOROID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'CONDUTOROID'
      Origin = 'CONDUTOROID'
    end
    object tblRomaneioSAIDA: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'SAIDA'
      Origin = 'SAIDA'
    end
    object tblRomaneioRETORNO: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'RETORNO'
      Origin = 'RETORNO'
    end
    object tblRomaneioKMSAIDA: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'KMSAIDA'
      Origin = 'KMSAIDA'
      Precision = 10
      Size = 2
    end
    object tblRomaneioKMRETORNO: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'KMRETORNO'
      Origin = 'KMRETORNO'
      Precision = 10
      Size = 2
    end
    object tblRomaneioKMRODADO: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'KMRODADO'
      Origin = 'KMRODADO'
      Precision = 10
      Size = 2
    end
    object tblRomaneioFUNCIONARIOSAIDAOID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'FUNCIONARIOSAIDAOID'
      Origin = 'FUNCIONARIOSAIDAOID'
    end
    object tblRomaneioFUNCIONARIORETORNOOID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'FUNCIONARIORETORNOOID'
      Origin = 'FUNCIONARIORETORNOOID'
    end
  end
  object tblVeiculo: TFDQuery
    Connection = DataModule1.cnMysql
    SQL.Strings = (
      'SELECT * FROM `PD2.0`.veiculo')
    Left = 146
    Top = 87
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
end

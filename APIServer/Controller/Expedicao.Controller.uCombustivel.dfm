object CombustivelController: TCombustivelController
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  OnDestroy = DSServerModuleDestroy
  Height = 159
  Width = 239
  object tblCombustivel: TFDQuery
    SQL.Strings = (
      'SELECT * FROM combustivel')
    Left = 80
    Top = 24
    object tblCombustivelCOMBUSTIVELOID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'COMBUSTIVELOID'
      Origin = 'COMBUSTIVELOID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
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
end

object InfracaoController: TInfracaoController
  OldCreateOrder = False
  Height = 165
  Width = 226
  object tblInfracao: TFDQuery
    Connection = DataModule1.cnMysql
    SQL.Strings = (
      'SELECT * FROM `PD2.0`.infracao')
    Left = 82
    Top = 86
    object tblInfracaoINFRACAOOID: TFDAutoIncField
      FieldName = 'INFRACAOOID'
      Origin = 'INFRACAOOID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object tblInfracaoVEICULOOID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'VEICULOOID'
      Origin = 'VEICULOOID'
    end
    object tblInfracaoDATA: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'DATA'
      Origin = '`DATA`'
    end
    object tblInfracaoHORA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'HORA'
      Origin = 'HORA'
      FixedChar = True
      Size = 5
    end
    object tblInfracaoAUTOINFRACAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'AUTOINFRACAO'
      Origin = 'AUTOINFRACAO'
      FixedChar = True
      Size = 50
    end
    object tblInfracaoORGAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ORGAO'
      Origin = 'ORGAO'
      FixedChar = True
      Size = 50
    end
    object tblInfracaoVALOR: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Precision = 10
      Size = 2
    end
    object tblInfracaoAUTORINFRACAO: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'AUTORINFRACAO'
      Origin = 'AUTORINFRACAO'
    end
    object tblInfracaoTIPOINFRACAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'TIPOINFRACAO'
      Origin = 'TIPOINFRACAO'
      FixedChar = True
    end
  end
end

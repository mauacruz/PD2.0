object SeguroController: TSeguroController
  OldCreateOrder = False
  Height = 199
  Width = 293
  object tblSeguro: TFDQuery
    Connection = DataModule1.cnMysql
    SQL.Strings = (
      'SELECT * FROM seguro')
    Left = 98
    Top = 85
    object tblSeguroSEGUROOID: TFDAutoIncField
      FieldName = 'SEGUROOID'
      Origin = 'SEGUROOID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
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
  object tblSeguradora: TFDQuery
    Connection = DataModule1.cnMysql
    SQL.Strings = (
      'SELECT * FROM seguradora '
      'WHERE SeguradoraOID = :SeguradoraOID')
    Left = 169
    Top = 83
    ParamData = <
      item
        Name = 'SEGURADORAOID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object tblSeguradoraSEGURADORAOID: TFDAutoIncField
      FieldName = 'SEGURADORAOID'
      Origin = 'SEGURADORAOID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object tblSeguradoraDESCRICAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 100
    end
    object tblSeguradoraCNPJ: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      FixedChar = True
      Size = 14
    end
    object tblSeguradoraTELEFONE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 15
    end
    object tblSeguradoraCORRETOR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CORRETOR'
      Origin = 'CORRETOR'
      Size = 50
    end
  end
end

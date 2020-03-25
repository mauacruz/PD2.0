object SeguradoraController: TSeguradoraController
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  OnDestroy = DSServerModuleDestroy
  Height = 218
  Width = 407
  object tblSeguradora: TFDQuery
    SQL.Strings = (
      'SELECT * FROM seguradora')
    Left = 128
    Top = 98
    object tblSeguradoraSEGURADORAOID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'SEGURADORAOID'
      Required = True
    end
    object tblSeguradoraDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 100
    end
    object tblSeguradoraCNPJ: TStringField
      FieldName = 'CNPJ'
      FixedChar = True
      Size = 14
    end
    object tblSeguradoraTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 15
    end
    object tblSeguradoraCORRETOR: TStringField
      FieldName = 'CORRETOR'
      Size = 50
    end
  end
end

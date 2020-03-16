object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 307
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnListaSeguradora: TBitBtn
    Left = 24
    Top = 48
    Width = 105
    Height = 33
    Caption = 'Listar Seguradoras'
    TabOrder = 0
    OnClick = btnListaSeguradoraClick
  end
  object lstListaResultado: TListBox
    Left = 208
    Top = 32
    Width = 289
    Height = 241
    ItemHeight = 13
    TabOrder = 1
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Projetos\PD2.0\APIServer\database\libmysql.dll'
    Left = 72
    Top = 200
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=PD2.0 REMOTO'
      'Database=spiritmy_pd')
    Connected = True
    LoginPrompt = False
    Left = 160
    Top = 104
  end
  object tblCombustivel: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM `PD2.0`.combustivel')
    Left = 80
    Top = 120
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
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from usuario')
    Left = 144
    Top = 32
  end
end

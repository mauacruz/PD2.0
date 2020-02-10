object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 269
  Width = 382
  object cnMysql: TFDConnection
    ConnectionName = 'PD2.0'
    Params.Strings = (
      'ConnectionDef=PD2.0')
    Connected = True
    LoginPrompt = False
    Left = 183
    Top = 118
  end
  object MySqlDriver: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Users\mau\Documents\projetos\PD2.0\APIServer\libmysql.dll'
    Left = 143
    Top = 62
  end
end

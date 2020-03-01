object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 269
  Width = 382
  object cnMysql: TFDConnection
    ConnectionName = 'PD2.0'
    Params.Strings = (
      'Server=www.spirit.myscriptcase.com'
      'Database=spiritmy_pd20'
      'Password=pd20user'
      'User_Name=spiritmy_pduser'
      'ConnectionDef=PD2.0')
    LoginPrompt = False
    Left = 183
    Top = 118
  end
  object MySqlDriver: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Projetos\PD2.0\APIServer\database\libmysql.dll'
    Left = 143
    Top = 62
  end
end

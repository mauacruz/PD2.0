object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 182
  Width = 231
  object cnSeguradora: TFDConnection
    Params.Strings = (
      'Database=D:\Projetos\PD2.0\APIServer\database\seguradora'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    AfterConnect = cnSeguradoraAfterConnect
    Left = 88
    Top = 56
  end
end

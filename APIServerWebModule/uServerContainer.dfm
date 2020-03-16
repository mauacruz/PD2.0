object ServerContainer1: TServerContainer1
  OldCreateOrder = False
  Height = 271
  Width = 651
  object DSServer1: TDSServer
    Left = 96
    Top = 11
  end
  object dsscCombustivel: TDSServerClass
    OnGetClass = dsscCombustivelGetClass
    Server = DSServer1
    Left = 280
    Top = 11
  end
  object dsscInfracao: TDSServerClass
    OnGetClass = dsscInfracaoGetClass
    Server = DSServer1
    Left = 272
    Top = 80
  end
  object dsscRomaneio: TDSServerClass
    OnGetClass = dsscRomaneioGetClass
    Server = DSServer1
    Left = 383
    Top = 8
  end
  object dsscSeguradora: TDSServerClass
    OnGetClass = dsscSeguradoraGetClass
    Server = DSServer1
    Left = 383
    Top = 80
  end
  object dsscVeiculo: TDSServerClass
    OnGetClass = dsscVeiculoGetClass
    Server = DSServer1
    Left = 503
    Top = 80
  end
  object dsscSeguro: TDSServerClass
    OnGetClass = dsscSeguroGetClass
    Server = DSServer1
    Left = 272
    Top = 144
  end
end

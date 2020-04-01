object ServerContainer1: TServerContainer1
  OldCreateOrder = False
  Height = 347
  Width = 574
  object DSServer1: TDSServer
    Left = 96
    Top = 11
  end
  object DSTCPServerTransport1: TDSTCPServerTransport
    Server = DSServer1
    Filters = <>
    Left = 96
    Top = 73
  end
  object DSHTTPService1: TDSHTTPService
    HttpPort = 8080
    OnFormatResult = DSHTTPService1FormatResult
    Server = DSServer1
    Filters = <>
    Left = 96
    Top = 135
  end
  object dsscCombustivel: TDSServerClass
    OnGetClass = dsscCombustivelGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 280
    Top = 11
  end
  object dsscInfracao: TDSServerClass
    OnGetClass = dsscInfracaoGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 272
    Top = 80
  end
  object dsscRomaneio: TDSServerClass
    OnGetClass = dsscRomaneioGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 384
    Top = 8
  end
  object dsscSeguradora: TDSServerClass
    OnGetClass = dsscSeguradoraGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 392
    Top = 80
  end
  object dsscVeiculo: TDSServerClass
    OnGetClass = dsscVeiculoGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 488
    Top = 72
  end
  object dsscSeguro: TDSServerClass
    OnGetClass = dsscSeguroGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 272
    Top = 144
  end
end

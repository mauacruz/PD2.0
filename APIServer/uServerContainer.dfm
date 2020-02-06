object ServerContainer1: TServerContainer1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
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
    Server = DSServer1
    Filters = <>
    Left = 96
    Top = 135
  end
  object dsscCombustivel: TDSServerClass
    OnGetClass = dsscCombustivelGetClass
    Server = DSServer1
    Left = 280
    Top = 11
  end
  object DSServerMetaDataProvider1: TDSServerMetaDataProvider
    Server = DSServer1
    Left = 88
    Top = 216
  end
  object DSProxyGenerator1: TDSProxyGenerator
    MetaDataProvider = DSServerMetaDataProvider1
    TargetUnitName = 'ServerFunctions.js'
    TargetDirectory = 'js'
    Writer = 'Java Script REST'
    Left = 200
    Top = 208
  end
  object DSHTTPServiceFileDispatcher1: TDSHTTPServiceFileDispatcher
    Service = DSHTTPService1
    WebFileExtensions = <
      item
        MimeType = 'text/css'
        Extensions = 'css'
      end
      item
        MimeType = 'text/html'
        Extensions = 'html;htm'
      end
      item
        MimeType = 'text/javascript'
        Extensions = 'js'
      end
      item
        MimeType = 'image/jpeg'
        Extensions = 'jpeg;jpg'
      end
      item
        MimeType = 'image/x-png'
        Extensions = 'png'
      end>
    WebDirectories = <
      item
        DirectoryAction = dirInclude
        DirectoryMask = '*'
      end
      item
        DirectoryAction = dirExclude
        DirectoryMask = '/templates/*'
      end>
    Left = 280
    Top = 240
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
    Left = 384
    Top = 8
  end
  object dsscSeguradora: TDSServerClass
    OnGetClass = dsscSeguradoraGetClass
    Server = DSServer1
    Left = 392
    Top = 80
  end
  object dsscVeiculo: TDSServerClass
    OnGetClass = dsscVeiculoGetClass
    Server = DSServer1
    Left = 488
    Top = 72
  end
end

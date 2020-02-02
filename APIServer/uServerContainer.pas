unit uServerContainer;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSTCPServerTransport,
    Datasnap.DSHTTPCommon, Datasnap.DSHTTP,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSClientMetadata, Datasnap.DSProxyJavaScript,
  IPPeerServer, IPPeerAPI, Datasnap.DSAuth, Datasnap.DSMetadata,
  Datasnap.DSServerMetadata,
  Expedicao.Controller.uCombustivel,
  Expedicao.Controller.uInfracao,
  Expedicao.Controller.uRomaneio,
  Expedicao.Controller.uSeguradora,
  Expedicao.Controller.uVeiculo;

type
  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSHTTPService1: TDSHTTPService;
    DSProxyGenerator1: TDSProxyGenerator;
    DSServerMetaDataProvider1: TDSServerMetaDataProvider;
    DSHTTPServiceFileDispatcher1: TDSHTTPServiceFileDispatcher;
    dsscCombustivel: TDSServerClass;
    dsscInfracao: TDSServerClass;
    dsscRomaneio: TDSServerClass;
    dsscSeguradora: TDSServerClass;
    dsscVeiculo: TDSServerClass;
    procedure dsscCombustivelGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DataModuleCreate(Sender: TObject);
    procedure dsscRomaneioGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsscInfracaoGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsscSeguradoraGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsscVeiculoGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
  end;

var
  ServerContainer1: TServerContainer1;

implementation
uses
  uServerMethods,
  Expedicao.Services.uExpedicaoFactory;

{$R *.dfm}


procedure TServerContainer1.DataModuleCreate(Sender: TObject);
var
  lFactory: TExpedicaoFactory;
begin
  //write the JavaScript proxy on startup
  DSProxyGenerator1.Write;

  //Injeta as classes de persistência nos Controllers
//  lFactory := TExpedicaoFactory.Create;



end;

procedure TServerContainer1.dsscCombustivelGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := Expedicao.Controller.uCombustivel.TCombustivelController;
end;

procedure TServerContainer1.dsscInfracaoGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := Expedicao.Controller.uInfracao.TInfracaoController;
end;

procedure TServerContainer1.dsscRomaneioGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := Expedicao.Controller.uRomaneio.TRomaneioController;
end;

procedure TServerContainer1.dsscSeguradoraGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := Expedicao.Controller.uSeguradora.TSeguradoraController;
end;

procedure TServerContainer1.dsscVeiculoGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := Expedicao.Controller.uVeiculo.TVeiculoController;
end;

end.


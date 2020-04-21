unit uServerContainer;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSClientMetadata, Datasnap.DSHTTPServiceProxyDispatcher,
  Datasnap.DSProxyJavaAndroid, Datasnap.DSProxyJavaBlackBerry,
  Datasnap.DSProxyObjectiveCiOS, Datasnap.DSProxyCsharpSilverlight,
  Datasnap.DSProxyFreePascal_iOS,
  IPPeerServer, IPPeerAPI, Datasnap.DSAuth, System.JSON, Data.DBXCommon,
  Datasnap.DSHTTP;

type
  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    dsscCombustivel: TDSServerClass;
    dsscInfracao: TDSServerClass;
    dsscRomaneio: TDSServerClass;
    dsscSeguradora: TDSServerClass;
    dsscVeiculo: TDSServerClass;
    dsscSeguro: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsscCombustivelGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsscRomaneioGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsscInfracaoGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsscSeguradoraGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsscVeiculoGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsscSeguroGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

function DSServer: TDSServer;

implementation

{$R *.dfm}

uses
  uServerMethods,

  Expedicao.Controller.uCombustivel,
  Expedicao.Controller.uInfracao,
  Expedicao.Controller.uRomaneio,
  Expedicao.Controller.uVeiculo,
  Expedicao.Controller.uSeguradora,
  Expedicao.Controller.uSeguro;


var
  FModule: TComponent;
  FDSServer: TDSServer;

function DSServer: TDSServer;
begin
  Result := FDSServer;
end;

constructor TServerContainer1.Create(AOwner: TComponent);
begin
  inherited;
  FDSServer := DSServer1;
end;

destructor TServerContainer1.Destroy;
begin
  inherited;
  FDSServer := nil;
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

procedure TServerContainer1.dsscSeguroGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := Expedicao.Controller.uSeguro.TSeguroController;
end;

procedure TServerContainer1.dsscVeiculoGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := Expedicao.Controller.uVeiculo.TVeiculoController;
end;

procedure TServerContainer1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := uServerMethods.TServerMethods1;
end;

initialization
  FModule := TServerContainer1.Create(nil);
finalization
  FModule.Free;
end.


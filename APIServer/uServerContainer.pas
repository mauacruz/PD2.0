unit uServerContainer;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSHTTPCommon, Datasnap.DSHTTP,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSClientMetadata, Datasnap.DSProxyJavaScript,
  IPPeerServer, IPPeerAPI, Datasnap.DSAuth, Datasnap.DSMetadata, System.JSON,
  Data.DBXCommon, Datasnap.DSServerMetadata,

  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  uDataModule;


type
  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSHTTPService1: TDSHTTPService;
    dsscCombustivel: TDSServerClass;
    dsscInfracao: TDSServerClass;
    dsscRomaneio: TDSServerClass;
    dsscSeguradora: TDSServerClass;
    dsscVeiculo: TDSServerClass;
    dsscSeguro: TDSServerClass;
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
    procedure DSHTTPService1FormatResult(Sender: TObject;
      var ResultVal: TJSONValue; const Command: TDBXCommand;
      var Handled: Boolean);
    procedure dsscSeguroGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
  end;

var
  ServerContainer1: TServerContainer1;

implementation
uses
//  Expedicao.Services.uExpedicaoFactory,
  Expedicao.Controller.uCombustivel,
  Expedicao.Controller.uInfracao,
  Expedicao.Controller.uRomaneio,
  Expedicao.Controller.uVeiculo,
  Expedicao.Controller.uSeguradora,
  Expedicao.Controller.uSeguro;



{$R *.dfm}


procedure TServerContainer1.DSHTTPService1FormatResult(Sender: TObject;
  var ResultVal: TJSONValue; const Command: TDBXCommand; var Handled: Boolean);
var
  ValueJSONPuro: TJSONValue;
begin
  ValueJSONPuro := ResultVal;
  try
    ResultVal := TJSONArray(ValueJSONPuro).Remove(0);
  finally
    ValueJSONPuro.Free;
  end;
  Handled := True;
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

end.


unit Expedicao.Controller.uVeiculo;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON;

type
  TVeiculoController = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function getVeiculos: TJSONValue;
    function getVeiculo(ID: TJSONNumber): TJSONValue;
    function updateVeiculo(Veiculos: TJSONValue): TJSONValue;
    function insertVeiculo(Veiculos: TJSONValue): TJSONValue;
    function deleteVeiculo(Veiculos: TJSONValue): TJSONValue;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TVeiculoController }

function TVeiculoController.deleteVeiculo(Veiculos: TJSONValue): TJSONValue;
begin

end;

function TVeiculoController.getVeiculo(ID: TJSONNumber): TJSONValue;
begin

end;

function TVeiculoController.getVeiculos: TJSONValue;
begin

end;

function TVeiculoController.insertVeiculo(Veiculos: TJSONValue): TJSONValue;
begin

end;

function TVeiculoController.updateVeiculo(Veiculos: TJSONValue): TJSONValue;
begin

end;

end.


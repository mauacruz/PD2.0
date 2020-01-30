unit Expedicao.Controller.uCombustivel;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON;

type
  TCombustivelController = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function getCombustiveiss: TJSONValue;
    function getCombustivel(ID: TJSONNumber): TJSONValue;
    function updateCombustivel(Combustiveis: TJSONValue): TJSONValue;
    function insertCombustivel(Combustiveis: TJSONValue): TJSONValue;
    function deleteCombustivel(Combustiveis: TJSONValue): TJSONValue;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TCombustivelController }

function TCombustivelController.deleteCombustivel(
  Combustiveis: TJSONValue): TJSONValue;
begin

end;

function TCombustivelController.getCombustiveiss: TJSONValue;
begin

end;

function TCombustivelController.getCombustivel(ID: TJSONNumber): TJSONValue;
begin

end;

function TCombustivelController.insertCombustivel(
  Combustiveis: TJSONValue): TJSONValue;
begin

end;

function TCombustivelController.updateCombustivel(
  Combustiveis: TJSONValue): TJSONValue;
begin

end;

end.


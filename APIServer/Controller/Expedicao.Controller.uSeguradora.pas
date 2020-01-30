unit Expedicao.Controller.uSeguradora;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON,
  Expedicao.Interfaces.uSeguradoraPersistencia;

type
  TSeguradoraController = class(TDSServerModule)
  private
    { Private declarations }
    FSeguradoraPersistencia: ISeguradoraPersistencia;
  public
    { Public declarations }
    function getSeguradoras: TJSONValue;
    function getSeguradora(ID: TJSONNumber): TJSONValue;
    function updateSeguradora(Seguradoras: TJSONValue): TJSONValue;
    function insertSeguradora(Seguradoras: TJSONValue): TJSONValue;
    function deleteSeguradora(Seguradoras: TJSONValue): TJSONValue;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TSeguradoraController }

function TSeguradoraController.deleteSeguradora(
  Seguradoras: TJSONValue): TJSONValue;
begin

end;

function TSeguradoraController.getSeguradora(ID: TJSONNumber): TJSONValue;
begin

end;

function TSeguradoraController.getSeguradoras: TJSONValue;
begin

end;

function TSeguradoraController.insertSeguradora(
  Seguradoras: TJSONValue): TJSONValue;
begin

end;

function TSeguradoraController.updateSeguradora(
  Seguradoras: TJSONValue): TJSONValue;
begin

end;

end.


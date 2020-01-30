unit Expedicao.Controller.uRomaneio;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON;

type
  TRomaneioController = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function getRomaneios: TJSONValue;
    function getRomaneio(ID: TJSONNumber): TJSONValue;
    function updateRomaneio(Romaneios: TJSONValue): TJSONValue;
    function insertRomaneio(Romaneios: TJSONValue): TJSONValue;
    function deleteRomaneio(Romaneios: TJSONValue): TJSONValue;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TRomaneioController }

function TRomaneioController.deleteRomaneio(Romaneios: TJSONValue): TJSONValue;
begin

end;

function TRomaneioController.getRomaneio(ID: TJSONNumber): TJSONValue;
begin

end;

function TRomaneioController.getRomaneios: TJSONValue;
begin

end;

function TRomaneioController.insertRomaneio(Romaneios: TJSONValue): TJSONValue;
begin

end;

function TRomaneioController.updateRomaneio(Romaneios: TJSONValue): TJSONValue;
begin

end;

end.


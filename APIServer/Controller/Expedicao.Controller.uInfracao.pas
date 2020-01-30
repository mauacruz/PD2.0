unit Expedicao.Controller.uInfracao;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON;

type
  TInfracaoController = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }

    function getInfracoes: TJSONValue;
    function getInfracao(ID: TJSONNumber): TJSONValue;
    function updateInfracao(Infracoes: TJSONValue): TJSONValue;
    function insertInfracao(Infracoes: TJSONValue): TJSONValue;
    function deleteInfracao(Infracoes: TJSONValue): TJSONValue;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TInfracaoController }

function TInfracaoController.deleteInfracao(
  Infracoes: TJSONValue): TJSONValue;
begin

end;

function TInfracaoController.getInfracao(ID: TJSONNumber): TJSONValue;
begin

end;

function TInfracaoController.getInfracoes: TJSONValue;
begin

end;

function TInfracaoController.insertInfracao(
  Infracoes: TJSONValue): TJSONValue;
begin

end;

function TInfracaoController.updateInfracao(
  Infracoes: TJSONValue): TJSONValue;
begin

end;

end.


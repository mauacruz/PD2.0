unit Expedicao.Controller.uRomaneio;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON,
  Expedicao.Interfaces.uRomaneioPersistencia;

type
  TRomaneioController = class(TDSServerModule)
  private
    { Private declarations }
    FRomaneioPersistencia: IRomaneioPersistencia;
  public
    { Public declarations }

    procedure SetRomaneioPersistencia(pRomaneioPersistencia: IRomaneioPersistencia);

    function Romaneios: TJSONValue;
    function Romaneio(ID: Integer): TJSONValue;
    function updateRomaneio(Romaneio: TJSONObject): TJSONValue;
    function acceptRomaneio(Romaneio: TJSONObject): TJSONValue;
    function cancelRomaneio(ID: Integer): TJSONValue;
  end;

implementation
uses
  REST.jSON,
  System.Generics.Collections,
  Expedicao.Services.uExpedicaoFactory,
  Expedicao.Models.uRomaneio;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TRomaneioController }

function TRomaneioController.cancelRomaneio(Romaneio: TJSONObject): TJSONValue;
var
  lListaRomaneio: TList<TRomaneio>;
begin

  if FRomaneioPersistencia.ExcluirRomaneio(ID) then
  begin
    lListaRomaneio := FRomaneioPersistencia.ObterListaRomaneio;
    try
      Result := TJSONString.Create('Total de Romaneios cadastradas: ' +
        lListaRomaneio.Count.ToString);

    finally
      lListaRomaneio.Free;
    end;
  end
  else
    Result := TJSONString.Create('Romaneio não encontrado!');

end;

function TRomaneioController.Romaneio(ID: Integer): TJSONValue;
var
  lRomaneio: TRomaneio;
  lArrResult: TJSONArray;
  lJSonObj: TJSONObject;
begin
  lArrResult := TJSONArray.Create;
  lRomaneio := FRomaneioPersistencia.ObterRomaneio(ID);

  if Assigned(lRomaneio) then
    Result := TJson.ObjectToJsonObject(lRomaneio)
  else
    Result := TJSONString.Create('Romaneio não encontrado!');

end;

function TRomaneioController.Romaneios: TJSONValue;
var
  lListaRomaneio: TList<TRomaneio>;
  lRomaneio: TRomaneio;
  lArrResult: TJSONArray;
  lJSonObj: TJSONObject;
begin
  lArrResult := TJSONArray.Create;
  lListaRomaneio := FRomaneioPersistencia.ObterListaRomaneio;

  try
    for lRomaneio in lListaRomaneio do
    begin
      lJSonObj := TJSon.ObjectToJSonObject(lRomaneio);
      lArrResult.AddElement(lJSonObj);

    end;
    Result := lArrResult;
  finally
    lListaRomaneio.Free;
  end;

end;

procedure TRomaneioController.SetRomaneioPersistencia(
  pRomaneioPersistencia: IRomaneioPersistencia);
begin
  FRomaneioPersistencia := pRomaneioPersistencia;
end;

function TRomaneioController.acceptRomaneio(Romaneio: TJSONObject): TJSONValue;
var
  lRomaneio: TRomaneio;
begin
  lRomaneio := TJson.JsonToObject<TRomaneio>(Romaneio);
  if FRomaneioPersistencia.IncluirRomaneio(lRomaneio) then
    Result := TJson.ObjectToJsonObject(
      FRomaneioPersistencia.ObterRomaneio(lRomaneio.RomaneioOID))

  else
    Result := TJSONString.Create('Erro ao incluir o romaneio!')

end;

function TRomaneioController.updateRomaneio(Romaneio: TJSONObject): TJSONValue;
var
  lRomaneio: TRomaneio;
begin
  lRomaneio := TJson.JsonToObject<TRomaneio>(Romaneio);
  if FRomaneioPersistencia.AlterarRomaneio(lRomaneio) then
    Result := TJson.ObjectToJsonObject(
      FRomaneioPersistencia.ObterRomaneio(lRomaneio.RomaneioOID))
  else
    Result := TJSONString.Create('Erro ao alterar a romaneio!')


end;

end.


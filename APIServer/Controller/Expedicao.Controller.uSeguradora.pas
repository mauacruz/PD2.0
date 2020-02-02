unit Expedicao.Controller.uSeguradora;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  Expedicao.Interfaces.uSeguradoraPersistencia, System.JSON;

type
  TSeguradoraController = class(TDSServerModule)
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FSeguradoraPersistencia: ISeguradoraPersistencia;
  public
    { Public declarations }

    procedure SetSeguradoraPersistencia(pSeguradoraPersistencia: ISeguradoraPersistencia);

    function Seguradoras: TJSONValue;
    function Seguradora(ID: Integer): TJSONValue;
    function updateSeguradoras(Seguradora: TJSONObject): TJSONValue;
    function acceptSeguradoras(Seguradora: TJSONObject): TJSONValue;
    function cancelSeguradoras(ID: Integer): TJSONValue;
  end;

implementation
uses
  REST.jSON,
  System.Generics.Collections,
  Expedicao.Services.uExpedicaoFactory,
  Expedicao.Models.uSeguradora;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TSeguradoraController }

function TSeguradoraController.cancelSeguradoras(
  ID: Integer): TJSONValue;
var
  lListaSeguradora: TList<TSeguradora>;
begin

  if FSeguradoraPersistencia.ExcluirSeguradora(ID) then
  begin
    lListaSeguradora := FSeguradoraPersistencia.ObterListaSeguradora;
    try
      Result := TJSONString.Create('Total de Seguradoras cadastradas: ' +
        lListaSeguradora.Count.ToString);

    finally
      lListaSeguradora.Free;
    end;
  end
  else
    Result := TJSONString.Create('Seguradora não encontrada!');

end;

procedure TSeguradoraController.DSServerModuleCreate(Sender: TObject);
var
  lFActory: TExpedicaoFactory;
begin
  //TODO: Confirmar como se faz a injeção de dependencia - Em que momento o DSServerModule é instanciado?
  lFActory := TExpedicaoFactory.Create;
  try
    FSeguradoraPersistencia := lFActory.ObterSeguradoraPersistencia(tpMock);
  finally
    lFActory.Free;
  end;
end;

function TSeguradoraController.Seguradora(ID: Integer): TJSONValue;
var
  lSeguradora: TSeguradora;
  lArrResult: TJSONArray;
  lJSonObj: TJSONObject;
begin
  lArrResult := TJSONArray.Create;
  lSeguradora := FSeguradoraPersistencia.ObterSeguradora(ID);

  if Assigned(lSeguradora) then
    Result := TJson.ObjectToJsonObject(lSeguradora)
  else
    Result := TJSONString.Create('Seguradora não encontrada!');

end;

function TSeguradoraController.Seguradoras: TJSONValue;
var
  lListaSeguradora: TList<TSeguradora>;
  lSeguradora: TSeguradora;
  lArrResult: TJSONArray;
  lJSonObj: TJSONObject;
begin
  lArrResult := TJSONArray.Create;
  lListaSeguradora := FSeguradoraPersistencia.ObterListaSeguradora;

  try
    for lSeguradora in lListaSeguradora do
    begin
      lJSonObj := TJSon.ObjectToJSonObject(lSeguradora);
      lArrResult.AddElement(lJSonObj);

    end;
    Result := lArrResult;
  finally
    lListaSeguradora.Free;
  end;
end;

function TSeguradoraController.acceptSeguradoras(
  Seguradora: TJSONObject): TJSONValue;
var
  lSeguradora: TSeguradora;
begin
  lSeguradora := TJson.JsonToObject<TSeguradora>(Seguradora);
  if FSeguradoraPersistencia.IncluirSeguradora(lSeguradora) then
    Result := TJson.ObjectToJsonObject(
      FSeguradoraPersistencia.ObterSeguradora(lSeguradora.SeguradoraOID))

  else
    Result := TJSONString.Create('Erro ao incluir a seguradora!')
end;

procedure TSeguradoraController.SetSeguradoraPersistencia(
  pSeguradoraPersistencia: ISeguradoraPersistencia);
begin
  FSeguradoraPersistencia := pSeguradoraPersistencia;
end;

function TSeguradoraController.updateSeguradoras(
  Seguradora: TJSONObject): TJSONValue;
var
  lSeguradora: TSeguradora;
begin
  lSeguradora := TJson.JsonToObject<TSeguradora>(Seguradora);
  if FSeguradoraPersistencia.AlterarSeguradora(lSeguradora) then
    Result := TJson.ObjectToJsonObject(
      FSeguradoraPersistencia.ObterSeguradora(lSeguradora.SeguradoraOID))
  else
    Result := TJSONString.Create('Erro ao alterar a seguradora!')
end;

end.


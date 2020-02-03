unit Expedicao.Controller.uCombustivel;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON, Expedicao.Interfaces.uCombustivelPersistencia;

type
  TCombustivelController = class(TDSServerModule)
  private
    { Private declarations }
    FCombustivelPersistencia: ICombustivelPersistencia;
  public
    { Public declarations }

    procedure setCombustivelPersistencia(pCombustivelPersistencia: ICombustivelPersistencia);

    function Combustiveis: TJSONValue;
    function Combustivel(ID: Integer): TJSONValue;
    function updateCombustiveis(Combustivel: TJSONValue): TJSONValue;
    function acceptCombustiveis(Combustivel: TJSONValue): TJSONValue;
    function cancelCombustiveis(ID: Integer): TJSONValue;
  end;

implementation
uses
  REST.jSON,
  System.Generics.Collections,
  Expedicao.Services.uExpedicaoFactory,
  Expedicao.Models.uCombustivel;


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TCombustivelController }

function TCombustivelController.cancelCombustiveis(
  ID: Integer): TJSONValue;
var
  lListaCombustivel: TList<TCombustivel>;
begin
  if FCombustivelPersistencia.ExcluirCombustivel(ID) then
  begin
    lListaCombustivel := FCombustivelPersistencia.ObterListaCombustivel;
    try
      Result := TJSONString.Create('Total de Combustíveis cadastrados: ' +
        lListaCombustivel.Count.ToString);

    finally
      lListaCombustivel.Free;
    end;
  end
  else
    Result := TJSONString.Create('Combustível não encontrado!');

end;

function TCombustivelController.Combustiveis: TJSONValue;
var
  lListaCombustivel: TList<TCombustivel>;
  lCombustivel: TCombustivel;
  lArrResult: TJSONArray;
  lJSonObj: TJSONObject;
begin
  lArrResult := TJSONArray.Create;
  lListaCombustivel := FCombustivelPersistencia.ObterListaCombustivel;

  try
    for lCombustivel in lListaCombustivel do
    begin
      lJSonObj := TJSon.ObjectToJSonObject(lCombustivel);
      lArrResult.AddElement(lJSonObj);

    end;
    Result := lArrResult;
  finally
    lListaCombustivel.Free;
  end;

end;


function TCombustivelController.Combustivel(ID: Integer): TJSONValue;
var
  lCombustivel: TCombustivel;
  lArrResult: TJSONArray;
  lJSonObj: TJSONObject;
begin
  lArrResult := TJSONArray.Create;
  lCombustivel := FCombustivelPersistencia.ObterCombustivel(ID);

  if Assigned(lCombustivel) then
    Result := TJson.ObjectToJsonObject(lSeguradora)
  else
    Result := TJSONString.Create('Combustível não encontrado!');

end;

procedure TCombustivelController.setCombustivelPersistencia(
  pCombustivelPersistencia: ICombustivelPersistencia);
begin
  FCombustivelPersistencia := pCombustivelPersistencia;
end;

function TCombustivelController.acceptCombustiveis(
  Combustivel: TJSONValue): TJSONValue;
var
  lCombustivel: TCombustivel;
begin
  lCombustivel := TJson.JsonToObject<TCombustivel>(Combustivel);
  if FCombustivelPersistencia.IncluirCombustivel(lCombustivel) then
    Result := TJson.ObjectToJsonObject(
      FCombustivelPersistencia.ObterCombustivel(lCombustivel.CombustivelOID))

  else
    Result := TJSONString.Create('Erro ao incluir a Combustivel!')

end;

function TCombustivelController.updateCombustiveis(
  Combustivel: TJSONValue): TJSONValue;
var
  lCombustivel: TCombustivel;
begin
  lCombustivel := TJson.JsonToObject<TCombustivel>(Combustivel);
  if FCombustivelPersistencia.AlterarCombustivel(lCombustivel) then
    Result := TJson.ObjectToJsonObject(
      FCombustivelPersistencia.ObterCombustivel(lCombustivel.CombustivelOID))
  else
    Result := TJSONString.Create('Erro ao alterar o combustivel!')

end;

end.


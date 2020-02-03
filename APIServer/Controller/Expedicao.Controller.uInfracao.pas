unit Expedicao.Controller.uInfracao;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON,
  Expedicao.Interfaces.uInfracaoPersistencia;

type
  TInfracaoController = class(TDSServerModule)
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
     FInfracaoPersistencia: IInfracaoPersistencia;
  public
    { Public declarations }

    procedure SetInfracaoPersistencia(pInfracaoPersistencia: IInfracaoPersistencia);

    function Infracoes: TJSONValue;
    function Infracao(ID: Integer): TJSONValue;
    function updateInfracao(Infracao: TJSONObject): TJSONValue;
    function acceptInfracao(Infracao: TJSONObject): TJSONValue;
    function cancelInfracao(ID: Integer): TJSONValue;
  end;

implementation

uses
  REST.jSON,
  System.Generics.Collections,
  Expedicao.Services.uExpedicaoFactory,
  Expedicao.Models.uInfracao;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TInfracaoController }

function TInfracaoController.cancelInfracao(
  ID: Integer): TJSONValue;
var
  lListaInfracao: TList<TInfracao>;
begin

  if FInfracaoPersistencia.ExcluirInfracao(ID) then
  begin
    lListaInfracao := FInfracaoPersistencia.ObterListaInfracao;
    try
      Result := TJSONString.Create('Total de Infrações cadastradas: ' +
        lListaInfracao.Count.ToString);

    finally
      lListaInfracao.Free;
    end;
  end
  else
    Result := TJSONString.Create('Infração não encontrada!');

end;

procedure TInfracaoController.DSServerModuleCreate(Sender: TObject);
var
  lFActory: TExpedicaoFactory;
begin
  //TODO: Confirmar como se faz a injeção de dependencia - Em que momento o DSServerModule é instanciado?
  lFActory := TExpedicaoFactory.Create;
  try
    FInfracaoPersistencia := lFActory.ObterInfracaoPersistencia(tpMock);
  finally
    lFActory.Free;
  end;
end;

function TInfracaoController.Infracao(ID: Integer): TJSONValue;
var
  lInfracao: TInfracao;
  lArrResult: TJSONArray;
  lJSonObj: TJSONObject;
begin
  lArrResult := TJSONArray.Create;
  lInfracao := FInfracaoPersistencia.ObterInfracao(ID);

  if Assigned(lInfracao) then
    Result := TJson.ObjectToJsonObject(lInfracao)
  else
    Result := TJSONString.Create('Infração não encontrada!');

end;

function TInfracaoController.Infracoes: TJSONValue;
var
  lListaInfracao: TList<TInfracao>;
  lInfracao: TInfracao;
  lArrResult: TJSONArray;
  lJSonObj: TJSONObject;
begin
  lArrResult := TJSONArray.Create;
  lListaInfracao := FInfracaoPersistencia.ObterListaInfracao;

  try
    for lInfracao in lListaInfracao do
    begin
      lJSonObj := TJSon.ObjectToJSonObject(lInfracao);
      lArrResult.AddElement(lJSonObj);

    end;
    Result := lArrResult;
  finally
    lListaInfracao.Free;
  end;

end;

procedure TInfracaoController.SetInfracaoPersistencia(
  pInfracaoPersistencia: IInfracaoPersistencia);
begin
  FInfracaoPersistencia := pInfracaoPersistencia;
end;

function TInfracaoController.acceptInfracao(
  Infracao: TJSONObject): TJSONValue;
var
  lInfracao: TInfracao;
begin
  lInfracao := TJson.JsonToObject<TInfracao>(Infracao);
  if FInfracaoPersistencia.IncluirInfracao(lInfracao) then
    Result := TJson.ObjectToJsonObject(
      FInfracaoPersistencia.ObterInfracao(lInfracao.InfracaoOID))

  else
    Result := TJSONString.Create('Erro ao incluir a infração!')

end;

function TInfracaoController.updateInfracao(
  Infracao: TJSONObject): TJSONValue;
var
  lInfracao: TInfracao;
begin
  lInfracao := TJson.JsonToObject<TInfracao>(Infracao);
  if FInfracaoPersistencia.AlterarInfracao(lInfracao) then
    Result := TJson.ObjectToJsonObject(
      FInfracaoPersistencia.ObterInfracao(lInfracao.InfracaoOID))
  else
    Result := TJSONString.Create('Erro ao alterar a infração!')

end;

end.


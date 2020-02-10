unit Expedicao.Controller.uInfracao;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  uDataModule,
  Expedicao.Models.uInfracao;


type
  TInfracaoController = class(TDSServerModule)
    tblInfracao: TFDQuery;
    tblInfracaoINFRACAOOID: TFDAutoIncField;
    tblInfracaoVEICULOOID: TIntegerField;
    tblInfracaoDATA: TDateTimeField;
    tblInfracaoHORA: TStringField;
    tblInfracaoAUTOINFRACAO: TStringField;
    tblInfracaoORGAO: TStringField;
    tblInfracaoVALOR: TBCDField;
    tblInfracaoAUTORINFRACAO: TIntegerField;
    tblInfracaoTIPOINFRACAO: TStringField;
  private
    { Private declarations }

    function ObterInfracaoSelecionada: TInfracao;
    function PesquisarInfracao(pInfracaoOID: Integer): Boolean;
    function GravarInfracao(pInfracao: TInfracao): Boolean;

  public
    { Public declarations }

    function Infracoes: TJSONValue;
    function Infracao(ID: Integer): TJSONValue;
    function updateInfracao(Infracao: TJSONObject): TJSONValue;
    function acceptInfracao(Infracao: TJSONObject): TJSONValue;
    function cancelInfracao(ID: Integer): TJSONValue;
  end;

implementation

uses
  REST.jSON;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TInfracaoController }

function TInfracaoController.ObterInfracaoSelecionada: TInfracao;
begin
  Result := TInfracao.Create;
  REsult.InfracaoOID := tblInfracaoInfracaoOID.AsInteger;
  Result.VeiculoOID  := tblInfracaoVeiculoOID.AsInteger;
  Result.Data := tblInfracaoData.AsDateTime;
  Result.Hora := tblInfracaoHora.AsString;
  Result.AutoInfracao := tblInfracaoAutoInfracao.AsString;
  Result.Orgao := tblInfracaoOrgao.AsString;
  Result.Valor := tblInfracaoValor.AsFloat;
  Result.AutorInfracao := tblInfracaoAutorInfracao.AsInteger;
  Result.TipoInfracao := tblInfracaoTipoInfracao.AsString;

end;

function TInfracaoController.PesquisarInfracao(
  pInfracaoOID: Integer): Boolean;
begin
  Result := False;

  with tblInfracao do
  begin
    if IsEmpty then
      Exit;

    Result := (Locate('INFRACAOOID', pInfracaoOID, []))
  end;

end;

function TInfracaoController.GravarInfracao(pInfracao: TInfracao): Boolean;
begin
  Result := False;

  tblInfracao.Open;
  if pInfracao.InfracaoOID <= 0 then
    tblInfracao.Append
  else
  begin
    if not PesquisarInfracao(pInfracao.InfracaoOID) then
     Exit
    else
     tblInfracao.Edit;
  end;

  tblInfracaoVeiculoOID.AsInteger := pInfracao.VeiculoOID;
  tblInfracaoDATA.AsDateTime := pInfracao.Data;
  tblInfracaoHORA.AsString := pInfracao.Hora;
  tblInfracaoAUTOINFRACAO.AsString := pInfracao.AutoInfracao;
  tblInfracaoORGAO.AsString := pInfracao.Orgao;
  tblInfracaoVALOR.AsFloat := pInfracao.Valor;
  tblInfracaoAUTORINFRACAO.AsInteger := pInfracao.AutorInfracao;
  tblInfracaoTIPOINFRACAO.AsString := pInfracao.TipoInfracao;

  tblInfracao.post;
  tblInfracao.Close;
  Result := true;

end;


function TInfracaoController.Infracoes: TJSONValue;
var
  lInfracao: TInfracao;
  lArrResult: TJSONArray;
  lJSonObj: TJSONObject;
begin

  with tblInfracao do
  begin
    Open;

    if IsEmpty then
    begin
      Result := TJSONString.Create('Infração não encontrada!');
      Close;
      Exit;
    end;

    lArrResult := TJSONArray.Create;
    while not Eof do
    begin
      lInfracao := ObterInfracaoSelecionada;
      lJSonObj := TJSon.ObjectToJSonObject(lInfracao);
      lArrResult.AddElement(lJSonObj);
      Next;
    end;
    Close;
    Result := lArrResult;
  end;
end;


function TInfracaoController.Infracao(ID: Integer): TJSONValue;
var
  lInfracao: TInfracao;
begin

  with tblInfracao do
  begin
    Open;

    if PesquisarInfracao(ID) then
    begin
      lInfracao := ObterInfracaoSelecionada;
      Result := TJson.ObjectToJsonObject(lInfracao);
      lInfracao.Free;
    end
    else
      Result := TJSONString.Create('Infração não encontrada!');

    Close;
  end;
end;

function TInfracaoController.acceptInfracao(
  Infracao: TJSONObject): TJSONValue;
var
  lInfracao: TInfracao;
begin
  lInfracao := TJson.JsonToObject<TInfracao>(Infracao);
  if lInfracao.InfracaoOID <> 0 then
  begin
    Result := TJSONString.Create('Infração já cadastrada. Inclusão cancelada!');
    Exit;
  end;

  if GravarInfracao(lInfracao) then
    Result := TJSONString.Create('Infracao gravada com sucesso!')
  else
    Result := TJSONString.Create('Erro ao gravar a infracao!')
end;

function TInfracaoController.updateInfracao(
  Infracao: TJSONObject): TJSONValue;
var
  lInfracao: TInfracao;
begin
  lInfracao := TJson.JsonToObject<TInfracao>(Infracao);

  tblInfracao.Open;
  if not PesquisarInfracao(lInfracao.InfracaoOID) then
  begin
    Result := TJSONString.Create('Infracao não encontrada!');
    Exit;
  end;
  tblInfracao.Close;

  if GravarInfracao(lInfracao) then
    Result := TJSONString.Create('Infracao gravada com sucesso!')
  else
    Result := TJSONString.Create('Erro ao gravar a Infracao!')
end;

function TInfracaoController.cancelInfracao(
  ID: Integer): TJSONValue;
begin
  tblInfracao.Open;
  if not PesquisarInfracao(ID) then
  begin
    Result := TJSONString.Create('Infracao não encontrada!');
    Exit;
  end;
  tblInfracao.Close;

  with tblInfracao do
  begin
    Open;
    PesquisarInfracao(ID);
    Delete;
    Close;
  end;
end;

end.


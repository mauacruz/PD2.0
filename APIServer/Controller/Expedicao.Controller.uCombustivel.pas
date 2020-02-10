unit Expedicao.Controller.uCombustivel;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON,
  Expedicao.Models.uCombustivel, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TCombustivelController = class(TDSServerModule)
    tblCombustivel: TFDQuery;
    tblCombustivelCOMBUSTIVELOID: TIntegerField;
    tblCombustivelDESCRICAO: TStringField;
    tblCombustivelVALOR: TBCDField;
    tblCombustivelUNIDADEMEDIDAOID: TIntegerField;

  private
    function GravarCombustivel(pCombustivel: TCombustivel): Boolean;
    function ObterCombustivelSelecionado: TCombustivel;
    function PesquisarCombustivel(pCombustivelOID: Integer): Boolean;

    { Private declarations }

  public
    { Public declarations }

    function Combustiveis: TJSONValue;
    function Combustivel(ID: Integer): TJSONValue;
    function updateCombustivel(Combustivel: TJSONObject): TJSONValue;
    function acceptCombustivel(Combustivel: TJSONObject): TJSONValue;
    function cancelCombustivel(ID: Integer): TJSONValue;
  end;

implementation
uses
  REST.jSON,
  uDataModule;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TCombustivelController }

function TCombustivelController.GravarCombustivel(
  pCombustivel: TCombustivel): Boolean;
begin
  Result := False;

  tblCombustivel.Open;
  if pCombustivel.CombustivelOID <= 0 then
    tblCombustivel.Append
  else
  begin
    if not PesquisarCombustivel(pCombustivel.CombustivelOID) then
     Exit
    else
     tblCombustivel.Edit;
  end;

  tblCombustivelDESCRICAO.AsString := pCombustivel.Descricao;
  tblCombustivelVALOR.AsFloat := pCombustivel.Valor;
  tblCombustivelUNIDADEMEDIDAOID.AsInteger := pCombustivel.UnidadeDeMedidaOID;

  tblCombustivel.post;
  tblCombustivel.Close;
  Result := true;

end;

function TCombustivelController.ObterCombustivelSelecionado: TCombustivel;
begin
  Result := TCombustivel.Create;

  Result.CombustivelOID := tblCombustivelCOMBUSTIVELOID.AsInteger;
  Result.Descricao  := tblCombustivelDESCRICAO.AsString;
  Result.Valor := tblCombustivelVALOR.AsFloat;
  Result.UnidadeDeMedidaOID := tblCombustivelUNIDADEMEDIDAOID.AsInteger;
end;

function TCombustivelController.PesquisarCombustivel(
  pCombustivelOID: Integer): Boolean;
begin
  Result := False;

  with tblCombustivel do
  begin
    if IsEmpty then
      Exit;

    Result := (Locate('COMBUSTIVELOID', pCombustivelOID, []))
  end;

end;

function TCombustivelController.Combustiveis: TJSONValue;
var
  lCombustivel: TCombustivel;
  lArrResult: TJSONArray;
  lJSonObj: TJSONObject;
begin
  with tblCombustivel do
  begin
    Open;

    if IsEmpty then
    begin
      Result := TJSONString.Create('Combustivel não encontrado!');
      Close;
      Exit;
    end;

    lArrResult := TJSONArray.Create;
    while not Eof do
    begin
      lCombustivel := ObterCombustivelSelecionado;
      lJSonObj := TJSon.ObjectToJSonObject(lCombustivel);
      lArrResult.AddElement(lJSonObj);
      Next;
    end;
    Close;
    Result := lArrResult;
  end;
end;

function TCombustivelController.Combustivel(ID: Integer): TJSONValue;
var
  lCombustivel: TCombustivel;
begin
  with tblCombustivel do
  begin
    Open;

    if PesquisarCombustivel(ID) then
    begin
      lCombustivel := ObterCombustivelSelecionado;
      Result := TJson.ObjectToJsonObject(lCombustivel);
      lCombustivel.Free;
    end
    else
      Result := TJSONString.Create('Combustivel não encontrado!');

    Close;
  end;
end;

function TCombustivelController.acceptCombustivel(
  Combustivel: TJSONObject): TJSONValue;
var
  lCombustivel: TCombustivel;
begin
  lCombustivel := TJson.JsonToObject<TCombustivel>(Combustivel);
  if lCombustivel.CombustivelOID <> 0 then
  begin
    Result := TJSONString.Create('Combustivel já cadastrado. Inclusão cancelada!');
    Exit;
  end;

  if GravarCombustivel(lCombustivel) then
    Result := TJSONString.Create('Combustivel gravado com sucesso!')
  else
    Result := TJSONString.Create('Erro ao gravar a combustivel!')

end;

function TCombustivelController.updateCombustivel(
  Combustivel: TJSONObject): TJSONValue;
var
  lCombustivel: TCombustivel;
begin
  lCombustivel := TJson.JsonToObject<TCombustivel>(Combustivel);

  tblCombustivel.Open;
  if not PesquisarCombustivel(lCombustivel.CombustivelOID) then
  begin
    Result := TJSONString.Create('Combustivel não encontrado!');
    Exit;
  end;
  tblCombustivel.Close;

  if GravarCombustivel(lCombustivel) then
    Result := TJSONString.Create('Combustivel gravado com sucesso!')
  else
    Result := TJSONString.Create('Erro ao gravar a combustivel!')

end;

function TCombustivelController.cancelCombustivel(ID: Integer): TJSONValue;
begin
  tblCombustivel.Open;
  if not PesquisarCombustivel(ID) then
  begin
    Result := TJSONString.Create('Combustivel não encontrado!');
    Exit;
  end;
  tblCombustivel.Close;

  with tblCombustivel do
  begin
    Open;
    PesquisarCombustivel(ID);
    Delete;
    Close;
  end;

end;

end.


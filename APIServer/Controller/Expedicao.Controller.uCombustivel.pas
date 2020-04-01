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
    procedure DSServerModuleCreate(Sender: TObject);
    procedure DSServerModuleDestroy(Sender: TObject);

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
       raise EDatabaseError.Create('Combustível não encontrado')
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
      Close;
      raise EDatabaseError.Create('Não existem combustíveis cadastrados!');
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
    try

      if PesquisarCombustivel(ID) then
      begin
        lCombustivel := ObterCombustivelSelecionado;
        Result := TJson.ObjectToJsonObject(lCombustivel);
        lCombustivel.Free;
      end
      else
        raise EDatabaseError.Create('Combustivel não encontrado!');

    finally
      Close;
    end;
  end;
end;

procedure TCombustivelController.DSServerModuleCreate(Sender: TObject);
begin
  tblCombustivel.Connection := datamodule1.ObterConnection;
end;

procedure TCombustivelController.DSServerModuleDestroy(Sender: TObject);
begin
  if Assigned(tblCombustivel.Connection) then
    tblCombustivel.Connection.Free;

end;

function TCombustivelController.acceptCombustivel(
  Combustivel: TJSONObject): TJSONValue;
var
  lCombustivel: TCombustivel;
begin
  lCombustivel := TJson.JsonToObject<TCombustivel>(Combustivel);
  try
    if lCombustivel.CombustivelOID <> 0 then
      raise EDatabaseError.Create('Combustivel já cadastrado. Inclusão cancelada!');

    if GravarCombustivel(lCombustivel) then
      Result := TJSONString.Create('Combustivel gravado com sucesso!');

  except
    on e:Exception do
      raise EDatabaseError.Create('Erro ao gravar a combustivel: ' + e.Message);
  end;
end;

function TCombustivelController.updateCombustivel(
  Combustivel: TJSONObject): TJSONValue;
var
  lCombustivel: TCombustivel;
begin
  lCombustivel := TJson.JsonToObject<TCombustivel>(Combustivel);

  try
    tblCombustivel.Open;
    if not PesquisarCombustivel(lCombustivel.CombustivelOID) then
      raise EDatabaseError.Create('Combustivel não encontrado!');

    tblCombustivel.Close;

    if GravarCombustivel(lCombustivel) then
      Result := TJSONString.Create('Combustivel gravado com sucesso!')
  except
    on e:Exception do
      raise EDatabaseError.Create('Erro ao gravar a combustivel: ' + e.Message);
  end;

end;

function TCombustivelController.cancelCombustivel(ID: Integer): TJSONValue;
var
  lQry: TFDQuery;
begin
  tblCombustivel.Open;
  if not PesquisarCombustivel(ID) then
    raise EDatabaseError.Create('Combustivel não encontrado!');

  tblCombustivel.Close;

  lQry := TFDQuery.Create(nil);
  try
    lQry.Connection := DataModule1.ObterConnection;
    lQry.SQL.Clear;
    lQry.SQL.Add('delete from Combustivel where COMBUSTIVELOID = :idCombustivel');
    lQry.ParamByName('idCombustivel').AsInteger := ID;
    lQry.ExecSQL;
  finally
    lQry.Connection.Free;
    lQry.Free;
  end;
end;

end.


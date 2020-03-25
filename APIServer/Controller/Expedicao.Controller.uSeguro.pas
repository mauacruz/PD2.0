unit Expedicao.Controller.uSeguro;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,

  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uDataModule, System.JSON,
  Expedicao.Models.uSeguro,
  Expedicao.Models.uSeguradora;


type
  TSeguroController = class(TDSServerModule)
    tblSeguro: TFDQuery;
    tblSeguroSEGUROOID: TFDAutoIncField;
    tblSeguroSEGURADORAOID: TIntegerField;
    tblSeguroDATAINICIO: TDateField;
    tblSeguroDATAFIM: TDateField;
    tblSeguroCOBERTURA: TStringField;
    tblSeguradora: TFDQuery;
    tblSeguradoraSEGURADORAOID: TFDAutoIncField;
    tblSeguradoraDESCRICAO: TStringField;
    tblSeguradoraCNPJ: TStringField;
    tblSeguradoraTELEFONE: TStringField;
    tblSeguradoraCORRETOR: TStringField;
    procedure DSServerModuleCreate(Sender: TObject);
    procedure DSServerModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    function GravarSeguro(pSeguro: TSeguro): Boolean;
    function ObterSeguroSelecionado: TSeguro;
    function PesquisarSeguro(pSeguroOID: Integer): Boolean;

  public
    { Public declarations }
    function Seguros: TJSONValue;
    function Seguro(ID: Integer): TJSONValue;
    function updateSeguro(Seguro: TJSONObject): TJSONValue;
    function acceptSeguro(Seguro: TJSONObject): TJSONValue;
    function cancelSeguro(ID: Integer): TJSONValue;

  end;

implementation
uses
  REST.jSON;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TSeguroController }

function TSeguroController.GravarSeguro(pSeguro: TSeguro): Boolean;
begin
  Result := False;

  tblSeguro.Open;
  if pSeguro.SeguroOID <= 0 then
    tblSeguro.Append
  else
  begin
    if not PesquisarSeguro(pSeguro.SeguroOID) then
     Exit
    else
     tblSeguro.Edit;
  end;


  tblSeguroSEGURADORAOID.AsInteger := pSeguro.Seguradora.SeguradoraOID;
  tblSeguroDATAINICIO.AsDateTime := pSeguro.DataInicio;
  tblSeguroDATAFIM.AsDateTime := pSeguro.DataFim;
  tblSeguroCOBERTURA.AsString := pSEguro.Cobertura;

  tblSeguro.post;
  tblSeguro.Close;
  Result := true;
end;

function TSeguroController.ObterSeguroSelecionado: TSeguro;

  function ObterSeguradora(pSeguradoraOID: Integer): TSeguradora;
  begin
    Result := nil;

    tblSeguradora.ParamByName('SeguradoraOID').AsInteger := pSeguradoraOID;
    tblSeguradora.Open;
    if tblSeguradora.IsEmpty then
    begin
      tblSeguradora.Close;
      Exit;
    end;

    Result := TSeguradora.Create;
    Result.SeguradoraOID := tblSeguradoraSEGURADORAOID.AsInteger;
  end;
begin
  Result := TSeguro.Create;
  Result.SeguroOID := tblSeguroSEGUROOID.AsInteger;
  Result.Seguradora := ObterSeguradora(tblSeguroSEGURADORAOID.AsInteger);
  Result.DataInicio := tblSeguroDATAINICIO.AsDateTime;
  Result.DataFim := tblSeguroDATAFIM.AsDateTime;
  Result.Cobertura := tblSeguroCOBERTURA.AsString;

end;

function TSeguroController.PesquisarSeguro(pSeguroOID: Integer): Boolean;
begin
  Result := False;

  with tblSeguro do
  begin
    if IsEmpty then
      Exit;

    Result := (Locate('SEGUROOID', pSeguroOID, []))
  end;

end;

function TSeguroController.Seguros: TJSONValue;
var
  lSeguro: TSeguro;
  lArrResult: TJSONArray;
  lJSonObj: TJSONObject;
begin

  with tblSeguro do
  begin
    Open;

    if IsEmpty then
    begin
      Result := TJSONString.Create('Seguro não encontrado!');
      Close;
      Exit;
    end;

    lArrResult := TJSONArray.Create;
    while not Eof do
    begin
      lSeguro := ObterSeguroSelecionado;
      lJSonObj := TJSon.ObjectToJSonObject(lSeguro);
      lArrResult.AddElement(lJSonObj);
      Next;
    end;
    Close;
    Result := lArrResult;
  end;

end;

function TSeguroController.Seguro(ID: Integer): TJSONValue;
var
  lSeguro: TSeguro;
begin

  with tblSeguro do
  begin
    Open;

    if PesquisarSeguro(ID) then
    begin
      lSeguro := ObterSeguroSelecionado;
      Result := TJson.ObjectToJsonObject(lSeguro);
      lSeguro.Free;
    end
    else
      Result := TJSONString.Create('Seguro não encontrado!');

    Close;
  end;


end;

function TSeguroController.acceptSeguro(Seguro: TJSONObject): TJSONValue;
var
  lSeguro: TSeguro;
begin
  lSeguro := TJson.JsonToObject<TSeguro>(Seguro);
  if lSeguro.SeguroOID <> 0 then
  begin
    Result := TJSONString.Create('Seguro já cadastrado. Inclusão cancelada!');
    Exit;
  end;

  if GravarSeguro(lSeguro) then
    Result := TJSONString.Create('Seguro gravado com sucesso!')
  else
    Result := TJSONString.Create('Erro ao gravar o seguro!')

end;

function TSeguroController.updateSeguro(Seguro: TJSONObject): TJSONValue;
var
  lSeguro: TSeguro;
begin
  lSeguro := TJson.JsonToObject<TSeguro>(Seguro);

  tblSeguro.Open;
  if not PesquisarSeguro(lSeguro.SeguroOID) then
  begin
    Result := TJSONString.Create('Seguro não encontrado!');
    Exit;
  end;
  tblSeguro.Close;

  if GravarSeguro(lSeguro) then
    Result := TJSONString.Create('Seguro gravado com sucesso!')
  else
    Result := TJSONString.Create('Erro ao gravar o seguro!')

end;

function TSeguroController.cancelSeguro(ID: Integer): TJSONValue;
begin
  tblSeguro.Open;
  if not PesquisarSeguro(ID) then
  begin
    Result := TJSONString.Create('Seguro não encontrado!');
    Exit;
  end;
  tblSeguro.Close;

  with tblSeguro do
  begin
    Open;
    PesquisarSeguro(ID);
    Delete;
    Close;
  end;

end;



procedure TSeguroController.DSServerModuleCreate(Sender: TObject);
begin
  tblSeguradora.Connection := datamodule1.ObterConnection;
  tblSeguro.Connection := datamodule1.ObterConnection;
end;

procedure TSeguroController.DSServerModuleDestroy(Sender: TObject);
begin
  tblSeguradora.Connection.Free;
  tblSeguro.Connection.Free;
end;

end.


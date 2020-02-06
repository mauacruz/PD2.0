unit Expedicao.Controller.uSeguradora;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Expedicao.Models.uSeguradora;

type
  TSeguradoraController = class(TDSServerModule)
    tblSeguradora: TFDQuery;
    tblSeguradoraSEGURADORAOID: TIntegerField;
    tblSeguradoraDESCRICAO: TStringField;
    tblSeguradoraCNPJ: TStringField;
    tblSeguradoraTELEFONE: TStringField;
    tblSeguradoraCORRETOR: TStringField;
    tblSeguradoraSEGUROOID: TIntegerField;

  private
    { Private declarations }
    function ObterSeguradoraSelecionada: TSeguradora;
    function GravarSeguradora(pSeguradora: TSeguradora): Boolean;
    function PesquisarSeguradora(pSeguradoraOID: Integer): Boolean;
  public
    { Public declarations }

//    procedure SetSeguradoraPersistencia(pSeguradoraPersistencia: ISeguradoraPersistencia);

    function Seguradoras: TJSONValue;
    function Seguradora(ID: Integer): TJSONValue;
    function updateSeguradora(Seguradora: TJSONObject): TJSONValue;
    function acceptSeguradora(Seguradora: TJSONObject): TJSONValue;
    function cancelSeguradora(ID: Integer): TJSONValue;
  end;

implementation
uses
  REST.jSON,
  uDataModule;


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TSeguradoraController }

function TSeguradoraController.cancelSeguradora(
  ID: Integer): TJSONValue;
begin

  with tblSeguradora do
  begin
    Open;

    if Locate('SEGURADORAOID', ID, []) then
    begin
      Delete;
      Result := TJSONString.Create('Seguradora exclu�da com sucesso!');
    end
    else
      Result := TJSONString.Create('Erro ao excluir a seguradora!');

    Close;
  end;

end;

function TSeguradoraController.GravarSeguradora(
  pSeguradora: TSeguradora): Boolean;
begin
  Result := False;

  tblSeguradora.Open;
  if pSeguradora.SeguradoraOID <= 0 then
    tblSeguradora.Append
  else
  begin
    if not PesquisarSeguradora(pSeguradora.SeguradoraOID) then
     Exit
    else
     tblSeguradora.Edit;
  end;

  tblSeguradoraDESCRICAO.AsString := pSeguradora.Descricao;
  tblSeguradoraCNPJ.AsString := pSeguradora.CNPJ;
  tblSeguradoraTELEFONE.AsString := pSeguradora.Telefone;
  tblSeguradoraCORRETOR.AsString := pSeguradora.Corretor;

  tblSeguradora.post;
  tblSeguradora.Close;
  Result := true;

end;

function TSeguradoraController.ObterSeguradoraSelecionada: TSeguradora;
begin
  Result := TSeguradora.Create;
  REsult.SeguradoraOID := tblSeguradoraSEGURADORAOID.AsInteger;
  Result.Descricao  := tblSeguradoraDESCRICAO.AsString;
  Result.CNPJ := tblSeguradoraCNPJ.AsString;
  Result.Telefone := tblSeguradoraTELEFONE.AsString;
  Result.Corretor := tblSeguradoraCORRETOR.AsString;
end;

function TSeguradoraController.PesquisarSeguradora(
  pSeguradoraOID: Integer): Boolean;
begin
  Result := False;

  with tblSeguradora do
  begin
    if IsEmpty then
      Exit;

    Result := (Locate('SEGURADORAOID', pSeguradoraOID, []))
  end;

end;

function TSeguradoraController.Seguradora(ID: Integer): TJSONValue;
var
  lSeguradora: TSeguradora;
begin

  with tblSeguradora do
  begin
    Open;

    if PesquisarSeguradora(ID) then
    begin
      lSeguradora := ObterSeguradoraSelecionada;
      Result := TJson.ObjectToJsonObject(lSeguradora);
      lSeguradora.Free;
    end
    else
      Result := TJSONString.Create('Seguradora n�o encontrada!');

    Close;
  end;

end;

function TSeguradoraController.Seguradoras: TJSONValue;
var
  lSeguradora: TSeguradora;
  lArrResult: TJSONArray;
  lJSonObj: TJSONObject;
begin

  with tblSeguradora do
  begin
    Open;

    if IsEmpty then
    begin
      Result := TJSONString.Create('Seguradora n�o encontrada!');
      Close;
      Exit;
    end;

    lArrResult := TJSONArray.Create;
    while not Eof do
    begin
      lSeguradora := ObterSeguradoraSelecionada;
      lJSonObj := TJSon.ObjectToJSonObject(lSeguradora);
      lArrResult.AddElement(lJSonObj);
      Next;
    end;
    Close;
    Result := lArrResult;
  end;
end;

function TSeguradoraController.acceptSeguradora(
  Seguradora: TJSONObject): TJSONValue;
var
  lSeguradora: TSeguradora;
begin
  lSeguradora := TJson.JsonToObject<TSeguradora>(Seguradora);
  if GravarSeguradora(lSeguradora) then
    Result := TJSONString.Create('Seguradora gravada com sucesso!')
  else
    Result := TJSONString.Create('Erro ao gravar a seguradora!')
end;


function TSeguradoraController.updateSeguradora(
  Seguradora: TJSONObject): TJSONValue;
var
  lSeguradora: TSeguradora;
begin
  lSeguradora := TJson.JsonToObject<TSeguradora>(Seguradora);
  if GravarSeguradora(lSeguradora) then
    Result := TJSONString.Create('Seguradora gravada com sucesso!')
  else
    Result := TJSONString.Create('Erro ao gravar a seguradora!')
end;

end.


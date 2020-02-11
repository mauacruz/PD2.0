unit Expedicao.Controller.uRomaneio;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  Expedicao.Models.uRomaneio,
  uDataModule
  ;


type
  TRomaneioController = class(TDSServerModule)
    tblRomaneio: TFDQuery;
    tblVeiculo: TFDQuery;
    tblRomaneioROMANEIOOID: TFDAutoIncField;
    tblRomaneioVEICULOOID: TIntegerField;
    tblRomaneioCONDUTOROID: TIntegerField;
    tblRomaneioSAIDA: TDateTimeField;
    tblRomaneioRETORNO: TDateTimeField;
    tblRomaneioFUNCIONARIOSAIDAOID: TIntegerField;
    tblRomaneioFUNCIONARIORETORNOOID: TIntegerField;
    tblVeiculoVEICULOOID: TFDAutoIncField;
    tblVeiculoMARCA: TStringField;
    tblVeiculoMODELO: TStringField;
    tblVeiculoPLACA: TStringField;
    tblVeiculoRENAVAM: TStringField;
    tblVeiculoCOR: TStringField;
    tblVeiculoANO: TStringField;
    tblRomaneioKMSAIDA: TBCDField;
    tblRomaneioKMRETORNO: TBCDField;
    tblRomaneioKMRODADO: TBCDField;
  private
    { Private declarations }

    function GravarRomaneio(pRomaneio: TRomaneio): Boolean;
    function ObterRomaneioSelecionado: TRomaneio;
    function PesquisarRomaneio(pRomaneioOID: Integer): Boolean;

  public
    { Public declarations }

    function Romaneios: TJSONValue;
    function Romaneio(ID: Integer): TJSONValue;
    function updateRomaneio(Romaneio: TJSONObject): TJSONValue;
    function acceptRomaneio(Romaneio: TJSONObject): TJSONValue;
    function cancelRomaneio(ID: Integer): TJSONValue;
  end;

implementation
uses
  REST.jSON,
  System.Generics.Collections;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TRomaneioController }

function TRomaneioController.GravarRomaneio(pRomaneio: TRomaneio): Boolean;
begin
  Result := False;

  tblRomaneio.Open;
  if pRomaneio.RomaneioOID <= 0 then
    tblRomaneio.Append
  else
  begin
    if not PesquisarRomaneio(pRomaneio.RomaneioOID) then
     Exit
    else
     tblRomaneio.Edit;
  end;

  tblRomaneioVEICULOOID.AsInteger := pRomaneio.VeiculoOID;
  tblRomaneioCONDUTOROID.AsInteger := pRomaneio.CondutorOID;
  tblRomaneioSAIDA.AsDateTime := pRomaneio.Saida;
  tblRomaneioRETORNO.AsDateTime := pRomaneio.Retorno;
  tblRomaneioKMSAIDA.AsFloat := pRomaneio.KMSaida;
  tblRomaneioKMRETORNO.AsFloat := pRomaneio.KMRetorno;
  tblRomaneioKMRODADO.AsFloat := pRomaneio.KMRodado;
  tblRomaneioFUNCIONARIOSAIDAOID.AsInteger := pRomaneio.FuncionarioSaidaOID;
  tblRomaneioFUNCIONARIORETORNOOID.AsInteger := pRomaneio.FuncionarioRetornoOID;

  tblRomaneio.post;
  tblRomaneio.Close;
  Result := true;

end;

function TRomaneioController.ObterRomaneioSelecionado: TRomaneio;
begin
  Result := TRomaneio.Create;
  Result.RomaneioOID := tblRomaneioROMANEIOOID.AsInteger;
  Result.VeiculoOID := tblRomaneioVEICULOOID.AsInteger;
  Result.CondutorOID := tblRomaneioCONDUTOROID.AsInteger;
  Result.Saida := tblRomaneioSAIDA.AsDateTime;
  Result.Retorno := tblRomaneioRETORNO.AsDateTime;
  Result.KMSaida := tblRomaneioKMSAIDA.AsFloat;
  Result.KMRetorno := tblRomaneioKMRETORNO.AsFloat;
  Result.KMRodado := tblRomaneioKMRODADO.AsFloat;
  Result.FuncionarioSaidaOID := tblRomaneioFUNCIONARIOSAIDAOID.AsInteger;
  Result.FuncionarioRetornoOID := tblRomaneioFUNCIONARIORETORNOOID.AsInteger;
end;

function TRomaneioController.PesquisarRomaneio(pRomaneioOID: Integer): Boolean;
begin
  Result := False;

  with tblRomaneio do
  begin
    if IsEmpty then
      Exit;

    Result := (Locate('ROMANEIOOID', pRomaneioOID, []))
  end;

end;


function TRomaneioController.Romaneios: TJSONValue;
var
  lRomaneio: TRomaneio;
  lArrResult: TJSONArray;
  lJSonObj: TJSONObject;
begin

  with tblRomaneio do
  begin
    Open;

    if IsEmpty then
    begin
      Result := TJSONString.Create('Romaneio não encontrado!');
      Close;
      Exit;
    end;

    lArrResult := TJSONArray.Create;
    while not Eof do
    begin
      lRomaneio := ObterRomaneioSelecionado;
      lJSonObj := TJSon.ObjectToJSonObject(lRomaneio);
      lArrResult.AddElement(lJSonObj);
      Next;
    end;
    Close;
    Result := lArrResult;
  end;

end;


function TRomaneioController.Romaneio(ID: Integer): TJSONValue;
var
  lRomaneio: TRomaneio;
begin

  with tblRomaneio do
  begin
    Open;

    if PesquisarRomaneio(ID) then
    begin
      lRomaneio := ObterRomaneioSelecionado;
      Result := TJson.ObjectToJsonObject(lRomaneio);
      lRomaneio.Free;
    end
    else
      Result := TJSONString.Create('Romaneio não encontrado!');

    Close;
  end;
end;

function TRomaneioController.acceptRomaneio(Romaneio: TJSONObject): TJSONValue;
var
  lRomaneio: TRomaneio;
begin
  lRomaneio := TJson.JsonToObject<TRomaneio>(Romaneio);
  if lRomaneio.RomaneioOID <> 0 then
  begin
    Result := TJSONString.Create('Romaneio já cadastrado. Inclusão cancelada!');
    Exit;
  end;



  if GravarRomaneio(lRomaneio) then
    Result := TJSONString.Create('Romaneio gravado com sucesso!')
  else
    Result := TJSONString.Create('Erro ao gravar o romaneio!')
end;

function TRomaneioController.updateRomaneio(Romaneio: TJSONObject): TJSONValue;
var
  lRomaneio: TRomaneio;
begin
  lRomaneio := TJson.JsonToObject<TRomaneio>(Romaneio);

  tblRomaneio.Open;
  if not PesquisarRomaneio(lRomaneio.RomaneioOID) then
  begin
    Result := TJSONString.Create('Romaneio não encontrado!');
    Exit;
  end;
  tblRomaneio.Close;

  if GravarRomaneio(lRomaneio) then
    Result := TJSONString.Create('Romaneio gravado com sucesso!')
  else
    Result := TJSONString.Create('Erro ao gravar o romaneio!')end;

function TRomaneioController.cancelRomaneio(ID: Integer): TJSONValue;
begin
  tblRomaneio.Open;
  if not PesquisarRomaneio(ID) then
  begin
    Result := TJSONString.Create('Romaneio não encontrado!');
    Exit;
  end;
  tblRomaneio.Close;

  with tblRomaneio do
  begin
    Open;
    PesquisarRomaneio(ID);
    Delete;
    Close;
  end;
end;

end.



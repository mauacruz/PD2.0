unit Expedicao.Controller.uSeguro;

interface

uses
  System.SysUtils,
  System.JSON,
  FireDAC.Comp.Client,
  Base.uControllerBase,

  Expedicao.Models.uSeguro,
  Expedicao.Models.uSeguradora;

type
  TSeguroController = class(TControllerBase)
  private
    { Private declarations }

    function ObterSeguroDaQuery(pQry: TFDQuery): TSeguro;
    function ObterSeguroPeloOID(pSeguroOID: Integer): TSeguro;
    function IncluirSeguro(pSeguro: TSeguro): Boolean;
    function AlterarSeguro(pSeguro: TSeguro): Boolean;
    function TestarSeguradoraCadastrada(pSeguradoraOID: Integer): Boolean;
    function ObterSeguradora(pSeguradoraID: Integer): TSeguradora;

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
  REST.jSON,
  uDataModule,
  Expedicao.Services.uSeguro;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TSeguroController }

function TSeguroController.ObterSeguradora(pSeguradoraID: Integer): TSeguradora;
var
  lSvcSeguro: TSeguroService;
begin
  lSvcSeguro := TSeguroService.Create;
  try
    lSvcSeguro.ObterSeguradora(pSeguradoraID);
  finally
    lSvcSeguro.Free;
  end;

end;

function TSeguroController.TestarSeguradoraCadastrada(
  pSeguradoraOID: Integer): Boolean;
var
  lSeguradora: TSeguradora;
begin
  Result := False;
  lSeguradora := ObterSeguradora(pSeguradoraOID);
  if Assigned(lSeguradora) then
  begin
    Result := True;
    lSeguradora.Free;
  end;
end;

function TSeguroController.ObterSeguroDaQuery(pQry: TFDQuery): TSeguro;
var
  lSvcSeguro: TSeguroService;
begin
  lSvcSeguro := TSeguroService.Create;
  try
    lSvcSeguro.ObterSeguroDaQuery(pQry);
  finally
    lSvcSeguro.Free;
  end;
end;

function TSeguroController.ObterSeguroPeloOID(pSeguroOID: Integer): TSeguro;
var
  lSvcSeguro: TSeguroService;
begin
  lSvcSeguro := TSeguroService.Create;
  try
    lSvcSeguro.ObterSeguroPeloOID(pSeguroOID);
  finally
    lSvcSeguro.Free;
  end;
end;

function TSeguroController.IncluirSeguro(pSeguro: TSeguro): Boolean;
var
  lQry: TFDQuery;
begin
  Result := False;
  lQry := DataModule1.ObterQuery;
  try

    with lQry do
    begin
      SQL.Add('INSERT INTO Seguro (');
      SQL.Add('SeguradoraOID, DataInicio, DataFim, Cobertura');
      SQL.Add(') VALUES (');
      SQL.Add(':SeguradoraOID, :DataInicio, :DataFim, :Cobertura');
      SQL.Add(');');

      ParamByName('SeguradoraOID').AsInteger := pSeguro.Seguradora.SeguradoraOID;
      ParamByName('DataInicio').AsDateTime := pSeguro.DataInicio;
      ParamByName('DataFim').AsDateTime := pSeguro.DataFim;
      ParamByName('Cobertura').AsString := pSeguro.Cobertura;

      ExecSQL;
      Result := True;
    end;

  finally
    DataModule1.DestruirQuery(lQry);
  end;

end;

function TSeguroController.AlterarSeguro(pSeguro: TSeguro): Boolean;
var
  lQry: TFDQuery;
begin
  Result := False;
  lQry := DataModule1.ObterQuery;
  try

    with lQry do
    begin
      SQL.Add('UPDATE Seguro SET ');
      SQL.Add('  SeguradoraOID = :SeguradoraOID,');
      SQL.Add('  DataInicio = :DataInicio, ');
      SQL.Add('  DataFim = :DataFim, ');
      SQL.Add('  Cobertura = :Cobertura ');
      SQL.Add('WHERE SeguroOID = :SeguroOID');

      ParamByName('SeguradoraOID').AsInteger := pSeguro.Seguradora.SeguradoraOID;
      ParamByName('DataInicio').AsDateTime := pSeguro.DataInicio;
      ParamByName('DataFim').AsDateTime := pSeguro.DataFim;
      ParamByName('Cobertura').AsString := pSeguro.Cobertura;
      ParamByName('SeguroOID').AsInteger := pSeguro.SeguroOID;

      ExecSQL;
      Result := True;
    end;

  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

function TSeguroController.Seguros: TJSONValue;
var
  lSeguro: TSeguro;
  lQry: TFDQuery;
begin
  lQry := DataModule1.ObterQuery;
  try
    with lQry do
    begin
      Open('SELECT * FROM Seguro');
      if IsEmpty then
      begin
        Result := TJSONString.Create('Nenhum seguro encontrado!');
        ConfigurarResponse(tmNotFound);
      end;

      Result := TJSONArray.Create;

      while not Eof do
      begin
        lSeguro := ObterSeguroDaQuery(lQry);
        (Result as TJSONArray).AddElement(TJson.ObjectToJsonObject(lSeguro));
        ConfigurarResponse(tmOK);
        Next;
      end;

    end;
  finally
    DataModule1.DestruirQuery(lQry);
  end;

end;


function TSeguroController.Seguro(ID: Integer): TJSONValue;
var
  lSeguro: TSeguro;
begin
  lSeguro := ObterSeguroPeloOID(ID);

  if not Assigned(lSeguro) then
  begin
    Result := TJSONString.Create('Seguro não encontrado!');
    ConfigurarResponse(tmNotFound);
  end
  else
  begin
    Result := TJson.ObjectToJsonObject(lSeguro);
    ConfigurarResponse(tmOK);
    lSeguro.Free;
  end;

end;

function TSeguroController.acceptSeguro(Seguro: TJSONObject): TJSONValue;
var
  lSeguroEnviado, lSeguroCadastrado: TSeguro;
begin
  lSeguroEnviado := TJson.JsonToObject<TSeguro>(Seguro);
  try
    lSeguroCadastrado := ObterSeguroPeloOID(lSeguroEnviado.SeguroOID);
    if Assigned(lSeguroCadastrado) then
    begin
      Result := TJSONString.Create('Seguro já cadastrado. Inclusão cancelada!');
      ConfigurarResponse(tmObjectAlreadyExists);

      lSeguroCadastrado.Free;
      Exit;
    end;

    try
      if (not Assigned(lSeguroEnviado.Seguradora)) or
        (not TestarSeguradoraCadastrada(lSeguroEnviado.Seguradora.SeguradoraOID)) then
      begin
        Result := TJSONString.Create('Seguradora informada não existe!');
        ConfigurarResponse(tmUnprocessableEntity);
        Exit;
      end;

      if IncluirSeguro(lSeguroEnviado) then
      begin
        Result := TJSONString.Create('Seguro gravado com sucesso!');
        ConfigurarResponse(tmOK);
      end
      else
        raise Exception.Create('Erro ao gravar o Seguro!');

    except
      on e: Exception do
      begin
        Result := TJSONString.Create(e.Message);
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    lSeguroEnviado.Free;
  end;

end;

function TSeguroController.updateSeguro(Seguro: TJSONObject): TJSONValue;
var
  lSeguroEnviado, lSeguroCadastrado: TSeguro;
begin
  lSeguroEnviado := TJson.JsonToObject<TSeguro>(Seguro);
  try
    lSeguroCadastrado := ObterSeguroPeloOID(lSeguroEnviado.SeguroOID);
    if not Assigned(lSeguroCadastrado) then
    begin
      Result := TJSONString.Create('Seguro não encontrado!');
      ConfigurarResponse(tmNotFound);
      Exit;
    end;

    lSeguroCadastrado.Free;

    try
      if (not Assigned(lSeguroEnviado.Seguradora)) or
        (not TestarSeguradoraCadastrada(lSeguroEnviado.Seguradora.SeguradoraOID)) then
      begin
        Result := TJSONString.Create('Seguradora informada não existe!');
        ConfigurarResponse(tmUnprocessableEntity);
        Exit;
      end;

      if AlterarSeguro(lSeguroEnviado) then
      begin
        Result := TJSONString.Create('Seguro gravado com sucesso!');
        ConfigurarResponse(tmOK);
      end
      else
        raise Exception.Create('Erro ao gravar o Seguro!');

    except
      on e: Exception do
      begin
        Result := TJSONString.Create(e.Message);
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    lSeguroEnviado.Free;
  end;
end;

function TSeguroController.cancelSeguro(ID: Integer): TJSONValue;
var
  lQry: TFDQuery;
  lSeguro: TSeguro;
begin

  lSeguro := ObterSeguroPeloOID(ID);
  if not Assigned(lSeguro) then
  begin
    Result := TJSONString.Create('Seguro não encontrado!');
    ConfigurarResponse(tmNotFound);
    Exit;
  end;

  lSeguro.Free;
  lQry := DataModule1.ObterQuery;
  try
    try
      with lQry do
      begin
        SQL.Add('DELETE FROM Seguro WHERE SeguroOID = :SeguroOID');
        ParamByName('SeguroOID').AsInteger := ID;
        ExecSQL;
        Result := TJSONString.Create('Seguro excluído com sucesso!');
        ConfigurarResponse(tmOK);
      end;
    except
      on e: Exception do
      begin
        Result := TJSONString.Create('Erro ao excluir o Seguro!');
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

end.


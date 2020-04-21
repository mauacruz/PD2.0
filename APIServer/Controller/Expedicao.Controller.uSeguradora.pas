unit Expedicao.Controller.uSeguradora;

interface

uses
  System.SysUtils,

  System.JSON,
  FireDAC.Comp.Client,

  Base.uControllerBase,
  Expedicao.Models.uSeguradora;

type
  TSeguradoraController = class(TControllerBase)

  private
    { Private declarations }

    function ObterSeguradoraDaQuery(pQry: TFDQuery): TSeguradora;
    function ObterSeguradoraPeloOID(pSeguradoraOID: Integer): TSeguradora;
    function IncluirSeguradora(pSeguradora: TSeguradora): Boolean;
    function AlterarSeguradora(pSeguradora: TSeguradora): Boolean;

  public
    { Public declarations }

    function Seguradoras: TJSONValue;
    function Seguradora(ID: Integer): TJSONValue;
    function updateSeguradora(Seguradora: TJSONObject): TJSONValue;
    function acceptSeguradora(Seguradora: TJSONObject): TJSONValue;
    function cancelSeguradora(ID: Integer): TJSONValue;

  end;

implementation
uses
  REST.jSON,
  uDataModule,
  Expedicao.Services.uSeguradora;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TSeguradoraController }


function TSeguradoraController.IncluirSeguradora(pSeguradora: TSeguradora): Boolean;
var
  lQry: TFDQuery;
begin
  Result := False;
  lQry := DataModule1.ObterQuery;
  try

    with lQry do
    begin
      SQL.Add('INSERT INTO Seguradora (');
      SQL.Add('Descricao, CNPJ, Telefone, Corretor');
      SQL.Add(') VALUES (');
      SQL.Add(':Descricao, :CNPJ, :Telefone, :Corretor');
      SQL.Add(');');

      ParamByName('Descricao').AsString := pSeguradora.Descricao;
      ParamByName('CNPJ').AsString := pSeguradora.CNPJ;
      ParamByName('Telefone').AsString := pSeguradora.Telefone;
      ParamByName('Corretor').AsString := pSeguradora.Corretor;

      ExecSQL;
      Result := True;

    end;

  finally
    DataModule1.DestruirQuery(lQry);
  end;

end;

function TSeguradoraController.ObterSeguradoraDaQuery(pQry: TFDQuery): TSeguradora;
var
  lSvcSeguradora: TSeguradoraService;
begin
  lSvcSeguradora := TSeguradoraService.Create;
  try
    Result := lSvcSeguradora.ObterSeguradoraDaQuery(pQry);
  finally
    lSvcSeguradora.Free;
  end;
end;

function TSeguradoraController.ObterSeguradoraPeloOID(
  pSeguradoraOID: Integer): TSeguradora;
var
  lSvcSeguradora: TSeguradoraService;
begin
  lSvcSeguradora := TSeguradoraService.Create;
  try
    Result := lSvcSeguradora.ObterSeguradoraPeloOID(pSeguradoraOID);
  finally
    lSvcSeguradora.Free;
  end;

end;


function TSeguradoraController.Seguradoras: TJSONValue;
var
  lSeguradora: TSeguradora;
  lQry: TFDQuery;
begin

  lQry := DataModule1.ObterQuery;
  try
    with lQry do
    begin
      Open('SELECT * FROM Seguradora');
      if IsEmpty then
      begin
        Result := TJSONString.Create('Nenhuma seguradora encontrada!');
        ConfigurarResponse(tmNotFound);
      end;

      Result := TJSONArray.Create;

      while not Eof do
      begin
        lSeguradora := ObterSeguradoraDaQuery(lQry);
        (Result as TJSONArray).AddElement(TJson.ObjectToJsonObject(lSeguradora));
        ConfigurarResponse(tmOK);
        Next;
      end;

    end;
  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

function TSeguradoraController.Seguradora(ID: Integer): TJSONValue;
var
  lSeguradora: TSeguradora;
begin

  lSeguradora := ObterSeguradoraPeloOID(ID);

  if not Assigned(lSeguradora) then
  begin
    Result := TJSONString.Create('Seguradora não encontrada!');
    ConfigurarResponse(tmNotFound);
  end
  else
  begin
    Result := TJson.ObjectToJsonObject(lSeguradora);
    ConfigurarResponse(tmOK);
    lSeguradora.Free;
  end;


end;

function TSeguradoraController.acceptSeguradora(
  Seguradora: TJSONObject): TJSONValue;
var
  lSeguradoraEnviada, lSeguradoraCadastrada: TSeguradora;
begin
  lSeguradoraEnviada := TJson.JsonToObject<TSeguradora>(Seguradora);
  try
    lSeguradoraCadastrada := ObterSeguradoraPeloOID(lSeguradoraEnviada.SeguradoraOID);
    if Assigned(lSeguradoraCadastrada) then
    begin
      Result := TJSONString.Create('Seguradora já cadastrada. Inclusão cancelada!');
      ConfigurarResponse(tmObjectAlreadyExists);

      lSeguradoraCadastrada.Free;
      Exit;
    end;

    try
      if IncluirSeguradora(lSeguradoraEnviada) then
      begin
        Result := TJSONString.Create('Seguradora gravada com sucesso!');
        ConfigurarResponse(tmOK);
      end
      else
        raise Exception.Create('Erro ao gravar a seguradora!');

    except
      on e: Exception do
      begin
        Result := TJSONString.Create(e.Message);
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    lSeguradoraEnviada.Free;
  end;

end;


function TSeguradoraController.updateSeguradora(
  Seguradora: TJSONObject): TJSONValue;
var
  lSeguradoraEnviada, lSeguradoraCadastrada: TSeguradora;
begin
  lSeguradoraEnviada := TJson.JsonToObject<TSeguradora>(Seguradora);
  try
    lSeguradoraCadastrada := ObterSeguradoraPeloOID(lSeguradoraEnviada.SeguradoraOID);
    if not Assigned(lSeguradoraCadastrada) then
    begin
      Result := TJSONString.Create('Seguradora não encontrada!');
      ConfigurarResponse(tmNotFound);
      Exit;
    end;

    lSeguradoraCadastrada.Free;

    try
      if AlterarSeguradora(lSeguradoraEnviada) then
      begin
        Result := TJSONString.Create('Seguradora gravada com sucesso!');
        ConfigurarResponse(tmOK);
      end
      else
        raise Exception.Create('Erro ao gravar a seguradora!');

    except
      on e: Exception do
      begin
        Result := TJSONString.Create(e.Message);
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    lSeguradoraEnviada.Free;
  end;

end;

function TSeguradoraController.AlterarSeguradora(
  pSeguradora: TSeguradora): Boolean;
var
  lQry: TFDQuery;
begin
  Result := False;
  lQry := DataModule1.ObterQuery;
  try

    with lQry do
    begin
      SQL.Add('UPDATE Seguradora SET ');
      SQL.Add('  Descricao = :Descricao,');
      SQL.Add('  CNPJ = :CNPJ, ');
      SQL.Add('  Telefone = :Telefone, ');
      SQL.Add('  Corretor = :Corretor ');
      SQL.Add('WHERE SeguradoraOID = :SeguradoraOID');


      ParamByName('Descricao').AsString := pSeguradora.Descricao;
      ParamByName('CNPJ').AsString := pSeguradora.CNPJ;
      ParamByName('Telefone').AsString := pSeguradora.Telefone;
      ParamByName('Corretor').AsString := pSeguradora.Corretor;
      ParamByName('SeguradoraOID').AsInteger := pSeguradora.SeguradoraOID;
      ExecSQL;
      Result := True;

    end;

  finally
    DataModule1.DestruirQuery(lQry);
  end;

end;

function TSeguradoraController.cancelSeguradora(
  ID: Integer): TJSONValue;
var
  lQry: TFDQuery;
  lSeguradora: TSeguradora;
begin

  lSeguradora := ObterSeguradoraPeloOID(ID);
  if not Assigned(lSeguradora) then
  begin
    Result := TJSONString.Create('Seguradora não encontrada!');
    ConfigurarResponse(tmNotFound);
    Exit;
  end;

  lSeguradora.Free;
  lQry := DataModule1.ObterQuery;
  try
    try
      with lQry do
      begin
        SQL.Add('DELETE FROM Seguradora WHERE SeguradoraOID = :SeguradoraOID');
        ParamByName('SeguradoraOID').AsInteger := ID;
        ExecSQL;
        Result := TJSONString.Create('Seguradora excluída com sucesso!');
        ConfigurarResponse(tmOK);
      end;
    except
      on e: Exception do
      begin
        Result := TJSONString.Create('Erro ao excluir a seguradora!');
        ConfigurarResponse(tmUndefinedError);
      end;
    end;


  finally
    DataModule1.DestruirQuery(lQry);
  end;

end;

end.


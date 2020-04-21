unit Expedicao.Controller.uInfracao;

interface

uses
  System.SysUtils,
  System.JSON,
  FireDAC.Comp.Client,
  Base.uControllerBase,
  Expedicao.Models.uInfracao;


type
  TInfracaoController = class(TControllerBase)
  private
    { Private declarations }

    function ObterInfracaoDaQuery(pQry: TFDQuery): TInfracao;
    function ObterInfracaoPeloOID(pInfracaoOID: Integer): TInfracao;
    function IncluirInfracao(pInfracao: TInfracao): Boolean;
    function AlterarInfracao(pInfracao: TInfracao): Boolean;
    function TestarVeiculoCadastrado(pVeiculoOID: Integer): Boolean;

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
  REST.jSON,
  uDataModule;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TInfracaoController }

function TInfracaoController.ObterInfracaoDaQuery(pQry: TFDQuery): TInfracao;
begin
  Result := TInfracao.Create;

  with Result do
  begin
    InfracaoOID := pQry.FieldByName('InfracaoOID').AsInteger;
    VeiculoOID := pQry.FieldByName('VeiculoOID').AsInteger;
    Data  := pQry.FieldByName('Data').AsDateTime;
    Hora := pQry.FieldByName('Hora').AsString;
    AutoInfracao := pQry.FieldByName('AutoInfracao').AsString;
    Orgao := pQry.FieldByName('Orgao').AsString;
    Valor := pQry.FieldByName('Valor').AsFloat;
    AutorInfracao := pQry.FieldByName('AutorInfracao').AsInteger;
    TipoInfracao := pQry.FieldByName('TipoInfracao').AsString;
  end;

end;

function TInfracaoController.ObterInfracaoPeloOID(
  pInfracaoOID: Integer): TInfracao;
var
  lQry: TFDQuery;
begin
  Result := nil;

  lQry := DataModule1.ObterQuery;
  try
    lQry.Open('SELECT * FROM Infracao WHERE InfracaoOID = :InfracaoOID',
      [pInfracaoOID]);

    if lQry.IsEmpty then
      Exit;

    Result := ObterInfracaoDaQuery(lQry);

  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

function TInfracaoController.TestarVeiculoCadastrado(
  pVeiculoOID: Integer): Boolean;
var
  lQry: TFDQuery;
begin
  Result := False;
  lQry := DataModule1.ObterQuery;
  try

    with lQry do
    begin
      Open('SELECT COUNT(*) AS Total FROM Veiculo WHERE VeiculoOID = :VeiculoOID', [pVeiculoOID]);

      Result := FieldByName('Total').AsInteger > 0;
    end;
  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

function TInfracaoController.IncluirInfracao(pInfracao: TInfracao): Boolean;
var
  lQry: TFDQuery;
begin
  Result := False;
  lQry := DataModule1.ObterQuery;
  try

    with lQry do
    begin
      SQL.Add('INSERT INTO Infracao (');
      SQL.Add('VeiculoOID, Data, Hora, AutoInfracao, Orgao, Valor, AutorInfracao, TipoInfracao');
      SQL.Add(') VALUES (');
      SQL.Add(':VeiculoOID, :Data, :Hora, :AutoInfracao, :Orgao, :Valor, :AutorInfracao, :TipoInfracao');
      SQL.Add(');');

      ParamByName('VeiculoOID').AsInteger := pInfracao.VeiculoOID;
      ParamByName('Data').AsDateTime := pInfracao.Data;
      ParamByName('Hora').AsString := pInfracao.Hora;
      ParamByName('AutoInfracao').AsString := pInfracao.AutoInfracao;
      ParamByName('Orgao').AsString := pInfracao.Orgao;
      ParamByName('Valor').AsFloat := pInfracao.Valor;
      ParamByName('AutorInfracao').AsInteger := pInfracao.AutorInfracao;
      ParamByName('TipoInfracao').AsString := pInfracao.TipoInfracao;

      ExecSQL;
      Result := True;
    end;

  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

function TInfracaoController.AlterarInfracao(pInfracao: TInfracao): Boolean;
var
  lQry: TFDQuery;
begin
  Result := False;
  lQry := DataModule1.ObterQuery;
  try

    with lQry do
    begin
      SQL.Add('UPDATE Infracao SET ');
      SQL.Add('  VeiculoOID = :VeiculoOID,');
      SQL.Add('  Data = :Data, ');
      SQL.Add('  Hora = :Hora, ');
      SQL.Add('  AutoInfracao = :AutoInfracao, ');
      SQL.Add('  Orgao = :Orgao, ');
      SQL.Add('  Valor = :Valor, ');
      SQL.Add('  AutorInfracao = :AutorInfracao, ');
      SQL.Add('  TipoInfracao = :TipoInfracao ');
      SQL.Add('WHERE InfracaoOID = :InfracaoOID');

      ParamByName('InfracaoOID').AsInteger := pInfracao.InfracaoOID;
      ParamByName('VeiculoOID').AsInteger := pInfracao.VeiculoOID;
      ParamByName('Data').AsDateTime := pInfracao.Data;
      ParamByName('Hora').AsString := pInfracao.Hora;
      ParamByName('AutoInfracao').AsString := pInfracao.AutoInfracao;
      ParamByName('Orgao').AsString := pInfracao.Orgao;
      ParamByName('Valor').AsFloat := pInfracao.Valor;
      ParamByName('AutorInfracao').AsInteger := pInfracao.AutorInfracao;
      ParamByName('TipoInfracao').AsString := pInfracao.TipoInfracao;

      ExecSQL;
      Result := True;

    end;

  finally
    DataModule1.DestruirQuery(lQry);
  end;

end;

function TInfracaoController.Infracoes: TJSONValue;
var
  lInfracao: TInfracao;
  lQry: TFDQuery;
begin
  lQry := DataModule1.ObterQuery;
  try
    with lQry do
    begin
      Open('SELECT * FROM Infracao');
      if IsEmpty then
      begin
        Result := TJSONString.Create('Nenhuma infração encontrada!');
        ConfigurarResponse(tmNotFound);
      end;

      Result := TJSONArray.Create;

      while not Eof do
      begin
        lInfracao := ObterInfracaoDaQuery(lQry);
        (Result as TJSONArray).AddElement(TJson.ObjectToJsonObject(lInfracao));
        ConfigurarResponse(tmOK);
        Next;
      end;

    end;
  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

function TInfracaoController.Infracao(ID: Integer): TJSONValue;
var
  lInfracao: TInfracao;
begin
  lInfracao := ObterInfracaoPeloOID(ID);

  if not Assigned(lInfracao) then
  begin
    Result := TJSONString.Create('Infração não encontrada!');
    ConfigurarResponse(tmNotFound);
  end
  else
  begin
    Result := TJson.ObjectToJsonObject(lInfracao);
    ConfigurarResponse(tmOK);
    lInfracao.Free;
  end;
end;

function TInfracaoController.acceptInfracao(
  Infracao: TJSONObject): TJSONValue;
var
  lInfracaoEnviada, lInfracaoCadastrada: TInfracao;
begin
  lInfracaoEnviada := TJson.JsonToObject<TInfracao>(Infracao);
  try
    lInfracaoCadastrada := ObterInfracaoPeloOID(lInfracaoEnviada.InfracaoOID);
    if Assigned(lInfracaoCadastrada) then
    begin
      Result := TJSONString.Create('Infração já cadastrada. Inclusão cancelada!');
      ConfigurarResponse(tmObjectAlreadyExists);

      lInfracaoCadastrada.Free;
      Exit;
    end;

    try
      if not TestarVeiculoCadastrado(lInfracaoEnviada.VeiculoOID) then
      begin
        Result := TJSONString.Create('Veículo informado não existe!');
        ConfigurarResponse(tmUnprocessableEntity);
        Exit;
      end;

      if IncluirInfracao(lInfracaoEnviada) then
      begin
        Result := TJSONString.Create('Infração gravada com sucesso!');
        ConfigurarResponse(tmOK);
      end
      else
        raise Exception.Create('Erro ao gravar a Infração!');

    except
      on e: Exception do
      begin
        Result := TJSONString.Create(e.Message);
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    lInfracaoEnviada.Free;
  end;
end;

function TInfracaoController.updateInfracao(
  Infracao: TJSONObject): TJSONValue;
var
  lInfracaoEnviada, lInfracaoCadastrada: TInfracao;
begin
  lInfracaoEnviada := TJson.JsonToObject<TInfracao>(Infracao);
  try
    lInfracaoCadastrada := ObterInfracaoPeloOID(lInfracaoEnviada.InfracaoOID);
    if not Assigned(lInfracaoCadastrada) then
    begin
      Result := TJSONString.Create('Infração não encontrada!');
      ConfigurarResponse(tmNotFound);
      Exit;
    end;

    lInfracaoCadastrada.Free;

    try
      if not TestarVeiculoCadastrado(lInfracaoEnviada.VeiculoOID) then
      begin
        Result := TJSONString.Create('Veículo informado não existe!');
        ConfigurarResponse(tmUnprocessableEntity);
        Exit;
      end;

      if AlterarInfracao(lInfracaoEnviada) then
      begin
        Result := TJSONString.Create('Infração gravada com sucesso!');
        ConfigurarResponse(tmOK);
      end
      else
        raise Exception.Create('Erro ao gravar a infração!');

    except
      on e: Exception do
      begin
        Result := TJSONString.Create(e.Message);
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    lInfracaoEnviada.Free;
  end;
end;

function TInfracaoController.cancelInfracao(
  ID: Integer): TJSONValue;
var
  lQry: TFDQuery;
  lInfracao: TInfracao;
begin

  lInfracao := ObterInfracaoPeloOID(ID);
  if not Assigned(lInfracao) then
  begin
    Result := TJSONString.Create('Infração não encontrada!');
    ConfigurarResponse(tmNotFound);
    Exit;
  end;

  lInfracao.Free;
  lQry := DataModule1.ObterQuery;
  try
    try
      with lQry do
      begin
        SQL.Add('DELETE FROM Infracao WHERE InfracaoOID = :InfracaoOID');
        ParamByName('InfracaoOID').AsInteger := ID;
        ExecSQL;
        Result := TJSONString.Create('Infração excluída com sucesso!');
        ConfigurarResponse(tmOK);
      end;
    except
      on e: Exception do
      begin
        Result := TJSONString.Create('Erro ao excluir a infração!');
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

end.


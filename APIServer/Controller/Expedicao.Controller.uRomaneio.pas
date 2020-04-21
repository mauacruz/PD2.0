unit Expedicao.Controller.uRomaneio;

interface

uses
  System.SysUtils,
  System.JSON,
  FireDAC.Comp.Client,
  Base.uControllerBase,
  Expedicao.Models.uRomaneio;


type
  TRomaneioController = class(TControllerBase)
  private
    { Private declarations }

    function ObterRomaneioDaQuery(pQry: TFDQuery): TRomaneio;
    function ObterRomaneioPeloOID(pRomaneioOID: Integer): TRomaneio;
    function IncluirRomaneio(pRomaneio: TRomaneio): Boolean;
    function AlterarRomaneio(pRomaneio: TRomaneio): Boolean;
    function TestarVeiculoCadastrado(pVeiculoOID: Integer): Boolean;

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
  uDataModule;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TRomaneioController }

function TRomaneioController.ObterRomaneioDaQuery(pQry: TFDQuery): TRomaneio;
begin
  Result := TRomaneio.Create;

  with Result do
  begin
    RomaneioOID := pQry.FieldByName('RomaneioOID').AsInteger;
    VeiculoOID := pQry.FieldByName('VeiculoOID').AsInteger;
    CondutorOID := pQry.FieldByName('CondutorOID').AsInteger;
    Saida := pQry.FieldByName('Saida').AsDateTime;
    Retorno := pQry.FieldByName('Retorno').AsDateTime;
    KMSaida := pQry.FieldByName('KMSaida').AsFloat;
    KMRetorno := pQry.FieldByName('KMRetorno').AsFloat;
    KMRodado := pQry.FieldByName('KMRodado').AsFloat;
    FuncionarioSaidaOID := pQry.FieldByName('FuncionarioSaidaOID').AsInteger;
    FuncionarioRetornoOID := pQry.FieldByName('FuncionarioRetornoOID').AsInteger;
  end;

end;

function TRomaneioController.ObterRomaneioPeloOID(
  pRomaneioOID: Integer): TRomaneio;
var
  lQry: TFDQuery;
begin
  Result := nil;

  lQry := DataModule1.ObterQuery;
  try
    lQry.Open('SELECT * FROM Romaneio WHERE RomaneioOID = :RomaneioOID',
      [pRomaneioOID]);

    if lQry.IsEmpty then
      Exit;

    Result := ObterRomaneioDaQuery(lQry);

  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

function TRomaneioController.IncluirRomaneio(pRomaneio: TRomaneio): Boolean;
var
  lQry: TFDQuery;
begin
  Result := False;
  lQry := DataModule1.ObterQuery;
  try

    with lQry do
    begin
      SQL.Add('INSERT INTO Romaneio (');
      SQL.Add('VeiculoOID, CondutorOID, Saida, Retorno, KMSaida, KMRetorno, KMRodado, FuncionarioSaidaOID, FuncionarioRetornoOID');
      SQL.Add(') VALUES (');
      SQL.Add(':VeiculoOID, :CondutorOID, :Saida, :Retorno, :KMSaida, :KMRetorno, :KMRodado, :FuncionarioSaidaOID, :FuncionarioRetornoOID');
      SQL.Add(');');

      ParamByName('VeiculoOID').AsInteger := pRomaneio.VeiculoOID;
      ParamByName('CondutorOID').AsInteger := pRomaneio.CondutorOID;
      ParamByName('Saida').AsDateTime := pRomaneio.Saida;
      ParamByName('Retorno').AsDateTime := pRomaneio.Retorno;
      ParamByName('KMSaida').AsFloat := pRomaneio.KMSaida;
      ParamByName('KMRetorno').AsFloat := pRomaneio.KMRetorno;
      ParamByName('KMRodado').AsFloat := pRomaneio.KMRodado;
      ParamByName('FuncionarioSaidaOID').AsInteger := pRomaneio.FuncionarioSaidaOID;
      ParamByName('FuncionarioRetornoOID').AsInteger := pRomaneio.FuncionarioRetornoOID;

      ExecSQL;
      Result := True;
    end;

  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

function TRomaneioController.AlterarRomaneio(pRomaneio: TRomaneio): Boolean;
var
  lQry: TFDQuery;
begin
  Result := False;
  lQry := DataModule1.ObterQuery;
  try

    with lQry do
    begin
      SQL.Add('UPDATE Romaneio SET ');
      SQL.Add('  VeiculoOID = :VeiculoOID,');
      SQL.Add('  CondutorOID = :CondutorOID, ');
      SQL.Add('  Saida = :Saida, ');
      SQL.Add('  Retorno = :Retorno, ');
      SQL.Add('  KMSaida = :KMSaida, ');
      SQL.Add('  KMRetorno = :KMRetorno, ');
      SQL.Add('  KMRodado = :KMRodado, ');
      SQL.Add('  FuncionarioSaidaOID = :FuncionarioSaidaOID, ');
      SQL.Add('  FuncionarioRetornoOID = :FuncionarioRetornoOID ');
      SQL.Add('WHERE RomaneioOID = :RomaneioOID');

      ParamByName('RomaneioOID').AsInteger := pRomaneio.RomaneioOID;
      ParamByName('VeiculoOID').AsInteger := pRomaneio.VeiculoOID;
      ParamByName('CondutorOID').AsInteger := pRomaneio.CondutorOID;
      ParamByName('Saida').AsDateTime := pRomaneio.Saida;
      ParamByName('Retorno').AsDateTime := pRomaneio.Retorno;
      ParamByName('KMSaida').AsFloat := pRomaneio.KMSaida;
      ParamByName('KMRetorno').AsFloat := pRomaneio.KMRetorno;
      ParamByName('KMRodado').AsFloat := pRomaneio.KMRodado;
      ParamByName('FuncionarioSaidaOID').AsInteger := pRomaneio.FuncionarioSaidaOID;
      ParamByName('FuncionarioRetornoOID').AsInteger := pRomaneio.FuncionarioRetornoOID;

      ExecSQL;
      Result := True;

    end;

  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

function TRomaneioController.Romaneios: TJSONValue;
var
  lRomaneio: TRomaneio;
  lQry: TFDQuery;
begin
  lQry := DataModule1.ObterQuery;
  try
    with lQry do
    begin
      Open('SELECT * FROM Romaneio');
      if IsEmpty then
      begin
        Result := TJSONString.Create('Nenhum romaneio encontrado!');
        ConfigurarResponse(tmNotFound);
      end;

      Result := TJSONArray.Create;

      while not Eof do
      begin
        lRomaneio := ObterRomaneioDaQuery(lQry);
        (Result as TJSONArray).AddElement(TJson.ObjectToJsonObject(lRomaneio));
        ConfigurarResponse(tmOK);
        Next;
      end;

    end;
  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

function TRomaneioController.TestarVeiculoCadastrado(
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

function TRomaneioController.Romaneio(ID: Integer): TJSONValue;
var
  lRomaneio: TRomaneio;
begin
  lRomaneio := ObterRomaneioPeloOID(ID);

  if not Assigned(lRomaneio) then
  begin
    Result := TJSONString.Create('Romaneio não encontrado!');
    ConfigurarResponse(tmNotFound);
  end
  else
  begin
    Result := TJson.ObjectToJsonObject(lRomaneio);
    ConfigurarResponse(tmOK);
    lRomaneio.Free;
  end;
end;

function TRomaneioController.acceptRomaneio(Romaneio: TJSONObject): TJSONValue;
var
  lRomaneioEnviado, lRomaneioCadastrado: TRomaneio;
begin
  lRomaneioEnviado := TJson.JsonToObject<TRomaneio>(Romaneio);
  try
    lRomaneioCadastrado := ObterRomaneioPeloOID(lRomaneioEnviado.RomaneioOID);
    if Assigned(lRomaneioCadastrado) then
    begin
      Result := TJSONString.Create('Romaneio já cadastrado. Inclusão cancelada!');
      ConfigurarResponse(tmObjectAlreadyExists);

      lRomaneioCadastrado.Free;
      Exit;
    end;

    try
      if not TestarVeiculoCadastrado(lRomaneioEnviado.VeiculoOID) then
      begin
        Result := TJSONString.Create('Veículo informado não existe!');
        ConfigurarResponse(tmUnprocessableEntity);
        Exit;
      end;

      if IncluirRomaneio(lRomaneioEnviado) then
      begin
        Result := TJSONString.Create('Romaneio gravado com sucesso!');
        ConfigurarResponse(tmOK);
      end
      else
        raise Exception.Create('Erro ao gravar o Romaneio!');

    except
      on e: Exception do
      begin
        Result := TJSONString.Create(e.Message);
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    lRomaneioEnviado.Free;
  end;
end;

function TRomaneioController.updateRomaneio(Romaneio: TJSONObject): TJSONValue;
var
  lRomaneioEnviado, lRomaneioCadastrado: TRomaneio;
begin
  lRomaneioEnviado := TJson.JsonToObject<TRomaneio>(Romaneio);
  try
    lRomaneioCadastrado := ObterRomaneioPeloOID(lRomaneioEnviado.RomaneioOID);
    if not Assigned(lRomaneioCadastrado) then
    begin
      Result := TJSONString.Create('Romaneio não encontrado!');
      ConfigurarResponse(tmNotFound);
      Exit;
    end;

    lRomaneioCadastrado.Free;

    try
      if not TestarVeiculoCadastrado(lRomaneioEnviado.VeiculoOID) then
      begin
        Result := TJSONString.Create('Veículo informado não existe!');
        ConfigurarResponse(tmUnprocessableEntity);
        Exit;
      end;

      if AlterarRomaneio(lRomaneioEnviado) then
      begin
        Result := TJSONString.Create('Romaneio gravado com sucesso!');
        ConfigurarResponse(tmOK);
      end
      else
        raise Exception.Create('Erro ao gravar o romaneio!');

    except
      on e: Exception do
      begin
        Result := TJSONString.Create(e.Message);
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    lRomaneioEnviado.Free;
  end;
end;


function TRomaneioController.cancelRomaneio(ID: Integer): TJSONValue;
var
  lQry: TFDQuery;
  lRomaneio: TRomaneio;
begin

  lRomaneio := ObterRomaneioPeloOID(ID);
  if not Assigned(lRomaneio) then
  begin
    Result := TJSONString.Create('Romaneio não encontrado!');
    ConfigurarResponse(tmNotFound);
    Exit;
  end;

  lRomaneio.Free;
  lQry := DataModule1.ObterQuery;
  try
    try
      with lQry do
      begin
        SQL.Add('DELETE FROM Romaneio WHERE RomaneioOID = :RomaneioOID');
        ParamByName('RomaneioOID').AsInteger := ID;
        ExecSQL;
        Result := TJSONString.Create('Romaneio excluído com sucesso!');
        ConfigurarResponse(tmOK);
      end;
    except
      on e: Exception do
      begin
        Result := TJSONString.Create('Erro ao excluir o Romaneio!');
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

end.



unit Expedicao.Controller.uCombustivel;

interface

uses
  System.SysUtils,
  System.JSON,
  FireDAC.Comp.Client,
  Base.uControllerBase,
  Expedicao.Models.uCombustivel;

type
  TCombustivelController = class(TControllerBase)

  private

    function ObterCombustivelDaQuery(pQry: TFDQuery): TCombustivel;
    function ObterCombustivelPeloOID(pCombustivelOID: Integer): TCombustivel;
    function IncluirCombustivel(pCombustivel: TCombustivel): Boolean;
    function AlterarCombustivel(pCombustivel: TCombustivel): Boolean;

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
  uDataModule,
  Expedicao.Services.uCombustivel;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TCombustivelController }

function TCombustivelController.ObterCombustivelDaQuery(
  pQry: TFDQuery): TCombustivel;
var
  lSvcCombustivel: TCombustivelService;
begin
  lSvcCombustivel := TCombustivelService.Create;
  try
    Result := lSvcCombustivel.ObterCombustivelDaQuery(pQry);
  finally
    lSvcCombustivel.Free;
  end;

end;

function TCombustivelController.ObterCombustivelPeloOID(
  pCombustivelOID: Integer): TCombustivel;
var
  lSvcCombustivel: TCombustivelService;
begin
  lSvcCombustivel := TCombustivelService.Create;
  try
    Result := lSvcCombustivel.ObterCombustivelPeloOID(pCombustivelOID);
  finally
    lSvcCombustivel.Free;
  end;
end;

function TCombustivelController.IncluirCombustivel(
  pCombustivel: TCombustivel): Boolean;
var
  lQry: TFDQuery;
begin
  Result := False;
  lQry := DataModule1.ObterQuery;
  try

    with lQry do
    begin
      SQL.Add('INSERT INTO Combustivel (');
      SQL.Add('Descricao, Valor, UnidadeMedidaOID');
      SQL.Add(') VALUES (');
      SQL.Add(':Descricao, :Valor, :UnidadeMedidaOID');
      SQL.Add(');');

      ParamByName('Descricao').AsString := pCombustivel.Descricao;
      ParamByName('Valor').AsFloat := pCombustivel.Valor;
      ParamByName('UnidadeMedidaOID').AsInteger := pCombustivel.UnidadeDeMedidaOID;

      ExecSQL;
      Result := True;
    end;

  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

function TCombustivelController.AlterarCombustivel(
  pCombustivel: TCombustivel): Boolean;
var
  lQry: TFDQuery;
begin
  Result := False;
  lQry := DataModule1.ObterQuery;
  try

    with lQry do
    begin
      SQL.Add('UPDATE Combustivel SET ');
      SQL.Add('  Descricao = :Descricao,');
      SQL.Add('  Valor = :Valor, ');
      SQL.Add('  UnidadeMedidaOID = :UnidadeMedidaOID ');
      SQL.Add('WHERE CombustivelOID = :CombustivelOID');

      ParamByName('Descricao').AsString := pCombustivel.Descricao;
      ParamByName('Valor').AsFloat := pCombustivel.Valor;
      ParamByName('UnidadeMedidaOID').AsInteger := pCombustivel.UnidadeDeMedidaOID;
      ParamByName('CombustivelOID').AsInteger := pCombustivel.CombustivelOID;
      ExecSQL;
      Result := True;

    end;

  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;


function TCombustivelController.Combustiveis: TJSONValue;
var
  lCombustivel: TCombustivel;
  lQry: TFDQuery;
begin
  lQry := DataModule1.ObterQuery;
  try
    with lQry do
    begin
      Open('SELECT * FROM Combustivel');
      if IsEmpty then
      begin
        Result := TJSONString.Create('Nenhum combustível encontrado!');
        ConfigurarResponse(tmNotFound);
      end;

      Result := TJSONArray.Create;

      while not Eof do
      begin
        lCombustivel := ObterCombustivelDaQuery(lQry);
        (Result as TJSONArray).AddElement(TJson.ObjectToJsonObject(lCombustivel));
        ConfigurarResponse(tmOK);
        Next;
      end;

    end;
  finally
    DataModule1.DestruirQuery(lQry);
  end;

end;

function TCombustivelController.Combustivel(ID: Integer): TJSONValue;
var
  lCombustivel: TCombustivel;
begin
  lCombustivel := ObterCombustivelPeloOID(ID);

  if not Assigned(lCombustivel) then
  begin
    Result := TJSONString.Create('Combustível não encontrado!');
    ConfigurarResponse(tmNotFound);
  end
  else
  begin
    Result := TJson.ObjectToJsonObject(lCombustivel);
    ConfigurarResponse(tmOK);
    lCombustivel.Free;
  end;
end;


function TCombustivelController.acceptCombustivel(
  Combustivel: TJSONObject): TJSONValue;
var
  lCombustivelEnviado, lCombustivelCadastrado: TCombustivel;
begin
  lCombustivelEnviado := TJson.JsonToObject<TCombustivel>(Combustivel);
  try
    lCombustivelCadastrado := ObterCombustivelPeloOID(lCombustivelEnviado.CombustivelOID);
    if Assigned(lCombustivelCadastrado) then
    begin
      Result := TJSONString.Create('Combustível já cadastrado. Inclusão cancelada!');
      ConfigurarResponse(tmObjectAlreadyExists);

      lCombustivelCadastrado.Free;
      Exit;
    end;

    try
      if IncluirCombustivel(lCombustivelEnviado) then
      begin
        Result := TJSONString.Create('Combustível gravado com sucesso!');
        ConfigurarResponse(tmOK);
      end
      else
        raise Exception.Create('Erro ao gravar o combustível!');

    except
      on e: Exception do
      begin
        Result := TJSONString.Create(e.Message);
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    lCombustivelEnviado.Free;
  end;
end;

function TCombustivelController.updateCombustivel(
  Combustivel: TJSONObject): TJSONValue;
var
  lCombustivelEnviado, lCombustivelCadastrado: TCombustivel;
begin
  lCombustivelEnviado := TJson.JsonToObject<TCombustivel>(Combustivel);
  try
    lCombustivelCadastrado := ObterCombustivelPeloOID(lCombustivelEnviado.CombustivelOID);
    if not Assigned(lCombustivelCadastrado) then
    begin
      Result := TJSONString.Create('Combustível não encontrado!');
      ConfigurarResponse(tmNotFound);
      Exit;
    end;

    lCombustivelCadastrado.Free;

    try
      if AlterarCombustivel(lCombustivelEnviado) then
      begin
        Result := TJSONString.Create('Combustível gravado com sucesso!');
        ConfigurarResponse(tmOK);
      end
      else
        raise Exception.Create('Erro ao gravar a combustível!');

    except
      on e: Exception do
      begin
        Result := TJSONString.Create(e.Message);
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    lCombustivelEnviado.Free;
  end;

end;

function TCombustivelController.cancelCombustivel(ID: Integer): TJSONValue;
var
  lQry: TFDQuery;
  lCombustivel: TCombustivel;
begin

  lCombustivel := ObterCombustivelPeloOID(ID);
  if not Assigned(lCombustivel) then
  begin
    Result := TJSONString.Create('Combustível não encontrado!');
    ConfigurarResponse(tmNotFound);
    Exit;
  end;

  lCombustivel.Free;
  lQry := DataModule1.ObterQuery;
  try
    try
      with lQry do
      begin
        SQL.Add('DELETE FROM Combustivel WHERE CombustivelOID = :CombustivelOID');
        ParamByName('CombustivelOID').AsInteger := ID;
        ExecSQL;
        Result := TJSONString.Create('Combustível excluído com sucesso!');
        ConfigurarResponse(tmOK);
      end;
    except
      on e: Exception do
      begin
        Result := TJSONString.Create('Erro ao excluir o combustível!');
        ConfigurarResponse(tmUndefinedError);
      end;
    end;


  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

end.


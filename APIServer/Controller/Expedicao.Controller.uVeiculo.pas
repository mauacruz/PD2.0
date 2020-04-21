unit Expedicao.Controller.uVeiculo;

interface

uses
  System.SysUtils,
  System.JSON,
  FireDAC.Comp.Client,

  Base.uControllerBase,
  Expedicao.Models.uVeiculo,
  Expedicao.Models.uCombustivel,
  Expedicao.Models.uSeguro;


type
  TVeiculoController = class(TControllerBase)

  private
    { Private declarations }

    procedure ValidarVeiculo(pVeiculoEnviado: TVeiculo);

    function ObterVeiculoDaQuery(pQry: TFDQuery): TVeiculo;
    function ObterVeiculoPeloOID(pVeiculoOID: Integer): TVeiculo;
    function TestarVeiculoCadastrado(pVeiculoOID: Integer): Boolean;
    function IncluirVeiculo(pVeiculo: TVeiculo): Boolean;
    function AlterarVeiculo(pVeiculo: TVeiculo): Boolean;
    function ConverterVeiculoParaJSON(pVeiculo: TVeiculo): TJSONValue;

    procedure AtualizaVeiculoCombustivel(pVeiculo: TVeiculo);
    procedure AtualizaSeguroVeiculo(pVeiculo: TVeiculo);
  public
    { Public declarations }
    function Veiculos: TJSONValue;
    function Veiculo(ID: Integer): TJSONValue;
    function updateVeiculo(Veiculo: TJSONObject): TJSONValue;
    function acceptVeiculo(Veiculo: TJSONObject): TJSONValue;
    function cancelVeiculo(ID: Integer): TJSONValue;
  end;

implementation
uses
  uDataModule,

  REST.jSON,
  Expedicao.Services.uCombustivel,
  Expedicao.Services.uSeguro;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TVeiculoController }

function TVeiculoController.ObterVeiculoDaQuery(pQry: TFDQuery): TVeiculo;
  procedure CarregarListaSeguro(pVeiculo: TVeiculo);
  var
    lQry: TFDQuery;
    lSvcSeguro: TSeguroService;
    lSeguro: TSeguro;
  begin

    lQry := DataModule1.ObterQuery;
    lSvcSeguro := TSeguroService.Create;
    try
      with lQry do
      begin
        Open('SELECT * FROM SeguroVeiculo WHERE VeiculoOID = :VeiculoOID',
          [pVeiculo.VeiculoOID]);

        if IsEmpty then
          Exit;

        while not Eof do
        begin
          lSeguro := lSvcSeguro.ObterSeguroPeloOID(FieldByName('SeguroOID').AsInteger);
          pVeiculo.Seguros.Add(lSeguro);
          Next;
        end;

      end;
    finally
      DataModule1.DestruirQuery(lQry);
      lSvcSeguro.Free;
    end;
  end;

  procedure CarregarListaCombustivel(pVeiculo: TVeiculo);
  var
    lQry: TFDQuery;
    lSvcCombustivel: TCombustivelService;
    lCombustivel: TCombustivel;
  begin

    lQry := DataModule1.ObterQuery;
    lSvcCombustivel := TCombustivelService.Create;
    try
      with lQry do
      begin
        Open('SELECT * FROM VeiculoCombustivel WHERE VeiculoID = :VeiculoOID',
          [pVeiculo.VeiculoOID]);

        if IsEmpty then
          Exit;

        while not Eof do
        begin
          lCombustivel := lSvcCombustivel.ObterCombustivelPeloOID(FieldByName('CombustivelID').AsInteger);
          pVeiculo.Combustiveis.Add(lCombustivel);
          Next;
        end;

      end;
    finally
      DataModule1.DestruirQuery(lQry);
      lSvcCombustivel.Free;
    end;
  end;


begin
  Result := TVeiculo.Create;
  with Result do
  begin
    VeiculoOID := pQry.FieldByName('VeiculoOID').AsInteger;
    Marca := pQry.FieldByName('Marca').AsString;
    Modelo := pQry.FieldByName('Modelo').AsString;
    Placa := pQry.FieldByName('Placa').AsString;
    Renavam := pQry.FieldByName('Renavam').AsString;
    Cor := pQry.FieldByName('Cor').AsString;
    Ano := pQry.FieldByName('Ano').AsString;
    CarregarListaSeguro(Result);
    CarregarListaCombustivel(Result);
  end;
end;

function TVeiculoController.ObterVeiculoPeloOID(pVeiculoOID: Integer): TVeiculo;
var
  lQry: TFDQuery;
begin
  Result := nil;

  lQry := DataModule1.ObterQuery;
  try
    lQry.Open('SELECT * FROM Veiculo WHERE VeiculoOID = :VeiculoOID',
      [pVeiculoOID]);

    if lQry.IsEmpty then
      Exit;

    Result := ObterVeiculoDaQuery(lQry);

  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

function TVeiculoController.ConverterVeiculoParaJSON(
  pVeiculo: TVeiculo): TJSONValue;
var
  lSeguro: TSeguro;
  lSeguroJSONArray: TJSONArray;
  lSeguroJSON: TJSONObject;

  lCombustivel: TCombustivel;
  lCombustivelTJSONArray: TJSONArray;
  lCombustivelJSON: TJSONObject;

begin
  Result := TJSONObject.Create;

  with (Result as TJSONObject) do
  begin
    AddPair('VeiculoOID', pVeiculo.VeiculoOID.ToString);
    AddPair('Marca', pVeiculo.Marca);
    AddPair('Modelo', pVeiculo.Modelo);
    AddPair('Placa', pVeiculo.Placa);
    AddPair('Renavam', pVeiculo.Renavam);
    AddPair('Cor', pVeiculo.Cor);
    AddPair('Ano', pVeiculo.Ano);

    lSeguroJSONArray := TJSONArray.Create;
    for lSeguro in pVeiculo.Seguros do
    begin
      lSeguroJSON := TJson.ObjectToJsonObject(lSeguro);
      lSeguroJSONArray.AddElement(lSeguroJSON);
    end;

    AddPair('Seguros', lSeguroJSONArray);

    lCombustivelTJSONArray := TJSONArray.Create;
    for lCombustivel in pVeiculo.Combustiveis do
    begin
      lCombustivelJSON := TJson.ObjectToJsonObject(lCombustivel);
      lCombustivelTJSONArray.AddElement(lCombustivelJSON);
    end;

    AddPair('Combustiveis', lCombustivelTJSONArray);
  end;
end;

function TVeiculoController.TestarVeiculoCadastrado(
  pVeiculoOID: Integer): Boolean;
var
  lVeiculo: TVeiculo;
begin
  lVeiculo := ObterVeiculoPeloOID(pVeiculoOID);

  if Assigned(lVeiculo) then
  begin
    Result := True;
    Exit;
  end
  else
    Result := False;

end;

function TVeiculoController.IncluirVeiculo(pVeiculo: TVeiculo): Boolean;
var
  lQry, lQryLastID, lQryInsertCombustivel, lQryInsertSeguro: TFDQuery;
  lCombustivel: TCombustivel;
  lSeguro: TSeguro;

begin
  Result := False;
  lQry := DataModule1.ObterQuery;
  lQryLastID := DataModule1.ObterQuery;
  lQryInsertCombustivel := DataModule1.ObterQuery;
  lQryInsertSeguro := DataModule1.ObterQuery;

  try
    lQryLastID.Connection := lQry.Connection;


    with lQry do
    begin
      SQL.Add('INSERT INTO Veiculo (');
      SQL.Add('Marca, Modelo, Placa, Renavam, Cor, Ano');
      SQL.Add(') VALUES (');
      SQL.Add(':Marca, :Modelo, :Placa, :Renavam, :Cor, :Ano');
      SQL.Add(');');

      ParamByName('Marca').AsString := pVeiculo.Marca;
      ParamByName('Modelo').AsString := pVeiculo.Modelo;
      ParamByName('Placa').AsString := pVeiculo.Placa;
      ParamByName('Renavam').AsString := pVeiculo.Renavam;
      ParamByName('Cor').AsString := pVeiculo.Cor;
      ParamByName('Ano').AsString := pVeiculo.Ano;

      ExecSQL;
    end;
    lQryLastID.Open('SELECT LAST_INSERT_ID() AS VeiculoOID');


    with lQryInsertSeguro do
    begin
      SQL.Add('INSERT INTO SeguroVeiculo (SeguroOID, VeiculoOID)');
      SQL.Add('VALUES (:SeguroOID, :VeiculoOID)');
      ParamByName('VeiculoOID').AsInteger := lQryLastID.FieldByName('VeiculoOID').AsInteger;

      for lSeguro in pVeiculo.Seguros do
      begin
        ParamByName('SeguroOID').AsInteger := lSeguro.SeguroOID;
        ExecSQL;
      end;

    end;

    with lQryInsertCombustivel do
    begin

      SQL.Add('INSERT INTO VeiculoCombustivel (VeiculoID, CombustivelID)');
      SQL.Add('VALUES (:VeiculoOID, :CombustivelID)');
      ParamByName('VeiculoOID').AsInteger := lQryLastID.FieldByName('VeiculoOID').AsInteger;

      for  lCombustivel in pVeiculo.Combustiveis do
      begin
        ParamByName('CombustivelID').AsInteger := lCombustivel.CombustivelOID;
        ExecSQL;

      end;
    end;

    Result := True;

  finally
    DataModule1.DestruirQuery(lQry);
    DataModule1.DestruirQuery(lQryLastID);
    DataModule1.DestruirQuery(lQryInsertCombustivel);
    DataModule1.DestruirQuery(lQryInsertSeguro);

  end;
end;

function TVeiculoController.AlterarVeiculo(pVeiculo: TVeiculo): Boolean;
var
  lQry: TFDQuery;
begin
  Result := False;
  lQry := DataModule1.ObterQuery;
  try

    with lQry do
    begin
      SQL.Add('UPDATE Veiculo SET ');
      SQL.Add('  Marca = :Marca,');
      SQL.Add('  Modelo = :Modelo, ');
      SQL.Add('  Placa = :Placa, ');
      SQL.Add('  Renavam = :Renavam, ');
      SQL.Add('  Cor = :Cor, ');
      SQL.Add('  Ano = :Ano ');
      SQL.Add('WHERE VeiculoOID = :VeiculoOID');

      ParamByName('Marca').AsString := pVeiculo.Marca;
      ParamByName('Modelo').AsString := pVeiculo.Modelo.Trim;
      ParamByName('Placa').AsString := pVeiculo.Placa.Trim;
      ParamByName('Renavam').AsString := pVeiculo.Renavam.Trim;
      ParamByName('Cor').AsString := pVeiculo.Cor.Trim;
      ParamByName('Ano').AsString := pVeiculo.Ano.Trim;
      ParamByName('VeiculoOID').AsInteger := pVeiculo.VeiculoOID;
      ExecSQL;

      AtualizaVeiculoCombustivel(pVeiculo);
      AtualizaSeguroVeiculo(pVeiculo);
      Result := True;
    end;

  finally
    DataModule1.DestruirQuery(lQry);
  end;

end;

procedure TVeiculoController.AtualizaSeguroVeiculo(pVeiculo: TVeiculo);
var
  lQry: TFDQuery;
  lSeguro: TSeguro;
begin
  lQry := DataModule1.ObterQuery;
  try
    with lQry do
    begin
      SQL.Add('DELETE FROM SeguroVeiculo WHERE VeiculoOID = :VeiculoOID');
      ParamByName('VeiculoOID').AsInteger := pVeiculo.VeiculoOID;

      ExecSql;


      SQL.Clear;
      SQL.Add('INSERT INTO SeguroVeiculo (VeiculoOID, SeguroOID) VALUES(:VeiculoOID, :SeguroOID)');
      ParamByName('VeiculoOID').AsInteger := pVeiculo.VeiculoOID;

      for lSeguro in pVeiculo.Seguros do
      begin
        ParamByName('SeguroOID').AsInteger := lSeguro.SeguroOID;
        ExecSQL;
      end;

    end;
  finally
    DataModule1.DestruirQuery(lQry);
  end;

end;

procedure TVeiculoController.AtualizaVeiculoCombustivel(pVeiculo: TVeiculo);
var
  lQry: TFDQuery;
  lCombustivel: TCombustivel;
begin
  lQry := DataModule1.ObterQuery;
  try
    with lQry do
    begin
      SQL.Add('DELETE FROM VeiculoCombustivel WHERE VeiculoID = :VeiculoOID');
      ParamByName('VeiculoOID').AsInteger := pVeiculo.VeiculoOID;

      ExecSql;

      SQL.Clear;
      SQL.Add('INSERT INTO VeiculoCombustivel (VeiculoID, CombustivelID) VALUES(:VeiculoOID, :CombustivelOID)');
      ParamByName('VeiculoOID').AsInteger := pVeiculo.VeiculoOID;

      for lCombustivel in pVeiculo.Combustiveis do
      begin
        ParamByName('CombustivelOID').AsInteger := lCombustivel.CombustivelOID;
        ExecSQL;
      end;
    end;
  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

function TVeiculoController.Veiculos: TJSONValue;
var
  lVeiculo: TVeiculo;
  lQry: TFDQuery;
//  lVeiculoJSON: TJSONValue;
begin
  lQry := DataModule1.ObterQuery;
  try
    with lQry do
    begin
      Open('SELECT * FROM Veiculo');
      if IsEmpty then
      begin
        Result := TJSONString.Create('Nenhum Veículo encontrado!');
        ConfigurarResponse(tmNotFound);
      end;

      Result := TJSONArray.Create;

      while not Eof do
      begin
        lVeiculo := ObterVeiculoDaQuery(lQry);
//        lVeiculoJSON := ConverterVeiculoParaJSON(lVeiculo);
//        (Result as TJSONArray).AddElement(TJson.ObjectToJsonObject(lVeiculo));
//        (Result as TJSONArray).AddElement(lVeiculoJSON);
        (Result as TJSONArray).AddElement(lVeiculo.ToJson);
        ConfigurarResponse(tmOK);
        Next;
      end;

    end;
  finally
    DataModule1.DestruirQuery(lQry);
  end;
end;

procedure TVeiculoController.ValidarVeiculo(pVeiculoEnviado: TVeiculo);
var
  lSvcSeguro: TSeguroService;
  lSvcCombustivel: TCombustivelService;
  lSeguro, lSeguroExiste: TSeguro;
  lCombustivel, lCombustivelExiste: TCombustivel;
begin

  lSvcSeguro := TSeguroService.Create;
  lSvcCombustivel := TCombustivelService.Create;
  try
    for lSeguro in pVeiculoEnviado.Seguros do
    begin
      lSeguroExiste := lSvcSeguro.ObterSeguroPeloOID(lSeguro.SeguroOID);
      if not Assigned(lSeguroExiste) then
        raise Exception.Create('Seguro não encontrado. OID: ' + lSeguro.SeguroOID.ToString)
      else
        lSeguroExiste.Free;
    end;

    for lCombustivel in pVeiculoEnviado.Combustiveis do
    begin
      lCombustivelExiste := lSvcCombustivel.ObterCombustivelPeloOID(lCombustivel.CombustivelOID);
      if not Assigned(lCombustivelExiste) then
        raise Exception.Create('Combustível não encontrado. OID: ' + lCombustivel.CombustivelOID.ToString)
      else
        lCombustivelExiste.Free;
    end;

  finally
    lSvcSeguro.Free;
    lSvcCombustivel.Free;

  end;

end;

function TVeiculoController.Veiculo(ID: Integer): TJSONValue;
var
  lVeiculo: TVeiculo;
begin
  lVeiculo := ObterVeiculoPeloOID(ID);

  if not Assigned(lVeiculo) then
  begin
    Result := TJSONString.Create('Veiculo não encontrado!');
    ConfigurarResponse(tmNotFound);
  end
  else
  begin
    Result := TJson.ObjectToJsonObject(lVeiculo);
    ConfigurarResponse(tmOK);
    lVeiculo.Free;
  end;

end;

function TVeiculoController.acceptVeiculo(Veiculo: TJSONObject): TJSONValue;
var
  lVeiculoEnviado, lVeiculoCadastrado: TVeiculo;
begin
  lVeiculoEnviado := TVeiculo.Create(Veiculo);

  try
    lVeiculoCadastrado := ObterVeiculoPeloOID(lVeiculoEnviado.VeiculoOID);
    if Assigned(lVeiculoCadastrado) then
    begin
      Result := TJSONString.Create('Veículo já cadastrado. Inclusão cancelada!');
      ConfigurarResponse(tmObjectAlreadyExists);

      lVeiculoCadastrado.Free;
      Exit;
    end;

    try
      ValidarVeiculo(lVeiculoEnviado);

      if IncluirVeiculo(lVeiculoEnviado) then
      begin
        Result := TJSONString.Create('Veículo gravado com sucesso!');
        ConfigurarResponse(tmOK);
      end
      else
        raise Exception.Create('Erro ao gravar o Veículo!');

    except
      on e: Exception do
      begin
        Result := TJSONString.Create(e.Message);
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    lVeiculoEnviado.Free;
  end;

end;

function TVeiculoController.updateVeiculo(Veiculo: TJSONObject): TJSONValue;
var
  lVeiculoEnviado, lVeiculoCadastrado: TVeiculo;
begin

  lVeiculoEnviado := TVeiculo.Create(Veiculo);
  try
    lVeiculoCadastrado := ObterVeiculoPeloOID(lVeiculoEnviado.VeiculoOID);
    if not Assigned(lVeiculoCadastrado) then
    begin
      Result := TJSONString.Create('Veículo já não encontrado!');
      ConfigurarResponse(tmNotFound);

      Exit;
    end;

    lVeiculoCadastrado.Free;
    try
      ValidarVeiculo(lVeiculoEnviado);

      if AlterarVeiculo(lVeiculoEnviado) then
      begin
        Result := TJSONString.Create('Veículo gravado com sucesso!');
        ConfigurarResponse(tmOK);
      end
      else
        raise Exception.Create('Erro ao gravar o Veículo!');

    except
      on e: Exception do
      begin
        Result := TJSONString.Create(e.Message);
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    lVeiculoEnviado.Free;
  end;
end;

function TVeiculoController.cancelVeiculo(ID: Integer): TJSONValue;
var
  lQry: TFDQuery;
  lVeiculo: TVeiculo;
begin

  lVeiculo := ObterVeiculoPeloOID(ID);
  if not Assigned(lVeiculo) then
  begin
    Result := TJSONString.Create('Veículo não encontrado!');
    ConfigurarResponse(tmNotFound);
    Exit;
  end;

  lVeiculo.Free;
  lQry := DataModule1.ObterQuery;
  try
    try
      with lQry do
      begin
        SQL.Add('DELETE FROM Veiculo WHERE VeiculoOID = :VeiculoOID');
        ParamByName('VeiculoOID').AsInteger := ID;
        ExecSQL;
        Result := TJSONString.Create('Veículo excluído com sucesso!');
        ConfigurarResponse(tmOK);
      end;
    except
      on e: Exception do
      begin
        Result := TJSONString.Create('Erro ao excluir o Veículo!');
        ConfigurarResponse(tmUndefinedError);
      end;
    end;
  finally
    DataModule1.DestruirQuery(lQry);
  end;

end;



end.


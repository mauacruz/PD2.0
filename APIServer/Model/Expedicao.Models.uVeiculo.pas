unit Expedicao.Models.uVeiculo;

interface
uses
  System.JSON,
  System.Generics.Collections,
  Expedicao.Models.uCombustivel,
  Expedicao.Models.uSeguro;

type
  TVeiculo = class
    private
      FCor: string;
      FModelo: string;
      FVeiculoOID: Integer;
      FAno: string;
      FMarca: string;
      FRenavam: string;
      FPlaca: string;

      FListaCombustivel: TObjectList<TCombustivel>;
      FListaSeguro: TObjectList<TSeguro>;

      procedure SetAno(const Value: string);
      procedure SetCor(const Value: string);
      procedure SetMarca(const Value: string);
      procedure SetModelo(const Value: string);
      procedure SetPlaca(const Value: string);
      procedure SetRenavam(const Value: string);
      procedure SetVeiculoOID(const Value: Integer);
    function GetToJson: TJSONValue;


    public
      constructor Create; overload;
      constructor Create(pVeiculoJSON: TJSONObject); overload;

      destructor Destroy; override;

      property VeiculoOID: Integer read FVeiculoOID write SetVeiculoOID;
      property Marca: string read FMarca write SetMarca;
      property Modelo: string read FModelo write SetModelo;
      property Placa: string read FPlaca write SetPlaca;
      property Renavam: string read FRenavam write SetRenavam;
      property Cor: string read FCor write SetCor;
      property Ano: string read FAno write SetAno;
      property Combustiveis: TObjectList<TCombustivel> read FListaCombustivel;
      property Seguros: TObjectList<TSeguro> read FListaSeguro;

      property ToJson: TJSONValue read GetToJson;
  end;

implementation
uses
  System.SysUtils,
  REST.jSON;

{ TVeiculo }

constructor TVeiculo.Create;
begin
  inherited;
  FListaCombustivel := TObjectList<TCombustivel>.Create(True);
  FListaSeguro := TObjectList<TSeguro>.Create(True);

end;

constructor TVeiculo.Create(pVeiculoJSON: TJSONObject);
var
  lArrCombustiveis: TJSONArray;
  lCombustivelJSON: TJSONObject;
  lCombustivel: TCombustivel;

  lArrSeguros: TJSONArray;
  lSeguroJSON: TJSONObject;
  lSeguro: TSeguro;
  I: Integer;
begin
  inherited Create;

  FListaCombustivel := TObjectList<TCombustivel>.Create(True);
  FListaSeguro := TObjectList<TSeguro>.Create(True);

  Self.VeiculoOID := TJSONNumber(pVeiculoJSON.GetValue('VeiculoOID')).AsInt;
  Self.Marca := TJSONString(pVeiculoJSON.GetValue('Marca')).Value;
  Self.Modelo := TJSONString(pVeiculoJSON.GetValue('Modelo')).Value;
  Self.Placa := TJSONString(pVeiculoJSON.GetValue('Placa')).Value;
  Self.Renavam := TJSONString(pVeiculoJSON.GetValue('Renavam')).Value;
  Self.Cor := TJSONString(pVeiculoJSON.GetValue('Cor')).Value;
  Self.Ano := TJSONString(pVeiculoJSON.GetValue('Ano')).Value;

  lArrCombustiveis := TJSONArray(pVeiculoJSON.GetValue('Combustiveis'));

  if lArrCombustiveis.Count > 0 then
  begin
    for I := 0 to Pred(lArrCombustiveis.Count) do
    begin

      lCombustivelJSON := TJSONObject(lArrCombustiveis.Items[I]);
      lCombustivel := TJson.JsonToObject<TCombustivel>(lCombustivelJSON);
      Self.Combustiveis.Add(lCombustivel)
    end;
  end;


  lArrSeguros := TJSONArray(pVeiculoJSON.GetValue('Seguros'));
  if lArrSeguros.Count > 0 then
  begin
    for I := 0 to Pred(lArrSeguros.Count) do
    begin
      lSeguroJSON := TJSONObject(lArrSeguros.Items[I]);
      lSeguro := TJson.JsonToObject<TSeguro>(lSeguroJSON);
      Self.Seguros.Add(lSeguro);
    end;
  end;
end;

destructor TVeiculo.Destroy;
begin
  FListaCombustivel.Clear;
  FListaCombustivel.Free;

  FListaSeguro.Clear;
  FListaSeguro.Free;

  inherited;
end;

function TVeiculo.GetToJson: TJSONValue;
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
    AddPair('VeiculoOID', Self.VeiculoOID.ToString);
    AddPair('Marca', Self.Marca);
    AddPair('Modelo', Self.Modelo);
    AddPair('Placa', Self.Placa);
    AddPair('Renavam', Self.Renavam);
    AddPair('Cor', Self.Cor);
    AddPair('Ano', Self.Ano);

    lSeguroJSONArray := TJSONArray.Create;
    for lSeguro in Self.Seguros do
    begin
      lSeguroJSON := TJson.ObjectToJsonObject(lSeguro);
      lSeguroJSONArray.AddElement(lSeguroJSON);
    end;

    AddPair('Seguros', lSeguroJSONArray);

    lCombustivelTJSONArray := TJSONArray.Create;
    for lCombustivel in Self.Combustiveis do
    begin
      lCombustivelJSON := TJson.ObjectToJsonObject(lCombustivel);
      lCombustivelTJSONArray.AddElement(lCombustivelJSON);
    end;

    AddPair('Combustiveis', lCombustivelTJSONArray);
  end;

end;

procedure TVeiculo.SetAno(const Value: string);
begin
  FAno := Value;
end;

procedure TVeiculo.SetCor(const Value: string);
begin
  FCor := Value;
end;

procedure TVeiculo.SetMarca(const Value: string);
begin
  FMarca := Value;
end;

procedure TVeiculo.SetModelo(const Value: string);
begin
  FModelo := Value;
end;

procedure TVeiculo.SetPlaca(const Value: string);
begin
  FPlaca := Value;
end;

procedure TVeiculo.SetRenavam(const Value: string);
begin
  FRenavam := Value;
end;

procedure TVeiculo.SetVeiculoOID(const Value: Integer);
begin
  FVeiculoOID := Value;
end;

end.

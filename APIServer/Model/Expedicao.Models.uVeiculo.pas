unit Expedicao.Models.uVeiculo;

interface
uses
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
      FRenavan: string;
      FPlaca: string;

      FListaCombustivel: TObjectList<TCombustivel>;
      FListaSeguro: TObjectList<TSeguro>;

      procedure SetAno(const Value: string);
      procedure SetCor(const Value: string);
      procedure SetMarca(const Value: string);
      procedure SetModelo(const Value: string);
      procedure SetPlaca(const Value: string);
      procedure SetRenavan(const Value: string);
      procedure SetVeiculoOID(const Value: Integer);


    public
      constructor Create;
      destructor Destroy; override;

      property VeiculoOID: Integer read FVeiculoOID write SetVeiculoOID;
      property Marca: string read FMarca write SetMarca;
      property Modelo: string read FModelo write SetModelo;
      property Placa: string read FPlaca write SetPlaca;
      property Renavan: string read FRenavan write SetRenavan;
      property Cor: string read FCor write SetCor;
      property Ano: string read FAno write SetAno;
      property Combustiveis: TObjectList<TCombustivel> read FListaCombustivel;
      property Seguros: TObjectList<TSeguro> read FListaSeguro;

  end;

implementation

{ TVeiculo }

constructor TVeiculo.Create;
begin
  FListaCombustivel := TObjectList<TCombustivel>.Create(True);
  FListaSeguro := TObjectList<TSeguro>.Create(True);

end;

destructor TVeiculo.Destroy;
begin
  FListaCombustivel.Clear;
  FListaCombustivel.Free;

  FListaSeguro.Clear;
  FListaSeguro.Free;

  inherited;
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

procedure TVeiculo.SetRenavan(const Value: string);
begin
  FRenavan := Value;
end;

procedure TVeiculo.SetVeiculoOID(const Value: Integer);
begin
  FVeiculoOID := Value;
end;

end.

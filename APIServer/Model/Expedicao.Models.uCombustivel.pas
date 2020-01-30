unit Expedicao.Models.uCombustivel;

interface
type
  TCombustivel = class
    private
      FValor: Currency;
      FDescricao: string;
      FCombustivelOID: Integer;
      FUnidadeDeMedidaOID: Integer;
      procedure SetCombustivelOID(const Value: Integer);
      procedure SetDescricao(const Value: string);
      procedure SetUnidadeDeMedidaOID(const Value: Integer);
      procedure SetValor(const Value: Currency);
    public
      property CombustivelOID: Integer read FCombustivelOID write SetCombustivelOID;
      property Descricao: string read FDescricao write SetDescricao;
      property Valor: Currency read FValor write SetValor;
      property UnidadeDeMedidaOID: Integer read FUnidadeDeMedidaOID write SetUnidadeDeMedidaOID;
  end;

implementation

{ TCombustivel }

procedure TCombustivel.SetCombustivelOID(const Value: Integer);
begin
  FCombustivelOID := Value;
end;

procedure TCombustivel.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TCombustivel.SetUnidadeDeMedidaOID(const Value: Integer);
begin
  FUnidadeDeMedidaOID := Value;
end;

procedure TCombustivel.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.

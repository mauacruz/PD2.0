unit Expedicao.Models.uInfracao;

interface

type
  TInfracao = class
    private
      FInfracaoOID: Integer;
      FTipoInfracao: string;
      FVeiculoOID: Integer;
      FData: TDateTime;
      FHora: string;
      FAutoInfracao: string;
      FOrgao: string;
      FValor: Currency;
      FAutorInfracao: Integer;

      procedure SetInfracaoOID(const Value: Integer);
      procedure SetTipoInfracao(const Value: string);
      procedure SetVeiculoOID(const Value: Integer);
      procedure SetData(const Value: TDateTime);
      procedure SetHora(const Value: string);
      procedure SetAutoInfracao(const Value: string);
      procedure SetOrgao(const Value: string);
      procedure SetValor(const Value: Currency);
      procedure SetAutorInfracao(const Value: Integer);

    public
      property InfracaoOID: Integer read FInfracaoOID write SetInfracaoOID;
      property TipoInfracao: string read FTipoInfracao write SetTipoInfracao;
      property VeiculoOID: Integer read FVeiculoOID write SetVeiculoOID;
      property Data: TDateTime read FData write SetData;
      property Hora: string read FHora write SetHora;
      property AutoInfracao: string read FAutoInfracao write SetAutoInfracao;
      property Orgao: string read FOrgao write SetOrgao;
      property Valor: Currency read FValor write SetValor;
      property AutorInfracao: Integer read FAutorInfracao write SetAutorInfracao;
  end;

implementation

{ TInfracao }

procedure TInfracao.SetAutoInfracao(const Value: string);
begin
  FAutoInfracao := Value;
end;

procedure TInfracao.SetAutorInfracao(const Value: Integer);
begin
  FAutorInfracao := Value;
end;

procedure TInfracao.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TInfracao.SetHora(const Value: string);
begin
  FHora := Value;
end;

procedure TInfracao.SetInfracaoOID(const Value: Integer);
begin
  FInfracaoOID := Value;
end;

procedure TInfracao.SetOrgao(const Value: string);
begin
  FOrgao := Value;
end;

procedure TInfracao.SetTipoInfracao(const Value: string);
begin
  FTipoInfracao := Value;
end;

procedure TInfracao.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

procedure TInfracao.SetVeiculoOID(const Value: Integer);
begin
  FVeiculoOID := Value;
end;

end.

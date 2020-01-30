unit Expedicao.Models.uRomaneio;

interface
type
  TRomaneio = class
    private
      FKMSaida: Real;
      FRetorno: TDateTime;
      FCondutorOID: Integer;
      FKMRodado: Real;
      FKMRetorno: Real;
      FVeiculoOID: Integer;
      FFuncionarioSaidaOID: Integer;
      FRomaneioOID: Integer;
      FFuncionarioRetornoOID: Integer;
      FSaida: TDateTime;

      procedure SetCondutorOID(const Value: Integer);
      procedure SetFuncionarioRetornoOID(const Value: Integer);
      procedure SetFuncionarioSaidaOID(const Value: Integer);
      procedure SetKMRetorno(const Value: Real);
      procedure SetKMRodado(const Value: Real);
      procedure SetKMSaida(const Value: Real);
      procedure SetRetorno(const Value: TDateTime);
      procedure SetRomaneioOID(const Value: Integer);
      procedure SetSaida(const Value: TDateTime);
      procedure SetVeiculoOID(const Value: Integer);

    public
      property RomaneioOID: Integer read FRomaneioOID write SetRomaneioOID;
      property VeiculoOID: Integer read FVeiculoOID write SetVeiculoOID;
      property CondutorOID: Integer read FCondutorOID write SetCondutorOID;
      property Saida: TDateTime read FSaida write SetSaida;
      property Retorno: TDateTime read FRetorno write SetRetorno;
      property KMSaida: Real read FKMSaida write SetKMSaida;
      property KMRetorno: Real read FKMRetorno write SetKMRetorno;
      property KMRodado: Real read FKMRodado write SetKMRodado;
      property FuncionarioSaidaOID: Integer read FFuncionarioSaidaOID write SetFuncionarioSaidaOID;
      property FuncionarioRetornoOID: Integer read FFuncionarioRetornoOID write SetFuncionarioRetornoOID;
  end;

implementation

{ TRomaneio }

procedure TRomaneio.SetCondutorOID(const Value: Integer);
begin
  FCondutorOID := Value;
end;

procedure TRomaneio.SetFuncionarioRetornoOID(const Value: Integer);
begin
  FFuncionarioRetornoOID := Value;
end;

procedure TRomaneio.SetFuncionarioSaidaOID(const Value: Integer);
begin
  FFuncionarioSaidaOID := Value;
end;

procedure TRomaneio.SetKMRetorno(const Value: Real);
begin
  FKMRetorno := Value;
end;

procedure TRomaneio.SetKMRodado(const Value: Real);
begin
  FKMRodado := Value;
end;

procedure TRomaneio.SetKMSaida(const Value: Real);
begin
  FKMSaida := Value;
end;

procedure TRomaneio.SetRetorno(const Value: TDateTime);
begin
  FRetorno := Value;
end;

procedure TRomaneio.SetRomaneioOID(const Value: Integer);
begin
  FRomaneioOID := Value;
end;

procedure TRomaneio.SetSaida(const Value: TDateTime);
begin
  FSaida := Value;
end;

procedure TRomaneio.SetVeiculoOID(const Value: Integer);
begin
  FVeiculoOID := Value;
end;

end.

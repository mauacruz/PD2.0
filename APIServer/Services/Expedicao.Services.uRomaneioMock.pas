unit Expedicao.Services.uRomaneioMock;

interface
uses
  Generics.Collections,
  Expedicao.Interfaces.uRomaneioPersistencia,
  Expedicao.Models.uRomaneio;

type
  TRomaneioMock = class (TInterfacedObject, IRomaneioPersistencia)
    private
      FListaRomaneio: TObjectList<TRomaneio>;

    public
      constructor Create;
      destructor Destroy; override;

      function ObterListaRomaneio: TList<TRomaneio>;
      function ObterRomaneio(pRomaneioOID: Integer): TRomaneio;
      function IncluirRomaneio(pRomaneio: TRomaneio): Boolean;
      function AlterarRomaneio(pRomaneio: TRomaneio): Boolean;
      function ExcluirRomaneio(pRomaneioOID: Integer): Boolean;
  end;

implementation
uses
  SysUtils;

{ TRomaneioMock }

constructor TRomaneioMock.Create;
var
  lRomaneio: TRomaneio;
begin
  FListaRomaneio := TObjectList<TRomaneio>.Create;

  lRomaneio := TRomaneio.Create;
  lRomaneio.RomaneioOID := 1;
  lRomaneio.VeiculoOID := 1;
  lRomaneio.CondutorOID := 1;
  lRomaneio.Saida := StrToDate('15/01/2020');
  lRomaneio.Retorno := StrToDate('15/01/2020');
  lRomaneio.KMSaida := 70200;
  lRomaneio.KMRetorno := 70400;
  lRomaneio.KMRodado := 200;
  lRomaneio.FuncionarioSaidaOID := 1;
  lRomaneio.FuncionarioRetornoOID := 1;
  FListaRomaneio.Add(lRomaneio);

  lRomaneio := TRomaneio.Create;
  lRomaneio.RomaneioOID := 2;
  lRomaneio.VeiculoOID := 2;
  lRomaneio.CondutorOID := 2;
  lRomaneio.Saida := StrToDate('20/02/2020');
  lRomaneio.Retorno := StrToDate('20/02/2020');
  lRomaneio.KMSaida := 150480;
  lRomaneio.KMRetorno := 150540;
  lRomaneio.KMRodado := 60;
  lRomaneio.FuncionarioSaidaOID := 2;
  lRomaneio.FuncionarioRetornoOID := 2;
  FListaRomaneio.Add(lRomaneio);


end;

destructor TRomaneioMock.Destroy;
begin
  FListaRomaneio.Clear;
  FListaRomaneio.Free;
  inherited;
end;

function TRomaneioMock.AlterarRomaneio(pRomaneio: TRomaneio): Boolean;
var
  lRomaneio: TRomaneio;
begin

  Result := False;
  for lRomaneio in FListaRomaneio do
    if lRomaneio.RomaneioOID = pRomaneio.RomaneioOID then
    begin

      lRomaneio.VeiculoOID := pRomaneio.VeiculoOID;
      lRomaneio.CondutorOID := pRomaneio.CondutorOID;
      lRomaneio.Saida := pRomaneio.Saida;
      lRomaneio.Retorno := pRomaneio.Retorno;
      lRomaneio.KMSaida := pRomaneio.KMSaida;
      lRomaneio.KMRetorno := pRomaneio.KMRetorno;
      lRomaneio.KMRodado := pRomaneio.KMRodado;
      lRomaneio.FuncionarioSaidaOID := pRomaneio.FuncionarioSaidaOID;
      lRomaneio.FuncionarioRetornoOID := pRomaneio.FuncionarioRetornoOID;
      Result := True;
      Exit;
    end;

end;

function TRomaneioMock.ExcluirRomaneio(pRomaneioOID: Integer): Boolean;
var
  lRomaneio: TRomaneio;
begin

  Result := False;
  for lRomaneio in FListaRomaneio do
    if lRomaneio.RomaneioOID = pRomaneioOID then
    begin
      FListaRomaneio.Remove(lRomaneio);
      Result := True;
      Exit;
    end;

end;

function TRomaneioMock.IncluirRomaneio(pRomaneio: TRomaneio): Boolean;
begin
  pRomaneio.RomaneioOID := FListaRomaneio.Count + 1;
  FListaRomaneio.Add(pRomaneio);

  Result := True;
end;

function TRomaneioMock.ObterListaRomaneio: TList<TRomaneio>;
var
  lRomaneio: TRomaneio;
begin
  Result := TList<TRomaneio>.Create;

  for lRomaneio in FListaRomaneio do
    Result.Add(lRomaneio);

end;

function TRomaneioMock.ObterRomaneio(pRomaneioOID: Integer): TRomaneio;
var
  lRomaneio: TRomaneio;
begin
  Result := nil;

  for lRomaneio in FListaRomaneio do
    if lRomaneio.RomaneioOID = pRomaneioOID then
    begin
      Result := lRomaneio;
      Exit;
    end;

end;

end.

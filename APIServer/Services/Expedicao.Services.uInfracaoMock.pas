unit Expedicao.Services.uInfracaoMock;

interface
uses
  Generics.Collections,
  Expedicao.Interfaces.uInfracaoPersistencia,
  Expedicao.Models.uInfracao;

type
  TInfracaoMock = class (TInterfacedObject, IInfracaoPersistencia)
    private
      FListaInfracao: TObjectList<TInfracao>;

    public
      constructor Create;
      destructor Destroy; override;

      function ObterListaInfracao: TList<TInfracao>;
      function ObterInfracao(pInfracaoOID: Integer): TInfracao;
      function IncluirInfracao(pInfracao: TInfracao): Boolean;
      function AlterarInfracao(pInfracao: TInfracao): Boolean;
      function ExcluirInfracao(pInfracaoOID: Integer): Boolean;
  end;

implementation
uses
  SysUtils;

{ TInfracaoMock }

constructor TInfracaoMock.Create;
var
  lInfracao: TInfracao;
begin

  FListaInfracao := TObjectList<TInfracao>.Create(true);
  lInfracao := TInfracao.Create;
  lInfracao.InfracaoOID := 1;
  lInfracao.VeiculoOID := 1;
  lInfracao.Data := StrToDate('14/01/2020');
  lInfracao.Hora := '10:55';
  lInfracao.AutoInfracao := 'xxxx';
  lInfracao.Orgao := 'DETRAN';
  lInfracao.Valor := 125.90;
  lInfracao.AutorInfracao := 1;
  lInfracao.TipoInfracao := 'M';
  FListaInfracao.Add(lInfracao);

  lInfracao := TInfracao.Create;
  lInfracao.InfracaoOID := 2;
  lInfracao.VeiculoOID := 2;
  lInfracao.Data := StrToDate('20/01/2020');
  lInfracao.Hora := '22:30';
  lInfracao.AutoInfracao := 'yyys';
  lInfracao.Orgao := 'DETRAN';
  lInfracao.Valor := 201.50;
  lInfracao.AutorInfracao := 2;
  lInfracao.TipoInfracao := 'M';
  FListaInfracao.Add(lInfracao);

end;

destructor TInfracaoMock.Destroy;
begin
  FListaInfracao.Clear;
  FListaInfracao.Free;
  inherited;
end;

function TInfracaoMock.AlterarInfracao(pInfracao: TInfracao): Boolean;
var
  lInfracao: TInfracao;
begin

  Result := False;
  for lInfracao in FListaInfracao do
    if lInfracao.InfracaoOID = pInfracao.InfracaoOID then
    begin
      lInfracao.VeiculoOID := pInfracao.VeiculoOID;
      lInfracao.Data := pInfracao.Data;
      lInfracao.Hora := pInfracao.Hora;
      lInfracao.AutoInfracao := pInfracao.AutoInfracao;
      lInfracao.Orgao := pInfracao.Orgao;
      lInfracao.Valor := pInfracao.Valor;
      lInfracao.AutorInfracao := pInfracao.AutorInfracao;
      lInfracao.TipoInfracao := pInfracao.TipoInfracao;
      Result := True;
      Exit;
    end;

end;

function TInfracaoMock.ExcluirInfracao(pInfracaoOID: Integer): Boolean;
var
  lInfracao: TInfracao;
begin

  Result := False;
  for lInfracao in FListaInfracao do
    if lInfracao.InfracaoOID = pInfracaoOID then
    begin
      FListaInfracao.Remove(lInfracao);
      Result := True;
      Exit;
    end;

end;

function TInfracaoMock.IncluirInfracao(pInfracao: TInfracao): Boolean;
begin
  pInfracao.InfracaoOID := FListaInfracao.Count + 1;
  FListaInfracao.Add(pInfracao);

  Result := True;
end;

function TInfracaoMock.ObterInfracao(pInfracaoOID: Integer): TInfracao;
var
  lInfracao: TInfracao;
begin
  Result := nil;

  for lInfracao in FListaInfracao do
    if lInfracao.InfracaoOID = pInfracaoOID then
    begin
      Result := lInfracao;
      Exit;
    end;
end;

function TInfracaoMock.ObterListaInfracao: TList<TInfracao>;
var
  lInfracao: TInfracao;
begin
  Result := TList<TInfracao>.Create;

  for lInfracao in FListaInfracao do
    Result.Add(lInfracao);

end;

end.

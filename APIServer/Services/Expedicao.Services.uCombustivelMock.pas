unit Expedicao.Services.uCombustivelMock;

interface
uses
  Generics.Collections,
  Expedicao.Interfaces.uCombustivelPersistencia,
  Expedicao.Models.uCombustivel;

type
  TCombustivelMock = class (TInterfacedObject, ICombustivelPersistencia)
    private
      FListaCombustivel: TObjectList<TCombustivel>;

    public
      constructor Create;
      destructor Destroy; override;

      function ObterListaCombustivel: TList<TCombustivel>;
      function ObterCombustivel(pCombustivelOID: Integer): TCombustivel;
      function IncluirCombustivel(pCombustivel: TCombustivel): Boolean;
      function AlterarCombustivel(pCombustivel: TCombustivel): Boolean;
      function ExcluirCombustivel(pCombustivelOID: Integer): Boolean;
  end;

implementation

{ TCombustivelMock }

constructor TCombustivelMock.Create;
var
  lCombustivel: TCombustivel;
begin
  FListaCombustivel := TObjectList<TCombustivel>.Create;

  lCombustivel := TCombustivel.Create;
  lCombustivel.CombustivelOID := 1;
  lCombustivel.Descricao := 'Gasolina';
  lCombustivel.Valor := 4.29;
  lCombustivel.UnidadeDeMedidaOID := 1;
  FListaCombustivel.Add(lCombustivel);

  lCombustivel := TCombustivel.Create;
  lCombustivel.CombustivelOID := 2;
  lCombustivel.Descricao := 'Alcool';
  lCombustivel.Valor := 2.89;
  lCombustivel.UnidadeDeMedidaOID := 1;
  FListaCombustivel.Add(lCombustivel);

end;

destructor TCombustivelMock.Destroy;
begin
  FListaCombustivel.Clear;
  FListaCombustivel.Free;

  inherited;
end;

function TCombustivelMock.AlterarCombustivel(
  pCombustivel: TCombustivel): Boolean;
var
  lCombustivel: TCombustivel;
begin

  Result := False;
  for lCombustivel in FListaCombustivel do
    if lCombustivel.CombustivelOID = pCombustivel.CombustivelOID then
    begin
      lCombustivel.Descricao := pCombustivel.Descricao;
      lCombustivel.Valor := pCombustivel.Valor;
      lCombustivel.UnidadeDeMedidaOID := pCombustivel.UnidadeDeMedidaOID;
      Result := True;
      Exit;
    end;

end;


function TCombustivelMock.ExcluirCombustivel(pCombustivelOID: Integer): Boolean;
var
  lCombustivel: TCombustivel;
begin

  Result := False;
  for lCombustivel in FListaCombustivel do
    if lCombustivel.CombustivelOID = pCombustivelOID then
    begin
      FListaCombustivel.Remove(lCombustivel);
      Result := True;
      Exit;
    end;

end;

function TCombustivelMock.IncluirCombustivel(
  pCombustivel: TCombustivel): Boolean;
begin
  pCombustivel.CombustivelOID := FListaCombustivel.Count + 1;
  FListaCombustivel.Add(pCombustivel);

  Result := True;
end;

function TCombustivelMock.ObterCombustivel(
  pCombustivelOID: Integer): TCombustivel;
begin

end;

function TCombustivelMock.ObterListaCombustivel: TList<TCombustivel>;
var
  lCombustivel: TCombustivel;
begin
  Result := TList<TCombustivel>.Create;

  for lCombustivel in FListaCombustivel do
    Result.Add(lCombustivel);

end;

end.

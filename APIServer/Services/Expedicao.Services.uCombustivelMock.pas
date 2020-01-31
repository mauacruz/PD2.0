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

function TCombustivelMock.AlterarCombustivel(
  pCombustivel: TCombustivel): Boolean;
begin

end;

constructor TCombustivelMock.Create;
begin

end;

destructor TCombustivelMock.Destroy;
begin

  inherited;
end;

function TCombustivelMock.ExcluirCombustivel(pCombustivelOID: Integer): Boolean;
begin

end;

function TCombustivelMock.IncluirCombustivel(
  pCombustivel: TCombustivel): Boolean;
begin

end;

function TCombustivelMock.ObterCombustivel(
  pCombustivelOID: Integer): TCombustivel;
begin

end;

function TCombustivelMock.ObterListaCombustivel: TList<TCombustivel>;
begin

end;

end.

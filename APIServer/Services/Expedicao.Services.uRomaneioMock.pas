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

{ TRomaneioMock }

function TRomaneioMock.AlterarRomaneio(pRomaneio: TRomaneio): Boolean;
begin

end;

constructor TRomaneioMock.Create;
begin

end;

destructor TRomaneioMock.Destroy;
begin

  inherited;
end;

function TRomaneioMock.ExcluirRomaneio(pRomaneioOID: Integer): Boolean;
begin

end;

function TRomaneioMock.IncluirRomaneio(pRomaneio: TRomaneio): Boolean;
begin

end;

function TRomaneioMock.ObterListaRomaneio: TList<TRomaneio>;
begin

end;

function TRomaneioMock.ObterRomaneio(pRomaneioOID: Integer): TRomaneio;
begin

end;

end.

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

{ TInfracaoMock }

function TInfracaoMock.AlterarInfracao(pInfracao: TInfracao): Boolean;
begin

end;

constructor TInfracaoMock.Create;
begin

end;

destructor TInfracaoMock.Destroy;
begin

  inherited;
end;

function TInfracaoMock.ExcluirInfracao(pInfracaoOID: Integer): Boolean;
begin

end;

function TInfracaoMock.IncluirInfracao(pInfracao: TInfracao): Boolean;
begin

end;

function TInfracaoMock.ObterInfracao(pInfracaoOID: Integer): TInfracao;
begin

end;

function TInfracaoMock.ObterListaInfracao: TList<TInfracao>;
begin

end;

end.

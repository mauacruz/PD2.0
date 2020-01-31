unit Expedicao.Services.uVeiculoMock;

interface
uses
  Generics.Collections,
  Expedicao.Interfaces.uVeiculoPersistencia,
  Expedicao.Models.uVeiculo;

type
  TVeiculoMock = class (TInterfacedObject, IVeiculoPersistencia)
    private
      FListaVeiculo: TObjectList<TVeiculo>;

    public
      constructor Create;
      destructor Destroy; override;

      function ObterListaVeiculo: TList<TVeiculo>;
      function ObterVeiculo(pVeiculoOID: Integer): TVeiculo;
      function IncluirVeiculo(pVeiculo: TVeiculo): Boolean;
      function AlterarVeiculo(pVeiculo: TVeiculo): Boolean;
      function ExcluirVeiculo(pVeiculoOID: Integer): Boolean;
  end;

implementation

{ TVeiculoMock }

function TVeiculoMock.AlterarVeiculo(pVeiculo: TVeiculo): Boolean;
begin

end;

constructor TVeiculoMock.Create;
begin

end;

destructor TVeiculoMock.Destroy;
begin

  inherited;
end;

function TVeiculoMock.ExcluirVeiculo(pVeiculoOID: Integer): Boolean;
begin

end;

function TVeiculoMock.IncluirVeiculo(pVeiculo: TVeiculo): Boolean;
begin

end;

function TVeiculoMock.ObterListaVeiculo: TList<TVeiculo>;
begin

end;

function TVeiculoMock.ObterVeiculo(pVeiculoOID: Integer): TVeiculo;
begin

end;

end.

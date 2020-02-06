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
uses
  Expedicao.Models.uCombustivel,
  Expedicao.Models.uSeguro;

{ TVeiculoMock }

constructor TVeiculoMock.Create;
var
  lVeiculo: TVeiculo;
  lCombustivel: TCombustivel;
  lSeguro : TSeguro;
begin
  FListaVeiculo := TObjectList<TVeiculo>.Create(True);

  lVeiculo := TVeiculo.Create;
  lVeiculo.Marca := 'Opalão';
  //...

  lCombustivel := TCombustivel.Create;
  lCombustivel.Descricao := 'Gasolina';

  lVeiculo.Combustiveis.Add(lCombustivel);

  lCombustivel := TCombustivel.Create;
  lCombustivel.Descricao := 'Alcool';

  lVeiculo.Combustiveis.Add(lCombustivel);


end;

destructor TVeiculoMock.Destroy;
begin
  FListaVeiculo.Clear;
  FListaVeiculo.Free;

  inherited;
end;

function TVeiculoMock.AlterarVeiculo(pVeiculo: TVeiculo): Boolean;
begin

end;


function TVeiculoMock.ExcluirVeiculo(pVeiculoOID: Integer): Boolean;
begin

end;

function TVeiculoMock.IncluirVeiculo(pVeiculo: TVeiculo): Boolean;
begin

end;

function TVeiculoMock.ObterListaVeiculo: TList<TVeiculo>;
begin
  Result := nil;
end;

function TVeiculoMock.ObterVeiculo(pVeiculoOID: Integer): TVeiculo;
begin
   result := nil;
end;

end.

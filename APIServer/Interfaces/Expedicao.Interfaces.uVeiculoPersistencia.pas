unit Expedicao.Interfaces.uVeiculoPersistencia;

interface
uses
  System.Generics.Collections,
  Expedicao.Models.uVeiculo;

type
  IVeiculoPersistencia = interface
  ['{BDF64CE2-17AB-463F-85DA-EDAD73B9731A}']

    function ObterListaVeiculo: TList<TVeiculo>;
    function ObterVeiculo(pVeiculoOID: Integer): TVeiculo;
    function IncluirVeiculo(pVeiculo: TVeiculo): Boolean;
    function AlterarVeiculo(pVeiculo: TVeiculo): Boolean;
    function ExcluirVeiculo(pVeiculoOID: Integer): Boolean;



  end;

implementation

end.

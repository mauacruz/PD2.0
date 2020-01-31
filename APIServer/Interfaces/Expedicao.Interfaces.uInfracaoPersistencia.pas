unit Expedicao.Interfaces.uInfracaoPersistencia;

interface
uses
  System.Generics.Collections,
  Expedicao.Models.uInfracao;
type
  IInfracaoPersistencia = interface
  ['{19E90F0C-754F-4C0D-9F01-265C67473511}']

    function ObterListaInfracao: TList<TInfracao>;
    function ObterInfracao(pInfracaoOID: Integer): TInfracao;
    function IncluirInfracao(pInfracao: TInfracao): Boolean;
    function AlterarInfracao(pInfracao: TInfracao): Boolean;
    function ExcluirInfracao(pInfracaoOID: Integer): Boolean;

  end;

implementation

end.

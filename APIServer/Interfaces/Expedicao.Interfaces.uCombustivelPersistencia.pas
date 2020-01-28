unit Expedicao.Interfaces.uCombustivelPersistencia;

interface
uses
  Generics.Collections,
  Expedicao.Models.uCombustivel;

type
  ICombustivelPersistencia = interface
  ['{98712061-7F4E-456B-9818-CFA2CB4B73AE}']

    function ObterListaCombustivel: TList<TCombustivel>;
    function ObterCombustivel(pCombustivelOID: Integer): TCombustivel;
    function IncluirCombustivel(pCombustivel: TCombustivel): Boolean;
    function AlterarCombustivel(pCombustivel: TCombustivel): Boolean;
    function ExcluirCombustivel(pCombustivelOID: Integer): Boolean;
  end;

implementation

end.

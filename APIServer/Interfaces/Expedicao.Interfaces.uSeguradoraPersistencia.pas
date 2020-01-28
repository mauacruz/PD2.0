unit Expedicao.Interfaces.uSeguradoraPersistencia;

interface
uses
  Generics.Collections,
  Expedicao.Models.uSeguradora;

type
  ISeguradoraPersistencia = interface
  ['{E6A477DC-2540-42E5-B82D-AE96F7A40680}']

    function ObterListaSeguradora: TList<TSeguradora>;
    function ObterSeguradora(pSeguradoraOID: Integer): TSeguradora;
    function IncluirSeguradora(pSeguradora: TSeguradora): Boolean;
    function AlterarSeguradora(pSeguradora: TSeguradora): Boolean;
    function ExcluirSeguradora(pSeguradoraOID: Integer): Boolean;
  end;

implementation

end.

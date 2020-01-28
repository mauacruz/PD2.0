unit Expedicao.Interfaces.uSeguradoraController;

interface
uses
  Generics.Collections,
  Expedicao.Models.uSeguradora;
type
  ISeguradoraController = interface
  ['{2077E48B-759E-42A4-99B2-7022B1111C0E}']

    function ObterListaSeguradora: TList<TSeguradora>;

  end;

implementation

end.

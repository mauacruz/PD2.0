unit Expedicao.Interfaces.uExpedicaoController;

interface
uses
  Generics.Collections,
  Expedicao.Models.uSeguradora;
type
  IExpedicaoController = interface
  ['{2077E48B-759E-42A4-99B2-7022B1111C0E}']

    (* Metodos - Veiculo *)

    (* Metodos - Combustivel *)

    (* Metodos - Seguro *)

    (* Metodos - Seguradora *)
    function ObterListaSeguradora: TObjectList<TSeguradora>;


    (* Metodos - Infração *)

    (* Metodos - Romaneio *)

  end;

implementation

end.

unit Expedicao.Interfaces.uRomaneioPersistencia;

interface

uses
  System.Generics.Collections,
  Expedicao.Models.uRomaneio;

type
  IRomaneioPersistencia = interface
    ['{46C4502E-F5A2-44EE-99C9-A79A8451C4C3}']

    function ObterListaRomaneio: TList<TRomaneio>;
    function ObterRomaneio(pRomaneioOID: Integer): TRomaneio;
    function IncluirRomaneio(pRomaneio: TRomaneio): Boolean;
    function AlterarRomaneio(pRomaneio: TRomaneio): Boolean;
    function ExcluirRomaneio(pRomaneioOID: Integer): Boolean;

  end;

implementation

end.

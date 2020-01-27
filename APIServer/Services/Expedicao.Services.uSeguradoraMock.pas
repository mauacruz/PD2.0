unit Expedicao.Services.uSeguradoraMock;

interface
uses
  Generics.Collections,
  Expedicao.Interfaces.uSeguradoraPersistencia,
  Expedicao.Models.uSeguradora;

type
  TSeguradoraMock = class(TInterfacedObject, ISeguradoraPersistencia)

    public
     function ObterListaSeguradora: TObjectList<TSeguradora>;
  end;



implementation

{ TSeguradoraMock }

function TSeguradoraMock.ObterListaSeguradora: TObjectList<TSeguradora>;
var
  lSeguradora: TSeguradora;
begin
  Result := TObjectList<TSeguradora>.Create(true);

  lSeguradora := TSeguradora.Create;
  lSeguradora.SeguradoraOID := 1;
  lSeguradora.Descricao := 'Seguradora X';
  lSeguradora.CNPJ := '11.111.111/00001-11';
  lSeguradora.Telefone := '(11) 1111-1111';
  Result.Add(lSeguradora);

  lSeguradora := TSeguradora.Create;
  lSeguradora.SeguradoraOID := 2;
  lSeguradora.Descricao := 'Seguradora Y';
  lSeguradora.CNPJ := '22.222.222/00002-22';
  lSeguradora.Telefone := '(22) 2222-2222';
  Result.Add(lSeguradora);



end;

end.

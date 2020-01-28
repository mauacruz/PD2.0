unit Expedicao.Services.uSeguradoraMock;

interface
uses
  Generics.Collections,
  Expedicao.Interfaces.uSeguradoraPersistencia,
  Expedicao.Models.uSeguradora;

type
  TSeguradoraMock = class(TInterfacedObject, ISeguradoraPersistencia)
    private
      FListaSeguradora: TObjectList<TSeguradora>;

    public
      constructor Create;
      destructor Destroy; override;

      function ObterListaSeguradora: TList<TSeguradora>;
      function ObterSeguradora(pSeguradoraOID: Integer): TSeguradora;
      function IncluirSeguradora(pSeguradora: TSeguradora): Boolean;
      function AlterarSeguradora(pSeguradora: TSeguradora): Boolean;
      function ExcluirSeguradora(pSeguradoraOID: Integer): Boolean;

  end;



implementation

{ TSeguradoraMock }

constructor TSeguradoraMock.Create;
var
  lSeguradora: TSeguradora;

begin
  FListaSeguradora := TObjectList<TSeguradora>.Create;

  lSeguradora := TSeguradora.Create;
  lSeguradora.SeguradoraOID := 1;
  lSeguradora.Descricao := 'Seguradora X';
  lSeguradora.CNPJ := '11.111.111/00001-11';
  lSeguradora.Telefone := '(11) 1111-1111';
  FListaSeguradora.Add(lSeguradora);

  lSeguradora := TSeguradora.Create;
  lSeguradora.SeguradoraOID := 2;
  lSeguradora.Descricao := 'Seguradora Y';
  lSeguradora.CNPJ := '22.222.222/00002-22';
  lSeguradora.Telefone := '(22) 2222-2222';
  FListaSeguradora.Add(lSeguradora);

end;

destructor TSeguradoraMock.Destroy;
begin
  FListaSeguradora.Clear;
  FListaSeguradora.Free;
  inherited;
end;


function TSeguradoraMock.AlterarSeguradora(pSeguradora: TSeguradora): Boolean;
var
  lSeguradora: TSeguradora;
begin

  Result := False;
  for lSeguradora in FListaSeguradora do
    if lSeguradora.SeguradoraOID = pSeguradora.SeguradoraOID then
    begin
      lSeguradora.Descricao := pSeguradora.Descricao;
      lSeguradora.CNPJ := pSeguradora.CNPJ;
      lSeguradora.Telefone := pSeguradora.Telefone;
      Exit;
    end;

end;

function TSeguradoraMock.ExcluirSeguradora(pSeguradoraOID: Integer): Boolean;
var
  lSeguradora: TSeguradora;
begin

  Result := False;
  for lSeguradora in FListaSeguradora do
    if lSeguradora.SeguradoraOID = pSeguradoraOID then
    begin
      FListaSeguradora.Remove(lSeguradora);
      Exit;
    end;

end;

function TSeguradoraMock.IncluirSeguradora(pSeguradora: TSeguradora): Boolean;
begin

  FListaSeguradora.Add(pSeguradora);
  Result := True;
end;

function TSeguradoraMock.ObterListaSeguradora: TList<TSeguradora>;
var
  lSeguradora: TSeguradora;
begin
  Result := TList<TSeguradora>.Create;

  for lSeguradora in FListaSeguradora do
    Result.Add(lSeguradora);
end;

function TSeguradoraMock.ObterSeguradora(pSeguradoraOID: Integer): TSeguradora;
var
  lSeguradora: TSeguradora;
begin
  Result := nil;

  for lSeguradora in FListaSeguradora do
    if lSeguradora.SeguradoraOID = pSeguradoraOID then
    begin
      Result := lSeguradora;
      Exit;
    end;

end;

end.

unit Expedicao.Services.uSeguradora;

interface
uses
  FireDAC.Comp.Client,
  Expedicao.Models.uSeguradora;

type
  TSeguradoraService = class
    private
    public
      function ObterSeguradoraPeloOID(pSeguradoraOID: Integer): TSeguradora;
      function ObterSeguradoraDaQuery(pQry: TFDQuery): TSeguradora;
  end;

implementation
uses
  uDataModule;

{ TSvcSeguradora }

function TSeguradoraService.ObterSeguradoraDaQuery(pQry: TFDQuery): TSeguradora;
begin
  Result := TSeguradora.Create;
  with Result do
  begin
    SeguradoraOID := pQry.FieldByName('SeguradoraOID').AsInteger;
    Descricao  := pQry.FieldByName('Descricao').AsString;
    CNPJ := pQry.FieldByName('CNPJ').AsString;
    Telefone := pQry.FieldByName('Telefone').AsString;
    Corretor := pQry.FieldByName('Corretor').AsString;
  end;

end;

function TSeguradoraService.ObterSeguradoraPeloOID(
  pSeguradoraOID: Integer): TSeguradora;
var
  lQry: TFDQuery;
begin
  Result := nil;

  lQry := DataModule1.ObterQuery;
  try

    lQry.Open('SELECT * FROM Seguradora WHERE SeguradoraOID = :SeguradoraOID',
      [pSeguradoraOID]);

    if lQry.IsEmpty then
      Exit;

    Result := ObterSeguradoraDaQuery(lQry);

  finally
    DataModule1.DestruirQuery(lQry);
  end;


end;

end.

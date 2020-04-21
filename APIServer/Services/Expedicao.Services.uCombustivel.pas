unit Expedicao.Services.uCombustivel;

interface
uses
  FireDAC.Comp.Client,
  Expedicao.Models.uCombustivel;

type
  TCombustivelService = class
    private
    public
      function ObterCombustivelPeloOID(pCombustivelOID: Integer): TCombustivel;
      function ObterCombustivelDaQuery(pQry: TFDQuery): TCombustivel;
  end;

implementation
uses
  uDataModule;

{ TCombustivelService }

function TCombustivelService.ObterCombustivelDaQuery(
  pQry: TFDQuery): TCombustivel;
begin
  Result := TCombustivel.Create;

  with Result do
  begin
    CombustivelOID := pQry.FieldByName('CombustivelOID').AsInteger;
    Descricao  := pQry.FieldByName('Descricao').AsString;
    Valor := pQry.FieldByName('Valor').AsFloat;
    UnidadeDeMedidaOID := pQry.FieldByName('UnidadeMedidaOID').AsInteger;
  end;

end;

function TCombustivelService.ObterCombustivelPeloOID(
  pCombustivelOID: Integer): TCombustivel;
var
  lQry: TFDQuery;
begin
  Result := nil;

  lQry := DataModule1.ObterQuery;
  try
    lQry.Open('SELECT * FROM Combustivel WHERE CombustivelOID = :CombustivelOID',
      [pCombustivelOID]);

    if lQry.IsEmpty then
      Exit;

    Result := ObterCombustivelDaQuery(lQry);

  finally
    DataModule1.DestruirQuery(lQry);
  end;

end;

end.

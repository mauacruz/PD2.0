unit Expedicao.Services.uSeguro;

interface
uses
  FireDAC.Comp.Client,
  Expedicao.Models.uSeguro,
  Expedicao.Models.uSeguradora;

type
  TSeguroService = class
    private

    public
      function ObterSeguroDaQuery(pQry: TFDQuery): TSeguro;
      function ObterSeguroPeloOID(pSeguroOID: Integer): TSeguro;
      function ObterSeguradora(pSeguradoraID: Integer): TSeguradora;
  end;

implementation
uses
  uDataModule,
  Expedicao.Services.uSeguradora;

{ TSeguroService }

function TSeguroService.ObterSeguradora(pSeguradoraID: Integer): TSeguradora;
var
  lSvcSeguradora: TSeguradoraService;
begin
  lSvcSeguradora := TSeguradoraService.Create;
  try
    Result := lSvcSeguradora.ObterSeguradoraPeloOID(pSeguradoraID);
  finally
    lSvcSeguradora.Free;
  end;
end;

function TSeguroService.ObterSeguroDaQuery(pQry: TFDQuery): TSeguro;
begin
  Result := TSeguro.Create;
  with Result do
  begin
    SeguroOID := pQry.FieldByName('SeguroOID').AsInteger;
    DataInicio := pQry.FieldByName('DataInicio').AsDateTime;
    DataFim := pQry.FieldByName('DataFim').AsDateTime;
    Cobertura := pQry.FieldByName('Cobertura').AsString;
    Seguradora := ObterSeguradora(pQry.FieldByName('SeguradoraOID').AsInteger);
  end;

end;

function TSeguroService.ObterSeguroPeloOID(pSeguroOID: Integer): TSeguro;
var
  lQry: TFDQuery;
begin
  Result := nil;

  lQry := DataModule1.ObterQuery;
  try
    lQry.Open('SELECT * FROM Seguro WHERE SeguroOID = :SeguroOID',
      [pSeguroOID]);

    if lQry.IsEmpty then
      Exit;

    Result := ObterSeguroDaQuery(lQry);

  finally
    DataModule1.DestruirQuery(lQry);
  end;

end;

end.

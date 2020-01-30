unit Expedicao.Models.uSeguro;

interface

uses
  Expedicao.Models.uSeguradora;

type
  TSeguro = class

    private
      FSeguradora: TSeguradora;
      FDataFim: TDateTime;
      FDataInicio: TDateTime;
      FCobertura: string;
      FSeguroOID: Integer;

      procedure SetCobertura(const Value: string);
      procedure SetDataFim(const Value: TDateTime);
      procedure SetDataInicio(const Value: TDateTime);
      procedure SetSeguradora(const Value: TSeguradora);
      procedure SetSeguroOID(const Value: Integer);

    public
      property SeguroOID: Integer read FSeguroOID write SetSeguroOID;
      property Seguradora: TSeguradora read FSeguradora write SetSeguradora;
      property DataInicio: TDateTime read FDataInicio write SetDataInicio;
      property DataFim: TDateTime read FDataFim write SetDataFim;
      property Cobertura: string read FCobertura write SetCobertura;


  end;

implementation

{ TSeguro }

procedure TSeguro.SetCobertura(const Value: string);
begin
  FCobertura := Value;
end;

procedure TSeguro.SetDataFim(const Value: TDateTime);
begin
  FDataFim := Value;
end;

procedure TSeguro.SetDataInicio(const Value: TDateTime);
begin
  FDataInicio := Value;
end;

procedure TSeguro.SetSeguradora(const Value: TSeguradora);
begin
  FSeguradora := Value;
end;

procedure TSeguro.SetSeguroOID(const Value: Integer);
begin
  FSeguroOID := Value;
end;

end.

unit Expedicao.Models.uSeguro;

interface

uses
  System.JSON,

  Expedicao.Models.uSeguradora;

type
  TSeguro = class

    private
      FSeguroOID: Integer;
      FDataInicio: TDateTime;
      FDataFim: TDateTime;
      FCobertura: string;
      FSeguradora: TSeguradora;

      procedure SetSeguroOID(const Value: Integer);
      procedure SetDataInicio(const Value: TDateTime);
      procedure SetDataFim(const Value: TDateTime);
      procedure SetCobertura(const Value: string);
      procedure SetSeguradora(const Value: TSeguradora);


    public

      destructor Destroy; override;

      property SeguroOID: Integer read FSeguroOID write SetSeguroOID;
      property DataInicio: TDateTime read FDataInicio write SetDataInicio;
      property DataFim: TDateTime read FDataFim write SetDataFim;
      property Cobertura: string read FCobertura write SetCobertura;
      property Seguradora: TSeguradora read FSeguradora write SetSeguradora;
  end;

implementation
uses
  System.SysUtils,
  System.StrUtils,
  REST.jSON;

{ TSeguro }


destructor TSeguro.Destroy;
begin
  if Assigned(FSeguradora) then
    FSeguradora.Free;
  inherited;
end;

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

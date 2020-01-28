unit Expedicao.Controller.uSeguradora;

interface
uses
  Generics.Collections,
  Expedicao.Interfaces.uSeguradoraController,
  Expedicao.Services.uExpedicaoFactory,
  Expedicao.Models.uSeguradora;

type
  TSeguradoraController = class(TInterfacedObject, ISeguradoraController)
    private
      FExpedicaoFactory: TExpedicaoFactory;

    public
      constructor Create;
      destructor Destroy; override;
      function ObterListaSeguradora: TObjectList<TSeguradora>;
  end;

implementation
uses
  Expedicao.Interfaces.uSeguradoraPersistencia;

{ TExpedicaoController }

constructor TSeguradoraController.Create;
begin
  Inherited;
  FExpedicaoFactory := TExpedicaoFactory.Create;
end;

destructor TSeguradoraController.Destroy;
begin
  FExpedicaoFactory.Free;
  inherited;
end;

function TSeguradoraController.ObterListaSeguradora: TObjectList<TSeguradora>;
var
  lSeguradoraPersistenciaSvc: ISeguradoraPersistencia;
begin

  lSeguradoraPersistenciaSvc := FExpedicaoFactory.ObterSeguradoraPersistencia(tpMock);
  Result := lSeguradoraPersistenciaSvc.ObterListaSeguradora;
end;

end.

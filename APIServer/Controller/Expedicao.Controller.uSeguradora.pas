unit Expedicao.Controller.uSeguradora;

interface
uses
  Generics.Collections,
  Expedicao.Interfaces.uSeguradoraController,
   Expedicao.Interfaces.uSeguradoraPersistencia,
  Expedicao.Services.uExpedicaoFactory,
  Expedicao.Models.uSeguradora;

type
  TSeguradoraController = class(TInterfacedObject, ISeguradoraController)
    private
      FExpedicaoFactory: TExpedicaoFactory;
      FSeguradoraPersistencia: ISeguradoraPersistencia;

    public
      constructor Create;
      destructor Destroy; override;
      function ObterListaSeguradora: TList<TSeguradora>;
  end;

implementation

{ TExpedicaoController }

constructor TSeguradoraController.Create;
begin
  Inherited;
  FExpedicaoFactory := TExpedicaoFactory.Create;
  FSeguradoraPersistencia := FExpedicaoFactory.ObterSeguradoraPersistencia(tpMock);;
end;

destructor TSeguradoraController.Destroy;
begin
  FExpedicaoFactory.Free;
  inherited;
end;

function TSeguradoraController.ObterListaSeguradora: TList<TSeguradora>;
begin
  Result := FSeguradoraPersistencia.ObterListaSeguradora;
end;

end.

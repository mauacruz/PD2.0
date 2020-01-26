unit Expedicao.Controller.uExpedicao;

interface
uses
  Generics.Collections,
  Expedicao.Interfaces.uExpedicaoController,
  Expedicao.Services.uExpedicaoFactory,
  Expedicao.Models.uSeguradora;

type
  TExpedicaoController = class(TInterfacedObject, IExpedicaoController)
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

constructor TExpedicaoController.Create;
begin
  Inherited;
  FExpedicaoFactory := TExpedicaoFactory.Create;
end;

destructor TExpedicaoController.Destroy;
begin
  FExpedicaoFactory.Free;
  inherited;
end;

function TExpedicaoController.ObterListaSeguradora: TObjectList<TSeguradora>;
var
  lSeguradoraPersistenciaSvc: ISeguradoraPersistencia;
begin

  lSeguradoraPersistenciaSvc := FExpedicaoFactory.ObterSeguradoraPersistencia(tpMock);
  Result := lSeguradoraPersistenciaSvc.ObterListaSeguradora;
end;

end.

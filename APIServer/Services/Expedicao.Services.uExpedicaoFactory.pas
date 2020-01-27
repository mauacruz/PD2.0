unit Expedicao.Services.uExpedicaoFactory;

interface
uses
  Expedicao.Interfaces.uSeguradoraPersistencia,
  Expedicao.Services.uSeguradoraMock;
type

  TTipoPersistencia = (tpMock, tpMySql, tpUnknown);

  TExpedicaoFactory = class


    function ObterSeguradoraPersistencia(pTipoPersistencia: TTipoPersistencia): ISeguradoraPersistencia;
  end;

implementation

uses
  SysUtils;

{ TExpedicaoFactory }

function TExpedicaoFactory.ObterSeguradoraPersistencia(
  pTipoPersistencia: TTipoPersistencia): ISeguradoraPersistencia;
begin
  case pTipoPersistencia of
    tpMock: Result := TSeguradoraMock.Create;
    tpMySql: ;  //Dever� devolver a instancia da classe que far� uso MySQL;
    tpUnknown: raise Exception.Create('Tipo de Persist�ncia n�o implementado!');
  end;
end;

end.

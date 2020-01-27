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
    tpMySql: ;  //Deverá devolver a instancia da classe que fará uso MySQL;
    tpUnknown: raise Exception.Create('Tipo de Persistência não implementado!');
  end;
end;

end.

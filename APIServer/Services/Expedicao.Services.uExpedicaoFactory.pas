unit Expedicao.Services.uExpedicaoFactory;

interface
uses
  Expedicao.Interfaces.uSeguradoraPersistencia,
  Expedicao.Services.uSeguradoraMock,

  Expedicao.Services.uCombustivelMock,
  Expedicao.Interfaces.uCombustivelPersistencia,

  Expedicao.Services.uInfracaoMock,
  Expedicao.Interfaces.uInfracaoPersistencia,

  Expedicao.Services.uRomaneioMock,
  Expedicao.Interfaces.uRomaneioPersistencia,

  Expedicao.Services.uVeiculoMock,
  Expedicao.Interfaces.uVeiculoPersistencia;
type

  TTipoPersistencia = (tpMock, tpMySql, tpUnknown);

  TExpedicaoFactory = class

    public
      function ObterSeguradoraPersistencia(pTipoPersistencia: TTipoPersistencia): ISeguradoraPersistencia;
      function ObterCombustivelPersistencia(pTipoPersistencia: TTipoPersistencia): ICombustivelPersistencia;
      function ObterInfracaoPersistencia(pTipoPersistencia: TTipoPersistencia): IInfracaoPersistencia;
      function ObterRomaneioPersistencia(pTipoPersistencia: TTipoPersistencia): IRomaneioPersistencia;
      function ObterVeiculoPersistencia(pTipoPersistencia: TTipoPersistencia): IVeiculoPersistencia;

  end;

implementation

uses
  SysUtils;

{ TExpedicaoFactory }

function TExpedicaoFactory.ObterCombustivelPersistencia(
  pTipoPersistencia: TTipoPersistencia): ICombustivelPersistencia;
begin
  case pTipoPersistencia of
    tpMock: Result := TCombustivelMock.Create;
    tpMySql: ;  //Deverá devolver a instancia da classe que fará uso MySQL;
    tpUnknown: raise Exception.Create('Tipo de Persistência não implementado!');
  end;

end;

function TExpedicaoFactory.ObterInfracaoPersistencia(
  pTipoPersistencia: TTipoPersistencia): IInfracaoPersistencia;
begin
  case pTipoPersistencia of
    tpMock: Result := TInfracaoMock.Create;
    tpMySql: ;  //Deverá devolver a instancia da classe que fará uso MySQL;
    tpUnknown: raise Exception.Create('Tipo de Persistência não implementado!');
  end;

end;

function TExpedicaoFactory.ObterRomaneioPersistencia(
  pTipoPersistencia: TTipoPersistencia): IRomaneioPersistencia;
begin
  case pTipoPersistencia of
    tpMock: Result := TRomaneioMock.Create;
    tpMySql: ;  //Deverá devolver a instancia da classe que fará uso MySQL;
    tpUnknown: raise Exception.Create('Tipo de Persistência não implementado!');
  end;

end;

function TExpedicaoFactory.ObterSeguradoraPersistencia(
  pTipoPersistencia: TTipoPersistencia): ISeguradoraPersistencia;
begin
  case pTipoPersistencia of
    tpMock: Result := TSeguradoraMock.Create;
    tpMySql: ;  //Deverá devolver a instancia da classe que fará uso MySQL;
    tpUnknown: raise Exception.Create('Tipo de Persistência não implementado!');
  end;
end;

function TExpedicaoFactory.ObterVeiculoPersistencia(
  pTipoPersistencia: TTipoPersistencia): IVeiculoPersistencia;
begin
  case pTipoPersistencia of
    tpMock: Result := TVeiculoMock.Create;
    tpMySql: ;  //Deverá devolver a instancia da classe que fará uso MySQL;
    tpUnknown: raise Exception.Create('Tipo de Persistência não implementado!');
  end;
end;

end.

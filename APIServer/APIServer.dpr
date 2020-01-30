program APIServer;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uVwConsole in 'uVwConsole.pas' {Form1},
  uServerMethods in 'uServerMethods.pas' {ServerMethods1: TDSServerModule},
  uServerContainer in 'uServerContainer.pas' {ServerContainer1: TDataModule},
  Expedicao.Controller.uSeguradora in 'Controller\Expedicao.Controller.uSeguradora.pas' {SeguradoraController: TDSServerModule},
  Expedicao.Models.uSeguradora in 'Model\Expedicao.Models.uSeguradora.pas',
  Expedicao.Interfaces.uSeguradoraPersistencia in 'Interfaces\Expedicao.Interfaces.uSeguradoraPersistencia.pas',
  Expedicao.Models.uCombustivel in 'Model\Expedicao.Models.uCombustivel.pas',
  Expedicao.Models.uInfracao in 'Model\Expedicao.Models.uInfracao.pas',
  Expedicao.Controller.uCombustivel in 'Controller\Expedicao.Controller.uCombustivel.pas' {CombustivelController: TDSServerModule},
  Expedicao.Controller.uInfracao in 'Controller\Expedicao.Controller.uInfracao.pas' {InfracaoController: TDSServerModule},
  Expedicao.Controller.uRomaneio in 'Controller\Expedicao.Controller.uRomaneio.pas' {RomaneioController: TDSServerModule},
  Expedicao.Controller.uVeiculo in 'Controller\Expedicao.Controller.uVeiculo.pas' {VeiculoController: TDSServerModule},
  Expedicao.Models.uRomaneio in 'Model\Expedicao.Models.uRomaneio.pas',
  Expedicao.Models.uVeiculo in 'Model\Expedicao.Models.uVeiculo.pas',
  Expedicao.Models.uSeguro in 'Model\Expedicao.Models.uSeguro.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.Run;
end.


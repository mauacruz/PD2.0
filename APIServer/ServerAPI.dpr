program ServerAPI;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uVwConsole in 'uVwConsole.pas' {Form1},
  uServerContainer in 'uServerContainer.pas' {ServerContainer1: TDataModule},
  Expedicao.Controller.uSeguradora in 'Controller\Expedicao.Controller.uSeguradora.pas' {SeguradoraController: TDSServerModule},
  Expedicao.Models.uSeguradora in 'Model\Expedicao.Models.uSeguradora.pas',
  Expedicao.Controller.uCombustivel in 'Controller\Expedicao.Controller.uCombustivel.pas' {CombustivelController: TDSServerModule},
  Expedicao.Controller.uInfracao in 'Controller\Expedicao.Controller.uInfracao.pas' {InfracaoController: TDSServerModule},
  Expedicao.Controller.uRomaneio in 'Controller\Expedicao.Controller.uRomaneio.pas' {RomaneioController: TDSServerModule},
  Expedicao.Controller.uVeiculo in 'Controller\Expedicao.Controller.uVeiculo.pas' {VeiculoController: TDSServerModule},
  Expedicao.Models.uCombustivel in 'Model\Expedicao.Models.uCombustivel.pas',
  Expedicao.Models.uInfracao in 'Model\Expedicao.Models.uInfracao.pas',
  Expedicao.Models.uRomaneio in 'Model\Expedicao.Models.uRomaneio.pas',
  Expedicao.Models.uSeguro in 'Model\Expedicao.Models.uSeguro.pas',
  Expedicao.Models.uVeiculo in 'Model\Expedicao.Models.uVeiculo.pas',
  uDataModule in 'uDataModule.pas' {DataModule1: TDataModule},
  Expedicao.Controller.uSeguro in 'Controller\Expedicao.Controller.uSeguro.pas' {SeguroController: TDSServerModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.


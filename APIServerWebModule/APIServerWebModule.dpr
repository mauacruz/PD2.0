program APIServerWebModule;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uVwConsole in 'uVwConsole.pas' {Form1},
  uServerMethods in 'uServerMethods.pas' {ServerMethods1: TDSServerModule},
  uServerContainer in 'uServerContainer.pas' {ServerContainer1: TDataModule},
  uWebModule in 'uWebModule.pas' {WebModule1: TWebModule},
  Expedicao.Controller.uCombustivel in '..\APIServer\Controller\Expedicao.Controller.uCombustivel.pas' {CombustivelController: TDSServerModule},
  Expedicao.Controller.uInfracao in '..\APIServer\Controller\Expedicao.Controller.uInfracao.pas' {InfracaoController: TDSServerModule},
  Expedicao.Controller.uRomaneio in '..\APIServer\Controller\Expedicao.Controller.uRomaneio.pas' {RomaneioController: TDSServerModule},
  Expedicao.Controller.uSeguradora in '..\APIServer\Controller\Expedicao.Controller.uSeguradora.pas' {SeguradoraController: TDSServerModule},
  Expedicao.Controller.uSeguro in '..\APIServer\Controller\Expedicao.Controller.uSeguro.pas' {SeguroController: TDSServerModule},
  Expedicao.Controller.uVeiculo in '..\APIServer\Controller\Expedicao.Controller.uVeiculo.pas' {VeiculoController: TDSServerModule},
  Expedicao.Models.uVeiculo in '..\APIServer\Model\Expedicao.Models.uVeiculo.pas',
  Expedicao.Models.uSeguro in '..\APIServer\Model\Expedicao.Models.uSeguro.pas',
  Expedicao.Models.uSeguradora in '..\APIServer\Model\Expedicao.Models.uSeguradora.pas',
  Expedicao.Models.uRomaneio in '..\APIServer\Model\Expedicao.Models.uRomaneio.pas',
  Expedicao.Models.uInfracao in '..\APIServer\Model\Expedicao.Models.uInfracao.pas',
  Expedicao.Models.uCombustivel in '..\APIServer\Model\Expedicao.Models.uCombustivel.pas',
  uDataModule in '..\APIServer\uDataModule.pas' {DataModule1: TDataModule},
  Base.uControllerBase in '..\APIServer\Base\Base.uControllerBase.pas',
  Expedicao.Services.uSeguradora in '..\APIServer\Services\Expedicao.Services.uSeguradora.pas',
  Expedicao.Services.uCombustivel in '..\APIServer\Services\Expedicao.Services.uCombustivel.pas',
  Expedicao.Services.uSeguro in '..\APIServer\Services\Expedicao.Services.uSeguro.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.

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
  Expedicao.Interfaces.uSeguradoraPersistencia in 'Interfaces\Expedicao.Interfaces.uSeguradoraPersistencia.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.Run;
end.


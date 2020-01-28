program VCLValidacao;

uses
  Vcl.Forms,
  uVwPrincipal in 'uVwPrincipal.pas' {Form1},
  Expedicao.Controller.uSeguradora in '..\APIServer\Controller\Expedicao.Controller.uSeguradora.pas',
  Expedicao.Interfaces.uSeguradoraController in '..\APIServer\Interfaces\Expedicao.Interfaces.uSeguradoraController.pas',
  Expedicao.Models.uSeguradora in '..\APIServer\Model\Expedicao.Models.uSeguradora.pas',
  Expedicao.Services.uExpedicaoFactory in '..\APIServer\Services\Expedicao.Services.uExpedicaoFactory.pas',
  Expedicao.Interfaces.uSeguradoraPersistencia in '..\APIServer\Interfaces\Expedicao.Interfaces.uSeguradoraPersistencia.pas',
  Expedicao.Services.uSeguradoraMock in '..\APIServer\Services\Expedicao.Services.uSeguradoraMock.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

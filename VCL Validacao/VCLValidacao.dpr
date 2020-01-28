program VCLValidacao;

uses
  Vcl.Forms,
  uVwPrincipal in 'uVwPrincipal.pas' {Form1},
  Expedicao.Controller.uSeguradora in '..\APIServer\Controller\Expedicao.Controller.uSeguradora.pas',
  Expedicao.Interfaces.uSeguradoraController in '..\APIServer\Interfaces\Expedicao.Interfaces.uSeguradoraController.pas',
  Expedicao.Models.uSeguradora in '..\APIServer\Model\Expedicao.Models.uSeguradora.pas',
  Expedicao.Services.uExpedicaoFactory in '..\APIServer\Services\Expedicao.Services.uExpedicaoFactory.pas',
  Expedicao.Interfaces.uSeguradoraPersistencia in '..\APIServer\Interfaces\Expedicao.Interfaces.uSeguradoraPersistencia.pas',
  Expedicao.Services.uSeguradoraMock in '..\APIServer\Services\Expedicao.Services.uSeguradoraMock.pas',
  Expedicao.Models.uInfracao in '..\APIServer\Model\Expedicao.Models.uInfracao.pas',
  Expedicao.Models.uCombustivel in '..\APIServer\Model\Expedicao.Models.uCombustivel.pas',
  Expedicao.Interfaces.uCombustivelPersistencia in '..\APIServer\Interfaces\Expedicao.Interfaces.uCombustivelPersistencia.pas',
  Expedicao.Interfaces.uCombustivelController in '..\APIServer\Interfaces\Expedicao.Interfaces.uCombustivelController.pas',
  uDataModule in 'uDataModule.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.

program VCLValidacao;

uses
  Vcl.Forms,
  uVwPrincipal in 'uVwPrincipal.pas' {Form1},
  Expedicao.Controller.uSeguradora in '..\APIServer\Controller\Expedicao.Controller.uSeguradora.pas',
  Expedicao.Interfaces.uSeguradoraController in '..\APIServer\Interfaces\Expedicao.Interfaces.uSeguradoraController.pas',
  Expedicao.Models.uSeguradora in '..\APIServer\Model\Expedicao.Models.uSeguradora.pas',
  Expedicao.Interfaces.uSeguradoraPersistencia in '..\APIServer\Interfaces\Expedicao.Interfaces.uSeguradoraPersistencia.pas',
  Expedicao.Models.uCombustivel in '..\APIServer\Model\Expedicao.Models.uCombustivel.pas',
  Expedicao.Interfaces.uCombustivelPersistencia in '..\APIServer\Interfaces\Expedicao.Interfaces.uCombustivelPersistencia.pas',
  Expedicao.Interfaces.uCombustivelController in '..\APIServer\Interfaces\Expedicao.Interfaces.uCombustivelController.pas',
  uDataModule in 'uDataModule.pas' {DataModule1: TDataModule},
  Expedicao.Controller.uCombustivel in '..\APIServer\Controller\Expedicao.Controller.uCombustivel.pas' {CombustivelController},
  Expedicao.Controller.uInfracao in '..\APIServer\Controller\Expedicao.Controller.uInfracao.pas' {InfracaoController},
  Expedicao.Controller.uRomaneio in '..\APIServer\Controller\Expedicao.Controller.uRomaneio.pas' {RomaneioController},
  Expedicao.Controller.uVeiculo in '..\APIServer\Controller\Expedicao.Controller.uVeiculo.pas' {VeiculoController},
  Expedicao.Services.uCombustivelMock in '..\APIServer\Services\Expedicao.Services.uCombustivelMock.pas',
  Expedicao.Services.uExpedicaoFactory in '..\APIServer\Services\Expedicao.Services.uExpedicaoFactory.pas',
  Expedicao.Services.uInfracaoMock in '..\APIServer\Services\Expedicao.Services.uInfracaoMock.pas',
  Expedicao.Services.uRomaneioMock in '..\APIServer\Services\Expedicao.Services.uRomaneioMock.pas',
  Expedicao.Services.uSeguradoraMock in '..\APIServer\Services\Expedicao.Services.uSeguradoraMock.pas',
  Expedicao.Services.uVeiculoMock in '..\APIServer\Services\Expedicao.Services.uVeiculoMock.pas',
  Expedicao.Models.uInfracao in '..\APIServer\Model\Expedicao.Models.uInfracao.pas',
  Expedicao.Interfaces.uInfracaoPersistencia in '..\APIServer\Interfaces\Expedicao.Interfaces.uInfracaoPersistencia.pas',
  Expedicao.Interfaces.uRomaneioPersistencia in '..\APIServer\Interfaces\Expedicao.Interfaces.uRomaneioPersistencia.pas',
  Expedicao.Models.uRomaneio in '..\APIServer\Model\Expedicao.Models.uRomaneio.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.

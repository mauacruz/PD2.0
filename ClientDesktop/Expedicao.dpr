program Expedicao;

uses
  Vcl.Forms,
  UFrmBasePrincipal in 'UFrmBasePrincipal.pas' {FrmBasePrincipal},
  UFrmBaseCrud in 'UFrmBaseCrud.pas' {FrmBaseCrud},
  UFrmPrincipal in 'UFrmPrincipal.pas' {frmPrincipal},
  uConfig in 'uConfig.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  UFrmCadVeiculo in 'UFrmCadVeiculo.pas' {FrmCadVeiculo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.

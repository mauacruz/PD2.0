unit UFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

type
  TfrmPrincipal = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Sair1: TMenuItem;
    Cadastrobase1: TMenuItem;
    Veculo1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure Cadastrobase1Click(Sender: TObject);
    procedure Veculo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses UFrmBaseCrud, Unit1, UFrmCadVeiculo;

procedure TfrmPrincipal.Cadastrobase1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCadVeiculo,FrmCadVeiculo);
  FrmCadVeiculo.ShowModal;
  FrmCadVeiculo.Free;
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.Veculo1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCadVeiculo,FrmCadVeiculo);
  FrmCadVeiculo.ShowModal;
  FrmCadVeiculo.Free;
end;

end.

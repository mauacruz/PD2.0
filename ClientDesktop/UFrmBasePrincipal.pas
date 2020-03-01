unit UFrmBasePrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TFrmBasePrincipal = class(TForm)
    pnlCabecalho: TPanel;
    FadeIn: TTimer;
    FadeOut: TTimer;
    Image1: TImage;
    stbrInfo: TStatusBar;
    procedure FadeInTimer(Sender: TObject);
    procedure FadeOutTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
//  protected
//    Function PegaTitulo:String; Virtual; Abstract;
  public
    { Public declarations }
  end;

var
  FrmBasePrincipal: TFrmBasePrincipal;

implementation

{$R *.dfm}

procedure TFrmBasePrincipal.FadeInTimer(Sender: TObject);
begin
  AlphaBlendValue := AlphaBlendValue + 15;
  FadeIn.Enabled := not(AlphaBlendValue = 255);
end;

procedure TFrmBasePrincipal.FadeOutTimer(Sender: TObject);
begin
  AlphaBlendValue := AlphaBlendValue - 15;
  if AlphaBlendValue = 0 then Close;
end;

procedure TFrmBasePrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key  of
    VK_ESCAPE: Fadeout.Enabled := true;
    VK_RETURN: Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFrmBasePrincipal.FormShow(Sender: TObject);
begin
//  Caption := PegaTitulo;
  Caption := 'Teste';
end;

end.

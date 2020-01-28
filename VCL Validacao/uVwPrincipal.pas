unit uVwPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    btnListaSeguradora: TBitBtn;
    lstListaResultado: TListBox;
    procedure btnListaSeguradoraClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
  Generics.Collections,
  Expedicao.Controller.uSeguradora,
  Expedicao.Models.uSeguradora;

{$R *.dfm}

procedure TForm1.btnListaSeguradoraClick(Sender: TObject);
var
  lSeguradoraCtr: TSeguradoraController;
  lListaSeguradora: TList<TSeguradora>;
  lSeguradora: TSeguradora;
begin
  lSeguradoraCtr := TSeguradoraController.Create;
  try
    lstListaResultado.clear;
    lListaSeguradora := lSeguradoraCtr.ObterListaSeguradora;
    if not Assigned(lListaSeguradora) then
      Exit;


    try
      for lSeguradora in lListaSeguradora do
      begin
         with lstListaResultado do
         begin
           Items.Add(lSeguradora.Descricao);
         end;
      end;

    finally
      lLIstaSeguradora.Clear;
      lListaSeguradora.Free;
    end;

  finally
    lSeguradoraCtr.Free;
  end;



end;

end.

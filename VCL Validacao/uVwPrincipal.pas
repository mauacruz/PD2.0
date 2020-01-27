unit uVwPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    btnSeguradora: TBitBtn;
    lstListaResultado: TListBox;
    procedure btnSeguradoraClick(Sender: TObject);
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
  Expedicao.Controller.uExpedicao,
  Expedicao.Models.uSeguradora;

{$R *.dfm}

procedure TForm1.btnSeguradoraClick(Sender: TObject);
var
  lExpedicaoCtr: TExpedicaoController;
  lListaSeguradora: TObjectList<TSeguradora>;
  lSeguradora: TSeguradora;
begin
  lExpedicaoCtr := TExpedicaoController.Create;
  try
    lstListaResultado.clear;
    lListaSeguradora := lExpedicaoCtr.ObterListaSeguradora;
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
    lExpedicaoCtr.Free;
  end;



end;

end.

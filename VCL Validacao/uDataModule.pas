unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client;

type
  TDataModule1 = class(TDataModule)
    cnSeguradora: TFDConnection;
    procedure cnSeguradoraAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.cnSeguradoraAfterConnect(Sender: TObject);
begin
  cnSeguradora.ExecSQL('CREATE TABLE IF NOT EXISTS Seguradora ( ' +
    ' SeguradoraOID INTEGER PRIMARY KEY NOT NULL, ' +
    ' Descricao TEXT NOT NULL, ' +
    ' CNPJ TEXT NOT NULL, ' +
    ' TELEFONE TEXT, ' +
    ' CORRETOR TEXT )');
end;

end.

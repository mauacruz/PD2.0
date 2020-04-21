unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  FireDAC.DApt,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client;

type
  TDataModule1 = class(TDataModule)
    MySqlDriver: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
   function ObterConnection: TFDConnection;
  public
    { Public declarations }
    procedure DestruirQuery(probQuery: TFDQuery);


    function ObterQuery: TFDQuery;

  end;


var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
var
  oParams: TStrings;
begin

  FDManager.Close;
  oParams := TStringList.Create;
  try
    oParams.Add('Database=PD2.0');
    oParams.Add('User_Name=mauacruz');
    oParams.Add('Password=mcmac');
    oParams.Add('Server=localhost');
    oParams.Add('port=3306');
    oParams.Add('Pooled=True');

    FDManager.AddConnectionDef('PD2.0', 'MySQL', oParams);
    FDManager.Open;

  finally
    oParams.Free;
  end;


end;

procedure TDataModule1.DestruirQuery(probQuery: TFDQuery);
begin
  //Destroi a conexão instanciada para a query;
  probQuery.Connection.Free;
  probQuery.Connection := nil;

  //Destroi a query;
  FreeAndNil(probQuery);
end;

function TDataModule1.ObterConnection: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.ConnectionDefName := 'PD2.0';
  Result.Connected := True;
end;

function TDataModule1.ObterQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := ObterConnection;
  Result.SQL.Clear;

end;

end.

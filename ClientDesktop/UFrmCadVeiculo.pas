unit UFrmCadVeiculo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBaseCrud, Data.DB, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  IPPeerClient, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TFrmCadVeiculo = class(TFrmBaseCrud)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    FDMemTable1cor: TWideStringField;
    FDMemTable1modelo: TWideStringField;
    FDMemTable1veiculoOID: TWideStringField;
    FDMemTable1ano: TWideStringField;
    FDMemTable1marca: TWideStringField;
    FDMemTable1renavan: TWideStringField;
    FDMemTable1placa: TWideStringField;
    DBEdit2: TDBEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    //função que retorno o campo chave do DataSet CRUD
    function GetKeyField: String; Override;
    //Função que retorna o nome do campo chave para filtrar o registro no DataSet de CRUD
    function GetQueryKeyField: String; Override;
  public
    { Public declarations }
  end;

var
  FrmCadVeiculo: TFrmCadVeiculo;

implementation

{$R *.dfm}

procedure TFrmCadVeiculo.FormShow(Sender: TObject);
begin
  inherited;
  caption := 'cadastro de Veículos';
  RESTRequest1.Execute;
end;


function TFrmCadVeiculo.GetKeyField: String;
begin
  result := 'veiculoOID';
end;

function TFrmCadVeiculo.GetQueryKeyField: String;
begin
  result := 'veiculoOID';
end;

end.

unit UFrmBaseCrud;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBasePrincipal, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.ToolWin, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, System.Actions, Vcl.ActnList,
  System.Generics.Collections, System.Uitypes, uConfig, Vcl.Mask, Vcl.DBCtrls;

type
  TRecordState = (rsNew, rsEdit, rsDelete);

  TFrmBaseCrud = class(TFrmBasePrincipal)
    pgCadastro: TPageControl;
    tbCrud: TTabSheet;
    tbQuery: TTabSheet;
    Panel1: TPanel;
    edtPesquisa: TButtonedEdit;
    Imagens: TImageList;
    ImgAcoes: TImageList;
    dbgQuery: TDBGrid;
    aclAcoes: TActionList;
    acNovo: TAction;
    acSalvar: TAction;
    acExcluir: TAction;
    acAnterior: TAction;
    acVisualizar: TAction;
    acImprimir: TAction;
    acCancelar: TAction;
    acPrimeiro: TAction;
    acProximo: TAction;
    acEditar: TAction;
    acUltimo: TAction;
    pnlControles: TPanel;
    SpeedButton8: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    Image2: TImage;
    Label1: TLabel;
    acFechar: TAction;
    DsCrud: TDataSource;
    DsQuery: TDataSource;
    DBEdit1: TDBEdit;
    procedure acExcluirExecute(Sender: TObject);
    procedure acNovoExecute(Sender: TObject);
    procedure acEditarExecute(Sender: TObject);
    procedure acCancelarExecute(Sender: TObject);
    procedure acSalvarExecute(Sender: TObject);
    procedure acImprimirExecute(Sender: TObject);
    procedure acVisualizarExecute(Sender: TObject);
    procedure acPrimeiroExecute(Sender: TObject);
    procedure acUltimoExecute(Sender: TObject);
    procedure acProximoExecute(Sender: TObject);
    procedure acAnteriorExecute(Sender: TObject);
    procedure acFecharExecute(Sender: TObject);
    procedure acNovoUpdate(Sender: TObject);
    procedure acSalvarUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtPesquisaRightButtonClick(Sender: TObject);
    procedure edtPesquisaLeftButtonClick(Sender: TObject);
    procedure dbgQueryTitleClick(Column: TColumn);
  private
    FCheckUnique: TDictionary<String, String>;
    FRecordState: TRecordState;
    procedure SetCheckUnique(const Value: TDictionary<String, String>);
    procedure DOAfterScroll(DataSet: TDataSet);
  protected
    //Objeto utlizado na rotina de filtro
    FieldFilter: TField;

    //função que retorno o campo chave do DataSet CRUD
    function GetKeyField: String; virtual; abstract;

    //Função que retorna o nome do campo chave para filtrar o registro no DataSet de CRUD
    function GetQueryKeyField: String; virtual; abstract;

    //procedure que carrega a permissao do usuario logado para o forlumario em questao
    procedure LoadPermissao;virtual;

    //procedure que carrega as restricoes dos campos do formulario em questao para o usuario logado
    procedure LoadRestricao;virtual;

    //Função que verifique a existencia de registro já cadastrado com base nos campos informados em FCheckUnique
    function DoCheckUnique: Boolean;virtual;
  public
    { Public declarations }
    property CheckUnique: TDictionary<String, String> read FCheckUnique write SetCheckUnique;
  end;

var
  FrmBaseCrud: TFrmBaseCrud;

implementation

{$R *.dfm}

uses UDados, Datasnap.DBClient;

procedure TFrmBaseCrud.acAnteriorExecute(Sender: TObject);
begin
  inherited;
  DsQuery.DataSet.Prior;
end;

procedure TFrmBaseCrud.acCancelarExecute(Sender: TObject);
begin
  inherited;
  case FRecordState of
    rsNew:
      if TConfig.GetInstance.ConfirmaGravacao then
        if MessageDlg('Confirma o cancelamento da inclusão do registro?',mtConfirmation,mbYesNo,0) = mrNo then Exit;
    rsEdit:
      if TConfig.GetInstance.ConfirmaGravacao then
        if MessageDlg('Confirma o cancelamento da edição do registro?',mtConfirmation,mbYesNo,0) = mrNo then Exit;
    rsDelete:
      if TConfig.GetInstance.ConfirmaGravacao then
        if MessageDlg('Confirma o cancelamento da exclusão do registro?',mtConfirmation,mbYesNo,0) = mrNo then Exit;
  end;
  DsCrud.DataSet.Cancel;

//  TClientDataSet(DsCrud.DataSet).CancelUpdates;
end;

procedure TFrmBaseCrud.acEditarExecute(Sender: TObject);
begin
  inherited;
  DsCrud.DataSet.Edit;
  pgCadastro.ActivePage := tbCrud;
  FRecordState := rsEdit;
end;

procedure TFrmBaseCrud.acExcluirExecute(Sender: TObject);
begin
  inherited;
  DsCrud.DataSet.Edit;
  pgCadastro.ActivePage := tbCrud;
  FRecordState := rsDelete;
end;

procedure TFrmBaseCrud.acFecharExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmBaseCrud.acImprimirExecute(Sender: TObject);
begin
  inherited;
  showmessage('ação');
end;

procedure TFrmBaseCrud.acNovoExecute(Sender: TObject);
var
  I: Integer;
begin
  inherited;
   DsCrud.DataSet.Append;
   pgCadastro.ActivePage := tbCrud;

   for I := 0 to pnlControles.ControlCount -1 do
     if pnlControles.Controls[I] is TLabel then
       if Assigned(TLabel(pnlControles.Controls[I]).FocusControl) then
         if TLabel(pnlControles.Controls[I]).FocusControl is TDBEdit then
           if TDBEdit(TLabel(pnlControles.Controls[I]).FocusControl).Field.Required then
             TLabel(pnlControles.Controls[I]).Font.Color := clRed
           else
             if TLabel(pnlControles.Controls[I]).FocusControl is TDBLookupComboBox then
                if TDBLookupComboBox(TLabel(pnlControles.Controls[I]).FocusControl).Field.Required then
                  TLabel(pnlControles.Controls[I]).Font.Color := clRed;
end;

procedure TFrmBaseCrud.acNovoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := not (DsCrud.State in [dsInsert, dsEdit]);
end;

procedure TFrmBaseCrud.acPrimeiroExecute(Sender: TObject);
begin
  inherited;
  DsQuery.DataSet.First;
end;

procedure TFrmBaseCrud.acProximoExecute(Sender: TObject);
begin
  inherited;
  DsQuery.DataSet.Next;
end;

procedure TFrmBaseCrud.acSalvarExecute(Sender: TObject);
begin
  inherited;
  if (DsCrud.DataSet.State in [dsInsert]) and (not DoCheckUnique) then exit;

  case FRecordState of
    rsNew:
      if TConfig.GetInstance.ConfirmaGravacao then
        if MessageDlg('Confirma a inclusão do registro?',mtConfirmation,mbYesNo,0) = mrNo then Exit;
    rsEdit:
      if TConfig.GetInstance.ConfirmaGravacao then
        if MessageDlg('Confirma a edição do registro?',mtConfirmation,mbYesNo,0) = mrNo then Exit;
    rsDelete:
      if TConfig.GetInstance.ConfirmaGravacao then
        if MessageDlg('Confirma a exclusão do registro?',mtConfirmation,mbYesNo,0) = mrYes then
          DsCrud.DataSet.Delete
        else
          Exit ;
  end;
  TClientDataSet(DsCrud.DataSet).ApplyUpdates(0);
  DsCrud.DataSet.Refresh;
  DsCrud.DataSet.Filtered := False;
  DsQuery.DataSet.Refresh;
  DsQuery.DataSet.Last;
end;

procedure TFrmBaseCrud.acSalvarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := DsCrud.State in [dsInsert, dsEdit];
end;

procedure TFrmBaseCrud.acUltimoExecute(Sender: TObject);
begin
  inherited;
  DsQuery.DataSet.Last;
end;

procedure TFrmBaseCrud.acVisualizarExecute(Sender: TObject);
begin
  inherited;
  if pgCadastro.ActivePage = tbCrud
  then pgCadastro.ActivePage := tbQuery
  else pgCadastro.ActivePage := tbCrud;
end;

procedure TFrmBaseCrud.dbgQueryTitleClick(Column: TColumn);
begin
  inherited;
  if Column.Field.FieldKind = fkData then
  begin
    FieldFilter := Column.Field;
    EdtPesquisa.Clear;
    EdtPesquisa.TextHint := 'Digite aqui para pesquisar em ' + Column.Title.Caption;
  end;
end;

procedure TFrmBaseCrud.edtPesquisaLeftButtonClick(Sender: TObject);
begin
  inherited;
  EdtPesquisa.Clear;
  DsQuery.DataSet.Filtered := False;
  DsQuery.DataSet.Refresh;
end;

procedure TFrmBaseCrud.edtPesquisaRightButtonClick(Sender: TObject);
var
  Filter: String;
begin
  inherited;
  if Assigned(FieldFilter) then
  begin
     case FieldFilter.DataType of
        ftUnknown:;
        ftBoolean:;

        ftString, ftFixedChar,
        ftWideString, ftFixedWideChar,
        ftWideMemo,ftMemo:
          Filter := 'upper('+FieldFilter.FieldName + ') like ' +
                            QuotedStr(UpperCase(EdtPesquisa.Text + '%'));

        ftSmallint, ftInteger,
        ftWord, ftLargeint,
        ftLongWord, ftShortint,
        ftBytes, ftByte:
          Filter := FieldFilter.FieldName + ' = ' +
             IntToStr(StrToIntDef(EdtPesquisa.Text,0));

        ftFloat, ftCurrency, ftBCD,
        ftFMTBcd, ftExtended, ftSingle: Filter :=
           FieldFilter.FieldName + ' = ' + FloatToStr(StrToFloatDef(EdtPesquisa.Text,0));

        ftDate, ftTime, ftDateTime: Filter := FieldFilter.FieldName + ' = ' + EdtPesquisa.Text;
      end;
      DsQuery.DataSet.Filter := Filter;
      DsQuery.DataSet.Filtered := True;
  end;
end;

procedure TFrmBaseCrud.DOAfterScroll(DataSet: TDataSet);
begin
{
  if not DsQuery.DataSet.IsEmpty then
  begin
    if not DsCrud.DataSet.Active then DsCrud.DataSet.Open;
    DsCrud.DataSet.Filter := GetKeyField + ' = ' + DsQuery.DataSet.FieldByName(GetQueryKeyField).AsString;
    DsCrud.DataSet.Filtered := True;
    StBrInfo.SimpleText := 'Total de Registros: ' + IntToStr(DsQuery.DataSet.RecordCount);
  end;
  }
end;

function TFrmBaseCrud.DoCheckUnique: Boolean;
var
  Clone: TClientDataSet;
  Field: String;
begin
  Clone := TClientDataSet.Create(Self);
  Clone.CloneCursor(dsCrud.DataSet as TClientDataSet,true, true);
  for Field in FCheckUnique.Keys do
  begin
    if Clone.Locate(Field,DsCrud.DataSet.FieldByName(Field).Value,[loCaseInsensitive]) then
    begin
      MessageDlg(FCheckUnique.Items[Field],mtWarning,[mbOK],0);
      Result := False;
      Break;
    end;
  end;
  Clone.Free;
end;

procedure TFrmBaseCrud.FormCreate(Sender: TObject);
begin
  inherited;
  FCheckUnique := TDictionary<String, String>.Create;
  DsQuery.DataSet.AfterScroll := DOAfterScroll;
end;

procedure TFrmBaseCrud.FormDestroy(Sender: TObject);
begin
  FCheckUnique.Free;
  inherited;
end;

procedure TFrmBaseCrud.LoadPermissao;
begin

end;

procedure TFrmBaseCrud.LoadRestricao;
begin

end;

procedure TFrmBaseCrud.SetCheckUnique(const Value: TDictionary<String, String>);
begin
  FCheckUnique := Value;
end;

end.

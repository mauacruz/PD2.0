unit Expedicao.Controller.uVeiculo;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON,
  Expedicao.Models.uVeiculo, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uDataModule,
  Expedicao.Models.uCombustivel,
  Expedicao.Models.uSeguro;


type
  TVeiculoController = class(TDSServerModule)
    tblVeiculo: TFDQuery;
    tblVeiculoCombustivel: TFDQuery;
    tblVeiculoSeguro: TFDQuery;
    tblVeiculoVEICULOOID: TFDAutoIncField;
    tblVeiculoMARCA: TStringField;
    tblVeiculoMODELO: TStringField;
    tblVeiculoPLACA: TStringField;
    tblVeiculoRENAVAM: TStringField;
    tblVeiculoCOR: TStringField;
    tblVeiculoANO: TStringField;
    tblVeiculoCombustivelVEICULOID: TIntegerField;
    tblVeiculoCombustivelCOMBUSTIVELID: TIntegerField;
    tblVeiculoSeguroSEGUROOID: TIntegerField;
    tblVeiculoSeguroVEICULOOID: TIntegerField;
    dsVeiculoMasterCombustivel: TDataSource;
    tblSeguro: TFDQuery;
    tblCombustivel: TFDQuery;
    tblCombustivelCOMBUSTIVELOID: TFDAutoIncField;
    tblCombustivelDESCRICAO: TStringField;
    tblCombustivelVALOR: TBCDField;
    tblCombustivelUNIDADEMEDIDAOID: TIntegerField;
    tblSeguroSEGUROOID: TFDAutoIncField;
    tblSeguroSEGURADORAOID: TIntegerField;
    tblSeguroDATAINICIO: TDateField;
    tblSeguroDATAFIM: TDateField;
    tblSeguroCOBERTURA: TStringField;
    dsVeiculoMasterSeguro: TDataSource;
    saVeiculo: TFDSchemaAdapter;

  private
    { Private declarations }

    function ObterVeiculoSelecionado: TVeiculo;
    function PesquisarVeiculo(pVeiculoOID: Integer): Boolean;
    function GravarVeiculo(pVeiculo: TVeiculo): Boolean;

  public
    { Public declarations }
    function Veiculos: TJSONValue;
    function Veiculo(ID: Integer): TJSONValue;
    function updateVeiculo(Veiculo: TJSONObject): TJSONValue;
    function acceptVeiculo(Veiculo: TJSONObject): TJSONValue;
    function cancelVeiculo(ID: Integer): TJSONValue;
  end;

implementation
uses
  REST.jSON;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TVeiculoController }

function TVeiculoController.ObterVeiculoSelecionado: TVeiculo;
var
  lCombustivel: TCombustivel;
  lSeguro: TSeguro;
begin
  Result := TVeiculo.Create;
  Result.VeiculoOID := tblVeiculoVEICULOOID.AsInteger;
  Result.Marca := tblVeiculoMARCA.AsString;
  Result.Modelo := tblVeiculoMODELO.AsString;
  Result.Placa := tblVeiculoPLACA.AsString;
  Result.Renavan := tblVeiculoRENAVAM.AsString;
  Result.Cor := tblVeiculoCOR.AsString;
  Result.Ano := tblVeiculoANO.AsString;

  tblVeiculoCombustivel.Open;
  tblVeiculoCombustivel.First;
  while not tblVeiculoCombustivel.Eof do
  begin
    tblCombustivel.Close;
    tblCombustivel.ParamByName('CombustivelOID').AsInteger := tblVeiculoCombustivelCOMBUSTIVELID.AsInteger;
    tblCombustivel.Open;

    if not tblCombustivel.IsEmpty then
    begin
      lCombustivel := TCombustivel.Create;
      lCombustivel.CombustivelOID := tblCombustivelCOMBUSTIVELOID.AsInteger;
      lCombustivel.Descricao := tblCombustivelDESCRICAO.AsString;
      lCombustivel.Valor := tblCombustivelVALOR.AsFloat;
      lCombustivel.UnidadeDeMedidaOID := tblCombustivelUNIDADEMEDIDAOID.AsInteger;
      Result.Combustiveis.Add(lCombustivel);
    end;
    tblCombustivel.Close;
    tblVeiculoCombustivel.Next;
  end;
  tblVeiculoCombustivel.Close;

  tblVeiculoSeguro.Open;
  tblVeiculoSeguro.First;
  while not tblVeiculoSeguro.Eof do
  begin
    tblSeguro.Close;
    tblSeguro.ParamByName('SeguroOID').AsInteger := tblVeiculoSeguroSEGUROOID.AsInteger;
    tblSeguro.Open;

    if not tblSeguro.Eof then
    begin
      lSeguro := TSeguro.Create;
      lSeguro.SeguroOID := tblSeguroSEGUROOID.AsInteger;
//      lSeguro.Seguradora := ObterSeguradora
      lSeguro.DataInicio := tblSeguroDATAINICIO.AsDateTime;
      lSeguro.DataFim := tblSeguroDATAFIM.AsDateTime;
      lSeguro.Cobertura := tblSeguroCOBERTURA.AsString;
      Result.Seguros.Add(lSeguro);
    end;
    tblSeguro.Close;
    tblVeiculoSeguro.Next;
  end;
  tblVeiculoSeguro.Close;

end;

function TVeiculoController.PesquisarVeiculo(pVeiculoOID: Integer): Boolean;
begin
  Result := False;

  with tblVeiculo do
  begin
    if IsEmpty then
      Exit;

    Result := (Locate('VEICULOOID', pVeiculoOID, []))
  end;

end;

function TVeiculoController.GravarVeiculo(pVeiculo: TVeiculo): Boolean;
var
  lCombustivel: TCombustivel;
  lSeguro: TSeguro;
begin
  Result := False;

  tblVeiculo.Open;
  if pVeiculo.VeiculoOID <= 0 then
    tblVeiculo.Append
  else
  begin
    if not PesquisarVeiculo(pVeiculo.VeiculoOID) then
     Exit
    else
     tblVeiculo.Edit;
  end;

//  tblVeiculoVeiculoOID.AsInteger := pVeiculo.VeiculoOID;
  tblVeiculoMARCA.AsString := pVeiculo.Marca;
  tblVeiculoMODELO.AsString := pVeiculo.Modelo;
  tblVeiculoPLACA.AsString := pVeiculo.Placa;
  tblVeiculoRENAVAM.AsString := pVeiculo.Renavan;
  tblVeiculoCOR.AsString := pVeiculo.Cor;
  tblVeiculoANO.AsString := pVeiculo.Ano;
  tblVeiculo.post;

  //ADICIONAR COMBUSTIVEIS
  tblVeiculoCombustivel.Open;
  for lCombustivel in pVeiculo.Combustiveis do
  begin
    if not tblVeiculoCombustivel.Locate('COMBUSTIVELID', lCombustivel.CombustivelOID, []) then
    begin
      tblVeiculoCombustivel.Insert;
      tblVeiculoCombustivelCOMBUSTIVELID.AsInteger := lCombustivel.CombustivelOID;
      tblVeiculoCombustivel.Post;
    end;
  end;

  //ADICIONAR SEGUROS
  tblVeiculoSeguro.Open;
  for lSeguro in pVeiculo.Seguros do
  begin
    if not tblVeiculoSeguro.Locate('SEGUROOID', lSEguro.SeguroOID, []) then
    begin
      tblVeiculoSeguro.Insert;
      tblVeiculoSeguroSEGUROOID.AsInteger := lSeguro.SeguroOID;
      tblVeiculoSeguro.Post;
    end;
  end;

  saVeiculo.ApplyUpdates(0);
  saVeiculo.CommitUpdates;
  tblVeiculo.Close;
  tblVeiculoSeguro.Close;
  tblVeiculoCombustivel.Close;
  Result := true;


end;

function TVeiculoController.Veiculos: TJSONValue;
var
  lVeiculo: TVeiculo;
  lArrResult: TJSONArray;
  lJSonObj: TJSONObject;
begin

  with tblVeiculo do
  begin
    Open;

    if IsEmpty then
    begin
      Result := TJSONString.Create('Veículo não encontrado!');
      Close;
      Exit;
    end;

    lArrResult := TJSONArray.Create;
    while not Eof do
    begin
      lVeiculo := ObterVeiculoSelecionado;
      lJSonObj := TJSon.ObjectToJSonObject(lVeiculo);
      lArrResult.AddElement(lJSonObj);
      Next;
    end;
    Close;
    Result := lArrResult;
  end;
end;

function TVeiculoController.Veiculo(ID: Integer): TJSONValue;
var
  lVeiculo: TVeiculo;
begin

  with tblVeiculo do
  begin
    Open;

    if PesquisarVeiculo(ID) then
    begin
      lVeiculo := ObterVeiculoSelecionado;
      Result := TJson.ObjectToJsonObject(lVeiculo);
      lVeiculo.Free;
    end
    else
      Result := TJSONString.Create('Veiculo não encontrado!');

    Close;
  end;

end;

function TVeiculoController.acceptVeiculo(Veiculo: TJSONObject): TJSONValue;
var
  lVeiculo: TVeiculo;
begin
  lVeiculo := TJson.JsonToObject<TVeiculo>(Veiculo);
  if lVeiculo.VeiculoOID <> 0 then
  begin
    Result := TJSONString.Create('Veículo já cadastrado. Inclusão cancelada!');
    Exit;
  end;

  if GravarVeiculo(lVeiculo) then
    Result := TJSONString.Create('Veículo gravado com sucesso!')
  else
    Result := TJSONString.Create('Erro ao gravar o veículo!')

end;

function TVeiculoController.updateVeiculo(Veiculo: TJSONObject): TJSONValue;
var
  lVeiculo: TVeiculo;
begin
  lVeiculo := TJson.JsonToObject<TVeiculo>(Veiculo);

  tblVeiculo.Open;
  if not PesquisarVeiculo(lVeiculo.VeiculoOID) then
  begin
    Result := TJSONString.Create('Veiculo não encontrado!');
    Exit;
  end;
  tblVeiculo.Close;

  if GravarVeiculo(lVeiculo) then
    Result := TJSONString.Create('Veiculo gravado com sucesso!')
  else
    Result := TJSONString.Create('Erro ao gravar o veiculo!')


end;

function TVeiculoController.cancelVeiculo(ID: Integer): TJSONValue;
begin
  tblVeiculo.Open;
  if not PesquisarVeiculo(ID) then
  begin
    Result := TJSONString.Create('Veiculo não encontrado!');
    Exit;
  end;
  tblVeiculo.Close;

  with tblVeiculo do
  begin
    Open;
    PesquisarVeiculo(ID);
    Delete;
    Close;
  end;

end;

end.


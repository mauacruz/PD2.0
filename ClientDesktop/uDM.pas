unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.DBXFirebird, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.Win.ADODB,
  FireDAC.Comp.Client, Data.DB, Data.SqlExpr, Data.FMTBcd, Datasnap.DBClient,
  Datasnap.Provider, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    DBConDBX: TSQLConnection;
    DBConFD: TFDConnection;
    DBConADO: TADOConnection;
    sqlEmployee: TSQLDataSet;
    DspEmployee: TDataSetProvider;
    CdsEmployee: TClientDataSet;
    CdsEmployeeEMP_NO: TSmallintField;
    CdsEmployeeFIRST_NAME: TStringField;
    CdsEmployeeLAST_NAME: TStringField;
    CdsEmployeePHONE_EXT: TStringField;
    CdsEmployeeHIRE_DATE: TSQLTimeStampField;
    CdsEmployeeDEPT_NO: TStringField;
    CdsEmployeeJOB_CODE: TStringField;
    CdsEmployeeJOB_GRADE: TSmallintField;
    CdsEmployeeJOB_COUNTRY: TStringField;
    CdsEmployeeSALARY: TFMTBCDField;
    CdsEmployeeFULL_NAME: TStringField;
    QryWorld: TFDQuery;
    DspWorld: TDataSetProvider;
    cdsWorld: TClientDataSet;
    cdsWorldID: TAutoIncField;
    cdsWorldName: TStringField;
    cdsWorldCountryCode: TStringField;
    cdsWorldDistrict: TStringField;
    cdsWorldPopulation: TIntegerField;
    QryProducts: TADOQuery;
    DspProducts: TDataSetProvider;
    cdsProducts: TClientDataSet;
    cdsProductsProductID: TAutoIncField;
    cdsProductsProductName: TWideStringField;
    cdsProductsSupplierID: TIntegerField;
    cdsProductsCategoryID: TIntegerField;
    cdsProductsQuantityPerUnit: TWideStringField;
    cdsProductsUnitPrice: TBCDField;
    cdsProductsUnitsInStock: TSmallintField;
    cdsProductsUnitsOnOrder: TSmallintField;
    cdsProductsReorderLevel: TSmallintField;
    cdsProductsDiscontinued: TBooleanField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.

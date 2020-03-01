object DM: TDM
  OldCreateOrder = False
  Height = 604
  Width = 1009
  object DBConDBX: TSQLConnection
    ConnectionName = 'DBEmployee'
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'DriverUnit=Data.DBXFirebird'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver240.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=24.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFire' +
        'birdDriver240.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandF' +
        'actory,Borland.Data.DbxFirebirdDriver,Version=24.0.0.0,Culture=n' +
        'eutral,PublicKeyToken=91d62ebb5b0d1b1b'
      'LibraryName=dbxfb.dll'
      'LibraryNameOsx=libsqlfb.dylib'
      'VendorLib=fbclient.dll'
      'VendorLibWin64=fbclient.dll'
      'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird'
      
        'Database=C:\Program Files\Firebird\Firebird_2_5\examples\empbuil' +
        'd\EMPLOYEE.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Role=RoleName'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'SQLDialect=3'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'TrimChar=False'
      'BlobSize=-1'
      'ErrorResourceFile='
      'RoleName=RoleName'
      'ServerCharSet='
      'Trim Char=False')
    Left = 185
    Top = 42
  end
  object DBConFD: TFDConnection
    Params.Strings = (
      'ConnectionDef=DBWorld')
    LoginPrompt = False
    Left = 377
    Top = 42
  end
  object DBConADO: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\Public\Doc' +
      'uments\Embarcadero\Studio\18.0\Samples\Data\fddemo.mdb;Persist S' +
      'ecurity Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 609
    Top = 42
  end
  object sqlEmployee: TSQLDataSet
    CommandText = 'select * from EMPLOYEE'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DBConDBX
    Left = 112
    Top = 112
  end
  object DspEmployee: TDataSetProvider
    DataSet = sqlEmployee
    Left = 112
    Top = 168
  end
  object CdsEmployee: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspEmployee'
    Left = 112
    Top = 232
    object CdsEmployeeEMP_NO: TSmallintField
      FieldName = 'EMP_NO'
      Required = True
    end
    object CdsEmployeeFIRST_NAME: TStringField
      FieldName = 'FIRST_NAME'
      Required = True
      Size = 15
    end
    object CdsEmployeeLAST_NAME: TStringField
      FieldName = 'LAST_NAME'
      Required = True
    end
    object CdsEmployeePHONE_EXT: TStringField
      FieldName = 'PHONE_EXT'
      Size = 4
    end
    object CdsEmployeeHIRE_DATE: TSQLTimeStampField
      FieldName = 'HIRE_DATE'
      Required = True
    end
    object CdsEmployeeDEPT_NO: TStringField
      FieldName = 'DEPT_NO'
      Required = True
      FixedChar = True
      Size = 3
    end
    object CdsEmployeeJOB_CODE: TStringField
      FieldName = 'JOB_CODE'
      Required = True
      Size = 5
    end
    object CdsEmployeeJOB_GRADE: TSmallintField
      FieldName = 'JOB_GRADE'
      Required = True
    end
    object CdsEmployeeJOB_COUNTRY: TStringField
      FieldName = 'JOB_COUNTRY'
      Required = True
      Size = 15
    end
    object CdsEmployeeSALARY: TFMTBCDField
      FieldName = 'SALARY'
      Required = True
      Precision = 18
      Size = 2
    end
    object CdsEmployeeFULL_NAME: TStringField
      FieldName = 'FULL_NAME'
      Size = 37
    end
  end
  object QryWorld: TFDQuery
    Connection = DBConFD
    SQL.Strings = (
      'Select * from city')
    Left = 344
    Top = 112
  end
  object DspWorld: TDataSetProvider
    DataSet = QryWorld
    Left = 344
    Top = 168
  end
  object cdsWorld: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspWorld'
    Left = 344
    Top = 238
    object cdsWorldID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object cdsWorldName: TStringField
      FieldName = 'Name'
      FixedChar = True
      Size = 35
    end
    object cdsWorldCountryCode: TStringField
      FieldName = 'CountryCode'
      FixedChar = True
      Size = 3
    end
    object cdsWorldDistrict: TStringField
      FieldName = 'District'
      FixedChar = True
    end
    object cdsWorldPopulation: TIntegerField
      FieldName = 'Population'
    end
  end
  object QryProducts: TADOQuery
    Connection = DBConADO
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from products'
      '')
    Left = 584
    Top = 104
  end
  object DspProducts: TDataSetProvider
    DataSet = QryProducts
    Left = 584
    Top = 168
  end
  object cdsProducts: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspProducts'
    Left = 584
    Top = 240
    object cdsProductsProductID: TAutoIncField
      FieldName = 'ProductID'
      ReadOnly = True
    end
    object cdsProductsProductName: TWideStringField
      FieldName = 'ProductName'
      Size = 40
    end
    object cdsProductsSupplierID: TIntegerField
      FieldName = 'SupplierID'
    end
    object cdsProductsCategoryID: TIntegerField
      FieldName = 'CategoryID'
    end
    object cdsProductsQuantityPerUnit: TWideStringField
      FieldName = 'QuantityPerUnit'
    end
    object cdsProductsUnitPrice: TBCDField
      FieldName = 'UnitPrice'
      Precision = 19
    end
    object cdsProductsUnitsInStock: TSmallintField
      FieldName = 'UnitsInStock'
    end
    object cdsProductsUnitsOnOrder: TSmallintField
      FieldName = 'UnitsOnOrder'
    end
    object cdsProductsReorderLevel: TSmallintField
      FieldName = 'ReorderLevel'
    end
    object cdsProductsDiscontinued: TBooleanField
      FieldName = 'Discontinued'
    end
  end
end

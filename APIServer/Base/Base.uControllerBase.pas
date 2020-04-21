unit Base.uControllerBase;

interface
uses
  Datasnap.DSProviderDataModuleAdapter;

type
  TMessage = (tmOK, tmNotFound, tmObjectAlreadyExists, tmUnprocessableEntity, tmUndefinedError);
  TControllerBase = class(TDSServerModule)
    protected
      procedure ConfigurarResponse(pMessage: TMessage);

  end;

implementation
uses
  Data.DBXPlatform;

{ TControllerBase }

procedure TControllerBase.ConfigurarResponse(pMessage: TMessage);
begin

  case pmessage of
    tmOK:
    begin
      GetInvocationMetadata.ResponseCode := 200;
      GetInvocationMetadata.ResponseMessage := 'OK!';
    end;
    tmNotFound:
    begin
      GetInvocationMetadata.ResponseCode := 400;
      GetInvocationMetadata.ResponseMessage := 'Not found!';
    end;
    tmObjectAlreadyExists:
    begin
      GetInvocationMetadata.ResponseCode := 400;
      GetInvocationMetadata.ResponseMessage := 'Object already exists!';
    end;
    tmUnprocessableEntity:
    begin
      GetInvocationMetadata.ResponseCode := 422;
      GetInvocationMetadata.ResponseMessage := 'Unprocessable entity!';
    end;

    tmUndefinedError:
    begin
      GetInvocationMetadata.ResponseCode := 400;
      GetInvocationMetadata.ResponseMessage := 'Undefined error!';
    end;



  end;

end;

end.

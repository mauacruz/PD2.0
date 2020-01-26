unit Expedicao.Models.uSeguradora;

interface

type
  TSeguradora = class
    private
      FSeguradoraOID: Integer;
      FDescricao: string;
      FCNPJ: string;
      FTelefone: string;
      FCorretor: string;

    public
      property SeguradoraOID: Integer read FSeguradoraOID write FSeguradoraOID;
      property Descricao: string read FDescricao write FDescricao;
      property CNPJ: string read FCNPJ write FCNPJ;
      property Telefone: string read FTelefone write FTelefone;
      property Corretor: string read FCorretor write FCorretor;



  end;

implementation

end.

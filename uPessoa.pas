unit uPessoa;

interface

uses
  uRTTIUtils;

type
  TEntidade = class
  private
    FSobrenome: String;
    FNome     : String;
    procedure SetNome(const Value: String);
    procedure SetSobrenome(const Value: String);
  public
    [Form(tcEdit, 'Nome', 150)]
    property Nome: String read FNome write SetNome;
    [Form(tcEdit, 'Sobrenome', 150)]
    property Sobrenome: String read FSobrenome write SetSobrenome;
  end;

implementation

{ TEntidade }

procedure TEntidade.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TEntidade.SetSobrenome(const Value: String);
begin
  FSobrenome := Value;
end;

end.

unit uPessoa;

interface

uses
  uRTTIUtils,
  Vcl.Dialogs;

type
  TClassSalvar = Procedure(Sender: TObject) of Object;

  TEntidade = class
  private
    FSobrenome: String;
    FNome     : String;
    FSalvar   : TClassSalvar;
    procedure SetNome(const Value: String);
    procedure SetSobrenome(const Value: String);
    procedure SetSalvar(const Value: TClassSalvar);
  public
    [Form(tcEdit, 'Nome', 150)]
    property Nome: String read FNome write SetNome;
    [Form(tcEdit, 'Sobrenome', 150)]
    property Sobrenome: String read FSobrenome write SetSobrenome;
    [Form(tcButton, 'Salvar', 100)]
    property Salvar: TClassSalvar read FSalvar write SetSalvar;

    procedure SalvarClick(Sender: TObject);
  end;

implementation

{ TEntidade }

procedure TEntidade.SalvarClick(Sender: TObject);
begin
  ShowMessage('Click em salvar');
end;

procedure TEntidade.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TEntidade.SetSalvar(const Value: TClassSalvar);
begin
  FSalvar := Value;
end;

procedure TEntidade.SetSobrenome(const Value: String);
begin
  FSobrenome := Value;
end;

end.

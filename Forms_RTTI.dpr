program Forms_RTTI;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {Form1},
  uRTTIUtils in 'uRTTIUtils.pas',
  uPessoa in 'uPessoa.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

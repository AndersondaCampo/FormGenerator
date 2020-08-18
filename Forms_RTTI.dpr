program Forms_RTTI;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {Frm_Principal},
  uRTTIUtils in 'uRTTIUtils.pas',
  uPessoa in 'uPessoa.pas',
  uFormPadrao in 'uFormPadrao.pas' {Frm_padrao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrm_Principal, Frm_Principal);
  Application.Run;
end.

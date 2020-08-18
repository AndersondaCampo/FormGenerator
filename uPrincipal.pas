unit uPrincipal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  uRTTIUtils,
  uPessoa,
  Vcl.StdCtrls,
  uFormPadrao;

type
  TFrm_Principal = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Principal: TFrm_Principal;

implementation

{$R *.dfm}

procedure TFrm_Principal.Button1Click(Sender: TObject);
var
  LFrmCad: TFrm_padrao;
begin
  LFrmCad := TFrm_padrao.Create(Self);
  try
    TRTTIUtils.ClassToFormCreate<TEntidade>(LFrmCad);

    if LFrmCad.ShowModal = mrOK then
      ShowMessage('ModalResult = mrOK');
  finally
    FreeAndNil(LFrmCad);
  end;
end;

end.

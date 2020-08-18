unit uRTTIUtils;

interface

uses
  Vcl.Forms,
  Vcl.StdCtrls;

type
  TTypeComponent = (tcEdit, tcLabel, tcButton);

  Form = class(TCustomAttribute)
  private
    FWidth        : Integer;
    FTypeComponent: TTypeComponent;
    FNome         : String;
    procedure SetNome(const Value: String);
    procedure SetTypeComponent(const Value: TTypeComponent);
    procedure SetWidth(const Value: Integer);
  public
    constructor Create(aType: TTypeComponent; aName: String; aWidth: Integer);
    property TypeComponent: TTypeComponent read FTypeComponent write SetTypeComponent;
    property Nome: String read FNome write SetNome;
    property Width: Integer read FWidth write SetWidth;
  end;

  TRTTIUtils = class
  private
  public
    class procedure ClassToFormCreate<T: class>(aEmbeded: TForm);
  end;

implementation

uses
  System.RTTI,
  System.TypInfo;

{ Form }

constructor Form.Create(aType: TTypeComponent; aName: String; aWidth: Integer);
begin
  FTypeComponent := aType;
  FNome          := aName;
  FWidth         := aWidth;
end;

procedure Form.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure Form.SetTypeComponent(const Value: TTypeComponent);
begin
  FTypeComponent := Value;
end;

procedure Form.SetWidth(const Value: Integer);
begin
  FWidth := Value;
end;

{ TRTTIUtils }

class procedure TRTTIUtils.ClassToFormCreate<T>(aEmbeded: TForm);
var
  ctxContext: TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  cusAttr   : TCustomAttribute;
  Info      : PTypeInfo;
  FCountTop : Integer;
  FCountLeft: Integer;

  LEdit : TEdit;
  LLabel: TLabel;

begin
  FCountTop  := 10;
  FCountLeft := 10;

  ctxContext := TRttiContext.Create;
  try
    Info    := System.TypeInfo(T);
    typRtti := ctxContext.GetType(Info);

    for prpRtti in typRtti.GetProperties do
      for cusAttr in prpRtti.GetAttributes do
      begin
        if cusAttr is Form then
        begin

          case Form(cusAttr).TypeComponent of
            tcEdit:
              begin
                LLabel         := TLabel.Create(aEmbeded);
                LLabel.Parent  := aEmbeded;
                LLabel.Caption := Form(cusAttr).Nome;
                LLabel.Name    := 'lbl' + Form(cusAttr).Nome;
                LLabel.Top     := FCountTop;
                LLabel.Left    := FCountLeft;
                FCountTop      := FCountTop + 15;

                LEdit        := TEdit.Create(aEmbeded);
                LEdit.Parent := aEmbeded;
                LEdit.Name   := 'edt' + Form(cusAttr).Nome;
                LEdit.Width  := Form(cusAttr).Width;
                LEdit.Text   := '';
                LEdit.Top    := FCountTop;
                LEdit.Left   := FCountLeft;
                FCountTop    := FCountTop + 30;
              end;
          end;

        end;
      end;

  finally
    ctxContext.Free;
  end;
end;

end.

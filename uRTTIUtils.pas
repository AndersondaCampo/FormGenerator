unit uRTTIUtils;

interface

uses
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.Controls;

type
  TTypeComponent = (tcEdit, tcLabel, tcButton);

  Form = class(TCustomAttribute)
  private
    FWidth        : Integer;
    FTypeComponent: TTypeComponent;
    FNome         : String;
    FModalResult  : TModalResult;
    procedure SetNome(const Value: String);
    procedure SetTypeComponent(const Value: TTypeComponent);
    procedure SetWidth(const Value: Integer);
    procedure SetModalResult(const Value: TModalResult);
  public
    constructor Create(aType: TTypeComponent; aName: String; aWidth: Integer);
    property TypeComponent: TTypeComponent read FTypeComponent write SetTypeComponent;
    property Nome: String read FNome write SetNome;
    property Width: Integer read FWidth write SetWidth;
  end;

  TRTTIUtils = class
  private
  public
    class function ClassToFormCreate<T: class>(aEmbeded: TForm): Integer;
  end;

const
  EDIT_LEFT  = 70;
  LABEL_LEFT = 10;

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

procedure Form.SetModalResult(const Value: TModalResult);
begin
  FModalResult := Value;
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

class function TRTTIUtils.ClassToFormCreate<T>(aEmbeded: TForm): Integer;
var
  ctxContext: TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  cusAttr   : TCustomAttribute;
  Info      : PTypeInfo;
  FCountTop : Integer;

  LEdit  : TEdit;
  LLabel : TLabel;
  LButton: TButton;

begin
  FCountTop := 10;

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
                LLabel.Left    := LABEL_LEFT;

                LEdit        := TEdit.Create(aEmbeded);
                LEdit.Parent := aEmbeded;
                LEdit.Name   := 'edt' + Form(cusAttr).Nome;
                LEdit.Width  := Form(cusAttr).Width;
                LEdit.Text   := '';
                LEdit.Top    := FCountTop;
                LEdit.Left   := EDIT_LEFT;
                FCountTop    := FCountTop + 30;
              end;

            tcButton:
              begin
                LButton             := TButton.Create(aEmbeded);
                LButton.Parent      := aEmbeded;
                LButton.Caption     := Form(cusAttr).Nome;
                LButton.ModalResult := mrOk;
                LButton.Width       := Form(cusAttr).Width;
                LButton.Top         := (aEmbeded.ClientHeight) - FCountTop ;
                LButton.Left        := (aEmbeded.Width div 2) - Form(cusAttr).Width;
                FCountTop           := FCountTop + 30;
              end;
          end;

        end;
      end;

  finally
    ctxContext.Free;
  end;
end;

end.

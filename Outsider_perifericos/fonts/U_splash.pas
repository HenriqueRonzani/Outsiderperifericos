unit U_splash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Imaging.pngimage;

type
  Tfrm_principal = class(TForm)
    Image1: TImage;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_principal: Tfrm_principal;

implementation

{$R *.dfm}

uses U_cadastro;

procedure Tfrm_principal.Timer1Timer(Sender: TObject);

begin
progressbar1.Position:=progressbar1.Position+1;
if progressbar1.Position = 100 then
begin
  timer1.Enabled:=false;
  frm_principal.Visible:=false;
  frm_cadastro.Show;

end;

end;
end.

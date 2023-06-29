unit U_cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Menus;

type
  Tfrm_cadastro = class(TForm)
    Image1: TImage;
    Image2: TImage;
    btn_cad: TImage;
    btn_logar: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_cadClick(Sender: TObject);
    procedure btn_logarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_cadastro: Tfrm_cadastro;

implementation

{$R *.dfm}

uses U_cadlogin, U_dm;

procedure Tfrm_cadastro.btn_cadClick(Sender: TObject);
begin
dm.clientes.Open;
dm.clientes.Insert;
with frm_cadlogin do begin
  tb_cadastro.tabVisible:= true;
  tb_login.tabvisible:= false;
  pgc.TabIndex:=0;
  frm_cadlogin.Showmodal;
end;

end;

procedure Tfrm_cadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure Tfrm_cadastro.btn_logarClick(Sender: TObject);
begin
with frm_cadlogin do begin
  tb_cadastro.tabVisible:= false;
  tb_login.tabVisible:= true;
  pgc.TabIndex:=0;
  frm_cadlogin.Showmodal;
end;
end;

end.

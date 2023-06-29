unit U_cadlogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.UITypes, Data.DB, FireDAC.Stan.Param;

type
  Tfrm_cadlogin = class(TForm)
    pgc: TPageControl;
    tb_cadastro: TTabSheet;
    tb_login: TTabSheet;
    Image1: TImage;
    cad_nome: TDBEdit;
    cad_cpf: TDBEdit;
    cad_nasc: TDBEdit;
    cad_telefone: TDBEdit;
    cad_email: TDBEdit;
    cad_endereco: TDBEdit;
    cad_cidade: TDBEdit;
    cad_cep: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    data_cad: TDBEdit;
    cad_id: TDBEdit;
    cad_senha: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    log_email: TEdit;
    log_senha: TEdit;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label12: TLabel;
    cad_tipo: TDBEdit;
    Label14: TLabel;
    cad_uf: TDBEdit;
    UF: TComboBox;
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_cadlogin: Tfrm_cadlogin;

implementation

{$R *.dfm}

uses U_dm, U_cadastro, U_biblio, U_menuprincipal, U_splash;

procedure Tfrm_cadlogin.FormActivate(Sender: TObject);
begin

  with dm.estado do begin
  UF.Clear;
  sql.Clear;
  sql.Add('select * from estado');
   open;
     while not eof do begin
       UF.Items.Add(FieldByName('UF').AsString);
       next;
     end;
  end;


end;

procedure Tfrm_cadlogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
frm_cadastro.Visible:=true;
dm.clientes.Cancel;
end;

procedure Tfrm_cadlogin.Image1Click(Sender: TObject);
begin
cad_uf.Text:=inttostr(uf.ItemIndex+1);
cad_tipo.Text:= '2';
if (Verificapreenche(frm_cadlogin)) then
messagedlg('Preencha todos campos!',mtWarning,[mbok,mbok],0)
else if VerificaDuplicidade(cad_cpf.Text,cad_email.Text) then
messagedlg('E-mail ou CPF já cadastrados!',mtWarning,[mbok,mbok],0)
else begin
data_cad.Text:= DateTimeToStr(now);
dm.clientes.Post;
dm.clientes.Active:=false;
messagedlg('Seu cadastro foi realizado com sucesso!'+ #13+'Agora realize login',mtInformation,[mbok,mbok],0);
close;
end;
end;

procedure Tfrm_cadlogin.Image2Click(Sender: TObject);
begin
  with dm.login do begin
    close;
    sql.Clear;
    sql.add('SELECT * FROM cliente WHERE email= :email and senha= :senha');
    ParamByName('email').AsString:=log_email.Text;
    ParamByName('senha').AsString:=log_senha.Text;
    Prepare;

    open;

    if not IsEmpty then begin
      abrir(frm_menuprincipal,frm_principal,frm_cadastro,frm_cadlogin);
    end
    else
    messagedlg('Cadastro não encontrado! '#13'Certifique-se que digitou os dados corretos',mtError,[mbok,mbok],0);

  end;
end;

end.








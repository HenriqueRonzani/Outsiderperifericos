unit U_loja;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.UITypes, FireDAC.Stan.Param,
  Vcl.StdCtrls;

type
  Tfrm_produto = class(TForm)
    Image1: TImage;
    foto: TImage;
    lb_preco: TLabel;
    lb_nome: TLabel;
    lb_modelo: TLabel;
    esquerda: TImage;
    Image3: TImage;
    titulo: TLabel;
    textinho: TLabel;
    Image2: TImage;
    lb_marca: TLabel;
    procedure esquerdaClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_produto: Tfrm_produto;

implementation

{$R *.dfm}

uses U_dm, U_menuprincipal, U_biblio;

procedure Tfrm_produto.esquerdaClick(Sender: TObject);
begin

  with dm.loja do
    if not Bof then begin
      Prior;
      atribuir(frm_produto.foto,frm_produto.lb_nome,frm_produto.lb_marca,frm_produto.lb_preco,frm_produto.lb_modelo,tipoperif,tipodoprod);
      textinho.Caption:= 'COMPRE '#13#10' '+lb_nome.Caption+' '#13#10' AGORA MESMO!!!';
    end

end;

procedure Tfrm_produto.FormActivate(Sender: TObject);
begin
  case tipodoprod of

    1:titulo.Caption:='TECLADOS';
    2:titulo.Caption:='MOUSES';
    3:titulo.Caption:='MICROFONES';
    4:titulo.Caption:='HEADSETS';

  end;

  textinho.Caption:= 'COMPRE '#13#10' '+lb_nome.Caption+' '#13#10' AGORA MESMO!!!';
end;

procedure Tfrm_produto.Image2Click(Sender: TObject);
begin

  if MessageDlg('Tem certeza que quer comprar?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    with dm.comprar do begin
      sql.clear;
      sql.add('INSERT INTO pedido (id, cod_cliente, cod_produto) VALUES (DEFAULT, :cliente, :produto)');
      parambyname('cliente').AsInteger:= dm.login.FieldByName('id').AsInteger;
      parambyname('produto').AsInteger:= dm.loja.FieldByName('id').AsInteger;
      ExecSQL;
    end;
    Messagedlg('Compra realizada com sucesso', mtInformation, [mbok,mbok], 0);

    frm_produto.close;
  end;

end;

procedure Tfrm_produto.Image3Click(Sender: TObject);
begin

   with dm.loja do
    if not Eof then begin
      Next;
      atribuir(frm_produto.foto,frm_produto.lb_nome,frm_produto.lb_marca,frm_produto.lb_preco,frm_produto.lb_modelo,tipoperif,tipodoprod);
      textinho.Caption:= 'COMPRE '#13#10' '+lb_nome.Caption+' '#13#10' AGORA MESMO!!!';
    end

end;

end.

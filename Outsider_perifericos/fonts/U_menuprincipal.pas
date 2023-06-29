unit U_menuprincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.Mask, Vcl.DBCtrls,System.IOUtils,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Param, System.UITypes;

type
  Tfrm_menuprincipal = class(TForm)
    pedidos: TPageControl;
    produtos: TTabSheet;
    pedido: TTabSheet;
    Conta: TTabSheet;
    adicionar: TTabSheet;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    ed_nome: TLabeledEdit;
    ed_email: TLabeledEdit;
    ed_cpf: TLabeledEdit;
    ed_nasc: TLabeledEdit;
    ed_cad: TLabeledEdit;
    ed_senha: TLabeledEdit;
    StatusBar1: TStatusBar;
    Image4: TImage;
    img_teclado: TImage;
    img_mouse: TImage;
    img_mic: TImage;
    img_headset: TImage;
    bg1: TImage;
    lb_teclado: TLabel;
    lb_mouse: TLabel;
    lb_mic: TLabel;
    lb_head: TLabel;
    Label2: TLabel;
    cad_preco: TDBEdit;
    cad_modelo: TDBEdit;
    cad_nome: TDBEdit;
    cad_marca: TDBEdit;
    cad_id: TDBEdit;
    Label3: TLabel;
    Label5: TLabel;
    Image3: TImage;
    btn_cadastrar: TImage;
    Label6: TLabel;
    Label11: TLabel;
    Label7: TLabel;
    cad_tipo: TDBRadioGroup;
    add: TImage;
    lb_add: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Image5: TImage;
    DBGrid1: TDBGrid;
    Label9: TLabel;
    Label10: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure img_mouseClick(Sender: TObject);
    procedure img_micClick(Sender: TObject);
    procedure img_headsetClick(Sender: TObject);
    procedure img_tecladoClick(Sender: TObject);
    procedure pedidosChange(Sender: TObject);
    procedure addClick(Sender: TObject);
    procedure btn_cadastrarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_menuprincipal: Tfrm_menuprincipal;
  visivel:bool=false;
  tipoperif:string;
  filetype,destinopath:string;
  origempath:string='null';
  tipodoprod:integer;

implementation

{$R *.dfm}

uses U_biblio, U_dm, U_loja;

procedure Tfrm_menuprincipal.FormActivate(Sender: TObject);
begin

  StatusBar1.Panels[0].Text:= '   '+dm.login.FieldByName('nome').Value;

  case dm.login.FieldByName('tipo').Value of
    1:begin
    statusbar1.Panels[1].Text:='Funcionário';
    adicionar.tabVisible:=true;
    end;

    2:begin
    statusbar1.Panels[1].Text:='Usuário';
    adicionar.tabVisible:=false;
    end

    else begin
    statusbar1.Panels[1].Text:='';
    adicionar.tabVisible:=false;
    end;
  end;

  with dm.login do begin
    ed_nome.Text:= FieldByName('nome').Value;
    ed_email.Text:= FieldByName('email').Value;
    ed_cpf.Text:= FieldByName('cpf').value;
    ed_nasc.Text:= FieldByName('data_nascimento').Value;
    ed_cad.Text:= FieldByName('data_cad').Value;
    ed_senha.Text:= FieldByName('senha').Value;
  end;

  statusbar1.Panels[2].Text:= dm.login.FieldByName('email').Value + '   ';

  with dm.mostrarpedido do begin

    sql.clear;
    sql.add('select p.id,c.nome,p.marca,p.modelo,p.preco from cliente as c join pedido as d on c.id=d.cod_cliente join produto as p on p.id=d.cod_produto where c.id=:id');
    parambyname('id').AsInteger:= dm.login.FieldByName('id').AsInteger;
    active;
    open;
    if not IsEmpty then
    DBGrid1.Visible:=true
    else
    DBGrid1.Visible:=false
  end;
  DBGrid1.Columns[0].Title.Caption := 'ID Produto';
  DBGrid1.Columns[1].Title.Caption := 'Comprador';
  DBGrid1.Columns[2].Title.Caption := 'Marca';
  DBGrid1.Columns[3].Title.Caption := 'Modelo';
  DBGrid1.Columns[4].Title.Caption := 'Preço (R$)';

end;

procedure Tfrm_menuprincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure Tfrm_menuprincipal.Image2Click(Sender: TObject);
begin
  if visivel=false then begin
    ed_cpf.PasswordChar:=#0;
    ed_senha.PasswordChar:=#0;
    visivel:=true;
  end
  else begin
    ed_cpf.PasswordChar:='*';
    ed_senha.PasswordChar:='*';
    visivel:=false;
  end;
end;

procedure Tfrm_menuprincipal.btn_cadastrarClick(Sender: TObject);
begin
if (origempath='null') or (verificapreenche(frm_menuprincipal)) then
messagedlg('Preencha todos campos!',mtWarning,[mbok,mbok],0)

  else begin
    dm.produto.Post;
    with dm.cadastroperif do begin
      sql.Clear;
      sql.add('SELECT MAX(id) AS id FROM produto');
    dm.cadastroperif.open;
    end;
        case cad_tipo.ItemIndex of
          0: begin
            destinopath := 'img/teclado/'+ inttostr(dm.cadastroperif.fieldbyname('id').value)+filetype;
            TFile.Copy(origempath, destinopath);
          end;

          1: begin
            destinopath := 'img/mouse/'+ inttostr(dm.cadastroperif.fieldbyname('id').value)+filetype;
            TFile.Copy(origempath, destinopath);
          end;

          2: begin
            destinopath := 'img/microfone/'+ inttostr(dm.cadastroperif.fieldbyname('id').value)+filetype;
            TFile.Copy(origempath, destinopath);
          end;

          3: begin
            destinopath := 'img/headset/'+ inttostr(dm.cadastroperif.fieldbyname('id').value)+filetype;
            TFile.Copy(origempath, destinopath);
          end;
        end;
    dm.cadastroperif.close;
    messagedlg('Cadastro realizado com susceso!',mtinformation,[mbok],0);
    origempath:='null';
    destinopath:='';
    add.Picture.LoadFromFile('img/savefile.png');


  end;
end;

procedure Tfrm_menuprincipal.DBGrid1CellClick(Column: TColumn);
var
id:integer;
begin
id:= DBGrid1.Fields[0].Value;
    with dm.SQL_imprimir_cliente do
    begin
      Close;
      sql.Clear;
      sql.add('select * from cliente as c join pedido as d on c.id=d.cod_cliente join produto as p on p.id=d.cod_produto join estado as e on e.id=c.UF where c.id=:id and p.id=:pid');
      ParamByName('id').AsInteger:= dm.login.FieldByName('id').AsInteger;
      ParamByName('pid').AsInteger:= id;
      Open;
      dm.report_pedido.LoadFromFile(GetCurrentDir + '\rel\rel1.fr3');
      dm.report_pedido.ShowReport();
    end;
end;

procedure Tfrm_menuprincipal.addClick(Sender: TObject);
var
  Opendialog: TOpenDialog;
  begin
    OpenDialog := TOpenDialog.Create(nil);
    OpenDialog.Title := 'Select a File';
    OpenDialog.Filter:= 'PNG Files (*.png)|*.png';

    if OpenDialog.Execute then
    begin

      origempath:= Opendialog.FileName;
      add.Picture.LoadFromFile(origempath);
      FileType := ExtractFileExt(origempath);
    end
end;

procedure Tfrm_menuprincipal.img_headsetClick(Sender: TObject);
begin
  tipoperif:='img\headset';
   tipodoprod:=4;
    with dm.loja do begin
      sql.Clear;
      sql.Add('select * from produto where tipo = :tipoproduto');
      ParamByName('tipoproduto').AsInteger:=  tipodoprod;
    end;

  atribuir(frm_produto.foto,frm_produto.lb_nome,frm_produto.lb_marca,frm_produto.lb_preco,frm_produto.lb_modelo,tipoperif,tipodoprod);
  frm_produto.Show;

end;

procedure Tfrm_menuprincipal.img_micClick(Sender: TObject);
begin
  tipoperif:='img\microfone';
   tipodoprod:=3;
    with dm.loja do begin
      sql.Clear;
      sql.Add('select * from produto where tipo = :tipoproduto');
      ParamByName('tipoproduto').AsInteger:=  tipodoprod;
    end;

  atribuir(frm_produto.foto,frm_produto.lb_nome,frm_produto.lb_marca,frm_produto.lb_preco,frm_produto.lb_modelo,tipoperif,tipodoprod);
  frm_produto.Show;

end;

procedure Tfrm_menuprincipal.img_mouseClick(Sender: TObject);
begin
  tipoperif:='img\mouse';
   tipodoprod:=2;
    with dm.loja do begin
      sql.Clear;
      sql.Add('select * from produto where tipo = :tipoproduto');
      ParamByName('tipoproduto').AsInteger:=  tipodoprod;
    end;

  atribuir(frm_produto.foto,frm_produto.lb_nome,frm_produto.lb_marca,frm_produto.lb_preco,frm_produto.lb_modelo,tipoperif,tipodoprod);
  frm_produto.Show;

end;

procedure Tfrm_menuprincipal.img_tecladoClick(Sender: TObject);
begin
  tipoperif:='img\teclado';
  tipodoprod:=1;
    with dm.loja do begin
      sql.Clear;
      sql.Add('select * from produto where tipo = :tipoproduto');
      ParamByName('tipoproduto').AsInteger:=  tipodoprod;
    end;

  atribuir(frm_produto.foto,frm_produto.lb_nome,frm_produto.lb_marca,frm_produto.lb_preco,frm_produto.lb_modelo,tipoperif,tipodoprod);
  frm_produto.Show;

end;

procedure Tfrm_menuprincipal.pedidosChange(Sender: TObject);
begin
  if (pedidos.ActivePage = adicionar) then
  begin
    dm.produto.open;
    dm.produto.insert;
  end
  else
  begin
    dm.produto.Cancel;
    add.Picture.LoadFromFile('img/savefile.png');
  end;

end;

end.

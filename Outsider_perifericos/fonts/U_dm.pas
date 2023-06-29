unit U_dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, frxClass, frxDBSet;

type
  Tdm = class(TDataModule)
    connection: TFDConnection;
    clientes: TFDTable;
    driver: TFDPhysMySQLDriverLink;
    datasourcecliente: TDataSource;
    login: TFDQuery;
    cadastro: TFDQuery;
    loja: TFDQuery;
    produto: TFDTable;
    datasourceproduto: TDataSource;
    cadastroperif: TFDQuery;
    comprar: TFDQuery;
    mostrarpedido: TFDQuery;
    mostrar: TDataSource;
    produtoid: TFDAutoIncField;
    produtonome: TStringField;
    produtomarca: TStringField;
    produtomodelo: TStringField;
    produtotipo: TIntegerField;
    produtopreco: TBCDField;
    clientesid: TFDAutoIncField;
    clientesnome: TStringField;
    clientesemail: TStringField;
    clientestelefone: TStringField;
    clientescpf: TStringField;
    clientesdata_nascimento: TDateField;
    clientesdata_cad: TDateField;
    clientesendereco: TStringField;
    clientescep: TStringField;
    clientescidade: TStringField;
    clientessenha: TStringField;
    clientestipo: TIntegerField;
    estado: TFDQuery;
    clientesUF: TIntegerField;
    sql_imprimir_cliente: TFDQuery;
    report_pedido: TfrxReport;
    ds_rel_pedido: TfrxDBDataset;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin

driver.VendorLib:= GetCurrentDir+ '\lib\libmysql.dll';
clientes.Active;
login.Active;
end;

end.

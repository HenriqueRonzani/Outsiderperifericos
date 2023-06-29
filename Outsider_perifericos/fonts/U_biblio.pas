unit U_biblio;

interface
Uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Menus;


Function Verificapreenche(form:Tform):boolean;
Function VerificaDuplicidade(cpf,email:string):boolean;
Procedure abrir(Paraabrir,f1,f2,f3:Tform);



Procedure atribuir(Ima:Timage;nomeprod,marcaprod,precoprod,modeloprod:Tlabel;Tipopr:string;tipopo:integer);


implementation

Uses U_dm;


Function Verificapreenche(form:Tform):boolean;
var
i:integer;
begin
result:=false;
  for i := 0 to form.ComponentCount-1 do

    if (form.Components[i] is TDBEdit) and (TDBEdit(Form.Components[i]).Text = '') then result:=true

else if (form.Components[i] is TDBRadioGroup) and
(TDBRadioGroup(Form.Components[i]).ItemIndex <0 ) then result:=true;

end;

Function VerificaDuplicidade(cpf,email:string):boolean;
begin
  with dm.cadastro do begin
    close;
    sql.clear;
    sql.add('Select * from cliente where cpf = :cpf or email = :email');
    parambyname('cpf').asstring:= cpf;
    parambyname('email').asstring:= email;

    open;

    if not isempty then
    result:=true
    else
    result:=false;
  end;
end;


Procedure abrir(Paraabrir,f1,f2,f3:Tform);
begin
Paraabrir.Show;
f1.visible:=false;
f2.visible:=false;
f3.visible:=false;
end;


Procedure atribuir(Ima:Timage;nomeprod,marcaprod,precoprod,modeloprod:Tlabel;Tipopr:string;tipopo:integer);
begin

  with dm.loja do begin

    open;

    Ima.Picture.LoadFromFile(tipopr + '/' + IntToStr(FieldByName('id').Value) + '.png');
    nomeprod.Caption := FieldByName('nome').AsString;
    marcaprod.Caption := FieldByName('marca').AsString;
    precoprod.Caption := 'R$ ' + FormatFloat('#0.00', FieldByName('preco').AsFloat);
    modeloprod.Caption:= FieldByName('modelo').AsString;

  end;

end;

end.

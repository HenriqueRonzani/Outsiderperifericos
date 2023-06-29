program Outsider;

uses
  Vcl.Forms,
  U_splash in 'fonts\U_splash.pas' {frm_principal},
  U_cadastro in 'fonts\U_cadastro.pas' {frm_cadastro},
  U_cadlogin in 'fonts\U_cadlogin.pas' {frm_cadlogin},
  U_dm in 'fonts\U_dm.pas' {dm: TDataModule},
  U_menuprincipal in 'fonts\U_menuprincipal.pas' {frm_menuprincipal},
  U_biblio in 'fonts\U_biblio.pas',
  U_loja in 'fonts\U_loja.pas' {frm_produto};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_principal, frm_principal);
  Application.CreateForm(Tfrm_cadastro, frm_cadastro);
  Application.CreateForm(Tfrm_cadlogin, frm_cadlogin);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tfrm_menuprincipal, frm_menuprincipal);
  Application.CreateForm(Tfrm_produto, frm_produto);
  Application.Run;
end.

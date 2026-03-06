program Loja;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uListarCarro in 'uListarCarro.pas' {frmListarCarro},
  uDM in 'uDM.pas' {DM: TDataModule},
  uLib in 'uLib.pas',
  uConstante in 'uConstante.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    menModulo: TMainMenu;
    Cadastro1: TMenuItem;
    Relatrio1: TMenuItem;
    Sair1: TMenuItem;
    Carro1: TMenuItem;
    Cidade1: TMenuItem;
    Movimento1: TMenuItem;
    Aluguel1: TMenuItem;
    stbRodape: TStatusBar;
    tmrPrincipal: TTimer;
    procedure Carro1Click(Sender: TObject);
    procedure Aluguel1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrPrincipalTimer(Sender: TObject);
  private
    procedure ExibirCarro;
    procedure ExibirAluguel;
    procedure Login;
    procedure PreencherInformacoesRodape;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uDM,
  uListarCarro,
  uListarAluguel,
  uLogin;

{$R *.dfm}

procedure TfrmPrincipal.Aluguel1Click(Sender: TObject);
begin
  ExibirAluguel;
end;

procedure TfrmPrincipal.Carro1Click(Sender: TObject);
begin
  ExibirCarro;
end;

procedure TfrmPrincipal.ExibirCarro;
begin
  var TelaListarCarro := TfrmListarCarro.Create(nil);
  try
    TelaListarCarro.ShowModal;
  finally
    TelaListarCarro.Free;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Login;
end;

procedure TfrmPrincipal.Login;
begin
  var TelaLogin := TfrmLogin.Create(nil);
  try
    TelaLogin.ShowModal;
  finally
    TelaLogin.Free;
  end;
end;

procedure TfrmPrincipal.PreencherInformacoesRodape;
begin
  stbRodape.Panels[0].Text := 'Data: ' + DateToStr(Date);
  stbRodape.Panels[1].Text := 'Hora: ' + TimeToStr(Time);
  stbRodape.Panels[2].Text := 'Cpf: ' + DM.qryUsuarioLogadoCPF.AsString;
  stbRodape.Panels[3].Text := 'Usuário: ' + DM.qryUsuarioLogadoNOME.AsString;
end;

procedure TfrmPrincipal.tmrPrincipalTimer(Sender: TObject);
begin
  PreencherInformacoesRodape;
end;

procedure TfrmPrincipal.ExibirAluguel;
begin
  var TelaListarAluguel := TfrmListarAluguel.Create(nil);
  try
    TelaListarAluguel.ShowModal;
  finally
    TelaListarAluguel.Free;
  end;
end;
end.

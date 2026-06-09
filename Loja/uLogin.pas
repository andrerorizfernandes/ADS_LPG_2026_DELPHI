unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  System.StrUtils;

type
  TfrmLogin = class(TForm)
    btnAcessar: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblSenha2: TLabel;
    Label4: TLabel;
    edtSenha1: TEdit;
    edtSenha2: TEdit;
    edtCPF: TMaskEdit;
    edtUsuario: TEdit;
    lblDominio: TLabel;
    procedure edtCPFChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAcessarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtSenha1KeyPress(Sender: TObject; var Key: Char);
    procedure edtSenha2KeyPress(Sender: TObject; var Key: Char);
  private
    procedure Acessar;
    procedure CarregarUsuario(const Cpf: string);
    procedure AcionarRecurso(const Key: Char);
    procedure PrepararAmbiente;
    procedure FecharLogin;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLogou: Boolean;

implementation

{$R *.dfm}

uses uLib, uDM;

procedure TfrmLogin.Acessar;
begin
  try
    if DadoInvalido(edtSenha1.Text, 'Digite a Senha', edtSenha1) then
      Exit;

    if (DM.qryUsuarioLogadoSenha.AsString = EmptyStr) then
    begin
      if (edtSenha1.Text <> edtSenha2.Text) then
      begin
        Alerta('As senhas informadas são diferentes. Proceda a correção.');
        edtSenha1.Text := EmptyStr;
        edtSenha2.Text := EmptyStr;
        edtSenha1.SetFocus;
        Exit;
      end;

      DM.qryUsuarioLogado.Edit;
      DM.qryUsuarioLogadoSenha.AsString := MD5(edtSenha1.Text);
      DM.qryUsuarioLogado.Post;

      Alerta('Senha cadastrada com sucesso !');
    end;

    if MD5(edtSenha1.Text) <> DM.qryUsuarioLogadoSenha.AsString then
      begin
        Alerta('Senha inválida');
        edtSenha1.Text := EmptyStr;
        edtSenha1.SetFocus;
        Exit;
      end
    else
      begin
        FLogou := True;
        Close;
      end;
  except
    on E: Exception do
    begin
     Alerta('Operação Cancelada ' + E.Message);
    end;
  end;
end;

procedure TfrmLogin.AcionarRecurso(const Key: Char);
begin
  if (Key = #13) and edtSenha2.Visible then
    edtSenha2.SetFocus;

  if (Key = #13) and (not edtSenha2.Visible) then
    btnAcessar.Click;
end;

procedure TfrmLogin.btnAcessarClick(Sender: TObject);
begin
  Acessar;
end;

procedure TfrmLogin.CarregarUsuario(const Cpf: string);
begin
  if (Cpf.Trim.Length = 11) then
    PassarParametro(DM.qryUsuarioLogado, [Cpf]);

  if DM.qryUsuarioLogado.IsEmpty or (Cpf.Trim.Length <> 11) then
    begin
      edtUsuario.Clear;
      btnAcessar.Enabled := False;
      edtSenha1.Enabled := False;
      edtSenha1.Color := clBtnFace;
      edtSenha2.Visible := False;
    end
  else
    begin
      btnAcessar.Enabled := True;
      edtUsuario.Text := DM.qryUsuarioLogadoNOME.AsString;
      edtSenha1.Enabled := True;
      edtSenha1.Color := clWindow;
      edtSenha2.Visible := DM.qryUsuarioLogadoSENHA.AsString = EmptyStr;
      lblSenha2.Visible := edtSenha2.Visible;
      edtSenha1.SetFocus;
    end;
end;

procedure TfrmLogin.edtCPFChange(Sender: TObject);
begin
  CarregarUsuario(edtCPF.Text);
end;

procedure TfrmLogin.edtSenha1KeyPress(Sender: TObject; var Key: Char);
begin
  AcionarRecurso(Key);
end;

procedure TfrmLogin.edtSenha2KeyPress(Sender: TObject; var Key: Char);
begin
  AcionarRecurso(Key);
end;

procedure TfrmLogin.FecharLogin;
begin
  if (FLogou = False) then
    Application.Terminate;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FecharLogin;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  PrepararAmbiente;
end;
procedure TfrmLogin.PrepararAmbiente;
begin
  FLogou := False;
  edtCPFChange(nil);
end;
end.

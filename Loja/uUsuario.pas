unit uUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uEnumerador, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.DBCtrls;

type
  TfrmUsuario = class(TForm)
    pnlRodape: TPanel;
    btnCancelar: TButton;
    btnGravar: TButton;
    pnlUsuario: TPanel;
    dbeCpf: TDBEdit;
    dbeNome: TDBEdit;
    dbeSenha: TDBEdit;
    lblCpf: TLabel;
    lblNome: TLabel;
    lblSenha: TLabel;
    edtConfirmarSenha: TEdit;
    lblConfirmarSenha: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dbeCpfKeyPress(Sender: TObject; var Key: Char);
    procedure dbeSenhaExit(Sender: TObject);
  private
    var
      FAcao: TAcao;
      FExigirConfirmacaoSenha: Boolean;

    procedure PrepararAmbiente;
    procedure ValidarDados;
    procedure Gravar;
    procedure Cancelar;
    procedure ControlarVisibilidadeDaConfirmacaoDeSenha(const pHabilitar: Boolean);
    { Private declarations }
  public
    property TipoAcao: TAcao write FAcao;
    { Public declarations }
  end;

var
  frmUsuario: TfrmUsuario;

implementation

{$R *.dfm}

uses uConstante, uDM, uLib, Data.DB;

procedure TfrmUsuario.btnCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmUsuario.btnGravarClick(Sender: TObject);
begin
  ValidarDados;
  Gravar;
  Close;
end;

procedure TfrmUsuario.FormActivate(Sender: TObject);
begin
  PrepararAmbiente;
  ControlarVisibilidadeDaConfirmacaoDeSenha(FAcao = tacInserir);
end;

procedure TfrmUsuario.PrepararAmbiente;
begin
  case FAcao of
    tacInserir:
    begin
      Caption := 'Usuário [Inserindo]';
      DM.qryUsuario.Append;
    end;
    tacEditar:
    begin
      Caption := 'Usuário [Editando]';
      DM.qryUsuario.Edit;
    end;
  end;

  dbeCpf.SetFocus;
end;

procedure TfrmUsuario.ValidarDados;
begin
  if DadoInvalido(dbeCpf.Text, 'Informe o cpf', dbeCpf) or
     DadoInvalido(dbeNome.Text, 'Informe o nome', dbeNome) or
     DadoInvalido(dbeSenha.Text, 'Informe a senha', dbeSenha) then
  Abort;

  if Trim(DM.qryUsuarioCPF.AsString).Length <> 11 then
  begin
    Alerta('O cpf deve conter 11 caracteres');
    dbeCpf.SetFocus;
    Abort;
  end;

  if (not ValidaCPF(DM.qryUsuarioCPF.AsString)) then
  begin
    Alerta('O cpf informado é inválido');
    dbeCpf.SetFocus;
    Abort;
  end;

  if FExigirConfirmacaoSenha then
  begin
    if DadoInvalido(edtConfirmarSenha.Text, 'Confirme a senha', edtConfirmarSenha) then
      Abort;

    if (not ConfirmacaoSenha(DM.qryUsuarioSENHA.AsString, edtConfirmarSenha.Text)) then
    begin
      Alerta('As senhas informadas são diferentes');
      edtConfirmarSenha.SetFocus;
      Abort;
    end;
  end;
end;

procedure TfrmUsuario.Gravar;
const
  ERRO_GRAVACAO = 'Ocorreu um erro inesperado';
begin
  try
    DM.qryUsuarioSENHA.AsString := MD5(DM.qryUsuarioSENHA.AsString);

    DM.qryUsuario.Post;
    DM.qryUsuario.Refresh;
  except
    raise Exception.Create(ERRO_GRAVACAO);
  end;
end;

procedure TfrmUsuario.Cancelar;
begin
  DM.qryUsuario.Cancel;
  Close;
end;

procedure TfrmUsuario.dbeCpfKeyPress(Sender: TObject; var Key: Char);
begin
  CaracterValido(SOMENTE_NUMEROS, Key);
end;

procedure TfrmUsuario.dbeSenhaExit(Sender: TObject);
begin
  var lHabilitar :=
    (FAcao = tacInserir) or
    (FAcao = tacEditar) and (dbeSenha.Field.Value <> dbeSenha.Field.OldValue);

  ControlarVisibilidadeDaConfirmacaoDeSenha(lHabilitar);
end;

procedure TfrmUsuario.ControlarVisibilidadeDaConfirmacaoDeSenha(const pHabilitar: Boolean);
begin
  if pHabilitar then
  begin
    lblConfirmarSenha.Enabled := True;
    edtConfirmarSenha.Enabled := True;
    FExigirConfirmacaoSenha := True;
    Exit;
  end;

  lblConfirmarSenha.Enabled := False;
  edtConfirmarSenha.Enabled := False;
  edtConfirmarSenha.Clear;
  FExigirConfirmacaoSenha := False;
end;
end.

unit uListarUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, uDM, uEnumerador;

type

  TfrmListarUsuario = class(TForm)
    pnlRodape: TPanel;
    btnExcluir: TButton;
    btnEditar: TButton;
    btnInserir: TButton;
    dbgListarUsuario: TDBGrid;
    lblQuantidadeRegistros: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure dbgListarUsuarioDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgListarUsuarioDblClick(Sender: TObject);
  private
    procedure ExcluirUsuario;
    procedure ControleBotoes;
    procedure AbrirCadastro(const Acao: TAcao);
    procedure AbrirEstrutura;
    procedure FecharEstrutura;
    procedure ExibirQuantidadeRegistros;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  uLib;
//  uUsuario;

procedure TfrmListarUsuario.AbrirCadastro(const Acao: TAcao);
begin
{  var TelaUsuario := TfrmUsuario.Create(nil);
  try
    TelaUsuario.TipoAcao := Acao;
    TelaUsuario.ShowModal;
    ControleBotoes;
  finally
    TelaUsuario.Free;
  end;}
end;

procedure TfrmListarUsuario.AbrirEstrutura;
begin
  if (not DM.qryUsuario.Active) then
    DM.qryUsuario.Open;

  if (not DM.qryMarca.Active) then
    DM.qryMarca.Open;

  ExibirQuantidadeRegistros;
end;

procedure TfrmListarUsuario.btnEditarClick(Sender: TObject);
begin
  AbrirCadastro(tacEditar);
end;

procedure TfrmListarUsuario.btnExcluirClick(Sender: TObject);
begin
  ExcluirUsuario;
  ExibirQuantidadeRegistros;
end;

procedure TfrmListarUsuario.btnInserirClick(Sender: TObject);
begin
  AbrirCadastro(tacInserir);
  ExibirQuantidadeRegistros;
end;

procedure TfrmListarUsuario.ControleBotoes;
begin
  btnExcluir.Enabled := (not DM.qryUsuario.IsEmpty);
  btnEditar.Enabled := (not DM.qryUsuario.IsEmpty);
end;

procedure TfrmListarUsuario.dbgListarUsuarioDblClick(Sender: TObject);
begin
  AbrirCadastro(tacEditar);
end;

procedure TfrmListarUsuario.dbgListarUsuarioDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  ZebrarGrid(dbgListarUsuario, DM.qryUsuario, Rect, Column, State);
end;

procedure TfrmListarUsuario.ExcluirUsuario;
const
  MENSAGEM_CONFIRMACAO = 'Deseja realmente excluir o usuário %s?';
begin
  if (not Pergunta(Format(MENSAGEM_CONFIRMACAO, [
    DM.qryUsuarioNOME.Value]))) then
    Exit;

  DM.qryUsuario.Edit;
  DM.qryUsuarioEXCLUIDO.Value := True;
  DM.qryUsuario.Post;

  DM.qryUsuario.Refresh;

  ControleBotoes;
end;

procedure TfrmListarUsuario.ExibirQuantidadeRegistros;
const
  INFORMACAO = '%d Registros ';
begin
  if (not DM.qryUsuario.Active) then
    Exit;

  lblQuantidadeRegistros.Caption := Format(INFORMACAO, [DM.qryUsuario.RecordCount]);
end;

procedure TfrmListarUsuario.FecharEstrutura;
begin
  DM.qryUsuario.Close;
  DM.qryMarca.Close;
end;

procedure TfrmListarUsuario.FormActivate(Sender: TObject);
begin
  AbrirEstrutura;
  ControleBotoes;
end;
procedure TfrmListarUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FecharEstrutura;
end;
end.

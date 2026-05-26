unit uListarAluguel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, uDM, uEnumerador;

type

  TfrmListarAluguel = class(TForm)
    pnlRodape: TPanel;
    btnExcluir: TButton;
    btnEditar: TButton;
    btnInserir: TButton;
    dbgListarAluguel: TDBGrid;
    lblQuantidadeRegistros: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure dbgListarAluguelDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgListarAluguelDblClick(Sender: TObject);
  private
    procedure ExcluirAluguel;
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
  uLib,
  uAluguel;

procedure TfrmListarAluguel.AbrirCadastro(const Acao: TAcao);
begin
  var TelaAluguel := TfrmAluguel.Create(nil);
  try
    TelaAluguel.TipoAcao := Acao;
    TelaAluguel.ShowModal;
    ControleBotoes;
  finally
    TelaAluguel.Free;
  end;
end;

procedure TfrmListarAluguel.AbrirEstrutura;
begin
  if (not DM.qryAluguel.Active) then
    DM.qryAluguel.Open;

  if (not DM.qryCarro.Active) then
    DM.qryCarro.Open;

  ExibirQuantidadeRegistros;
end;

procedure TfrmListarAluguel.btnEditarClick(Sender: TObject);
begin
  AbrirCadastro(tacEditar);
end;

procedure TfrmListarAluguel.btnExcluirClick(Sender: TObject);
begin
  ExcluirAluguel;
  ExibirQuantidadeRegistros;
end;

procedure TfrmListarAluguel.btnInserirClick(Sender: TObject);
begin
  AbrirCadastro(tacInserir);
  ExibirQuantidadeRegistros;
end;

procedure TfrmListarAluguel.ControleBotoes;
begin
  btnExcluir.Enabled := (not DM.qryAluguel.IsEmpty);
  btnEditar.Enabled := (not DM.qryAluguel.IsEmpty);
end;

procedure TfrmListarAluguel.dbgListarAluguelDblClick(Sender: TObject);
begin
  AbrirCadastro(tacEditar);
end;

procedure TfrmListarAluguel.dbgListarAluguelDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  ZebrarGrid(dbgListarAluguel, DM.qryAluguel, Rect, Column, State);
end;

procedure TfrmListarAluguel.ExcluirAluguel;
const
  MENSAGEM_CONFIRMACAO = 'Deseja realmente excluir o aluguel %s?';
begin
  if (not Pergunta(Format(MENSAGEM_CONFIRMACAO, [
    DM.qryAluguelCODIGOALUGUEL.Value]))) then
    Exit;

  DM.qryAluguel.Edit;
  DM.qryAluguelEXCLUIDO.Value := True;
  DM.qryAluguel.Post;

  DM.qryAluguel.Refresh;

  ControleBotoes;
end;

procedure TfrmListarAluguel.ExibirQuantidadeRegistros;
const
  INFORMACAO = '%d Registros ';
begin
  if (not DM.qryAluguel.Active) then
    Exit;

  lblQuantidadeRegistros.Caption := Format(INFORMACAO, [DM.qryAluguel.RecordCount]);
end;

procedure TfrmListarAluguel.FecharEstrutura;
begin
  DM.qryAluguel.Close;
  DM.qryMarca.Close;
end;

procedure TfrmListarAluguel.FormActivate(Sender: TObject);
begin
  AbrirEstrutura;
  ControleBotoes;
end;
procedure TfrmListarAluguel.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FecharEstrutura;
end;
end.

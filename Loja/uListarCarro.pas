unit uListarCarro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, uDM, uEnumerador;

type

  TfrmListarCarro = class(TForm)
    pnlRodape: TPanel;
    btnExcluir: TButton;
    btnEditar: TButton;
    btnInserir: TButton;
    dbgListarCarro: TDBGrid;
    lblQuantidadeRegistros: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure dbgListarCarroDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure ExcluirCarro;
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
  uCarro;

procedure TfrmListarCarro.AbrirCadastro(const Acao: TAcao);
begin
  var TelaCarro := TfrmCarro.Create(nil);
  try
    TelaCarro.TipoAcao := Acao;
    TelaCarro.ShowModal;
    ControleBotoes;
  finally
    TelaCarro.Free;
  end;
end;

procedure TfrmListarCarro.AbrirEstrutura;
begin
  if (not DM.qryCarro.Active) then
    DM.qryCarro.Open;

  ExibirQuantidadeRegistros;
end;

procedure TfrmListarCarro.btnEditarClick(Sender: TObject);
begin
  AbrirCadastro(tacEditar);
end;

procedure TfrmListarCarro.btnExcluirClick(Sender: TObject);
begin
  ExcluirCarro;
  ExibirQuantidadeRegistros;
end;

procedure TfrmListarCarro.btnInserirClick(Sender: TObject);
begin
  AbrirCadastro(tacInserir);
  ExibirQuantidadeRegistros;
end;

procedure TfrmListarCarro.ControleBotoes;
begin
  btnExcluir.Enabled := (not DM.qryCarro.IsEmpty);
  btnEditar.Enabled := (not DM.qryCarro.IsEmpty);
end;

procedure TfrmListarCarro.dbgListarCarroDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  ZebrarGrid(dbgListarCarro, DM.qryCarro, Rect, Column, State);
end;

procedure TfrmListarCarro.ExcluirCarro;
const
  MENSAGEM_CONFIRMACAO = 'Deseja realmente excluir o carro %s - %s?';
begin
  if (not Pergunta(Format(MENSAGEM_CONFIRMACAO, [
    DM.qryCarroPlaca.Value, DM.qryCarroNome.Value]))) then
    Exit;

  DM.qryCarro.Delete;

  ControleBotoes;
end;

procedure TfrmListarCarro.ExibirQuantidadeRegistros;
const
  INFORMACAO = '%d Registros ';
begin
  if (not DM.qryCarro.Active) then
    Exit;

  lblQuantidadeRegistros.Caption := Format(INFORMACAO, [DM.qryCarro.RecordCount]);
end;

procedure TfrmListarCarro.FecharEstrutura;
begin
  DM.qryCarro.Close;
end;

procedure TfrmListarCarro.FormActivate(Sender: TObject);
begin
  AbrirEstrutura;
  ControleBotoes;
end;
procedure TfrmListarCarro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FecharEstrutura;
end;
end.

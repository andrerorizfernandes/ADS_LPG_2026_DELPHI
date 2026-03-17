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
    procedure FormActivate(Sender: TObject);
    procedure dbgListarCarroDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure ExcluirCarro;
    procedure ControleBotaoExcluir;
    procedure AbrirCadastro(const Acao: TAcao);
    procedure AbrirEstrutura;
    procedure FecharEstrutura;
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
  finally
    TelaCarro.Free;
  end;
end;

procedure TfrmListarCarro.AbrirEstrutura;
begin
  if (not DM.cdsCarro.Active) then
    DM.cdsCarro.CreateDataSet;

  DM.cdsCarro.Open;
end;

procedure TfrmListarCarro.btnEditarClick(Sender: TObject);
begin
  AbrirCadastro(tacEditar);
end;

procedure TfrmListarCarro.btnExcluirClick(Sender: TObject);
begin
  ExcluirCarro;
end;

procedure TfrmListarCarro.btnInserirClick(Sender: TObject);
begin
  AbrirCadastro(tacInserir);
end;

procedure TfrmListarCarro.ControleBotaoExcluir;
begin
  btnExcluir.Enabled := (not DM.cdsCarro.IsEmpty);
end;

procedure TfrmListarCarro.dbgListarCarroDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  ZebrarGrid(dbgListarCarro, DM.cdsCarro, Rect, Column, State);
end;

procedure TfrmListarCarro.ExcluirCarro;
const
  MENSAGEM_CONFIRMACAO = 'Deseja realmente excluir o carro %s - %s?';
begin
  if (not Pergunta(Format(MENSAGEM_CONFIRMACAO, [
    DM.cdsCarroPlaca.Value, DM.cdsCarroNome.Value]))) then
    Exit;

  DM.cdsCarro.Delete;

  ControleBotaoExcluir;
end;

procedure TfrmListarCarro.FecharEstrutura;
begin
  DM.cdsCarro.Close;
end;

procedure TfrmListarCarro.FormActivate(Sender: TObject);
begin
  AbrirEstrutura;
  ControleBotaoExcluir;
end;
procedure TfrmListarCarro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FecharEstrutura;
end;
end.

unit uAluguel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uEnumerador, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.DBCtrls;

type
  TfrmAluguel = class(TForm)
    pnlRodape: TPanel;
    btnCancelar: TButton;
    btnGravar: TButton;
    pnlAluguel: TPanel;
    lblCarro: TLabel;
    dblCarro: TDBLookupComboBox;
    lblValor: TLabel;
    dbeValor: TDBEdit;
    lblDias: TLabel;
    dbeDias: TDBEdit;
    chkPago: TDBCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    var
    FAcao: TAcao;

    procedure PrepararAmbiente;
    procedure ValidarDados;
    procedure Gravar;
    procedure Cancelar;
    { Private declarations }
  public
    property TipoAcao: TAcao write FAcao;
    { Public declarations }
  end;

var
  frmAluguel: TfrmAluguel;

implementation

{$R *.dfm}

uses uDM, uLib;

procedure TfrmAluguel.btnCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmAluguel.btnGravarClick(Sender: TObject);
begin
  ValidarDados;
  Gravar;
  Close;
end;

procedure TfrmAluguel.FormActivate(Sender: TObject);
begin
  PrepararAmbiente;
end;

procedure TfrmAluguel.PrepararAmbiente;
begin
  case FAcao of
    tacInserir:
    begin
      Caption := 'Aluguel [Inserindo]';
      DM.qryAluguel.Append;
      DM.qryAluguelPAGO.Value := False;
    end;
    tacEditar:
    begin
      Caption := 'Aluguel [Editando]';
      DM.qryAluguel.Edit;
    end;
  end;
end;

procedure TfrmAluguel.ValidarDados;
begin
  if (dblCarro.KeyValue = Null) or (dblCarro.KeyValue = -1) then
  begin
    Alerta('Selecione o carro');
    dblCarro.SetFocus;
    Abort;
  end;

  if (dbeValor.Text = EmptyStr) then
  begin
    Alerta('Informe o valor');
    dbeValor.SetFocus;
    Abort;
  end;

  if (dbeDias.Text = EmptyStr) then
  begin
    Alerta('Informe a quantidade de dias');
    dbeDias.SetFocus;
    Abort;
  end;
end;

procedure TfrmAluguel.Gravar;
const
  ERRO_GRAVACAO = 'Ocorreu um erro inesperado';
begin
  try
    DM.qryAluguel.Post;
    DM.qryAluguel.Refresh;
  except
    raise Exception.Create(ERRO_GRAVACAO);
  end;
end;

procedure TfrmAluguel.Cancelar;
begin
  DM.qryAluguel.Cancel;
  Close;
end;
end.

unit uCarro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uEnumerador;

type
  TfrmCarro = class(TForm)
    pnlCarro: TPanel;
    pnlRodape: TPanel;
    btnCancelar: TButton;
    btnGravar: TButton;
    edtCodigo: TEdit;
    lblCodigo: TLabel;
    edtNome: TEdit;
    lblNome: TLabel;
    edtMarca: TEdit;
    lblMarca: TLabel;
    edtPlaca: TEdit;
    lblPlaca: TLabel;
    edtCor: TEdit;
    lblCor: TLabel;
    lblPotencia: TLabel;
    edtPotencia: TEdit;
    edtAno: TEdit;
    lblAno: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    var
      FAcao: TAcao;
    procedure PrepararAmbiente;
    procedure Cancelar;
    procedure ValidarDados;
    procedure Gravar;
    { Private declarations }
  public
    property TipoAcao: TAcao write FAcao;
    { Public declarations }
  end;

implementation

uses
  uDM,
  uLib, Data.DB;

{$R *.dfm}

procedure TfrmCarro.btnCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmCarro.btnGravarClick(Sender: TObject);
begin
  ValidarDados;
  Gravar;
  Close;
end;

procedure TfrmCarro.Cancelar;
begin
  DM.cdsCarro.Cancel;
  Close;
end;

procedure TfrmCarro.FormActivate(Sender: TObject);
begin
  PrepararAmbiente;
end;

procedure TfrmCarro.Gravar;
begin
  DM.cdsCarroCodigo.Value := StrToInt(edtCodigo.Text);
  DM.cdsCarroNome.Value := edtNome.Text;
  DM.cdsCarroMarca.Value := edtMarca.Text;
  DM.cdsCarroPlaca.Value := edtPlaca.Text;
  DM.cdsCarroCor.Value := edtCodigo.Text;
  DM.cdsCarroPotencia.Value := StrToFloat(edtPotencia.Text);
  DM.cdsCarroAno.Value := StrToInt(edtAno.Text);

  DM.cdsCarro.Post;
end;

procedure TfrmCarro.PrepararAmbiente;
begin
  case FAcao of
    tacInserir:
    begin
      Caption := 'Carro [Inserindo]';
      DM.cdsCarro.Append;
    end;
    tacEditar:
    begin
      Caption := 'Carro [Editando]';
      DM.cdsCarro.Edit;
    end;
  end;

  DM.cdsCarro.Open;
end;

procedure TfrmCarro.ValidarDados;
begin
  if (edtCodigo.Text = EmptyStr) then
  begin
    Alerta('Informe o código');
    edtCodigo.SetFocus;
    Abort;
  end;

  if (edtNome.Text = EmptyStr) then
  begin
    Alerta('Informe o nome');
    edtNome.SetFocus;
    Abort;
  end;

  if (edtMarca.Text = EmptyStr) then
  begin
    Alerta('Informe a marca');
    edtMarca.SetFocus;
    Abort;
  end;

  if (edtPlaca.Text = EmptyStr) then
  begin
    Alerta('Informe a placa');
    edtPlaca.SetFocus;
    Abort;
  end;

  if (edtCor.Text = EmptyStr) then
  begin
    Alerta('Informe a cor');
    edtCor.SetFocus;
    Abort;
  end;

  if (edtPotencia.Text = EmptyStr) then
  begin
    Alerta('Informe a potência');
    edtPotencia.SetFocus;
    Abort;
  end;

  if (edtAno.Text = EmptyStr) then
  begin
    Alerta('Informe a ano');
    edtAno.SetFocus;
    Abort;
  end;

  if (DM.cdsCarro.State = dsBrowse) then
    Abort;
end;
end.

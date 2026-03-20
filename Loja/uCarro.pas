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
    procedure edtPotenciaKeyPress(Sender: TObject; var Key: Char);
  private
    var
      FAcao: TAcao;
    procedure PrepararAmbiente;
    procedure Cancelar;
    procedure ValidarDados;
    procedure Gravar;
    function CarregarCampos: Boolean;
    { Private declarations }
  public
    property TipoAcao: TAcao write FAcao;
    { Public declarations }
  end;

implementation

uses
  uConstante,
  uDM,
  uLib,
  Data.DB;

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

function TfrmCarro.CarregarCampos: Boolean;
begin
  if DM.cdsCarro.IsEmpty then
    Exit(False);

  edtCodigo.Text := DM.cdsCarroCodigo.AsString;
  edtNome.Text := DM.cdsCarroNome.AsString;
  edtMarca.Text := DM.cdsCarroMarca.AsString;
  edtPlaca.Text := DM.cdsCarroPlaca.AsString;
  edtCor.Text := DM.cdsCarroCor.AsString;
  edtPotencia.Text := DM.cdsCarroPotencia.AsString;
  edtAno.Text := DM.cdsCarroAno.AsString;

  Result := True;
end;

procedure TfrmCarro.edtPotenciaKeyPress(Sender: TObject; var Key: Char);
begin
  CaracterValido(SOMENTE_NUMEROS_VIRGULA, Key);
end;

procedure TfrmCarro.FormActivate(Sender: TObject);
begin
  PrepararAmbiente;
end;

procedure TfrmCarro.Gravar;
const
  ERRO_GRAVACAO = 'Ocorreu um erro inesperado';
begin
  try
    if (FAcao = tacInserir) then
      DM.cdsCarroCodigo.Value := GerarProximoCodigo(DM.cdsCarro);

    DM.cdsCarroNome.AsString := edtNome.Text;
    DM.cdsCarroMarca.AsString := edtMarca.Text;
    DM.cdsCarroPlaca.AsString := edtPlaca.Text;
    DM.cdsCarroCor.AsString := edtCor.Text;
    DM.cdsCarroPotencia.Value := StrToFloat(edtPotencia.Text);
    DM.cdsCarroAno.Value := StrToInt(edtAno.Text);

    DM.cdsCarro.Post;
  except
    raise Exception.Create(ERRO_GRAVACAO);
  end;
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
      if CarregarCampos then
        DM.cdsCarro.Edit;
    end;
  end;
end;

procedure TfrmCarro.ValidarDados;
begin
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

  if (Length(edtAno.Text) <> 4) then
  begin
    Alerta('O ano precisa ter 4 dígitos');
    edtAno.SetFocus;
    Abort;
  end;

  if (DM.cdsCarro.State = dsBrowse) then
    Abort;
end;
end.

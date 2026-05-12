unit uCarro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uEnumerador,
  Vcl.Buttons;

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
    lblMarca: TLabel;
    edtPlaca: TEdit;
    lblPlaca: TLabel;
    edtCor: TEdit;
    lblCor: TLabel;
    lblPotencia: TLabel;
    edtPotencia: TEdit;
    edtAno: TEdit;
    lblAno: TLabel;
    cboMarca: TComboBox;
    SpeedButton1: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtPotenciaKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
  private
    var
    FAcao: TAcao;

    procedure PrepararAmbiente;
    procedure Cancelar;
    procedure ValidarDados;
    procedure Gravar;
    function CarregarCampos: Boolean;
    procedure PreencherMarcas;
    function RetornaCodigoDaMarca(const Marca: string): Integer;
    procedure CadastrarMarca;
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
  Data.DB,
  System.SysUtils,
  FireDAC.Comp.Client;

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
  DM.qryCarro.Cancel;
  Close;
end;

function TfrmCarro.CarregarCampos: Boolean;
begin
  if DM.qryCarro.IsEmpty then
    Exit(False);

  edtCodigo.Text := DM.qryCarroCODIGO.AsString;
  edtNome.Text := DM.qryCarroNOME.AsString;

  cboMarca.ItemIndex := cboMarca.Items.IndexOf(DM.qryCarroMARCA.AsString);

  edtPlaca.Text := DM.qryCarroPLACA.AsString;
  edtCor.Text := DM.qryCarroCOR.AsString;

  var lPotencia := StringReplace(DM.qryCarroPOTENCIA.AsString, ',', '.', [rfReplaceAll]);
  edtPotencia.Text := lPotencia;

  edtAno.Text := DM.qryCarroANO.AsString;

  Result := True;
end;

procedure TfrmCarro.edtPotenciaKeyPress(Sender: TObject; var Key: Char);
begin
  CaracterValido(SOMENTE_NUMEROS_PONTO, Key);
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
    DM.qryCarroNOME.AsString := edtNome.Text;
    DM.qryCarroCODIGOMARCA.AsInteger := RetornaCodigoDaMarca(cboMarca.Text);
    DM.qryCarroPLACA.AsString := edtPlaca.Text;
    DM.qryCarroCOR.AsString := edtCor.Text;

    var lPotencia := StringReplace(edtPotencia.Text, '.', ',', [rfReplaceAll]);
    DM.qryCarroPOTENCIA.Value := StrToFloat(lPotencia);

    DM.qryCarroANO.Value := StrToInt(edtAno.Text);

    DM.qryCarro.Post;
    DM.qryCarro.Refresh;
  except
    raise Exception.Create(ERRO_GRAVACAO);
  end;
end;

procedure TfrmCarro.PrepararAmbiente;
begin
  PreencherMarcas;

  case FAcao of
    tacInserir:
    begin
      Caption := 'Carro [Inserindo]';
      DM.qryCarro.Append;
    end;
    tacEditar:
    begin
      Caption := 'Carro [Editando]';
      if CarregarCampos then
        DM.qryCarro.Edit;
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

  if (cboMarca.ItemIndex = -1) then
  begin
    Alerta('Selecione a marca');
    cboMarca.SetFocus;
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

  if (DM.qryCarro.State = dsBrowse) then
    Abort;
end;

procedure TfrmCarro.PreencherMarcas;
begin
  if DM.qryMarca.IsEmpty then
    Exit;

  cboMarca.Items.Clear;
  DM.qryMarca.Refresh;
  DM.qryMarca.First;
  while (not DM.qryMarca.Eof) do
  begin
    cboMarca.Items.Add(DM.qryMarcaNOME.AsString);

    DM.qryMarca.Next;
  end;
end;

function TfrmCarro.RetornaCodigoDaMarca(const Marca: string): Integer;
const
  VALOR_INVALIDO = 0;
begin
  if Marca.Trim.IsEmpty then
    Exit(VALOR_INVALIDO);

  Result := VALOR_INVALIDO;
  if DM.qryMarca.Locate('NOME', Marca.Trim, [loCaseInsensitive, loPartialKey]) then
    Result := DM.qryMarcaCODIGO.AsInteger;
end;

procedure TfrmCarro.SpeedButton1Click(Sender: TObject);
begin
  CadastrarMarca;
  PreencherMarcas;
end;

procedure TfrmCarro.CadastrarMarca;
const
  VALOR_INDICADOR_ERRO_UNIQUE = 'UNIQUE KEY constraint "MARCA_UNIQUE"';
  MENSAGEM_INFORMAR_MARCA = 'Informe a marca';
  MENSAGEM_MARCA_DUPLICADA = 'A marca %s já foi cadastrada';
  SQL_CADASTRO_MARCA = 'INSERT INTO MARCA(NOME) VALUES (''%s'');';
var
  qryCadastroMarca: TFDQuery;
begin
  var Marca := InputBox(MENSAGEM_INFORMAR_MARCA, EmptyStr, EmptyStr);

  if (Marca.Trim.IsEmpty) then
    Exit;

  qryCadastroMarca := TFDQuery.Create(nil);
  try
    qryCadastroMarca.Connection := DM.Conexao;
    qryCadastroMarca.Close;
    qryCadastroMarca.SQL.Text := Format(SQL_CADASTRO_MARCA, [Marca]);

    try
      qryCadastroMarca.ExecSQL;
    except
      on E: Exception do
        if E.Message.Contains(VALOR_INDICADOR_ERRO_UNIQUE) then
          Erro(Format(MENSAGEM_MARCA_DUPLICADA, [Marca]));
    end;
  finally
    qryCadastroMarca.Free;
  end;
end;
end.

unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  uEnvConfig;

type
  TDM = class(TDataModule)
    dsrCarro: TDataSource;
    Conexao: TFDConnection;
    qryCarro: TFDQuery;
    qryCarroCODIGO: TIntegerField;
    qryCarroNOME: TWideStringField;
    qryCarroMARCA: TWideStringField;
    qryCarroPLACA: TWideStringField;
    qryCarroCOR: TWideStringField;
    qryCarroPOTENCIA: TFMTBCDField;
    qryCarroANO: TIntegerField;
    qryCarroCODIGOMARCA: TIntegerField;
    qryMarca: TFDQuery;
    dsrMarca: TDataSource;
    qryMarcaCODIGO: TIntegerField;
    qryMarcaNOME: TWideStringField;
    qryCarroEXCLUIDO: TBooleanField;
    qryAluguel: TFDQuery;
    dsrAluguel: TDataSource;
    qryAluguelCODIGOALUGUEL: TIntegerField;
    qryAluguelCODIGOCARRO: TIntegerField;
    qryAluguelNOME: TWideStringField;
    qryAluguelPLACA: TWideStringField;
    qryAluguelVALOR: TFMTBCDField;
    qryAluguelDIAS: TIntegerField;
    qryAluguelPAGO: TBooleanField;
    qryAluguelEXCLUIDO: TBooleanField;
    qryAluguelStatusPagamento: TStringField;
    qryUsuarioLogado: TFDQuery;
    dsrUsuarioLogado: TDataSource;

    procedure DataModuleCreate(Sender: TObject);
    procedure qryAluguelCalcFields(DataSet: TDataSet);

  private
    procedure PreencherStatusDoPagamento;
    procedure ConectarBanco;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

uses
  System.UITypes,
  Vcl.Forms,
  Vcl.Dialogs;

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  ConectarBanco;
end;

procedure TDM.ConectarBanco;
const
  MENSAGEM_ERRO_CONFIGURACAO = 'Erro de configuração do banco de dados:' + sLineBreak + '%s';
  MENSAGEM_FALHA_CONEXAO = 'Não foi possível conectar ao banco de dados.' + sLineBreak +
    'Verifique as configurações no arquivo .env.' + sLineBreak + sLineBreak +
    'Detalhe técnico: %s';
begin
  try
    CarregarConexao(Conexao);
    Conexao.Connected := True;
  except
    on E: EEnvConfigError do
    begin
      MessageDlg(Format(MENSAGEM_ERRO_CONFIGURACAO, [E.Message]), mtError, [mbOK], 0);
      Application.Terminate;
    end;

    on E: Exception do
    begin
      MessageDlg(Format(MENSAGEM_FALHA_CONEXAO, [E.Message]), mtError, [mbOK], 0);
      Application.Terminate;
    end;
  end;
end;

procedure TDM.qryAluguelCalcFields(DataSet: TDataSet);
begin
  PreencherStatusDoPagamento;
end;

procedure TDM.PreencherStatusDoPagamento;
begin
  if (qryAluguel.State <> dsCalcFields) then
    Exit;

  if qryAluguelPAGO.Value then
    qryAluguelStatusPagamento.AsString := 'Sim'
  else
    qryAluguelStatusPagamento.AsString := 'Não';
end;
end.

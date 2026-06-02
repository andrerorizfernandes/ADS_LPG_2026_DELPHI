unit uEnvConfig;

{
  uEnvConfig.pas (Instruções)
  --------------------------
  Lê um arquivo .env na raiz do projeto/executável e aplica as configurações
  em um TFDConnection (FireDAC + Firebird).

  Formato suportado no .env:
    DB_DATABASE=C:\caminho\para\BANCO.FDB
    DB_USERNAME=SYSDBA
    DB_PASSWORD=masterkey
    DB_HOST=localhost
    DB_PORT=3050
    APP_ENV=development

  Regras de parsing:
    - Linhas iniciadas com # são comentários e ignoradas
    - Espaços em torno do = são ignorados
    - Linhas sem = são ignoradas silenciosamente
    - Variáveis ausentes no .env resultam em erro descritivo
}

interface

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  FireDAC.Comp.Client;

type
  EEnvConfigError = class(Exception);

  TEnvConfig = class
  private
    FValues: TStringList;
    FArquivoEnv: string;

    procedure CarregarArquivo;
    function ObterValor(const Chave: string; Obrigatorio: Boolean = True): string;
    procedure ValidarChavesObrigatorias;
  public
    constructor Create(const ArquivoEnv: string = '');
    destructor Destroy; override;

    procedure AplicarNaConexao(Conexao: TFDConnection);

    function Obter(const Chave: string; const Padrao: string = ''): string;
    function ObterInt(const Chave: string; Padrao: Integer = 0): Integer;
    function ObterBool(const Chave: string; Padrao: Boolean = False): Boolean;

    property ArquivoEnv: string read FArquivoEnv;
  end;

procedure CarregarConexao(Conexao: TFDConnection; const ArquivoEnv: string = '');
function CaminhoEnvPadrao: string;

implementation

function CaminhoEnvPadrao: string;
const
  NOME_ARQUIVO_ENV = '.env';
begin
  Result := TPath.Combine(ExtractFileDir(ParamStr(0)), NOME_ARQUIVO_ENV);
end;

constructor TEnvConfig.Create(const ArquivoEnv: string);
begin
  inherited Create;

  FValues := TStringList.Create;
  FValues.CaseSensitive := False;

  FArquivoEnv := ArquivoEnv;
  if ArquivoEnv.Trim.IsEmpty then
    FArquivoEnv := CaminhoEnvPadrao;

  CarregarArquivo;
end;

destructor TEnvConfig.Destroy;
begin
  FValues.Free;
  inherited;
end;

procedure TEnvConfig.CarregarArquivo;
const
  MENSAGEM_ARQUIVO_INEXISTENTE = 'Arquivo .env não encontrado: "%s"' + sLineBreak + sLineBreak +
    'Copie o .env.example e preencha com suas configurações.';
var
  Linhas: TStringList;
begin
  if (not TFile.Exists(FArquivoEnv)) then
    raise EEnvConfigError.CreateFmt(MENSAGEM_ARQUIVO_INEXISTENTE, [FArquivoEnv]);

  Linhas := TStringList.Create;
  try
    Linhas.LoadFromFile(FArquivoEnv, TEncoding.UTF8);

    FValues.Clear;
    for var Linha in Linhas do
    begin
      var LinhaLimpa := Linha.Trim;
      if (LinhaLimpa = EmptyStr) or LinhaLimpa.StartsWith('#') then
        Continue;

      var PosIgual := Pos('=', LinhaLimpa);
      if (PosIgual < 2) then
        Continue;

      var Chave := Trim(Copy(LinhaLimpa, 1, PosIgual - 1));
      var Valor := Trim(Copy(LinhaLimpa, PosIgual + 1, MaxInt));

      if (Length(Valor) >= 2) and
         ((Valor[1] = '"') and (Valor[Length(Valor)] = '"')) or
         ((Valor[1] = '''') and (Valor[Length(Valor)] = '''')) then
        Valor := Copy(Valor, 2, Length(Valor) - 2);

      FValues.Values[Chave] := Valor;
    end;
  finally
    Linhas.Free;
  end;

  ValidarChavesObrigatorias;
end;

procedure TEnvConfig.ValidarChavesObrigatorias;
const
  CHAVES: array[0..2] of string = ('DB_DATABASE', 'DB_USERNAME', 'DB_PASSWORD');
  MENSAGEM_CHAVES_AUSENTES = 'As seguintes chaves obrigatórias estão ausentes no .env:' + sLineBreak +
    '%s' + sLineBreak + sLineBreak + 'Consulte o .env.example para referência.';
var
  Faltando: TStringList;
begin
  Faltando := TStringList.Create;
  try
    for var Chave in CHAVES do
      if FValues.IndexOfName(Chave) < 0 then
        Faltando.Add('  ' + Chave);

    if Faltando.Count > 0 then
      raise EEnvConfigError.CreateFmt(MENSAGEM_CHAVES_AUSENTES, [Faltando.Text]);
  finally
    Faltando.Free;
  end;
end;

function TEnvConfig.ObterValor(const Chave: string; Obrigatorio: Boolean): string;
const
  MENSAGEM_VARIAVEL_NAO_ENCONTRADA = 'Variável obrigatória "%s" não encontrada no .env.';
begin
  var Indice := FValues.IndexOfName(Chave);
  if (Indice >= 0) then
    Result := FValues.ValueFromIndex[Indice]
  else if Obrigatorio then
    raise EEnvConfigError.CreateFmt(MENSAGEM_VARIAVEL_NAO_ENCONTRADA, [Chave])
  else
    Result := EmptyStr;
end;

function TEnvConfig.Obter(const Chave: string; const Padrao: string): string;
begin
  var Indice := FValues.IndexOfName(Chave);
  if (Indice >= 0) then
    Result := FValues.ValueFromIndex[Indice]
  else
    Result := Padrao;
end;

function TEnvConfig.ObterInt(const Chave: string; Padrao: Integer): Integer;
const
  MENSAGEM_TIPO_INVALIDO = 'Variável "%s" deve ser um número inteiro. Valor encontrado: "%s"';
begin
  var Valor := Obter(Chave, EmptyStr);
  if Valor.Trim.IsEmpty then
    Result := Padrao
  else if not TryStrToInt(Valor, Result) then
    raise EEnvConfigError.CreateFmt(MENSAGEM_TIPO_INVALIDO, [Chave, Valor]);
end;

function TEnvConfig.ObterBool(const Chave: string; Padrao: Boolean): Boolean;
begin
  var Valor := Obter(Chave, EmptyStr).ToLower;
  if Valor.Trim.IsEmpty then
    Result := Padrao
  else
    Result := (Valor = 'true') or (Valor = '1') or (Valor = 'yes') or (Valor = 'sim');
end;

procedure TEnvConfig.AplicarNaConexao(Conexao: TFDConnection);
begin
  if Conexao = nil then
    raise EEnvConfigError.Create('TFDConnection não pode ser nil.');

  Conexao.Connected := False;

  Conexao.Params.Clear;
  Conexao.Params.Add('DriverID=FB');
  Conexao.Params.Add('Database=' + ObterValor('DB_DATABASE'));
  Conexao.Params.Add('User_Name=' + ObterValor('DB_USERNAME'));
  Conexao.Params.Add('Password='  + ObterValor('DB_PASSWORD'));

  var Host := Obter('DB_HOST', 'localhost');
  var Port := ObterInt('DB_PORT', 3050);

  if (not Host.Trim.IsEmpty) and (Host <> 'localhost') then
  begin
    Conexao.Params.Add('Server=' + Host);
    Conexao.Params.Add('Port=' + Port.ToString);
  end;

  Conexao.LoginPrompt := False;
end;

procedure CarregarConexao(Conexao: TFDConnection; const ArquivoEnv: string);
var
  Env: TEnvConfig;
begin
  Env := TEnvConfig.Create(ArquivoEnv);
  try
    Env.AplicarNaConexao(Conexao);
  finally
    Env.Free;
  end;
end;
end.

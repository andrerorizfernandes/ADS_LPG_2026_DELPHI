unit uLib;

interface

uses
  System.Types,
  Vcl.DBGrids, Vcl.Grids, Datasnap.DBClient, Vcl.ComCtrls, IdHashMessageDigest,
  FireDAC.Comp.Client;

procedure Alerta(Mensagem: string);
procedure Informacao(Mensagem: string);
procedure Erro(Mensagem: string);
procedure ZebrarGrid(Sender, DataSet: TObject; Rect: TRect; Column: TColumn; State: TGridDrawState);
function Pergunta(Pergunta: string): Boolean;
procedure CaracterValido(Tipo: Integer; var key: Char);
function DadoInvalido(Valor: String; Str: String; Sender: TObject; TabSheet: TTabSheet = nil): Boolean;
function MD5(const texto:string):string;
procedure PassarParametro(Query: TFDQuery; Valores: array of variant; AbrirQuery: Boolean = True);
function ValidaCPF(numero : string): Boolean;
function ConfirmacaoSenha(const Senha, Confirmacao: string): Boolean;

implementation

uses
  Vcl.Forms,
  Winapi.Windows,
  uConstante, Data.DB, Vcl.Graphics, System.SysUtils, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Mask, System.TypInfo;

procedure Alerta(Mensagem: string);
begin
  Application.MessageBox(PChar(Mensagem), PWideChar(NOME_SISTEMA), MB_ICONWARNING);
end;

procedure Informacao(Mensagem: string);
begin
  Application.MessageBox(PChar(Mensagem), PWideChar(NOME_SISTEMA), MB_ICONINFORMATION);
end;

procedure Erro(Mensagem: string);
begin
  Application.MessageBox(PChar(Mensagem), PWideChar(NOME_SISTEMA), MB_ICONERROR);
end;

procedure ZebrarGrid(Sender, DataSet: TObject; Rect: TRect; Column: TColumn; State: TGridDrawState);
begin
  if (not (DataSet as TDataSet).Active) then
    Exit;

  if (DataSet as TDataSet).IsEmpty then
    Exit;

  if not Odd((DataSet as TDataSet).RecNo) then
    if (not (gdSelected in State)) then
      begin
        (Sender as TDBGrid).Canvas.Brush.Color := cl3DLight;
        (Sender as TDBGrid).Canvas.FillRect(Rect);
        (Sender as TDBGrid).DefaultDrawDataCell(rect,column.Field,State);
      end
      else
        begin
          (Sender as TDBGrid).Canvas.Brush.Color := $00CFB78F;
          (Sender as TDBGrid).Canvas.FillRect(Rect);
          (Sender as TDBGrid).DefaultDrawDataCell(rect,column.Field,State);
        end
        else
          if (gdSelected in State) then
          begin
            (Sender as TDBGrid).Canvas.Brush.Color := $00CFB78F;
            (Sender as TDBGrid).Canvas.FillRect(Rect);
            (Sender as TDBGrid).DefaultDrawDataCell(rect,column.Field,State);
          end;
end;

function Pergunta(Pergunta: string): Boolean;
begin
  if Application.MessageBox(PChar(Pergunta), PWideChar(NOME_SISTEMA),
    MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) = idYes then
    Exit(True);

  Result := False;
end;

procedure CaracterValido(Tipo: Integer; var key: Char);
var
 Caracteres: TSysCharSet;
begin
  case Tipo of
    1: Caracteres:= ['0'..'9', #3, #8, #13, #22, #24, #27, #42];
    2: Caracteres:= ['0'..'9'];
    3: Caracteres:= ['a'..'z','A'..'Z'];
    4: Caracteres:= ['a'..'z','A'..'Z','0'..'9', #3, #8, #13, #22, #24, #27];
    5: Caracteres:= ['0'..'9',',',#8];
    6: Caracteres:= ['0'..'9','.',#8];
  end;

  if ((Tipo = 2) and CharInSet(key,Caracteres)) or
     ((Tipo <> 2) and not CharInSet(key,Caracteres)) then
  begin
    key:= #0;
  end;
end;

function DadoInvalido(Valor: String; Str: String; Sender: TObject; TabSheet: TTabSheet = nil): Boolean;
begin
  if Trim(Valor) = '' then
  begin
    Alerta(Str);

    if TabSheet <> nil then
      TabSheet.Show;

    if Sender is TDBEdit then
    with Sender as TDBEdit do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TEdit then
    with Sender as TEdit do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TDBMemo then
    with Sender as TDBMemo do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TMemo then
    with Sender as TMemo do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TDBLookupComboBox then
    with Sender as TDBLookupComboBox do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TDBComboBox then
    with Sender as TDBComboBox do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TComboBox then
    with Sender as TComboBox do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TCheckBox then
    with Sender as TCheckBox do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TDBCheckBox then
    with Sender as TDBCheckBox do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TDateTimePicker then
    with Sender as TDateTimePicker do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TDBGrid then
    with Sender as TDBgrid do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TMaskEdit then
    with Sender as TMaskEdit do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    Result:= True;
  end
  else
  begin
    if (Sender <> nil) and (IsPublishedProp(Sender,'Color')) then
    SetOrdProp(Sender, 'Color', clWindow);

    result:= false;
  end;
end;

function MD5(const texto:string):string;
begin
  var idmd5 := TIdHashMessageDigest5.Create;
  try
    Result := idmd5.HashStringAsHex(texto);
  finally
    idmd5.Free;
  end;
end;

Procedure PassarParametro(Query: TFDQuery; Valores: array of variant; AbrirQuery: Boolean = True);
begin
  Query.Close;
  for var I := 0 to Length(Valores) - 1 do
    Query.Params[I].Value := Valores[I];

  if AbrirQuery then
  begin
    try
      Query.Open;
    except
      Alerta('Valor inválido!');
    end;
  end;
end;

Function ValidaCPF(numero : string): Boolean;
var
  i               : integer;
  Want            : char;
  Wvalid          : boolean;
  Wdigit1,Wdigit2 : integer;
begin
  if numero.IsEmpty then
  begin
    result:= false;
    exit;
  end;
  Wvalid:= False;
  Wdigit1:= 0;
  Wdigit2:= 0;
  Want:= numero[1];//variavel para testar se o cpf é repetido como 111.111.111-11
  Delete(numero,ansipos('.',numero),1); //retira as mascaras se houver
  Delete(numero,ansipos('.',numero),1);
  Delete(numero,ansipos('-',numero),1);

  //testar se o cpf é repetido como 111.111.111-11
  for i:=1 to length(numero) do
  begin
    if numero[i] <> Want then
    begin
      Wvalid:=true; // se o cpf possui um digito diferente ele passou no primeiro teste
      break;
    end;
  end;
  // se o cpf é composto por numeros repetido retorna falso
  if not Wvalid then
  begin
    result:=false;
    exit;
  end;

  //executa o calculo para o primeiro verificador
  for i:=1 to 9 do
  begin
    wdigit1:=Wdigit1+(strtoint(numero[10-i])*(I+1));
  end;
  Wdigit1:= ((11 - (Wdigit1 mod 11))mod 11) mod 10;
  {formula do primeiro verificador
  soma=1°*2+2°*3+3°*4.. até 9°*10
  digito1 = 11 - soma mod 11
  se digito > 10 digito1 =0}

  //verifica se o 1° digito confere
  if IntToStr(Wdigit1) <> numero[10] then
  begin
    result:=false;
    exit;
  end;

  for i:=1 to 10 do
  begin
    wdigit2:=Wdigit2+(strtoint(numero[11-i])*(I+1));
  end;
  Wdigit2:= ((11 - (Wdigit2 mod 11))mod 11) mod 10;
  {formula do segundo verificador
  soma=1°*2+2°*3+3°*4.. até 10°*11
  digito1 = 11 - soma mod 11
  se digito > 10 digito1 =0}

  // confere o 2° digito verificador
  if IntToStr(Wdigit2) <> numero[11] then
  begin
    result:=false;
    exit;
  end;

  //se chegar até aqui o cpf é valido
  result:=true;
end;

function ConfirmacaoSenha(const Senha, Confirmacao: string): Boolean;
begin
  if Senha.Trim.IsEmpty or Confirmacao.Trim.IsEmpty then
    Exit(False);

  Result := Senha.Equals(Confirmacao);
end;
end.

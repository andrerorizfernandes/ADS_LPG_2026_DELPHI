unit uLib;

interface

uses
  System.Types,
  Vcl.DBGrids, Vcl.Grids, Datasnap.DBClient;

procedure Alerta(Mensagem: string);
procedure Informacao(Mensagem: string);
procedure Erro(Mensagem: string);
procedure ZebrarGrid(Sender, DataSet: TObject; Rect: TRect; Column: TColumn; State: TGridDrawState);
function Pergunta(Pergunta: string): Boolean;
procedure CaracterValido(Tipo: Integer; var key: Char);

implementation

uses
  Vcl.Forms,
  Winapi.Windows,
  uConstante, Data.DB, Vcl.Graphics, System.SysUtils;

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
  end;

  if ((Tipo = 2) and CharInSet(key,Caracteres)) or
     ((Tipo <> 2) and not CharInSet(key,Caracteres)) then
  begin
    key:= #0;
  end;
end;
end.

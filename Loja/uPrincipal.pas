unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TfrmPrincipal = class(TForm)
    menModulo: TMainMenu;
    Cadastro1: TMenuItem;
    Relatrio1: TMenuItem;
    Sair1: TMenuItem;
    Carro1: TMenuItem;
    Cidade1: TMenuItem;
    procedure Carro1Click(Sender: TObject);
  private
    procedure ExibirCarro;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uListarCarro;

{$R *.dfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.Carro1Click(Sender: TObject);
begin
  ExibirCarro;
end;

procedure TfrmPrincipal.ExibirCarro;
begin
  var TelaListarCarro := TfrmListarCarro.Create(nil);
  try
    TelaListarCarro.ShowModal;
  finally
    TelaListarCarro.Free;
  end;
end;

end.

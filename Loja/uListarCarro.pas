unit uListarCarro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, uDM;

type
  TfrmListarCarro = class(TForm)
    pnlRodape: TPanel;
    btnExcluir: TButton;
    btnEditar: TButton;
    btnInserir: TButton;
    dbgListarCarro: TDBGrid;
    procedure FormActivate(Sender: TObject);
  private
    procedure MockTesteListaCarros;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmListarCarro.FormActivate(Sender: TObject);
begin
  MockTesteListaCarros;
end;

procedure TfrmListarCarro.MockTesteListaCarros;
begin
  DM.cdsCarro.CreateDataSet;

  DM.cdsCarro.Append;
  DM.cdsCarroCodigo.Value := 1;
  DM.cdsCarroNome.Value := 'Polo Sedan';
  DM.cdsCarroMarca.Value := 'VW';
  DM.cdsCarroPlaca.Value := 'TRE8964';
  DM.cdsCarroCor.Value := 'Preto';
  DM.cdsCarroPotencia.Value := 1.8;
  DM.cdsCarroAno.Value := 2007;
  DM.cdsCarro.Post;

  DM.cdsCarro.Append;
  DM.cdsCarroCodigo.Value := 2;
  DM.cdsCarroNome.Value := 'Argo';
  DM.cdsCarroMarca.Value := 'Fiat';
  DM.cdsCarroPlaca.Value := 'MTR0064';
  DM.cdsCarroCor.Value := 'Branco';
  DM.cdsCarroPotencia.Value := 1.4;
  DM.cdsCarroAno.Value := 2025;
  DM.cdsCarro.Post;

  DM.cdsCarro.Append;
  DM.cdsCarroCodigo.Value := 3;
  DM.cdsCarroNome.Value := 'Panamera';
  DM.cdsCarroMarca.Value := 'Porshe';
  DM.cdsCarroPlaca.Value := 'RWQ1234';
  DM.cdsCarroCor.Value := 'Azul Fosco';
  DM.cdsCarroPotencia.Value := 5.0;
  DM.cdsCarroAno.Value := 2026;
  DM.cdsCarro.Post;
end;
end.

unit uCarro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.

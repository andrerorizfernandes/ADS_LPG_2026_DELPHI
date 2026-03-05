unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TDM = class(TDataModule)
    cdsCarro: TClientDataSet;
    dsrCarro: TDataSource;
    cdsCarroCodigo: TIntegerField;
    cdsCarroNome: TStringField;
    cdsCarroMarca: TStringField;
    cdsCarroPlaca: TStringField;
    cdsCarroCor: TStringField;
    cdsCarroPotencia: TFloatField;
    cdsCarroAno: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.

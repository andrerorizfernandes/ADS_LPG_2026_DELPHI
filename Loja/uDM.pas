unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

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
    Conexao: TFDConnection;
    lnkMySql: TFDPhysMySQLDriverLink;
    qryCarro: TFDQuery;
    qryCarrocodigo: TFDAutoIncField;
    qryCarronome: TStringField;
    qryCarromarca: TStringField;
    qryCarroplaca: TStringField;
    qryCarrocor: TStringField;
    qryCarropotencia: TBCDField;
    qryCarroano: TIntegerField;
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

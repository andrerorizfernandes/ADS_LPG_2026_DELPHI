unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.FB, FireDAC.Phys.FBDef;

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

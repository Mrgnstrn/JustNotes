program MJN;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uNew in 'uNew.pas' {frmNew},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Блокнот заказов';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmNew, frmNew);
  Application.Run;
end.

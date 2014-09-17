unit uNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TfrmNew = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    dtData: TDateTimePicker;
    txtJob: TMemo;
    txtCost: TLabeledEdit;
    txtJobMemo: TMemo;
    btnNew: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    rgNewType: TRadioGroup;
    txtPhone: TLabeledEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNew: TfrmNew;

implementation
uses uMain;
{$R *.dfm}

procedure TfrmNew.btnCancelClick(Sender: TObject);
begin
ModalResult := mrCancel;
Hide;
end;

procedure TfrmNew.btnNewClick(Sender: TObject);
begin
if (txtJob.Text='') {or (txtPhone.Text='') or (txtCost.Text='')} then begin
    frmMain.Log('Не заполнены все поля ввода... Внимательнее!');
    Exit;
    end;
ModalResult:=mrOk;
Hide;
end;

procedure TfrmNew.FormCreate(Sender: TObject);
begin
dtData.Date:=Now;
rgNewType.Items:=frmMain.rgTypeFilter.Items;
rgNewType.Items.Delete(0);
rgNewType.ItemIndex:=0;
end;

procedure TfrmNew.btnClearClick(Sender: TObject);
begin
txtJob.Clear;
txtJobMemo.Clear;
txtCost.Clear;
dtData.Date:=Now;
txtPhone.Clear;
end;

end.

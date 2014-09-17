unit uMain;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, DB, ADODB, Vcl.ToolWin,
  Vcl.ImgList;

type
  TfrmMain = class(TForm)
    ImageList1: TImageList;
    gbZakaz: TGroupBox;
    txtCost: TLabeledEdit;
    txtJobMemo: TMemo;
    Label3: TLabel;
    DataSet: TADODataSet;
    txtJob: TLabeledEdit;
    txtPhone: TLabeledEdit;
    lblStatus: TLabel;
    tcMain: TPageControl;
    TabSheet1: TTabSheet;
    lvMain: TListView;
    TabSheet2: TTabSheet;
    txtNotes: TRichEdit;
    TabSheet3: TTabSheet;
    lbLog: TListBox;
    TabSheet4: TTabSheet;
    Label2: TLabel;
    gbMenu: TGroupBox;
    ToolBar1: TToolBar;
    tbNew: TToolButton;
    tbEdit: TToolButton;
    tbSave: TToolButton;
    tbDel: TToolButton;
    tbChStatus: TToolButton;
    rgStatusFilter: TRadioGroup;
    rgTypeFilter: TRadioGroup;
    procedure FormResize(Sender: TObject);
    procedure lvMainKeyPress(Sender: TObject; var Key: Char);
    procedure lbLogDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tcMainChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbNewClick(Sender: TObject);
    Procedure OpenNotes;
    Procedure LoadTypes;
    Procedure SetDBfilter;
    Procedure OpenDB;
    Procedure RenderRecordset();
    procedure tbEditClick(Sender: TObject);
    procedure tbDelClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure rgTypeFilterClick(Sender: TObject);
    procedure rgStatusFilterClick(Sender: TObject);
    procedure lvMainClick(Sender: TObject);
    procedure lvMainDblClick(Sender: TObject);
    procedure tbChStatusClick(Sender: TObject);
    procedure lvMainSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private declarations }
  public
    Procedure Log(s: string);
    { Public declarations }
  end;
const
	strBASENAME: String = 'base.mdb';
    strNotesFileName: String = '.\notes.txt';
    intNoteTab: Integer = 1;       //Номер таба с заметками минус один
    intLogTab: Integer = 2;        //Номер таба с логом
var
  frmMain: TfrmMain;
    flgCMisN: Boolean;          //True if Current Mode = Notes ;)
  db, access: Variant;
  strFilter: String;
  aStatuses: array [0..10] of string;

implementation
uses uNew;
{$R *.dfm}
{******************************************************************************}
procedure TfrmMain.FormCreate(Sender: TObject);
begin
OpenNotes;
OpenDB;
LoadTypes;
//RenderRecordset;
end;
{******************************************************************************}
procedure TfrmMain.FormResize(Sender: TObject);
begin
     lvMain.Columns[2].AutoSize:=True;
end;

procedure TfrmMain.lbLogDblClick(Sender: TObject);
begin
{******************************************************************************}
if lbLog.Font.Name='Wingdings' then begin
lbLog.Font.Name:= 'Tahoma';
lbLog.Font.Charset:=1;
log('');
log('Wake up, Neo...');
log('The Matrix has you... :)');              // :)
log('');
log('');
log('');
end;
end;
{******************************************************************************}
procedure TfrmMain.LoadTypes();
begin
Log('Загрузка типов...');
DataSet.CommandText:='SELECT * FROM Типы';
DataSet.Open;
while not DataSet.Eof do begin
    rgTypeFilter.Items.Add(DataSet['Тип']);
    DataSet.Next;
    End;
DataSet.Close;
Log('Загрузка статусов...');
DataSet.CommandText:='SELECT * FROM Статусы';
DataSet.Open;
while not DataSet.Eof do begin
    rgStatusFilter.Items.Add(DataSet['Статус']);
    aStatuses[StrToInt(DataSet['Ключ'])]:= DataSet['Статус'];
    DataSet.Next;
    End;
DataSet.Close;
rgStatusFilter.ItemIndex:=1;
end;
{******************************************************************************}
Procedure TfrmMain.SetDBfilter;
begin
strFilter:='SELECT * FROM Заказы';
Log('Фильтр:');
Log('   Статус заказа: '+ IntToStr(rgStatusFilter.ItemIndex));
Log('   Тип заказа:    '+ IntToStr(rgTypeFilter.ItemIndex));
If rgTypeFilter.ItemIndex <> 0 then begin
    strFilter:= strFilter + ' WHERE Тип='+ Trim(IntToStr(rgTypeFilter.ItemIndex));
    end;
If rgStatusFilter.ItemIndex <> 0 then begin
    If rgTypeFilter.ItemIndex <> 0 then strFilter:=strFilter + ' AND Статус='
    else strFilter:=strFilter + ' WHERE Статус=';
    strFilter:= strFilter + Trim(IntToStr(rgStatusFilter.ItemIndex));
    end;
strFilter:=strFilter + ' ORDER BY Дата';
RenderRecordset;
end;
{******************************************************************************}
procedure TfrmMain.OpenNotes();
begin
Log('Загрузка заметок...');
txtNotes.Lines.LoadFromFile(strNotesFileName);
end;
procedure TfrmMain.tcMainChange(Sender: TObject);
begin
{if tcMain.TabIndex <> intLogTab then
Log('Переключение режима: '+ tcMain.Pages[tcMain.TabIndex].Caption);}
    flgCMisN:=(tcMain.TabIndex=intNoteTab);
{    txtNotes.Visible:=flgCMisN;
    gbZakaz.Visible:=not flgCMisN;
    rgStatusFilter.Visible:=not flgCMisN;
    rgTypeFilter.Visible:=not flgCMisN;
    //gbSearch.Visible:=not flgCMisN;
    gbMenu.Visible:=not flgCMisN;}
end;
{******************************************************************************}
procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
    begin
    txtNotes.Lines.SaveToFile(strNotesFileName);
    DataSet.Close;
    end;
{******************************************************************************}
procedure TfrmMain.tbNewClick(Sender: TObject);
begin
        if flgCMisN then exit;
        Log('Ввод нового заказа');
        case rgTypeFilter.ItemIndex of
            0:   frmNew.rgNewType.ItemIndex:=0;
            else frmNew.rgNewType.ItemIndex:= rgTypeFilter.ItemIndex - 1;
            end;
        frmNew.Caption:='Новый заказ:';
        frmNew.btnClearClick(nil);
        frmNew.ShowModal;
        If frmNew.ModalResult = mrCancel then
            Log('Ввод отменен!')
        else begin
            DataSet.Open;
            DataSet.Insert;
            DataSet['Дата']:=frmNew.dtData.DateTime;
            DataSet['Заказ']:=frmNew.txtJob.Text;
            DataSet['Стоимость']:=frmNew.txtCost.Text;
            DataSet['Телефон']:=frmNew.txtPhone.Text;
            DataSet['Примечание']:=frmNew.txtJobMemo.Text;
            DataSet['Тип']:=frmNew.rgNewType.ItemIndex + 1;
            DataSet.Refresh;
            Log('Новый заказ добавлен. Обновление таблицы...');
            DataSet.Close;
            SetDBfilter;
        End;
end;
{******************************************************************************}
Procedure TfrmMain.OpenDB();
begin
Log('Открытие базы...');
DataSet.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;'+
            'User ID=Admin;Data Source=' + strBASENAME +';'+
            'Mode=Share Deny None;'+
            'Extended Properties="";'+
            'Jet OLEDB:System database="";'+
            'Jet OLEDB:Registry Path="";'+
            'Jet OLEDB:Database Password="";'+
            'Jet OLEDB:Engine Type=5;'+
            'Jet OLEDB:Database Locking Mode=1;'+
            'Jet OLEDB:Global Partial Bulk Ops=2;'+
            'Jet OLEDB:Global Bulk Transactions=1;'+
            'Jet OLEDB:New Database Password="";'+
            'Jet OLEDB:Create System Database=False;'+
            'Jet OLEDB:Encrypt Database=False;'+
            'Jet OLEDB:Don''t Copy Locale on Compact=False;'+
            'Jet OLEDB:Compact Without Replica Repair=False;'+
            'Jet OLEDB:SFP=False';
end;
{******************************************************************************}
Procedure TfrmMain.Log(s: string);
begin
lbLog.AddItem(s, nil);
lbLog.ItemIndex:=lbLog.Items.Count-1;
end;
{******************************************************************************}
Procedure TfrmMain.RenderRecordset();
var
    L: TListItem;
    curPosn: Integer;
begin
Log('Рендеринг таблицы...');
DataSet.CommandText:= strFilter;
DataSet.Open;
curPosn:=-1;
if LvMain.ItemIndex <> -1 then curPosn:=lvMain.ItemIndex;
LvMain.Clear;
Log('   Позиция курсора: '+ intToStr(curPosn));
Log('   SQL: ' + DataSet.CommandText);
Log('   Записей: '+ IntToStr(DataSet.RecordCount));
If DataSet.RecordCount = 0 then begin
    Log('   Нечего рисовать в сетку!');
    end
    else begin
    while not DataSet.Eof do begin
        L:=lvMain.Items.Add;
        L.Caption:= IntToStr(Dataset.Fields[0].Value);
        L.SubItems.Append(DateToStr(DataSet['Дата']));
        L.SubItems.Append(DataSet['Заказ']);
        L.SubItems.Append(DataSet['Телефон']);
        DataSet.Next;
        end;
    end;
DataSet.Close;
If (curPosn > -1) and (curPosn < lvMain.Items.Count) then lvMain.ItemIndex:=curPosn;
If curPosn >= lvMain.Items.Count then lvMain.ItemIndex:= lvMain.Items.Count-1;
lvMainClick(nil);
end;
{******************************************************************************}
procedure TfrmMain.tbEditClick(Sender: TObject);
begin
if lvMain.ItemIndex < 0 then Exit;
Log('Редактирование заказа, код: '+ Trim(lvMain.Selected.Caption)+ '...');
DataSet.CommandText:='SELECT * FROM Заказы WHERE Код=' + Trim(lvMain.Selected.Caption);
DataSet.Open;
frmNew.dtData.Date:=DataSet['Дата'];
frmNew.txtJob.Text:=DataSet['Заказ'];
frmNew.txtCost.Text:=DataSet['Стоимость'];
frmNew.txtPhone.Text:=DataSet['Телефон'];
frmNew.txtJobMemo.Text:=DataSet['Примечание'];
frmNew.rgNewType.ItemIndex:=DataSet['Тип'] - 1;

frmNew.Caption:='Редактирование заказа:';
frmNew.ShowModal;
If frmNew.ModalResult = mrCancel then begin
  Log('   Редактирование отменено!');
  DataSet.Close;
  end
else begin
  Log('   Запись.');
  DataSet.Edit;
  DataSet['Дата']:=frmNew.dtData.DateTime;
  DataSet['Заказ']:=frmNew.txtJob.Text;
  DataSet['Стоимость']:=frmNew.txtCost.Text;
  DataSet['Телефон']:=frmNew.txtPhone.Text;
  DataSet['Примечание']:=frmNew.txtJobMemo.Text;
  DataSet['Тип']:=frmNew.rgNewType.ItemIndex + 1;
  DataSet.Refresh;
  Log('Обновление таблицы...');
  DataSet.Close;
  SetDBfilter;
End;
end;
{******************************************************************************}
procedure TfrmMain.tbChStatusClick(Sender: TObject);
begin
Log('Изменение статуса...');
if flgCMisN=True then Exit;
If lvMain.ItemIndex = -1 then begin
    Log('Ничего не выбрано.. Сначала надо указать запись.');
    Exit;
    end;
DataSet.CommandText:='SELECT * FROM Заказы WHERE Код=' + Trim(lvMain.Selected.Caption);
DataSet.Open;
Log ('Статус: ' + aStatuses[StrToInt(DataSet['Статус'])]);
Case DataSet['Статус'] of
    1:  If MessageBox(frmMain.Handle, 'Текущий статус: Заказан' + chr(10)+ 'Перенести в выполненые?', 'Подтверждение', MB_YESNO + MB_ICONQUESTION) = IDYES then begin
            Log('   Изменение статуса: Выполнен');
            DataSet.Edit;
            DataSet['Статус']:=2;
            DataSet.Refresh;
            Log('   Обновление таблицы...');
            DataSet.Close;
            RenderRecordset();
            end
        Else begin
            log('   Отменено...');
            DataSet.Close;
        end;
    2:  If MessageBox(frmMain.Handle, 'Текущий статус: Выполнен' + chr(10)+ 'Перенести в заказаные?', 'Подтверждение', MB_YESNO + MB_ICONQUESTION) = IDYES then begin
            Log('   Изменение статуса: Заказан');
            DataSet.Edit;
            DataSet['Статус']:=1;
            DataSet.Refresh;
            Log('   Обновление таблицы...');
            DataSet.Close;
            RenderRecordset();
            end
        Else begin
            log('   Отменено...');
            DataSet.Close;
        end;
end; //case
end;
{******************************************************************************}
procedure TfrmMain.tbDelClick(Sender: TObject);
begin
Log('Попытка удаления...');
if flgCMisN=True then Exit;
If lvMain.ItemIndex = -1 then begin
    Log('Ничего не выбрано.. Сначала надо указать что удаляем.');
    Exit;
    end;
Log('   Запрос удаления...');
if MessageBox(frmMain.Handle, 'Уверены в удалении выбранных записей?', 'Удаление', MB_YESNO + MB_ICONQUESTION)=IDNO	then begin
    Log('   Удаление отменено.');
    Log('   Правильно, сначала подумай, потом делай.');
    Exit;
    end;
Log('   Удаление записи, код: '+ Trim(lvMain.Selected.Caption));
DataSet.CommandText:='SELECT * FROM Заказы WHERE Код=' + Trim(lvMain.Selected.Caption);
DataSet.Open;
DataSet.Delete;
DataSet.Refresh;
DataSet.Close;
Log('   Удалилося!!! :)');
SetDBFilter;
end;
{******************************************************************************}
procedure TfrmMain.tbSaveClick(Sender: TObject);
begin
Log('Нажали на конопку сохранить :)');
if flgCMisN=True then
    begin
    txtNotes.Lines.SaveToFile(strNotesFileName);
    Log('Заметки сохранены');
    Exit;
    End
Else
     // ;)
    Log('База сохранена =)');
end;
procedure TfrmMain.rgTypeFilterClick(Sender: TObject);
begin
SetDBfilter;
end;
{******************************************************************************}
procedure TfrmMain.rgStatusFilterClick(Sender: TObject);
begin
Log('Смена фильтра по статусу');
SetDBfilter;
end;
{******************************************************************************}
procedure TfrmMain.lvMainClick(Sender: TObject);
begin
if lvMain.ItemIndex < 0 then begin
    //data.Date:=Now;
    txtJob.Text:='';
    txtCost.Text:='';
    txtPhone.Text:='';
    txtJobMemo.Text:='';
    lblStatus.Caption:= 'Статус: ';
    {tbDel.Enabled:=False;
    tbChStatus.Enabled:=False;}
  end else begin
  {tbDel.Enabled:=True;
  tbChStatus.Enabled:=True;}
  Log('Отмечен заказ, код: '+ Trim(lvMain.Selected.Caption));
  DataSet.CommandText:='SELECT * FROM Заказы WHERE Код=' + Trim(lvMain.Selected.Caption);
  DataSet.Open;
  //dtData.Date:=DataSet['Дата'];
  txtJob.Text:=DataSet['Заказ'];
  txtCost.Text:=DataSet['Стоимость'];
  txtPhone.Text:=DataSet['Телефон'];
  txtJobMemo.Text:=DataSet['Примечание'];
  lblStatus.Caption:= 'Статус: ' + aStatuses[StrToInt(DataSet['Статус'])];
  DataSet.Close;
  end;
end;
{******************************************************************************}
procedure TfrmMain.lvMainDblClick(Sender: TObject);
begin
frmMain.tbEditClick(nil);
end;
{******************************************************************************}
procedure TfrmMain.lvMainKeyPress(Sender: TObject; var Key: Char);
begin
if Key=chr(13) then lvMainDblClick(nil);
end;
procedure TfrmMain.lvMainSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
lvMainClick(nil);
end;

end.

object frmNew: TfrmNew
  Left = 260
  Top = 173
  BorderStyle = bsToolWindow
  Caption = #1053#1086#1074#1099#1081' '#1079#1072#1082#1072#1079':'
  ClientHeight = 235
  ClientWidth = 404
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 68
    Height = 13
    Caption = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 31
    Width = 34
    Height = 13
    Caption = #1047#1072#1082#1072#1079':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 125
    Width = 178
    Height = 13
    Caption = #1050#1086#1085#1090#1072#1082#1090#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' '#1080' '#1087#1088#1080#1084#1077#1095#1072#1085#1080#1103':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object dtData: TDateTimePicker
    Left = 144
    Top = 10
    Width = 137
    Height = 21
    Date = 39369.202833113430000000
    Time = 39369.202833113430000000
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object txtJob: TMemo
    Left = 8
    Top = 47
    Width = 273
    Height = 21
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object txtCost: TLabeledEdit
    Left = 9
    Top = 94
    Width = 128
    Height = 21
    EditLabel.Width = 124
    EditLabel.Height = 13
    EditLabel.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100'/'#1055#1088#1077#1076#1086#1087#1083#1072#1090#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object txtJobMemo: TMemo
    Left = 8
    Top = 142
    Width = 273
    Height = 83
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object btnNew: TButton
    Left = 288
    Top = 184
    Width = 105
    Height = 41
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnNewClick
  end
  object btnCancel: TButton
    Left = 288
    Top = 152
    Width = 105
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object btnClear: TButton
    Left = 288
    Top = 8
    Width = 105
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    WordWrap = True
    OnClick = btnClearClick
  end
  object rgNewType: TRadioGroup
    Left = 288
    Top = 40
    Width = 105
    Height = 105
    Caption = #1058#1080#1087' '#1079#1072#1082#1072#1079#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object txtPhone: TLabeledEdit
    Left = 152
    Top = 94
    Width = 129
    Height = 21
    EditLabel.Width = 110
    EditLabel.Height = 13
    EditLabel.Caption = #1050#1086#1085#1090#1072#1082#1090#1085#1099#1081' '#1090#1077#1083#1077#1092#1086#1085':'
    TabOrder = 8
  end
end

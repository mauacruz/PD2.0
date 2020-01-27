object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 307
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnSeguradora: TBitBtn
    Left = 32
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Seguradora'
    TabOrder = 0
    OnClick = btnSeguradoraClick
  end
  object lstListaResultado: TListBox
    Left = 208
    Top = 32
    Width = 289
    Height = 241
    ItemHeight = 13
    TabOrder = 1
  end
end

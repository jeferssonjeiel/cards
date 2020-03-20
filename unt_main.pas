unit unt_main;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Effects,
  FMX.ListBox,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  Tfrm_cards = class(TForm)
    VertScrollBox1: TVertScrollBox;
    conxexao_local: TFDConnection;
    fdq_base: TFDQuery;
    fdq_basecod: TFDAutoIncField;
    fdq_basenome: TWideMemoField;
    fdq_basedescricao: TWideMemoField;
    fdq_baseano: TWideMemoField;
    fdq_basecapa: TBlobField;
    ToolBar1: TToolBar;
    btn_refresh: TSpeedButton;
    procedure CreateCards
    (fotobanco: TBlobField; TituloDoFilme: String; DescricaoDoFilme: String);
    procedure FormCreate(Sender: TObject);
    Procedure LoadBitmapFromBlob(Bitmap: TBitmap; Blob: TBlobField);
    procedure FormShow(Sender: TObject);
  private
    procedure AtualizaBase;
  public
    { Public declarations }
  end;

var
  frm_cards: Tfrm_cards;

implementation

{$R *.fmx}

procedure Tfrm_cards.AtualizaBase;
  begin
    //while not fdq_base.Eof do
        //fdq_base.Delete;

    while not fdq_base.Eof do
      begin
        CreateCards(fdq_basecapa,fdq_basenome.AsString,fdq_basedescricao.AsString);
        fdq_base.Next;
      end;
  end;

procedure Tfrm_cards.CreateCards
(fotobanco: TBlobField; TituloDoFilme: String; DescricaoDoFilme: String);
var
  boxCard: TRectangle;
  lytContend: TLayout;
  img: TImage;
  lytLabelsContend: Tlayout;
  lblTitle: TText;
  lblDescricao: TText;
  btnAcessar: TButton;
  contendShadow: TShadowEffect;
  bmp: TBitmap;
begin
  boxCard := TRectangle.Create(nil);
  lytContend := TLayout.Create(nil);
  img := TImage.Create(nil);
  lytLabelsContend := TLayout.Create(nil);
  lblTitle := TText.Create(nil);
  lblDescricao := TText.Create(nil);
  btnAcessar := TButton.Create(nil);
  contendShadow := TShadowEffect.Create(nil);
  bmp := TBitmap.Create;

  with boxCard do
  begin
    Parent := VertScrollBox1;
    Align := TAlignLayout.Top;
    Fill.Color := TAlphaColorRec.White;
    Stroke.Color := TAlphaColorRec.Null;
    Height := 90;
    XRadius := 10;
    YRadius := 10;
    Margins.Bottom := 10;
    Margins.Left := 10;
    Margins.Right := 10;
    Margins.Top := 10;
  end;

  with contendShadow do
  begin
    Parent := boxCard;
    Direction := 90;
    Distance := 6;
    Opacity := 0.2;
    Softness := 0.4;
  end;

  with lytContend do
  begin
    Parent := boxCard;
    Align := TAlignLayout.Client;
    Margins.Top := 10;
    Margins.Left := 10;
    Margins.Right := 10;
    Margins.Bottom := 10;
  end;

  with img do
    begin
      Parent := lytContend;
      Align := TAlignLayout.Left;
      LoadBitmapFromBlob(bmp,fotobanco);
      Bitmap.Assign(bmp);
      Margins.Right := 5;
    end;

  with lytLabelsContend do
    begin
      Parent := lytContend;
      Align := TAlignLayout.Client;
      Margins.Left := 3;
    end;

  with lblTitle do
    begin
      Parent := lytLabelsContend;
      Align := TAlignLayout.Top;
      //Width := 80;
      VertTextAlign := TTextAlign.Leading;
      HorzTextAlign := TTextAlign.Leading;
      Font.Style := [TFontStyle.fsBold];
      Font.Size := 15;
      Text := TituloDoFilme;
    end;

  with lblDescricao do
    begin
      Parent := lytLabelsContend;
      //Margins.Top := 100;
      Align := TAlignLayout.Bottom;
      Width := 20;
      Height := 45;
      VertTextAlign := TTextAlign.Trailing;
      HorzTextAlign := TTextAlign.Trailing;
      Text := DescricaoDoFilme;
      WordWrap := true;
    end;

end;

procedure Tfrm_cards.FormCreate(Sender: TObject);
Var I: Integer;
  begin
    fdq_base.Active := true;
  end;

procedure Tfrm_cards.FormShow(Sender: TObject);
  begin
    //AtualizaBase;

    while not fdq_base.Eof do
      begin
        CreateCards(fdq_basecapa,fdq_basenome.AsString,fdq_basedescricao.AsString);
        fdq_base.Next;
      end;

  end;

procedure Tfrm_cards.LoadBitmapFromBlob(Bitmap: TBitmap; Blob: TBlobField);
var ms, ms2: TMemoryStream;
  begin
    ms := TMemoryStream.Create;
  try
    Blob.SaveToStream(ms);
    ms.Position := 0;
    Bitmap.LoadFromStream(ms);
  finally
    ms.Free;
  end;
  end;

end.

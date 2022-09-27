{ ************************************************************************** }
{ }
{ Delphi Visual Shapes }
{ }
{ Copyright (c) 1998-99 DithoSoft Software Solutions }
{ }
{ ************************************************************************** }
// 26-JUN-2004 CLX Port (Sergey Mishin - kylixapps.narod.ru)

// Original from :http://kylixapps.narod.ru/components5.html

unit Shapes;
{$R-,W-,S-}
{
  Delphi Visual Shapes (2022)
  Updated: 2022-05-04 (Y-M-D)
  Add some feature by: Samrid Somboon
  Email : samrids@gmail.com
  ========================

  This unit contains a set of different shape components. Some of them can
  already be displayed using Delphi's standard TShape component.



  Shape Types
  ===========

  Geometric Shapes

  TCircleShape              - Circle
  TEllipseShape             - Ellipse
  TSquareShape              - Square
  TRectShape                - Rectangle
  TRoundSquareShape         - Round Square
  TRoundRectShape           - Round Rectangle
  TTriangleShape            - Triangle
  TParallelogramShape       - Parallelogram
  TTrapezoidShape           - Trapezoid
  TPentagonShape            - Pentagon
  THexagonShape             - Hexagon
  TOctagonShape             - Nonagon


  Special Shapes

  TStarShape                - Star
  TBubbleShape              - Comic Bubble

  + Some new features

  - All Shapes can be move at Runtime
  - All Shapes can be set capton, set caption alignment
}

interface

uses
  SysUtils, Classes,
{$IFDEF MSWINDOWS}
  Windows, Messages, Graphics, Controls, Forms, Dialogs;
{$ENDIF}
{$IFDEF LINUX}
QGraphics, QControls, QForms, QDialogs, Types;
{$ENDIF}

type
  { TCustomShape }
  TCustomShape = class(TGraphicControl)
  private
    FBrush: TBrush;
    FPen: TPen;
    FShadow: Boolean;
    FShadowOffset: Cardinal;
    FShadowColor: TColor;
    FMousePt: TPoint;
    FAllowRuntimeMove: Boolean;
    FinReposition: Boolean;
    FOldPt: TPoint;
    FAlignment: TAlignment;
    FVerticalAlignment: TVerticalAlignment;

    FOnMouseEnter,
    FOnMouseLeave : TNotifyEvent;

    procedure ChangeRedraw(Sender: TObject);
    procedure SetBrush(Value: TBrush);
    procedure SetPen(Value: TPen);
    procedure SetShadow(Value: Boolean);
    procedure SetShadowOffset(Value: Cardinal);
    procedure SetShadowColor(Value: TColor);
    procedure SetAllowRuntimeMove(const Value: Boolean);
    procedure SetAlignment(const Value: TAlignment);
    procedure SetVerticalAlignment(const Value: TVerticalAlignment);
  protected
    procedure Paint; override;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Msg: TMessage); message CM_TEXTCHANGED;
    procedure PaintShadow; virtual;
    procedure PaintShape; virtual;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;

    procedure CMMouseEnter (var msg:tmessage); message cm_mouseenter;
    procedure CMMouseLeave (var msg:tmessage); message cm_mouseleave;


    // procedure Invalidate;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Brush: TBrush read FBrush write SetBrush;
{$IFDEF MSWINDOWS}
    property DragCursor;
{$ENDIF}
    property Anchors;
    property Alignment: TAlignment read FAlignment write SetAlignment
      default taCenter;
    property VerticalAlignment : TVerticalAlignment read FVerticalAlignment write SetVerticalAlignment default taVerticalCenter;
    property Caption;
    procedure Click; override;
    property Font;
    property DragMode;
    property Enabled;
    property PopupMenu;
    property ParentShowHint;
    property Pen: TPen read FPen write SetPen;
    property Shadow: Boolean read FShadow write SetShadow;
    property AllowRuntimeMove: Boolean read FAllowRuntimeMove
      write SetAllowRuntimeMove;
    property ShadowOffset: Cardinal read FShadowOffset write SetShadowOffset;
    property ShadowColor: TColor read FShadowColor write SetShadowColor;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseEnter : TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave : TNotifyEvent read FOnMouseLeave  write FOnMouseLeave;
    property OnMouseUp;
    property OnStartDrag;
  end;

  { TCustomPolyShape }
  TCustomPolyShape = class(TCustomShape)
  protected
    function CalcPoly(var Points: Array of TPoint; Source: Array of TPoint;
      AWidth, AHeight: Integer): Boolean; virtual;
    procedure OffsetPoly(var Points: Array of TPoint;
      OfsX, OfsY: Integer); virtual;
  end;

  { TRectShape }
  TRectShape = class(TCustomShape)
  protected
    procedure PaintShadow; override;
    procedure PaintShape; override;
  end;

  { TRoundRectShape }
  TRoundRectShape = class(TCustomShape)
  protected
    procedure PaintShadow; override;
    procedure PaintShape; override;
  end;

  { TSquareShape }
  TSquareShape = class(TCustomShape)
  protected
    procedure PaintShadow; override;
    procedure PaintShape; override;
  end;

  { TRoundSquareShape }
  TRoundSquareShape = class(TCustomShape)
  protected
    procedure PaintShadow; override;
    procedure PaintShape; override;
  end;

  { TEllipseShape }
  TEllipseShape = class(TCustomShape)
  protected
    procedure PaintShadow; override;
    procedure PaintShape; override;
  end;

  { TCircleShape }
  TCircleShape = class(TCustomShape)
  protected
    procedure PaintShadow; override;
    procedure PaintShape; override;
  end;

  { TTriangleShape }
  TTriangleShape = class(TCustomPolyShape)
  protected
    procedure PaintShadow; override;
    procedure PaintShape; override;
  end;

  { TParallelogramShape }
  TParallelogramShape = class(TCustomPolyShape)
  protected
    procedure PaintShadow; override;
    procedure PaintShape; override;
  end;

  { TTrapezoidShape }
  TTrapezoidShape = class(TCustomPolyShape)
  protected
    procedure PaintShadow; override;
    procedure PaintShape; override;
  end;

  { TPentagonShape }
  TPentagonShape = class(TCustomPolyShape)
  protected
    procedure PaintShadow; override;
    procedure PaintShape; override;
  end;

  { THexagonShape }
  THexagonShape = class(TCustomPolyShape)
  protected
    procedure PaintShadow; override;
    procedure PaintShape; override;
  end;

  { TOctagonShape }
  TOctagonShape = class(TCustomPolyShape)
  protected
    procedure PaintShadow; override;
    procedure PaintShape; override;
  end;

  { TStarShape }
  TStarShape = class(TCustomPolyShape)
  protected
    function CalcPoly(var Points: Array of TPoint; Source: Array of TPoint;
      AWidth, AHeight: Integer): Boolean; override;
    procedure PaintShadow; override;
    procedure PaintShape; override;
  end;

  { TBubbleShape }
  TBubbleShape = class(TCustomPolyShape)
  protected
    function CalcPoly(var Points: Array of TPoint; Source: Array of TPoint;
      AWidth, AHeight: Integer): Boolean; override;
    procedure PaintShadow; override;
    procedure PaintShape; override;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Shapes', [TRectShape]);
  RegisterComponents('Shapes', [TRoundRectShape]);
  RegisterComponents('Shapes', [TSquareShape]);
  RegisterComponents('Shapes', [TRoundSquareShape]);
  RegisterComponents('Shapes', [TEllipseShape]);
  RegisterComponents('Shapes', [TCircleShape]);
  RegisterComponents('Shapes', [TTriangleShape]);
  RegisterComponents('Shapes', [TParallelogramShape]);
  RegisterComponents('Shapes', [TTrapezoidShape]);
  RegisterComponents('Shapes', [TPentagonShape]);
  RegisterComponents('Shapes', [THexagonShape]);
  RegisterComponents('Shapes', [TOctagonShape]);
  RegisterComponents('Shapes', [TStarShape]);
  RegisterComponents('Shapes', [TBubbleShape]);
end;

{ Polygon points for geometric shapes }
const
  POLY_TRIANGLE: Array [0 .. 3] of TPoint = ((X: 50; Y: 0), (X: 100; Y: 100),
    (X: 0; Y: 100), (X: 50; Y: 0));
  POLY_PARALLELOGRAM: Array [0 .. 4] of TPoint = ((X: 0; Y: 0), (X: 75; Y: 0),
    (X: 100; Y: 100), (X: 25; Y: 100), (X: 0; Y: 0));
  POLY_TRAPEZOID: Array [0 .. 4] of TPoint = ((X: 25; Y: 0), (X: 75; Y: 0),
    (X: 100; Y: 100), (X: 0; Y: 100), (X: 25; Y: 0));
  POLY_PENTAGON: Array [0 .. 5] of TPoint = ((X: 50; Y: 0), (X: 100; Y: 50),
    (X: 75; Y: 100), (X: 25; Y: 100), (X: 0; Y: 50), (X: 50; Y: 0));
  POLY_HEXAGON: Array [0 .. 6] of TPoint = ((X: 25; Y: 0), (X: 75; Y: 0),
    (X: 100; Y: 50), (X: 75; Y: 100), (X: 25; Y: 100), (X: 0; Y: 50),
    (X: 25; Y: 0));
  POLY_OCTAGON: Array [0 .. 8] of TPoint = ((X: 25; Y: 0), (X: 75; Y: 0),
    (X: 100; Y: 25), (X: 100; Y: 75), (X: 75; Y: 100), (X: 25; Y: 100), (X: 0;
    Y: 75), (X: 0; Y: 25), (X: 25; Y: 0));
  POLY_STAR: Array [0 .. 16] of TPoint = ((X: 11; Y: 0), (X: 13; Y: 6), (X: 19;
    Y: 3), (X: 16; Y: 9), (X: 22; Y: 11), (X: 16; Y: 13), (X: 19; Y: 19),
    (X: 13; Y: 16), (X: 11; Y: 22), (X: 9; Y: 16), (X: 3; Y: 19), (X: 6; Y: 13),
    (X: 0; Y: 11), (X: 6; Y: 9), (X: 3; Y: 3), (X: 9; Y: 6), (X: 11; Y: 0));
  POLY_BUBBLE: Array [0 .. 11] of TPoint = ((X: 10; Y: 23), (X: 17; Y: 10),
    (X: 20; Y: 10), (X: 23; Y: 7), (X: 23; Y: 3), (X: 20; Y: 0), (X: 3; Y: 0),
    (X: 0; Y: 3), (X: 0; Y: 7), (X: 3; Y: 10), (X: 15; Y: 10), (X: 10; Y: 23));

  { TCustomShape }
constructor TCustomShape.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  { Initialize }
  ControlStyle := ControlStyle + [csReplicatable];
  Width := 65;
  Height := 65;

  FBrush := TBrush.Create;
  FBrush.OnChange := ChangeRedraw;
  FPen := TPen.Create;
  FPen.OnChange := ChangeRedraw;
  FShadow := True;
  FAllowRuntimeMove := True;
  FShadowOffset := 2;
  FShadowColor := clBtnShadow;


  FAlignment := TAlignment.taCenter;
  FVerticalAlignment := TVerticalAlignment.taVerticalCenter;
end;

destructor TCustomShape.Destroy;
begin
  FBrush.Free;
  FPen.Free;

  inherited Destroy;
end;

procedure TCustomShape.Paint;
const
  Alignments: array [TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
  VerticalAlignments: array[TVerticalAlignment] of Longint = (DT_TOP, DT_BOTTOM, DT_VCENTER);
var
  Rect,RectVertical: TRect;
  FontHeight: Integer;
  Flags: Longint;
begin
  inherited Paint;
  Rect := GetClientRect;
  Canvas.Brush := FBrush;
  Canvas.Pen := FPen;

  if Shadow then
    PaintShadow;
  PaintShape;

  Canvas.Font.Assign(Font);
  Rect := ClientRect;
  RectVertical:= Rect;
  Font := Self.Font;
  FontHeight := Canvas.TextHeight('W');
  with Rect do
  begin
    Top := ((Bottom + Top) - FontHeight) div 2;
    Bottom := Top + FontHeight;
    if FAlignment = taLeftJustify then
      Left := Left + 10;
    if FAlignment = taRightJustify then
      Right := Right - 10;
    if FVerticalAlignment = TVerticalAlignment.taAlignTop then
      Top := (RectVertical.Top + FontHeight)-10;
    if FVerticalAlignment = TVerticalAlignment.taAlignBottom then
      Bottom := (RectVertical.Bottom - FontHeight)+5;

    if (Self.ClassType = TBubbleShape) then
    begin
       Top := Top -  Round((0.60 * Top));
       Bottom := Top + FontHeight;
    end
    else if Self.ClassType = TTriangleShape then
    begin
       Top := Top + Round((0.40 * Top));
       Bottom := Top + FontHeight;
    end
    else if Self.ClassType = TPentagonShape then
    begin
       Top := Top + Round((0.25 * Top));
       Bottom := Top + FontHeight;
    end;
  end;

  Flags := DT_EXPANDTABS or
           DT_SINGLELINE or
           VerticalAlignments[FVerticalAlignment]
           or Alignments[FAlignment];
  Flags := DrawTextBiDiModeFlags(Flags);
  DrawText(Canvas.Handle, PChar(Caption), -1, Rect, Flags);

  // DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_VCENTER or
  // DT_CENTER or DT_SINGLELINE);
end;

procedure TCustomShape.PaintShadow;
begin
  Canvas.Brush.Color := FShadowColor;
  Canvas.Pen.Color := FShadowColor;
end;

procedure TCustomShape.PaintShape;
begin
  Canvas.Brush.Color := FBrush.Color;
  Canvas.Pen.Color := FPen.Color;
end;

procedure TCustomShape.ChangeRedraw(Sender: TObject);
begin
  Invalidate;
end;

procedure TCustomShape.SetBrush(Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TCustomShape.SetPen(Value: TPen);
begin
  FPen.Assign(Value);
end;

procedure TCustomShape.SetShadow(Value: Boolean);
begin
  if FShadow <> Value then
  begin
    FShadow := Value;
    Invalidate;
  end;
end;

procedure TCustomShape.SetShadowOffset(Value: Cardinal);
begin
  if FShadowOffset <> Value then
  begin
    FShadowOffset := Value;
    Invalidate;
  end;
end;

procedure TCustomShape.SetVerticalAlignment(const Value: TVerticalAlignment);
begin
  if FVerticalAlignment <> Value then begin
      FVerticalAlignment := Value;
      Invalidate;
  end;
end;

procedure TCustomShape.SetShadowColor(Value: TColor);
begin
  if FShadowColor <> Value then
  begin
    FShadowColor := Value;
    Invalidate;
  end;
end;

procedure TCustomShape.Click;
begin
  inherited;

end;

procedure TCustomShape.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomShape.CMMouseEnter(var msg: tmessage);
begin
if Assigned(FOnMouseEnter) then FOnMouseEnter(self);
end;

procedure TCustomShape.CMMouseLeave(var msg: tmessage);
begin
if Assigned(FOnMouseLeave) then FOnMouseLeave(self);
end;

procedure TCustomShape.CMTextChanged(var Msg: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomShape.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if FAllowRuntimeMove then
  begin
    FMousePt := Point(X, Y);

    FinReposition := True;
    GetCursorPos(FOldPt);
  end;
  inherited;
end;

procedure TCustomShape.MouseMove(Shift: TShiftState; X, Y: Integer);
const
  minWidth = 20;
  minHeight = 20;
var
  frmPoint: TPoint;
begin
  if FAllowRuntimeMove then
  begin
    if FinReposition then
    begin
      Screen.Cursor := crSize; // Move
      if (ssLeft in Shift) then
      begin
        Screen.Cursor := crSize;
        SetBounds(Left + X - FMousePt.X, Top + Y - FMousePt.Y, Width, Height);
      end
      else
      begin
        if (ssShift in Shift) then
        begin // resize
          Screen.Cursor := crSizeNWSE;
          frmPoint := ScreenToClient(Mouse.CursorPos);
          if frmPoint.X > minWidth then
            Width := frmPoint.X;
          if frmPoint.Y > minHeight then
            Height := frmPoint.Y;
        end;
      end;
    end;
  end;
  inherited;
end;

procedure TCustomShape.SetAlignment(const Value: TAlignment);
begin
  FAlignment := Value;
  Invalidate;
end;

procedure TCustomShape.SetAllowRuntimeMove(const Value: Boolean);
begin
  FAllowRuntimeMove := Value;
end;

procedure TCustomShape.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if FinReposition then
  begin
    Screen.Cursor := crDefault;
    ReleaseCapture;
    FinReposition := False;
  end;
end;

{ TCustomPolyShape }
function TCustomPolyShape.CalcPoly(var Points: Array of TPoint;
  Source: Array of TPoint; AWidth, AHeight: Integer): Boolean;
var
  i: Integer;
  lx, ly: Longint;
begin
  Result := True;
  try
    for i := Low(Points) to High(Points) do
    begin
      lx := MulDiv(Source[i].X, AWidth, 100);
      ly := MulDiv(Source[i].Y, AHeight, 100);
      Points[i].X := lx;
      Points[i].Y := ly;
    end;
  except
    Result := False;
  end;
end;

procedure TCustomPolyShape.OffsetPoly(var Points: Array of TPoint;
  OfsX, OfsY: Integer);
var
  i: Integer;
begin
  for i := Low(Points) to High(Points) do
  begin
    Points[i].X := Points[i].X + OfsX;
    Points[i].Y := Points[i].Y + OfsY;
  end;
end;

{ TRectShape }
procedure TRectShape.PaintShadow;
var
  rl, rt, rw, rh: Integer;
begin
  inherited PaintShadow;

  if Shadow then
  begin
    { Calc width and height of the shadow rectangle }
    rl := Pen.Width div (ShadowOffset + 2);
    rt := Pen.Width div (ShadowOffset + 2);

    rw := Width - ShadowOffset - Pen.Width + 1;
    rh := Height - ShadowOffset - Pen.Width + 1;

    if Pen.Width = 0 then
    begin
      Dec(rw);
      Dec(rh);
    end;

    { Draw the shadow rectangle }
    Canvas.Rectangle(rl, rt, rl + rw, rt + rh);
  end;
end;

procedure TRectShape.PaintShape;
var
  rl, rt, rw, rh: Integer;
begin
  inherited PaintShape;

  { Calc the width and height of the rectangle }
  rl := Pen.Width div 2;
  rt := Pen.Width div 2;

  rw := Width - ShadowOffset - Pen.Width + 1;
  rh := Height - ShadowOffset - Pen.Width + 1;

  if not Shadow then
  begin
    Inc(rw, ShadowOffset);
    Inc(rh, ShadowOffset);
  end;

  if Pen.Width = 0 then
  begin
    Dec(rw);
    Dec(rh);
  end;

  { Paint the rectangle }
  Canvas.Rectangle(rl, rt, rl + rw, rt + rh);
end;

{ TRoundRectShape }
procedure TRoundRectShape.PaintShadow;
var
  rl, rt, rw, rh, r: Integer;
begin
  inherited PaintShadow;

  if Shadow then
  begin
    { Calc width and height of the shadow rectangle }
    rl := Pen.Width div 2 + ShadowOffset;
    rt := Pen.Width div 2 + ShadowOffset;

    rw := Width - ShadowOffset - Pen.Width + 1;
    rh := Height - ShadowOffset - Pen.Width + 1;

    if Pen.Width = 0 then
    begin
      Dec(rw);
      Dec(rh);
    end;

    if rw < rh then
      r := rw
    else
      r := rh;

    { Draw the shadow rectangle }
    Canvas.RoundRect(rl, rt, rl + rw, rt + rh, r div 4, r div 4);
  end;
end;

procedure TRoundRectShape.PaintShape;
var
  rl, rt, rw, rh, r: Integer;
begin
  inherited PaintShape;

  { Calc the width and height of the rectangle }
  rl := Pen.Width div 2;
  rt := Pen.Width div 2;

  rw := (Width - ShadowOffset) - Pen.Width + 1;
  rh := (Height - ShadowOffset) - Pen.Width + 1;

  if not Shadow then
  begin
    Inc(rw, ShadowOffset);
    Inc(rh, ShadowOffset);
  end;

  if Pen.Width = 0 then
  begin
    Dec(rw);
    Dec(rh);
  end;

  if rw < rh then
    r := rw
  else
    r := rh;

  { Paint the rectangle }
  Canvas.RoundRect(rl, rt, rl + rw, rt + rh, r div 4, r div 4);
end;

{ TSquareShape }
procedure TSquareShape.PaintShadow;
var
  rl, rt, rw, rh: Integer;
begin
  inherited PaintShadow;

  if Shadow then
  begin
    { Calc width and height of the shadow square }
    rl := Pen.Width div 2 + ShadowOffset;
    rt := Pen.Width div 2 + ShadowOffset;

    rw := Width - ShadowOffset - Pen.Width + 1;
    rh := Height - ShadowOffset - Pen.Width + 1;

    if Pen.Width = 0 then
    begin
      Dec(rw);
      Dec(rh);
    end;

    if rw > rh then
      rw := rh
    else
      rh := rw;

    { Draw the shadow square }
    Canvas.Rectangle(rl, rt, rl + rw, rt + rh);
  end;
end;

procedure TSquareShape.PaintShape;
var
  rl, rt, rw, rh: Integer;
begin
  inherited PaintShape;

  { Calc the width and height of the square }
  rl := Pen.Width div 2;
  rt := Pen.Width div 2;

  rw := Width - ShadowOffset - Pen.Width + 1;
  rh := Height - ShadowOffset - Pen.Width + 1;

  if not Shadow then
  begin
    Inc(rw, ShadowOffset);
    Inc(rh, ShadowOffset);
  end;

  if Pen.Width = 0 then
  begin
    Dec(rw);
    Dec(rh);
  end;

  if rw > rh then
    rw := rh
  else
    rh := rw;

  { Paint the square }
  Canvas.Rectangle(rl, rt, rl + rw, rt + rh);
end;

{ TRoundSquareShape }
procedure TRoundSquareShape.PaintShadow;
var
  rl, rt, rw, rh, r: Integer;
begin
  inherited PaintShadow;

  if Shadow then
  begin
    { Calc width and height of the shadow square }
    rl := Pen.Width div 2 + ShadowOffset;
    rt := Pen.Width div 2 + ShadowOffset;

    rw := Width - ShadowOffset - Pen.Width + 1;
    rh := Height - ShadowOffset - Pen.Width + 1;

    if Pen.Width = 0 then
    begin
      Dec(rw);
      Dec(rh);
    end;

    if rw > rh then
    begin
      rw := rh;
      r := rh;
    end
    else
    begin
      rh := rw;
      r := rw;
    end;

    { Draw the shadow square }
    Canvas.RoundRect(rl, rt, rl + rw, rt + rh, r div 4, r div 4);
  end;
end;

procedure TRoundSquareShape.PaintShape;
var
  rl, rt, rw, rh, r: Integer;
begin
  inherited PaintShape;

  { Calc the width and height of the square }
  rl := Pen.Width div 2;
  rt := Pen.Width div 2;

  rw := Width - ShadowOffset - Pen.Width + 1;
  rh := Height - ShadowOffset - Pen.Width + 1;

  if not Shadow then
  begin
    Inc(rw, ShadowOffset);
    Inc(rh, ShadowOffset);
  end;

  if Pen.Width = 0 then
  begin
    Dec(rw);
    Dec(rh);
  end;

  if rw > rh then
  begin
    rw := rh;
    r := rh;
  end
  else
  begin
    rh := rw;
    r := rw;
  end;

  { Paint the square }
  Canvas.RoundRect(rl, rt, rl + rw, rt + rh, r div 4, r div 4);
end;

{ TEllipseShape }
procedure TEllipseShape.PaintShadow;
var
  rl, rt, rw, rh: Integer;
begin
  inherited PaintShadow;

  if Shadow then
  begin
    { Calc width and height of the shadow ellipse }
    rl := Pen.Width div 2 + ShadowOffset;
    rt := Pen.Width div 2 + ShadowOffset;

    rw := Width - ShadowOffset - Pen.Width + 1;
    rh := Height - ShadowOffset - Pen.Width + 1;

    if Pen.Width = 0 then
    begin
      Dec(rw);
      Dec(rh);
    end;

    { Draw the shadow ellipse }
    Canvas.Ellipse(rl, rt, rl + rw, rt + rh);
  end;
end;

procedure TEllipseShape.PaintShape;
var
  rl, rt, rw, rh: Integer;
begin
  inherited PaintShape;

  { Calc the width and height of the ellipse }
  rl := Pen.Width div 2;
  rt := Pen.Width div 2;

  rw := Width - ShadowOffset - Pen.Width + 1;
  rh := Height - ShadowOffset - Pen.Width + 1;

  if not Shadow then
  begin
    Inc(rw, ShadowOffset);
    Inc(rh, ShadowOffset);
  end;

  if Pen.Width = 0 then
  begin
    Dec(rw);
    Dec(rh);
  end;

  { Paint the ellipse }
  Canvas.Ellipse(rl, rt, rl + rw, rt + rh);
end;

{ TCircleShape }
procedure TCircleShape.PaintShadow;
var
  rl, rt, rw, rh: Integer;
begin
  inherited PaintShadow;

  if Shadow then
  begin
    { Calc width and height of the shadow Circle }
    rl := Pen.Width div 2 + ShadowOffset;
    rt := Pen.Width div 2 + ShadowOffset;

    rw := Width - ShadowOffset - Pen.Width + 1;
    rh := Height - ShadowOffset - Pen.Width + 1;

    if Pen.Width = 0 then
    begin
      Dec(rw);
      Dec(rh);
    end;

    if rw > rh then
      rw := rh
    else
      rh := rw;

    { Draw the shadow Circle }
    Canvas.Ellipse(rl, rt, rl + rw, rt + rh);
  end;
end;

procedure TCircleShape.PaintShape;
var
  rl, rt, rw, rh: Integer;
begin
  inherited PaintShape;

  { Calc the width and height of the Circle }
  rl := Pen.Width div 2;
  rt := Pen.Width div 2;

  rw := Width - ShadowOffset - Pen.Width + 1;
  rh := Height - ShadowOffset - Pen.Width + 1;

  if not Shadow then
  begin
    Inc(rw, ShadowOffset);
    Inc(rh, ShadowOffset);
  end;

  if Pen.Width = 0 then
  begin
    Dec(rw);
    Dec(rh);
  end;

  if rw > rh then
    rw := rh
  else
    rh := rw;

  { Paint the Circle }
  Canvas.Ellipse(rl, rt, rl + rw, rt + rh);
end;

{ TTriangleShape }
procedure TTriangleShape.PaintShadow;
var
  Points: Array [0 .. 3] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShadow;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_TRIANGLE, w, h) then
  begin
    OffsetPoly(Points, l + ShadowOffset, t + ShadowOffset);
    Canvas.Polygon(Points);
  end;
end;

procedure TTriangleShape.PaintShape;
var
  Points: Array [0 .. 3] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShape;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if not Shadow then
  begin
    Inc(w, ShadowOffset);
    Inc(h, ShadowOffset);
  end;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_TRIANGLE, w, h) then
  begin
    OffsetPoly(Points, l, t);
    Canvas.Polygon(Points);
  end;
end;

{ TParallelogramShape }
procedure TParallelogramShape.PaintShadow;
var
  Points: Array [0 .. 4] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShadow;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_PARALLELOGRAM, w, h) then
  begin
    OffsetPoly(Points, l + ShadowOffset, t + ShadowOffset);
    Canvas.Polygon(Points);
  end;
end;

procedure TParallelogramShape.PaintShape;
var
  Points: Array [0 .. 4] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShape;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if not Shadow then
  begin
    Inc(w, ShadowOffset);
    Inc(h, ShadowOffset);
  end;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_PARALLELOGRAM, w, h) then
  begin
    OffsetPoly(Points, l, t);
    Canvas.Polygon(Points);
  end;
end;

{ TTrapezoidShape }
procedure TTrapezoidShape.PaintShadow;
var
  Points: Array [0 .. 4] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShadow;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_TRAPEZOID, w, h) then
  begin
    OffsetPoly(Points, l + ShadowOffset, t + ShadowOffset);
    Canvas.Polygon(Points);
  end;
end;

procedure TTrapezoidShape.PaintShape;
var
  Points: Array [0 .. 4] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShape;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if not Shadow then
  begin
    Inc(w, ShadowOffset);
    Inc(h, ShadowOffset);
  end;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_TRAPEZOID, w, h) then
  begin
    OffsetPoly(Points, l, t);
    Canvas.Polygon(Points);
  end;
end;

{ TPentagonShape }
procedure TPentagonShape.PaintShadow;
var
  Points: Array [0 .. 5] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShadow;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_PENTAGON, w, h) then
  begin
    OffsetPoly(Points, l + ShadowOffset, t + ShadowOffset);
    Canvas.Polygon(Points);
  end;
end;

procedure TPentagonShape.PaintShape;
var
  Points: Array [0 .. 5] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShape;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if not Shadow then
  begin
    Inc(w, ShadowOffset);
    Inc(h, ShadowOffset);
  end;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_PENTAGON, w, h) then
  begin
    OffsetPoly(Points, l, t);
    Canvas.Polygon(Points);
  end;
end;

{ THexagonShape }
procedure THexagonShape.PaintShadow;
var
  Points: Array [0 .. 6] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShadow;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_HEXAGON, w, h) then
  begin
    OffsetPoly(Points, l + ShadowOffset, t + ShadowOffset);
    Canvas.Polygon(Points);
  end;
end;

procedure THexagonShape.PaintShape;
var
  Points: Array [0 .. 6] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShape;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if not Shadow then
  begin
    Inc(w, ShadowOffset);
    Inc(h, ShadowOffset);
  end;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_HEXAGON, w, h) then
  begin
    OffsetPoly(Points, l, t);
    Canvas.Polygon(Points);
  end;
end;

{ TOctagonShape }
procedure TOctagonShape.PaintShadow;
var
  Points: Array [0 .. 8] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShadow;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_OCTAGON, w, h) then
  begin
    OffsetPoly(Points, l + ShadowOffset, t + ShadowOffset);
    Canvas.Polygon(Points);
  end;
end;

procedure TOctagonShape.PaintShape;
var
  Points: Array [0 .. 8] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShape;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if not Shadow then
  begin
    Inc(w, ShadowOffset);
    Inc(h, ShadowOffset);
  end;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_OCTAGON, w, h) then
  begin
    OffsetPoly(Points, l, t);
    Canvas.Polygon(Points);
  end;
end;

{ TStarShape }
function TStarShape.CalcPoly(var Points: Array of TPoint;
  Source: Array of TPoint; AWidth, AHeight: Integer): Boolean;
var
  i: Integer;
  lx, ly: Longint;
begin
  Result := True;
  try
    for i := Low(Points) to High(Points) do
    begin
      lx := MulDiv(Source[i].X, AWidth, 22);
      ly := MulDiv(Source[i].Y, AHeight, 22);
      Points[i].X := lx;
      Points[i].Y := ly;
    end;
  except
    Result := False;
  end;
end;

procedure TStarShape.PaintShadow;
var
  Points: Array [0 .. 16] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShadow;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_STAR, w, h) then
  begin
    OffsetPoly(Points, l + ShadowOffset, t + ShadowOffset);
    Canvas.Polygon(Points);
  end;
end;

procedure TStarShape.PaintShape;
var
  Points: Array [0 .. 16] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShape;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if not Shadow then
  begin
    Inc(w, ShadowOffset);
    Inc(h, ShadowOffset);
  end;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_STAR, w, h) then
  begin
    OffsetPoly(Points, l, t);
    Canvas.Polygon(Points);
  end;
end;

{ TBubbleShape }
function TBubbleShape.CalcPoly(var Points: Array of TPoint;
  Source: Array of TPoint; AWidth, AHeight: Integer): Boolean;
var
  i: Integer;
  lx, ly: Longint;
begin
  Result := True;
  try
    for i := Low(Points) to High(Points) do
    begin
      lx := MulDiv(Source[i].X, AWidth, 23);
      ly := MulDiv(Source[i].Y, AHeight, 23);
      Points[i].X := lx;
      Points[i].Y := ly;
    end;
  except
    Result := False;
  end;
end;

procedure TBubbleShape.PaintShadow;
var
  Points: Array [0 .. 11] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShadow;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_BUBBLE, w, h) then
  begin
    OffsetPoly(Points, l + ShadowOffset, t + ShadowOffset);
    Canvas.Polygon(Points);
  end;
end;

procedure TBubbleShape.PaintShape;
var
  Points: Array [0 .. 11] of TPoint;
  l, t, w, h: Integer;
begin
  inherited PaintShape;

  { Calc the new coordinates for the current width and height }
  l := Pen.Width div 2;
  t := l;
  w := Width - ShadowOffset - 1 - Pen.Width;
  h := Height - ShadowOffset - 1 - Pen.Width;

  if not Shadow then
  begin
    Inc(w, ShadowOffset);
    Inc(h, ShadowOffset);
  end;

  if Pen.Width = 0 then
  begin
    Dec(w);
    Dec(h);
  end;

  if CalcPoly(Points, POLY_BUBBLE, w, h) then
  begin
    OffsetPoly(Points, l, t);
    Canvas.Polygon(Points);
  end;
end;

end.

{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressCommonLibrary                                         }
{                                                                    }
{       Copyright (c) 1998-2005 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSCOMMONLIBRARY AND ALL          }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxScrollBar;

{$I cxVer.inc}

interface

uses
{$IFDEF VCL}
  Windows, Messages, dxThemeManager,
{$ELSE}
  Qt, QTypes,
{$ENDIF}
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
{$IFNDEF DELPHI5}
  cxClasses,
{$ENDIF}
  SysUtils, Classes, Controls, StdCtrls,
  Graphics, cxGraphics, Forms, cxLookAndFeels, cxLookAndFeelPainters;

type
  TcxScrollBarState = record
    PressedPart: TcxScrollBarPart;
    HotPart: TcxScrollBarPart;
  end;

  TcxScrollBar = class(TCustomControl)
  private
    FBitmap: TBitmap;
    FState: TcxScrollBarState;
    FTimer: TComponent;
    FCanvas: TcxCanvas;
    FLookAndFeel: TcxLookAndFeel;
  {$IFDEF VCL}
    FThemeChangedNotificator: TdxThemeChangedNotificator;
  {$ELSE}
    FUseSaveScrollCode: Boolean;
    FSaveScrollCode: TScrollCode;
    FParamsChanging: Boolean;
    FRangeControl: QRangeControlH;
  {$ENDIF}
    FThumbnailSize: Integer;
    FTopLeftArrow: TRect;
    FBottomRightArrow: TRect;
    FThumbnail: TRect;
    FPageUp: TRect;
    FPageDown: TRect;
    FKind: TScrollBarKind;
    FPosition: Integer;
    FSavePosition: Integer;
    FSaveThumbnailPos: TPoint;
    FDownMousePos: TPoint;
    FMin: Integer;
    FMax: Integer;
    FPageSize: Integer;
    FSmallChange: TScrollBarInc;
    FLargeChange: TScrollBarInc;
    FUnlimitedTracking: Boolean;
    FOnChange: TNotifyEvent;
    FOnScroll: TScrollEvent;
    procedure AdjustPagesRects;
    procedure CalcMinThumnailSize;
    procedure CalculateRects;
    procedure CalculateThumbnailRect;
    procedure CancelScroll;
    procedure DoScroll(APart: TcxScrollBarPart);
    function GetPositionFromThumbnail: Integer;
    function GetScrollBarPart(P: TPoint): TcxScrollBarPart;
    procedure InternalScroll(AScrollCode: TScrollCode);
    procedure OnTimer(Sender: TObject);
    procedure SetKind(Value: TScrollBarKind);
    procedure SetLookAndFeel(Value: TcxLookAndFeel);
    procedure SetMax(Value: Integer);
    procedure SetMin(Value: Integer);
    procedure SetPageSize(Value: Integer);
    procedure SetPosition(Value: Integer);
  {$IFDEF VCL}
    procedure ThemeChanged;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CNHScroll(var Message: TWMHScroll); message CN_HSCROLL;
    procedure CNVScroll(var Message: TWMVScroll); message CN_VSCROLL;
    procedure CNCtlColorScrollBar(var Message: TMessage); message CN_CTLCOLORSCROLLBAR;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  {$ELSE}
    function GetHandle: QScrollBarH;
    function GetLargeChange: TScrollBarInc;
    function GetMax: Integer;
    function GetMin: Integer;
    function GetPosition: Integer;
    function GetSmallChange: TScrollBarInc;
    procedure NextLineHook; cdecl;
    procedure NextPageHook; cdecl;
    procedure PrevLineHook; cdecl;
    procedure PrevPageHook; cdecl;
    procedure SetLargeChange(const Value: TScrollBarInc);
    procedure SetSmallChange(const Value: TScrollBarInc);
    procedure SliderPressedHook; cdecl;
    procedure SliderReleasedHook; cdecl;
    procedure ValueChangedHook(Value: Integer); cdecl;
    function RangeControl: QRangeControlH;
  {$ENDIF}
  protected
    procedure Change; virtual;
  {$IFNDEF VCL}
    procedure CreateWidget; override;
    procedure HookEvents; override;
    procedure InitWidget; override;
    procedure DestroyWidget; override;
    procedure Loaded; override;
    procedure Painting(Sender: QObjectH; EventRegion: QRegionH); override;
  {$ENDIF}
    function GetPainter: TcxCustomLookAndFeelPainterClass;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseEnter(AControl: TControl); {$IFDEF VCL}dynamic{$ELSE}override{$ENDIF};
    procedure MouseLeave(AControl: TControl); {$IFDEF VCL}dynamic{$ELSE}override{$ENDIF};
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;

    procedure Paint; override;
    procedure PaintDev;
    procedure PaintVclskin;
    
    procedure Scroll(ScrollCode: TScrollCode; var ScrollPos: Integer); virtual;
    property Painter: TcxCustomLookAndFeelPainterClass read GetPainter;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure SetScrollParams(AMin, AMax, APosition, APageSize: Integer; ARedraw: Boolean = True);
    procedure SetParams(APosition, AMin, AMax: Integer);
  {$IFNDEF VCL}
    property Handle: QScrollBarH read GetHandle;
  {$ENDIF}
  published
    property Align;
    property Anchors;
    property Constraints;
  {$IFDEF VCL}
    property Ctl3D;
    property DragCursor;
    property DragKind;
  {$ENDIF}
    property DragMode;
    property Enabled;
    property Kind: TScrollBarKind read FKind write SetKind default sbHorizontal;
    property LargeChange: TScrollBarInc
    {$IFDEF VCL}
      read FLargeChange write FLargeChange
    {$ELSE}
      read GetLargeChange write SetLargeChange
    {$ENDIF}
      default 1;
    property LookAndFeel: TcxLookAndFeel read FLookAndFeel write SetLookAndFeel;
    property Max: Integer
      read {$IFDEF VCL}FMax{$ELSE}GetMax{$ENDIF} write SetMax default 100;
    property Min: Integer
      read {$IFDEF VCL}FMin{$ELSE}GetMin{$ENDIF} write SetMin default 0;
    property PageSize: Integer read FPageSize write SetPageSize;
  {$IFDEF VCL}
    property ParentCtl3D;
  {$ENDIF}
    property ParentShowHint;
    property PopupMenu;
    property Position: Integer
      read {$IFDEF VCL}FPosition{$ELSE}GetPosition{$ENDIF} write SetPosition
      default 0;
    property ShowHint;
    property SmallChange: TScrollBarInc
    {$IFDEF VCL}
      read FSmallChange write FSmallChange
    {$ELSE}
      read GetSmallChange write SetSmallChange
    {$ENDIF}
      default 1;
    property UnlimitedTracking: Boolean read FUnlimitedTracking write FUnlimitedTracking default False;
    property Visible;
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDragDrop;
    property OnDragOver;
  {$IFDEF VCL}
    property OnEndDock;
  {$ENDIF}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnScroll: TScrollEvent read FOnScroll write FOnScroll;
  {$IFDEF VCL}
    property OnStartDock;
  {$ENDIF}
    property OnStartDrag;
  end;

function GetScrollBarSize: TSize;      

implementation

uses
{$IFDEF VCL}
  dxuxTheme,
  dxThemeConsts,
{$ENDIF}
  Consts, cxControls,WinSkindata,WinskinDlg,WinskinForm;

const
  EmptyRect: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);
  cxScrollInitialInterval = 400;
  cxScrollInterval = 60;
  cxScrollMinDistance: Integer = 34;
  cxScrollMaxDistance: Integer = 136;
  cxMinStdThumbnailSize = 8;
  cxTimerParts = [sbpLineUp, sbpLineDown, sbpPageUp, sbpPageDown];

function GetScrollBarSize: TSize;
begin
{$IFDEF VCL}
  Result.cx := GetSystemMetrics(SM_CXVSCROLL);
  Result.cy := GetSystemMetrics(SM_CYHSCROLL);
{$ELSE}
  QStyle_scrollBarExtent(QApplication_style, @Result);
{$ENDIF}
end;

function MaxInt(A, B: Integer): Integer;
begin
  if A > B then Result := A else Result := B;
end;

function MinInt(A, B: Integer): Integer;
begin
  if A < B then Result := A else Result := B;
end;

{$IFNDEF DELPHI6}

function Bounds(ALeft, ATop, AWidth, AHeight: Integer): TRect;
begin
  with Result do
  begin
    Left := ALeft;
    Top := ATop;
    Right := ALeft + AWidth;
    Bottom :=  ATop + AHeight;
  end;
end;

{$ENDIF}

{ TcxScrollBar }

constructor TcxScrollBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBitmap := TBitmap.Create;
{$IFDEF VCL}
  FBitmap.PixelFormat := pfDevice;
{$ELSE}
  Palette.ColorRole := crButton;
  Palette.TextColorRole := crButtonText;
{$ENDIF}
  FCanvas := TcxCanvas.Create(FBitmap.Canvas);
  FLookAndFeel := TcxLookAndFeel.Create(Self);
  FLookAndFeel.OnChanged := LookAndFeelChanged;
  Width := 121;
  ControlStyle := [csFramed, csOpaque, csCaptureMouse];
  FKind := sbHorizontal;
  Height := GetScrollBarSize.cy;
{$IFDEF VCL}
  FThemeChangedNotificator := TdxThemeChangedNotificator.Create;
  FThemeChangedNotificator.OnThemeChanged := ThemeChanged;
{$ENDIF}
  FPosition := 0;
  FMin := 0;
  FMax := 100;
  FSmallChange := 1;
  FLargeChange := 1;

  FTimer := TcxTimer.Create(nil);
  TcxTimer(FTimer).Enabled := False;
  TcxTimer(FTimer).Interval:= cxScrollInitialInterval;
  TcxTimer(FTimer).OnTimer := OnTimer;
  CalcMinThumnailSize;
  CalculateRects;
end;

destructor TcxScrollBar.Destroy;
begin
  FreeAndNil(FTimer);
{$IFDEF VCL}
  FreeAndNil(FThemeChangedNotificator);
{$ENDIF}
  FreeAndNil(FLookAndFeel);
  FreeAndNil(FCanvas);
  FreeAndNil(FBitmap);
  inherited Destroy;
end;

procedure TcxScrollBar.OnTimer(Sender: TObject);

  function CheckHotPart: Boolean;
  var
    P: TPoint;
  begin
    GetCursorPos(P);
    Result := GetScrollBarPart(ScreenToClient(P)) = FState.PressedPart;
  end;

begin
  if (GetCaptureControl = Self) and (FState.PressedPart in cxTimerParts) then
  begin
    if TcxTimer(FTimer).Interval = cxScrollInitialInterval then
      TcxTimer(FTimer).Interval := cxScrollInterval;
    DoScroll(FState.PressedPart);
    TcxTimer(FTimer).Enabled := CheckHotPart;
  end
  else
    CancelScroll;
end;

procedure TcxScrollBar.SetKind(Value: TScrollBarKind);
begin
  if FKind <> Value then
  begin
    FKind := Value;
  {$IFNDEF VCL}
    if FLookAndFeel.NativeStyle then
      QScrollBar_setOrientation(Handle, Orientation(FKind));
  {$ENDIF}
    if not (csLoading in ComponentState) then
      SetBounds(Left, Top, Height, Width)
    else
      CalculateRects;
    Invalidate;
  end;
end;

procedure TcxScrollBar.SetLookAndFeel(Value: TcxLookAndFeel);
begin
  FLookAndFeel.Assign(Value);
end;

procedure TcxScrollBar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  ABoundsChanged: Boolean;
begin
  ABoundsChanged := (ALeft <> Left) or (ATop <> Top) or
    (AWidth <> Width) or (AHeight <> Height);
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if ABoundsChanged and (AWidth > 0) and (AHeight > 0) then
  begin
    FBitmap.Width := AWidth;
    FBitmap.Height := AHeight;
    CalculateRects;
  end;
end;

procedure TcxScrollBar.SetScrollParams(AMin, AMax, APosition,
  APageSize: Integer; ARedraw: Boolean = True);
begin
  if (AMax < AMin) or (AMax < APageSize) then
    raise EInvalidOperation.Create(SScrollBarRange);
  ARedraw := ARedraw and HandleAllocated;

  if APosition < AMin then APosition := AMin;
  if APosition > AMax then APosition := AMax;

{$IFNDEF VCL}
  FParamsChanging := True;
  try
{$ENDIF}
    if (Min <> AMin) or (Max <> AMax) or (FPageSize <> APageSize) or
      (Position <> APosition) then
    begin
      FMin := AMin;
      FMax := AMax;
    {$IFNDEF VCL}
      if FLookAndFeel.NativeStyle then
        QRangeControl_setRange(RangeControl, AMin, AMax);
    {$ENDIF}
      FPageSize := APageSize;
    end                                          
    else
      ARedraw := False;
    if Position <> APosition then
    begin
      Enabled := True;
    {$IFNDEF VCL}
      if FLookAndFeel.NativeStyle then
      begin
        QRangeControl_setValue(RangeControl, APosition);
        FPosition := Position;
      end
      else
      begin
        FPosition := APosition;
        CalculateThumbnailRect;
        if ARedraw then {$IFDEF LINUX}Invalidate{$ELSE}Repaint{$ENDIF};
      end;
      InternalScroll(scPosition);
    {$ELSE}
      FPosition := APosition;
      CalculateThumbnailRect;
      if ARedraw then Repaint;
      Change;
    {$ENDIF}
    end
    else
    begin
      CalculateThumbnailRect;
      if ARedraw then {$IFDEF LINUX}Invalidate{$ELSE}Repaint{$ENDIF};
    end;
{$IFNDEF VCL}
  finally
    FParamsChanging := False;
  end;
{$ENDIF}
end;

procedure TcxScrollBar.SetParams(APosition, AMin, AMax: Integer);
begin
  SetScrollParams(AMin, AMax, APosition, {$IFDEF VCL}FPageSize{$ELSE}0{$ENDIF});
end;

procedure TcxScrollBar.SetMax(Value: Integer);
begin
  SetScrollParams(FMin, Value, FPosition, FPageSize);
end;

procedure TcxScrollBar.SetMin(Value: Integer);
begin
  SetScrollParams(Value, FMax, FPosition, FPageSize);
end;

procedure TcxScrollBar.SetPageSize(Value: Integer);
begin
  SetScrollParams(FMin, FMax, FPosition, Value);
end;

procedure TcxScrollBar.SetPosition(Value: Integer);
begin
  SetScrollParams(FMin, FMax, Value, FPageSize);
end;

procedure TcxScrollBar.Change;
begin
{$IFDEF VCL}
  inherited Changed;
{$ENDIF}
  if Assigned(FOnChange) then FOnChange(Self);
end;

{$IFNDEF VCL}

procedure TcxScrollBar.CreateWidget;
begin
  if FLookAndFeel.NativeStyle then
  begin
    FHandle := QScrollBar_create(ParentWidget, nil);
    Hooks := QScrollBar_hook_create(FHandle);
  end
  else
    inherited CreateWidget;
end;

procedure TcxScrollBar.HookEvents;
var
  Method: TMethod;
begin
  if FLookAndFeel.NativeStyle then
  begin
    QScrollBar_valueChanged_Event(Method) := ValueChangedHook;
    QScrollBar_hook_hook_valueChanged(QScrollBar_hookH(Hooks), Method);
    QScrollBar_sliderPressed_Event(Method) := SliderPressedHook;
    QScrollBar_hook_hook_sliderPressed(QScrollBar_hookH(Hooks), Method);
    QScrollBar_sliderReleased_Event(Method) := SliderReleasedHook;
    QScrollBar_hook_hook_sliderReleased(QScrollBar_hookH(Hooks), Method);
    QScrollBar_nextLine_Event(Method) := NextLineHook;
    QScrollBar_hook_hook_nextLine(QScrollBar_hookH(Hooks), Method);
    QScrollBar_prevLine_Event(Method) := PrevLineHook;
    QScrollBar_hook_hook_prevLine(QScrollBar_hookH(Hooks), Method);
    QScrollBar_nextPage_Event(Method) := NextPageHook;
    QScrollBar_hook_hook_nextPage(QScrollBar_hookH(Hooks), Method);
    QScrollBar_prevPage_Event(Method) := PrevPageHook;
    QScrollBar_hook_hook_prevPage(QScrollBar_hookH(Hooks), Method);
  end;
  inherited HookEvents;
end;

procedure TcxScrollBar.InitWidget;
begin
  inherited InitWidget;
  if FLookAndFeel.NativeStyle then
  begin
    Max := FMax;
    Min := FMin;
    SmallChange := FSmallChange;
    LargeChange := FLargeChange;
    Position:= FPosition;
    //!!! lcm 
    //if FUnlimitedTracking then Style.MaxSliderDragDistance := -1;
    QScrollBar_setTracking(Handle, True);
    QScrollBar_setOrientation(Handle, Orientation(FKind));
  end
  else
    QWidget_setBackgroundMode(Handle, QWidgetBackgroundMode_NoBackground);
  QWidget_setFocusPolicy(Handle, QWidgetFocusPolicy_NoFocus);
end;

procedure TcxScrollBar.DestroyWidget;
begin
  FRangeControl := nil;
  Style := nil;
  inherited DestroyWidget;
end;

procedure TcxScrollBar.Loaded;
begin
  inherited Loaded;
  if FLookAndFeel.NativeStyle then
    QScrollBar_setOrientation(Handle, Orientation(FKind));
end;

procedure TcxScrollBar.Painting(Sender: QObjectH; EventRegion: QRegionH);
var
  ForcedPaintEvent: QPaintEventH;
begin
  if not FLookAndFeel.NativeStyle then
    inherited
  else
  begin
    ForcedPaintEvent := QPaintEvent_create(EventRegion, False);
    try
      ControlState := ControlState + [csWidgetPainting];
      try
        QObject_event(Sender, ForcedPaintEvent);
      finally
        ControlState := ControlState - [csWidgetPainting];
      end;
    finally
      QPaintEvent_destroy(ForcedPaintEvent);
    end;
  end;
end;

{$ENDIF}

function TcxScrollBar.GetPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := LookAndFeel.GetAvailablePainter(totScrollBar);
end;

procedure TcxScrollBar.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
{$IFDEF VCL}
  CalcMinThumnailSize;
  CalculateRects;
{$ELSE}
  RecreateWidget;
  if not Sender.NativeStyle then
  begin
    CalcMinThumnailSize;
    CalculateRects;
  end;
{$ENDIF}
  Invalidate;
end;

procedure TcxScrollBar.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  APart: TcxScrollBarPart;
begin
  inherited;
  if (Button <> mbLeft){$IFNDEF VCL} or FLookAndFeel.NativeStyle{$ENDIF} then Exit;
  APart := GetScrollBarPart(Point(X, Y));
  if APart <> sbpNone then
  begin
    if APart = sbpThumbnail then
    begin
      FDownMousePos := Point(X, Y);
      FSavePosition := FPosition;
      FSaveThumbnailPos := FThumbnail.TopLeft;
      InternalScroll(scTrack);
    end;
    FState.PressedPart := APart;
    FState.HotPart := APart;
    if APart in cxTimerParts then
    begin
      DoScroll(APart);
      TcxTimer(FTimer).Interval := cxScrollInitialInterval;
      TcxTimer(FTimer).Enabled := True;
    end;
    Repaint;
  end;
end;

procedure TcxScrollBar.MouseEnter(AControl: TControl);
begin
{$IFNDEF VCL}
  inherited MouseEnter(AControl);
  if FLookAndFeel.NativeStyle then Exit;
{$ENDIF}
  if Painter.IsButtonHotTrack or (FState.PressedPart in cxTimerParts) then
    Repaint;
end;

procedure TcxScrollBar.MouseLeave(AControl: TControl);
begin
{$IFNDEF VCL}
  inherited MouseLeave(AControl);
  if FLookAndFeel.NativeStyle then Exit;
{$ENDIF}
  if FState.PressedPart <> sbpThumbnail then
    FState.HotPart := sbpNone;
  if Painter.IsButtonHotTrack or (FState.PressedPart in cxTimerParts) then
    Invalidate;
end;


procedure TcxScrollBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  APart: TcxScrollBarPart;
  R: TRect;
  ADelta, ANewPos, ASize: Integer;

  procedure UpdateThumbnail(ADeltaX, ADeltaY: Integer);
  begin
    if FKind = sbHorizontal then
      FThumbnail := Bounds(FSaveThumbnailPos.X, 0, ASize, Height)
    else
      FThumbnail := Bounds(0, FSaveThumbnailPos.Y, Width, ASize);
    OffsetRect(FThumbnail, ADeltaX, ADeltaY);
    AdjustPagesRects;
    Repaint;
  end;

begin
  inherited MouseMove(Shift, X, Y);
{$IFNDEF VCL}
  if FLookAndFeel.NativeStyle then Exit;
{$ENDIF}
  APart := GetScrollBarPart(Point(X, Y));
  if FState.PressedPart = sbpThumbnail then
  begin
    if FKind = sbHorizontal then
    begin
      ASize := FThumbnail.Right - FThumbnail.Left;
      R := Rect(-cxScrollMinDistance, -cxScrollMaxDistance,
        Width + cxScrollMinDistance, Height + cxScrollMaxDistance);
    end
    else
    begin
      ASize := FThumbnail.Bottom - FThumbnail.Top;
      R := Rect(-cxScrollMaxDistance, -cxScrollMinDistance,
        Width + cxScrollMaxDistance, Height + cxScrollMinDistance);
    end;
    if not (FUnlimitedTracking or PtInRect(R, Point(X, Y))) then
    begin
      if Position <> FSavePosition then
      begin
        Position := FSavePosition;
        DoScroll(sbpThumbnail);
      end; 
    end
    else
    begin
      if FKind = sbHorizontal then
      begin
        ADelta := X - FDownMousePos.X;
        if ADelta = 0 then Exit;
        if (ADelta < 0) and (FSaveThumbnailPos.X + ADelta < FTopLeftArrow.Right) then
          ADelta := FTopLeftArrow.Right - FSaveThumbnailPos.X
        else
          if (ADelta > 0) and (FSaveThumbnailPos.X + ASize + ADelta > FBottomRightArrow.Left) then
            ADelta := FBottomRightArrow.Left - (FSaveThumbnailPos.X + ASize);
        UpdateThumbnail(ADelta, 0);
      end
      else
      begin
        ADelta := Y - FDownMousePos.Y;
        if ADelta = 0 then Exit;
        if (ADelta < 0) and (FSaveThumbnailPos.Y + ADelta < FTopLeftArrow.Bottom) then
          ADelta := FTopLeftArrow.Bottom - FSaveThumbnailPos.Y
        else
          if (ADelta > 0) and (FSaveThumbnailPos.Y + ASize + ADelta > FBottomRightArrow.Top) then
            ADelta := FBottomRightArrow.Top - (FSaveThumbnailPos.Y + ASize);
        UpdateThumbnail(0, ADelta);
      end;
      ANewPos := GetPositionFromThumbnail;
      if ANewPos <> FPosition then
      begin
        FPosition := ANewPos;
        DoScroll(sbpThumbnail);
      end;
    end;
  end
  else
  begin
    if FState.PressedPart <> sbpNone then
      TcxTimer(FTimer).Enabled := FState.PressedPart = APart;
    if (FState.HotPart <> APart) and Painter.IsButtonHotTrack then
    begin
      FState.HotPart := APart;
      Repaint;
    end
    else
      FState.HotPart := APart;
  end;
end;

procedure TcxScrollBar.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
{$IFNDEF VCL}
//  FUseSaveScrollCode := False;
  if FLookAndFeel.NativeStyle then
  begin
    if Enabled and Visible then InternalScroll(scEndScroll);
    FUseSaveScrollCode := False;
  end
  else
{$ENDIF}
  begin
    CancelScroll;
    FState.HotPart := GetScrollBarPart(Point(X, Y));
  end;
end;

procedure TcxScrollBar.Paint;
begin
    PaintVclskin;
end;

procedure DrawSkinMap3( acanvas:Tcanvas; rc:TRect;
       bmp:Tbitmap;I,N:integer);
var temp1:Tbitmap;
    w,h,x:integer;
begin
    if (rc.right<rc.left) or (rc.bottom<rc.top) then exit;
    temp1:=Tbitmap.create;
    w:=bmp.width div n;
    h:=bmp.height;
    temp1.height:=rc.bottom-rc.top;
    temp1.width:=rc.right-rc.left;
    x:=(i-1)*w;
    temp1.canvas.copyrect( rect(0,0,rc.right-rc.left,rc.bottom-rc.top),
             bmp.canvas,rect(x,0,x+w,h));

    temp1.Transparent:=true;
    temp1.Transparentcolor:=clFuchsia;

    acanvas.draw(rc.left,rc.top,temp1);
    temp1.free;
end;

procedure TcxScrollBar.PaintVclskin;
  function GetButtonStateFromPartState(APart: TcxScrollBarPart): TcxButtonState;
  begin
    if not Enabled then
      Result := cxbsDisabled
    else
      if (APart <> sbpThumbnail) or ((APart = sbpThumbnail) and
        Painter.IsButtonHotTrack) then
      begin
        if FState.PressedPart <> sbpNone then
          if (APart = FState.PressedPart) and (APart = FState.HotPart) then
            Result := cxbsPressed
          else
            Result := cxbsNormal
        else
          if (APart = FState.HotPart) and not (csDesigning in ComponentState) then
            Result := cxbsHot
          else
            Result := cxbsNormal
      end
      else
        Result := cxbsNormal;
  end;

var
  AHorz: Boolean;
  fsd:TSkinData;
  temp:Tbitmap;
  st:TcxButtonState;
  i:integer;
  rc:Trect;
  bw,n:integer;
begin
   if (csDesigning in ComponentState) then begin
       PaintDev;
       exit;
   end;
   fsd:=Skinmanager.maindata;
   if not fsd.Active then begin
       PaintDev;
       exit;
   end;

   AHorz := FKind = sbHorizontal;

   temp:=FBitmap;
   rc:=Rect(0,0,temp.width,temp.height);
   
   SetStretchBltMode(temp.canvas.handle,STRETCH_DELETESCANS);
   temp.canvas.brush.color:=fsd.colors[csbuttonface];
   temp.canvas.fillrect(rc);

   st:=GetButtonStateFromPartState(sbpPageUp);
   i:=1;
   if st=cxbsDisabled then i:=3;
   rc:=Fpageup;
   if AHorz then begin
     rc.right:=FPageDown.Right;
     DrawRect2(temp.canvas.handle,rc,fsd.HBar.map,
                   fsd.HBar.r,i,4,fsd.hbar.trans,fsd.hbar.tile);
   end else begin
     rc.Bottom:=FPageDown.Bottom;
     DrawRect2(temp.canvas.handle,rc,fsd.VBar.map,
                   fsd.VBar.r,i,4,fsd.vbar.trans,fsd.hbar.tile);
   end;


   st:=GetButtonStateFromPartState(sbpLineUp);
   i:=1;
   case st of
       cxbsNormal:i:=1;
       cxbsPressed:i:=2;
       cxbsDisabled:i:=3;
       cxbsHot:i:=4;
   end;
   if AHorz then begin
      DrawSkinMap3( temp.canvas,FTopLeftArrow,fsd.SArrow.map,i,fsd.SArrow.frame);
   end else begin
      inc(i,8);
      DrawSkinMap3( temp.canvas,FTopLeftArrow,fsd.SArrow.map,i,fsd.SArrow.frame);
   end;

   st:=GetButtonStateFromPartState(sbpLineDown);
   i:=1;
   case st of
       cxbsNormal:i:=1;
       cxbsPressed:i:=2;
       cxbsDisabled:i:=3;
       cxbsHot:i:=4;
   end;
   if AHorz then begin
      inc(i,4);
      DrawSkinMap3( temp.canvas,FBottomRightArrow,fsd.SArrow.map,i,fsd.SArrow.frame);
   end else begin
      inc(i,12);
      DrawSkinMap3( temp.canvas,FBottomRightArrow,fsd.SArrow.map,i,fsd.SArrow.frame);
   end;

   if not IsRectEmpty(FThumbnail) then begin
      st:=GetButtonStateFromPartState(sbpThumbnail);
      i:=1;
      case st of
          cxbsNormal:i:=1;
          cxbsPressed:i:=2;
          cxbsDisabled:i:=3;
          cxbsHot:i:=4;
      end;
      if AHorz then begin
        if i> fsd.HSlider.frame then i:=1;
        DrawRect2(temp.canvas.handle,FThumbnail,fsd.HSlider.map,
                   fsd.Hslider.r,i,fsd.Hslider.frame,fsd.hslider.trans)
      end else begin
        if i> fsd.VSlider.frame then i:=1;
        DrawRect2(temp.canvas.handle,FThumbnail,fsd.VSlider.map,
                   fsd.Vslider.r,i,fsd.Hslider.frame,fsd.hslider.trans)
      end;
      bw := fsd.SArrow.map.Height;
      i:=1;
      case st of
          cxbsNormal:i:=1;
          cxbsPressed:i:=2;
          cxbsHot:i:=3;
      end;

      if AHorz then begin
          inc(i,16);
          rc:=FThumbnail;
          n:= (rc.Right-rc.Left-bw) div 2;
          rc.Left:=rc.Left+n;
          rc.Right:=rc.Right-n;
          DrawSkinMap3( temp.canvas,rc,fsd.SArrow.map,i,fsd.SArrow.frame);
      end else begin
          inc(i,19);
          rc:=FThumbnail;
          n:= (rc.Bottom-rc.Top-bw) div 2;
          rc.Top:=rc.Top+n;
          rc.Bottom:=rc.Bottom-n;
          DrawSkinMap3( temp.canvas,rc,fsd.SArrow.map,i,fsd.SArrow.frame);
      end;
   end;

   BitBlt(Canvas.Handle, 0, 0, FBitmap.Width, FBitmap.Height,
      FCanvas.Handle, 0, 0, SRCCOPY);
end;

procedure TcxScrollBar.PaintDev;

  function GetButtonStateFromPartState(APart: TcxScrollBarPart): TcxButtonState;
  begin
    if not Enabled then
      Result := cxbsDisabled
    else
      if (APart <> sbpThumbnail) or ((APart = sbpThumbnail) and
        Painter.IsButtonHotTrack) then
      begin
        if FState.PressedPart <> sbpNone then
          if (APart = FState.PressedPart) and (APart = FState.HotPart) then
            Result := cxbsPressed
          else
            Result := cxbsNormal
        else
          if (APart = FState.HotPart) and not (csDesigning in ComponentState) then
            Result := cxbsHot
          else
            Result := cxbsNormal
      end
      else
        Result := cxbsNormal;
  end;

var
  AHorz: Boolean;
{$IFNDEF VCL}
  R: TRect;
{$ENDIF}
begin
{$IFNDEF VCL}
  if FLookAndFeel.NativeStyle then
    Exit;
{$ENDIF}
  AHorz := FKind = sbHorizontal;
  with Painter do
  begin
    if not IsRectEmpty(FThumbnail) then
      DrawScrollBarPart(FCanvas, AHorz, FThumbnail, sbpThumbnail,
        GetButtonStateFromPartState(sbpThumbnail))
    else
    begin
      DrawScrollBarPart(FCanvas, AHorz, Bounds(0, 0, Width, Height),
        sbpPageUp, cxbsNormal);
    end;
    DrawScrollBarPart(FCanvas, AHorz, FTopLeftArrow, sbpLineUp,
      GetButtonStateFromPartState(sbpLineUp));
    DrawScrollBarPart(FCanvas, AHorz, FBottomRightArrow, sbpLineDown,
      GetButtonStateFromPartState(sbpLineDown));
    if not IsRectEmpty(FPageUp) then
      DrawScrollBarPart(FCanvas, AHorz, FPageUp, sbpPageUp,
        GetButtonStateFromPartState(sbpPageUp));
    if not IsRectEmpty(FPageDown) then
      DrawScrollBarPart(FCanvas, AHorz, FPageDown, sbpPageDown,
        GetButtonStateFromPartState(sbpPageDown));
  end;
{$IFDEF VCL}
  BitBlt(Canvas.Handle, 0, 0, FBitmap.Width, FBitmap.Height,
    FCanvas.Handle, 0, 0, SRCCOPY);
{$ELSE}
  R := Rect(0, 0, FBitmap.Width, FBitmap.Height);
  Canvas.CopyRect(R, FCanvas.Canvas, R);
{$ENDIF}
end;

procedure TcxScrollBar.Scroll(ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  if Assigned(FOnScroll) then FOnScroll(Self, ScrollCode, ScrollPos);
end;

procedure TcxScrollBar.AdjustPagesRects;
begin
  if not IsRectEmpty(FThumbnail) then
  begin
    if FKind = sbHorizontal then
    begin
      FPageUp := Rect(FTopLeftArrow.Right, 0, FThumbnail.Left, Height);
      FPageDown := Rect(FThumbnail.Right, 0, FBottomRightArrow.Left, Height);
    end
    else
    begin
      FPageUp := Rect(0, FTopLeftArrow.Bottom, Width, FThumbnail.Top);
      FPageDown := Rect(0, FThumbnail.Bottom, Width, FBottomRightArrow.Top);
    end
  end
  else
  begin
    FPageUp := EmptyRect;
    FPageDown := EmptyRect;
  end;
end;

procedure TcxScrollBar.CalcMinThumnailSize;
{$IFDEF VCL}
const
  ThumbnailGripKind: array[Boolean] of Integer = (SBP_GRIPPERVERT, SBP_GRIPPERHORZ);
  ThumbnailKind: array[Boolean] of Integer = (SBP_THUMBBTNVERT, SBP_THUMBBTNHORZ);
var
  ATheme: TTheme;
  AThumbSize, AGripSize: TSize;
{$ENDIF}
begin
{$IFDEF VCL}
  if Painter = TcxWinXPLookAndFeelPainter then
  begin
    ATheme := OpenTheme(totScrollBar);
    if (ATheme <> 0) and (GetThemePartSize(ATheme, 0, ThumbnailGripKind[FKind = sbVertical],
        SCRBS_NORMAL, TS_MIN, AGripSize) = S_OK) then
    begin
      if (GetThemePartSize(ATheme, 0, ThumbnailGripKind[FKind = sbVertical],
        SCRBS_NORMAL, TS_TRUE, AThumbSize) = S_OK) then
      begin
        if FKind = sbVertical then
          FThumbnailSize := MaxInt(AGripSize.cy, AThumbSize.cy + 4)
        else
          FThumbnailSize := MaxInt(AGripSize.cx, AThumbSize.cx + 4);
      end
      else
        if FKind = sbVertical then
          FThumbnailSize := AGripSize.cy
        else
          FThumbnailSize := AGripSize.cx;
      if FThumbnailSize < cxMinStdThumbnailSize then
        FThumbnailSize := cxMinStdThumbnailSize
    end
    else
      FThumbnailSize := cxMinStdThumbnailSize;
  end
  else
{$ENDIF}
    FThumbnailSize := cxMinStdThumbnailSize;
end;

procedure TcxScrollBar.CalculateRects;
var
  W, H, ASize: Integer;
begin
  if FKind = sbHorizontal then
  begin
    ASize := GetScrollBarSize.cy;
    if (Width div 2) < ASize then W := Width div 2 else W := ASize;
    FTopLeftArrow := Bounds(0, 0, W, Height);
    FBottomRightArrow := Bounds(Width - W, 0, W, Height);
  end
  else
  begin
    ASize := GetScrollBarSize.cx;
    if (Height div 2) < ASize then H := Height div 2 else H := ASize;
    FTopLeftArrow := Bounds(0, 0, Width, H);
    FBottomRightArrow := Bounds(0, Height - H, Width, H);
  end;
  CalculateThumbnailRect;
end;

procedure TcxScrollBar.CalculateThumbnailRect;
var
  ADelta, ASize: Integer;
begin
  FThumbnail := EmptyRect;
  AdjustPagesRects;
  if not Enabled then
    Exit;
  if FKind = sbHorizontal then
  begin
    ADelta := FBottomRightArrow.Left - FTopLeftArrow.Right;
    if FPageSize = 0 then
    begin
    {$IFDEF VCL}
      ASize := GetSystemMetrics(SM_CXHTHUMB);
    {$ELSE}
      ASize := FTopLeftArrow.Right - FTopLeftArrow.Left;
    {$ENDIF}
      if ASize > ADelta then Exit;
      Dec(ADelta, ASize);
      if (ADelta <= 0) or (FMax = FMin) then
        FThumbnail := Bounds(FTopLeftArrow.Right, 0, ASize, Height)
      else
        FThumbnail := Bounds(FTopLeftArrow.Right +
          MulDiv(ADelta, FPosition - FMin, FMax - FMin), 0, ASize, Height);
    end
    else
    begin
      ASize := MinInt(ADelta, MulDiv(FPageSize, ADelta, FMax - FMin + 1));
      if (ADelta < FThumbnailSize) or (FMax = FMin) then Exit;
      if ASize < FThumbnailSize then ASize := FThumbnailSize;
      Dec(ADelta, ASize);
      FThumbnail := Bounds(FTopLeftArrow.Right, 0, ASize, Height);
      ASize := (FMax - FMin) - (FPageSize - 1);
      OffsetRect(FThumbnail, MulDiv(ADelta, MinInt(FPosition - FMin, ASize), ASize), 0);
    end;
  end
  else
  begin
    ADelta := FBottomRightArrow.Top - FTopLeftArrow.Bottom;
    if FPageSize = 0 then
    begin
    {$IFDEF VCL}
      ASize := GetSystemMetrics(SM_CYVTHUMB);
    {$ELSE}
      ASize := FTopLeftArrow.Bottom - FTopLeftArrow.Top;
    {$ENDIF}
      if ASize > ADelta then Exit;
      Dec(ADelta, ASize);
      if (ADelta <= 0) or (FMax = FMin) then
        FThumbnail := Bounds(0, FTopLeftArrow.Bottom, Width, ASize)
      else
        FThumbnail := Bounds(0, FTopLeftArrow.Bottom +
          MulDiv(ADelta, FPosition - FMin, FMax - FMin), Width, ASize);
    end
    else
    begin
      ASize := MinInt(ADelta, MulDiv(FPageSize, ADelta, FMax - FMin + 1));
      if (ADelta < FThumbnailSize) or (FMax = FMin) then Exit;
      if ASize < FThumbnailSize then ASize := FThumbnailSize;
      Dec(ADelta, ASize);
      FThumbnail := Bounds(0, FTopLeftArrow.Bottom, Width, ASize);
      ASize := (FMax - FMin) - (FPageSize - 1);
      OffsetRect(FThumbnail, 0, MulDiv(ADelta, MinInt(FPosition - FMin, ASize), ASize));
    end;
  end;
  AdjustPagesRects;
end;

procedure TcxScrollBar.CancelScroll;
begin
  if FState.PressedPart <> sbpNone then
  begin
    if FState.PressedPart = sbpThumbnail then
    begin
    {$IFDEF VCL}
      FPosition := GetPositionFromThumbnail;
    {$ENDIF}  
      InternalScroll(scPosition);
    end;
    TcxTimer(FTimer).Enabled := False;
    FState.PressedPart := sbpNone;
    FState.HotPart := sbpNone;
    InternalScroll(scEndScroll);
    CalculateThumbnailRect;
    Invalidate;
  end;
end;

procedure TcxScrollBar.DoScroll(APart: TcxScrollBarPart);
begin
  case APart of
    sbpLineUp:  InternalScroll(scLineUp);
    sbpLineDown: InternalScroll(scLineDown);
    sbpPageUp: InternalScroll(scPageUp);
    sbpPageDown: InternalScroll(scPageDown);
    sbpThumbnail: InternalScroll(scTrack);
  end;
end;

function TcxScrollBar.GetPositionFromThumbnail: Integer;
var
  ATotal, AThumbnailSize, ADistance: Integer;
begin
  ATotal := FMax - FMin;
  if FPageSize > 0 then Dec(ATotal, FPageSize - 1);
  if FKind = sbHorizontal then
  begin
    AThumbnailSize := FThumbnail.Right - FThumbnail.Left;
    ADistance := FBottomRightArrow.Left - FTopLeftArrow.Right - AThumbnailSize;
    Result := FMin + MulDiv(ATotal, FThumbnail.Left - FTopLeftArrow.Right,
      ADistance);
  end
  else
  begin
    AThumbnailSize := FThumbnail.Bottom - FThumbnail.Top;
    ADistance := FBottomRightArrow.Top - FTopLeftArrow.Bottom - AThumbnailSize;
    Result := FMin + MulDiv(ATotal, FThumbnail.Top - FTopLeftArrow.Bottom,
      ADistance);
  end;
end;

function TcxScrollBar.GetScrollBarPart(P: TPoint): TcxScrollBarPart;
begin
  Result := sbpNone;
  if not PtInRect(ClientRect, P) then
    Exit;
  if PtInRect(FTopLeftArrow, P) then
    Result := sbpLineUp
  else if PtInRect(FBottomRightArrow, P) then
    Result := sbpLineDown
  else if IsRectEmpty(FThumbnail) then
    Exit
  else if PtInRect(FThumbnail, P) then
    Result := sbpThumbnail
  else if PtInRect(FPageUp, P) then
    Result := sbpPageUp
  else if PtInRect(FPageDown, P) then
    Result := sbpPageDown
end;

procedure TcxScrollBar.InternalScroll(AScrollCode: TScrollCode);
var
  ScrollPos: Integer;
  NewPos: Longint;

  procedure CorrectPos(var APos: Integer);
  begin
    if APos < Min then APos := Min;
    if APos > Max then APos := Max;
  end;

begin
{$IFNDEF VCL}
  if FParamsChanging then Exit;
{$ENDIF}
  NewPos := Position;
{$IFNDEF VCL}
  if not FUseSaveScrollCode then
{$ENDIF}
  case AScrollCode of
    scLineUp:
      Dec(NewPos, SmallChange);
    scLineDown:
      Inc(NewPos, SmallChange);
    scPageUp:
      Dec(NewPos, LargeChange);
    scPageDown:
      Inc(NewPos, LargeChange);
    scTop:
    {$IFNDEF VCL}
      if not FLookAndFeel.NativeStyle then
    {$ENDIF}
        NewPos := FMin;
    scBottom:
    {$IFNDEF VCL}
      if not FLookAndFeel.NativeStyle then
    {$ENDIF}
        NewPos := FMax;
  end;
  CorrectPos(NewPos);
  ScrollPos := NewPos;
{$IFNDEF VCL}
  if FUseSaveScrollCode then AScrollCode := FSaveScrollCode;
  Scroll(AScrollCode, ScrollPos);
  if FLookAndFeel.NativeStyle then
  begin
    if ScrollPos <> NewPos then
    begin
      case AScrollCode of
        scPageDown:
          Dec(ScrollPos, LargeChange);
        scPageUp:
          Inc(ScrollPos, LargeChange);
        scLineDown:
          Dec(ScrollPos, SmallChange);
        scLineUp:
          Inc(ScrollPos, SmallChange);
      end;
      Position := ScrollPos;
    end;
    FPosition := Position;
  end
  else
{$ELSE}
  Scroll(AScrollCode, ScrollPos);
{$ENDIF}
  begin
    CorrectPos(ScrollPos);
    if ScrollPos <> FPosition then
    begin
      if AScrollCode <> scTrack then
        SetPosition(ScrollPos)
      else
      begin
        FPosition := ScrollPos;
        Repaint;
      end;
    end;
  end;
end;

{$IFDEF VCL}

procedure TcxScrollBar.ThemeChanged;
begin
  CalcMinThumnailSize;
  CalculateRects;
  UpdateScrollBarBitmaps;
  Invalidate;
  if Parent <> nil then
    Parent.Realign;
end;

procedure TcxScrollBar.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  CalculateRects;
  if not Enabled then
    CancelScroll;
  Invalidate;
end;

procedure TcxScrollBar.CNHScroll(var Message: TWMHScroll);
begin
  InternalScroll(TScrollCode(Message.ScrollCode));
end;

procedure TcxScrollBar.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if Message.lParam = 0 then
    MouseEnter(Self)
  else
  {$IFNDEF CLR}
    MouseEnter(TControl(Message.lParam));
  {$ELSE}
    //TODO CLR check it out
    if (Parent <> nil) and (Message.lParam < Parent.ControlCount)
      and (Message.lParam >= 0) then
      MouseEnter(Parent.Controls[Message.lParam]);
  {$ENDIF}
end;

procedure TcxScrollBar.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if Message.lParam = 0 then
    MouseLeave(Self)
  else
  {$IFNDEF CLR}
    MouseLeave(TControl(Message.lParam));
  {$ELSE}
    //TODO CLR check it out
    if (Parent <> nil) and (Message.lParam < Parent.ControlCount)
      and (Message.lParam >= 0) then
      MouseLeave(Parent.Controls[Message.lParam]);
  {$ENDIF}
end;

procedure TcxScrollBar.CMSysColorChange(var Message: TMessage);
begin
  UpdateScrollBarBitmaps;
  inherited;
end;

procedure TcxScrollBar.CMVisibleChanged(var Message: TMessage);
begin
  if not Visible then CancelScroll;
  inherited;
end;

procedure TcxScrollBar.CNVScroll(var Message: TWMVScroll);
begin
  InternalScroll(TScrollCode(Message.ScrollCode));
end;

procedure TcxScrollBar.CNCtlColorScrollBar(var Message: TMessage);
begin
  UpdateScrollBarBitmaps;
  with Message do
    CallWindowProc(DefWndProc, Handle, Msg, WParam, LParam);
end;

procedure TcxScrollBar.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TcxScrollBar.WMCancelMode(var Message: TWMCancelMode);
begin
  CancelScroll;
  inherited;
end;

{$ELSE}

function TcxScrollBar.GetHandle: QScrollBarH;
begin
  HandleNeeded;
  Result := QScrollBarH(FHandle);
end;

function TcxScrollBar.GetLargeChange: TScrollBarInc;
begin
  if FLookAndFeel.NativeStyle then
    Result := QRangeControl_pageStep(RangeControl)
  else
    Result := FLargeChange;
end;

function TcxScrollBar.GetMax: Integer;
begin
  if FLookAndFeel.NativeStyle then
    Result := QRangeControl_maxValue(RangeControl)
  else
    Result := FMax;
end;

function TcxScrollBar.GetMin: Integer;
begin
  if FLookAndFeel.NativeStyle then
    Result := QRangeControl_minValue(RangeControl)
  else
    Result := FMin;
end;

function TcxScrollBar.GetPosition: Integer;
begin
  if FLookAndFeel.NativeStyle then
    Result := QRangeControl_value(RangeControl)
  else
    Result := FPosition;
end;

function TcxScrollBar.GetSmallChange: TScrollBarInc;
begin
  if FLookAndFeel.NativeStyle then
    Result := QRangeControl_lineStep(RangeControl)
  else
    Result := FSmallChange;
end;

procedure TcxScrollBar.NextLineHook;
begin
  FSaveScrollCode := scLineDown;
  FUseSaveScrollCode := True;
end;

procedure TcxScrollBar.NextPageHook;
begin
  FSaveScrollCode := scPageDown;
  FUseSaveScrollCode := True;
end;

procedure TcxScrollBar.PrevLineHook;
begin
  FSaveScrollCode := scLineUp;
  FUseSaveScrollCode := True;
end;

procedure TcxScrollBar.PrevPageHook;
begin
  FSaveScrollCode := scPageUp;
  FUseSaveScrollCode := True;
end;

procedure TcxScrollBar.SetLargeChange(const Value: TScrollBarInc);
begin
  if Value <> LargeChange then
    if FLookAndFeel.NativeStyle then
    begin
      QRangeControl_setSteps(RangeControl, SmallChange, Value);
      FLargeChange := LargeChange;
    end
    else
      FLargeChange := Value;
end;

procedure TcxScrollBar.SetSmallChange(const Value: TScrollBarInc);
begin
  if Value <> SmallChange then
    if FLookAndFeel.NativeStyle then
    begin
      QRangeControl_SetSteps(RangeControl, Value, LargeChange);
      FSmallChange := SmallChange;
    end
    else
      FSmallChange := Value;
end;

procedure TcxScrollBar.SliderPressedHook;
begin
  FUseSaveScrollCode := False;
  try
    InternalScroll(scTrack);
  except
    Application.HandleException(Self);
  end;
end;

procedure TcxScrollBar.SliderReleasedHook;
begin
  try
    InternalScroll(scPosition);
  except
    Application.HandleException(Self);
  end;
end;

function TcxScrollBar.RangeControl: QRangeControlH;
begin
  if not Assigned(FRangeControl) then
    FRangeControl := QScrollBar_to_QRangeControl(Handle);
  Result := FRangeControl;
end;

procedure TcxScrollBar.ValueChangedHook(Value: Integer);
begin
  try
    InternalScroll(scTrack);
    FUseSaveScrollCode := False;
    if Position = Min then InternalScroll(scTop)
    else if Position = Max then InternalScroll(scBottom);
    Change;
  except
    Application.HandleException(Self);
  end;
end;

{$ENDIF}

end.

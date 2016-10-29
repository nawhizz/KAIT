//This is patch for Vclskin

//you can search "fsd" to find all modification.

//most modification is in UltraFlat style.


unit cxLookAndFeelPainters;

{$I cxVer.inc}

interface

uses
  Windows, dxUxTheme, dxThemeManager, dxThemeConsts, dxOffice11,
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  Classes, Graphics, Controls, ImgList, cxClasses, cxGraphics,
  WinSkinData,WinskinDlg,WinSkinForm;

const
  cxTextOffset = 2;
  cxHeaderTextOffset = cxTextOffset;

type
  TcxLookAndFeelStyle = (lfsFlat, lfsStandard, lfsUltraFlat,
    lfsNative, lfsOffice11);

  TcxArrowDirection = (adUp, adDown, adLeft, adRight);
  TcxArrowPoints = array[0..2] of TPoint;
  TcxButtonState = (cxbsDefault, cxbsNormal, cxbsHot, cxbsPressed, cxbsDisabled);
  TcxHeaderArrows = (haNone, haLeft, haRight, haBoth);
  TcxIndicatorKind = (ikNone, ikArrow, ikEdit, ikInsert, ikMultiDot, ikMultiArrow, ikFilter);
  TcxNeighbor = (nLeft, nTop, nRight, nBottom);
  TcxNeighbors = set of TcxNeighbor;
  TcxScrollBarPart = (sbpNone, sbpLineUp, sbpLineDown, sbpThumbnail,
    sbpPageUp, sbpPageDown);
  TcxPopupBorderStyle = (pbsNone, pbsUltraFlat, pbsFlat, pbs3D);

  TcxDrawBackgroundEvent = function(ACanvas: TcxCanvas; const ABounds: TRect): Boolean of object;
  TcxCustomLookAndFeelPainterClass = class of TcxCustomLookAndFeelPainter;

  TcxCustomLookAndFeelPainter = class
  protected
    class procedure DrawButtonArrow(ACanvas: TcxCanvas; const R: TRect; AColor: TColor); virtual;
    class procedure DrawContent(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect; AState: Integer;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsFooter: Boolean = False); virtual;
    class procedure DrawExpandButtonCross(ACanvas: TcxCanvas; const R: TRect;
      AExpanded: Boolean; AColor: TColor);
    class procedure DrawGroupExpandButtonMark(ACanvas: TcxCanvas; const R: TRect;
      AExpanded: Boolean; AState: TcxButtonState);
    class procedure DrawIndicatorImage(ACanvas: TcxCanvas; const R: TRect; AKind: TcxIndicatorKind);
    class procedure DrawMonthHeaderArrows(ACanvas: TcxCanvas; const ABounds: TRect;
      AArrows: TcxHeaderArrows; ASideWidth: Integer; AColor: TColor);
    class procedure DrawSortingArrow(ACanvas: TcxCanvas; const R: TRect;
      AColor1, AColor2: TColor; AAscendingSorting: Boolean);
    class function FooterCellContentBounds(const ABounds: TRect): TRect; virtual;
    class function FooterCellTextAreaBounds(const ABounds: TRect): TRect; virtual;
    class function GetArrowDirection(AHorizontal: Boolean; APart: TcxScrollBarPart): TcxArrowDirection;
  public
  {$IFDEF CLR}
    constructor Create; virtual;
  {$ENDIF}
    class function LookAndFeelStyle: TcxLookAndFeelStyle; virtual;
    // colors
    class function DefaultContentColor: TColor; virtual;
    class function DefaultContentTextColor: TColor; virtual;
    class function DefaultFilterBoxColor: TColor; virtual;
    class function DefaultFilterBoxTextColor: TColor; virtual;
    class function DefaultFixedSeparatorColor: TColor; virtual;
    class function DefaultFooterColor: TColor; virtual;
    class function DefaultFooterTextColor: TColor; virtual;
    class function DefaultGridLineColor: TColor; virtual;
    class function DefaultGroupColor: TColor; virtual;
    class function DefaultGroupTextColor: TColor; virtual;
    class function DefaultGroupByBoxColor: TColor; virtual;
    class function DefaultGroupByBoxTextColor: TColor; virtual;
    class function DefaultHeaderColor: TColor; virtual;
    class function DefaultHeaderTextColor: TColor; virtual;
    class function DefaultHeaderBackgroundColor: TColor; virtual;
    class function DefaultHeaderBackgroundTextColor: TColor; virtual;
    class function DefaultHyperlinkTextColor: TColor; virtual;
    class function DefaultInactiveColor: TColor; virtual;
    class function DefaultInactiveTextColor: TColor; virtual;
    class function DefaultPreviewTextColor: TColor; virtual;
    class function DefaultRecordSeparatorColor: TColor; virtual;

    class function DefaultDateNavigatorHeaderColor: TColor; virtual;
    class function DefaultDateNavigatorSelectionColor: TColor; virtual;
    class function DefaultDateNavigatorSelectionTextColor: TColor; virtual;

    class function DefaultSchedulerBackgroundColor: TColor; virtual;
    class function DefaultSchedulerTextColor: TColor; virtual;
    class function DefaultSchedulerBorderColor: TColor; virtual;
    class function DefaultSchedulerControlColor: TColor; virtual;
    class function DefaultSchedulerViewContentColor: TColor; virtual;
    class function DefaultSchedulerViewTextColor: TColor; virtual;
    class function DefaultSelectionColor: TColor; virtual;
    class function DefaultSelectionTextColor: TColor; virtual;
    class function DefaultSeparatorColor: TColor; virtual;
    class function DefaultTabColor: TColor; virtual;
    class function DefaultTabTextColor: TColor; virtual;
    class function DefaultTabsBackgroundColor: TColor; virtual;

    class function DefaultTimeGridMajorScaleColor: TColor; virtual;
    class function DefaultTimeGridMajorScaleTextColor: TColor; virtual;
    class function DefaultTimeGridMinorScaleColor: TColor; virtual;
    class function DefaultTimeGridMinorScaleTextColor: TColor; virtual;
    class function DefaultTimeGridSelectionBarColor: TColor; virtual;

    class function DefaultChartDiagramValueBorderColor: TColor; virtual;
    class function DefaultChartDiagramValueCaptionTextColor: TColor; virtual;
    class function DefaultChartHistogramAxisColor: TColor; virtual;
    class function DefaultChartHistogramGridLineColor: TColor; virtual;
    class function DefaultChartHistogramPlotColor: TColor; virtual;
    class function DefaultChartPieDiagramSeriesSiteBorderColor: TColor; virtual;
    class function DefaultChartPieDiagramSeriesSiteCaptionColor: TColor; virtual;
    class function DefaultChartPieDiagramSeriesSiteCaptionTextColor: TColor; virtual;
    class function DefaultChartToolBoxDataLevelInfoBorderColor: TColor; virtual;
    class function DefaultChartToolBoxItemSeparatorColor: TColor; virtual;

    // arrow
    class procedure CalculateArrowPoints(R: TRect; var P: TcxArrowPoints; AArrowDirection: TcxArrowDirection; AProportional: Boolean);
    class procedure DrawArrow(ACanvas: TcxCanvas; const R: TRect; AArrowDirection: TcxArrowDirection; AColor: TColor); overload; virtual;
    class procedure DrawArrow(ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState; AArrowDirection: TcxArrowDirection; ADrawBorder: Boolean = True); overload; virtual;
    class procedure DrawArrowBorder(ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState); virtual;
    class procedure DrawScrollBarArrow(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AArrowDirection: TcxArrowDirection); virtual;
    // border
    class function BorderSize: Integer; virtual;
    class procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); virtual;
    // buttons
    class function AdjustGroupButtonDisplayRect(const R: TRect; AButtonCount, AButtonIndex: Integer): TRect; virtual;
    class function ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer; virtual; // abstract;
    class function ButtonColor(AState: TcxButtonState): TColor; virtual;
    class function ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect; virtual;
    class function ButtonGroupBorderSizes(AButtonCount, AButtonIndex: Integer): TRect; virtual;
    class function ButtonTextOffset: Integer; virtual; // abstract;
    class function ButtonTextShift: Integer; virtual; // abstract;
    class function ButtonSymbolColor(AState: TcxButtonState;
      ADefaultColor: TColor = clDefault): TColor; virtual;
    class function ButtonSymbolState(AState: TcxButtonState): TcxButtonState; virtual;
    class procedure DrawButton(ACanvas: TcxCanvas; R: TRect; const ACaption: string; AState: TcxButtonState; ADrawBorder: Boolean = True;
      AColor: TColor = clDefault; ATextColor: TColor = clDefault); virtual;
    class procedure DrawButtonCross(ACanvas: TcxCanvas; const R: TRect; AColor: TColor;
      AState: TcxButtonState);
    class procedure DrawButtonInGroup(ACanvas: TcxCanvas; R: TRect;
      AState: TcxButtonState; AButtonCount, AButtonIndex: Integer;
      ABackgroundColor: TColor); virtual;
    class procedure DrawButtonBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); virtual; // abstract;
    class procedure DrawButtonGroupBorder(ACanvas: TcxCanvas; R: TRect; AInplace, ASelected: Boolean); virtual;
    class procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault); virtual; // abstract;
    class function DrawExpandButtonFirst: Boolean; virtual;
    class procedure DrawGroupExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AState: TcxButtonState); virtual; // abstract
    class procedure DrawSmallExpandButton(ACanvas: TcxCanvas; R: TRect; AExpanded: Boolean;
      ABorderColor: TColor; AColor: TColor = clDefault); virtual;
    class function ExpandButtonSize: Integer; virtual; // abstract;
    class function GroupExpandButtonSize: Integer; virtual; // abstract;
    class function IsButtonHotTrack: Boolean; virtual; // abstract;
    class function IsPointOverGroupExpandButton(const R: TRect; const P: TPoint): Boolean; virtual;
    class function SmallExpandButtonSize: Integer; virtual;
    // checkbox
    class function CheckBorderSize: Integer; virtual;
    class function CheckButtonColor(AState: TcxButtonState): TColor; virtual;
    class function CheckButtonSize: TSize; virtual;
    class procedure DrawCheck(ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState;
      AChecked: Boolean; AColor: TColor); virtual;
    class procedure DrawCheckBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); virtual; // abstract;
    class procedure DrawCheckButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState;
      AChecked: Boolean); virtual;
    // RadioGroup
    class procedure DrawRadioButton(ACanvas: TcxCanvas; X, Y: Integer;
      AButtonState: TcxButtonState; AChecked, AFocused: Boolean;
      ABrushColor: TColor;  AIsDesigning: Boolean = False); virtual;
    class function RadioButtonSize: TSize; virtual;
    // header
    class procedure DrawHeader(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsLast: Boolean = False); virtual;
    class procedure DrawHeaderEx(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil); virtual;
    class procedure DrawHeaderBorder(ACanvas: TcxCanvas; const R: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders); virtual;
    class procedure DrawHeaderPressed(ACanvas: TcxCanvas; const ABounds: TRect); virtual;
    class procedure DrawHeaderControlSection(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine,
      AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor,
      ABkColor: TColor); virtual;
    class procedure DrawHeaderControlSectionBorder(ACanvas: TcxCanvas; const R: TRect;
      ABorders: TcxBorders; AState: TcxButtonState); virtual;
    class procedure DrawHeaderControlSectionContent(ACanvas: TcxCanvas; const ABounds,
      ATextAreaBounds: TRect; AState: TcxButtonState; AAlignmentHorz: TAlignment;
      AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor); virtual;
    class procedure DrawHeaderControlSectionText(ACanvas: TcxCanvas;
      const ATextAreaBounds: TRect; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine,
      AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor: TColor); virtual;
    class procedure DrawSortingMark(ACanvas: TcxCanvas; const R: TRect; AAscendingSorting: Boolean); virtual; // abstract;
    class function HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders; virtual;
    class function HeaderBorderSize: Integer; virtual;
    class function HeaderBounds(const ABounds: TRect; ANeighbors: TcxNeighbors;
      ABorders: TcxBorders = cxBordersAll): TRect; virtual;
    class function HeaderContentBounds(const ABounds: TRect; ABorders: TcxBorders): TRect; virtual;
    class function HeaderDrawCellsFirst: Boolean; virtual;
    class function HeaderHeight(AFontHeight: Integer): Integer; virtual;
    class function HeaderControlSectionBorderSize(
      AState: TcxButtonState = cxbsNormal): Integer; virtual;
    class function HeaderControlSectionTextAreaBounds(ABounds: TRect;
      AState: TcxButtonState): TRect; virtual;
    class function HeaderControlSectionContentBounds(const ABounds: TRect;
      AState: TcxButtonState): TRect; virtual;
    class function HeaderWidth(ACanvas: TcxCanvas; ABorders: TcxBorders;
      const AText: string; AFont: TFont): Integer; virtual;
    class function IsHeaderHotTrack: Boolean; virtual;
    class function SortingMarkAreaSize: TPoint; virtual;
    class function SortingMarkSize: TPoint; virtual; // abstract;
    // footer
    class procedure DrawFooterCell(ACanvas: TcxCanvas; const ABounds: TRect;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil); virtual;
    class function FooterBorders: TcxBorders; virtual;
    class function FooterBorderSize: Integer; virtual; // abstract;
    class function FooterCellBorderSize: Integer; virtual; // abstract;
    class function FooterCellOffset: Integer; virtual; // abstract;
    class function FooterDrawCellsFirst: Boolean; virtual;
    class function FooterSeparatorColor: TColor; virtual;
    class function FooterSeparatorSize: Integer; virtual;
    class procedure DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect); virtual; // abstract;
    class procedure DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect); virtual; // abstract;
    class procedure DrawFooterSeparator(ACanvas: TcxCanvas; const R: TRect); virtual;
    // filter
    class procedure DrawFilterActivateButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AChecked: Boolean); virtual;
    class procedure DrawFilterCloseButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); virtual;
    class procedure DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); virtual; // abstract;
    class function FilterActivateButtonSize: TPoint; virtual;
    class function FilterCloseButtonSize: TPoint; virtual;
    class function FilterDropDownButtonSize: TPoint; virtual;
    // popup
    class function PopupBorderStyle: TcxPopupBorderStyle; virtual;
    // tabs
    class procedure DrawTab(ACanvas: TcxCanvas; R: TRect; ABorders: TcxBorders;
      const AText: string; AState: TcxButtonState; AVertical: Boolean; AFont: TFont;
      ATextColor, ABkColor: TColor; AShowPrefix: Boolean = False); virtual;
    class procedure DrawTabBorder(ACanvas: TcxCanvas; R: TRect; ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean); virtual; // abstract;
    class procedure DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AVertical: Boolean); virtual; // abstract;
    class function IsDrawTabImplemented(AVertical: Boolean): Boolean; virtual;
    class function IsTabHotTrack(AVertical: Boolean): Boolean; virtual;
    class function TabBorderSize(AVertical: Boolean): Integer; virtual;
    // indicator
    class procedure DrawIndicatorItem(ACanvas: TcxCanvas; const R: TRect;
      AKind: TcxIndicatorKind; AColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil); virtual;
    class procedure DrawIndicatorItemEx(ACanvas: TcxCanvas; const R: TRect;
      AKind: TcxIndicatorKind; AColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil); virtual;
    class function IndicatorDrawItemsFirst: Boolean; virtual;
    // scrollbars
    class procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); virtual;
    // ms outlook
    class procedure DrawMonthHeader(ACanvas: TcxCanvas; const ABounds: TRect;
      const AText: string; ANeighbors: TcxNeighbors; const AViewParams: TcxViewParams;
      AArrows: TcxHeaderArrows; ASideWidth: Integer; AOnDrawBackground: TcxDrawBackgroundEvent = nil); virtual;
    class procedure DrawSchedulerBorder(ACanvas: TcxCanvas; R: TRect); virtual;
    class procedure DrawSchedulerNavigatorButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); virtual;
    class procedure DrawSchedulerSplitterBorder(ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams; AIsHorizontal: Boolean); virtual;
    // chart view
    class function ChartToolBoxDataLevelInfoBorderSize: Integer; virtual;
  end;

  TcxStandardLookAndFeelPainter = class(TcxCustomLookAndFeelPainter)
  public
    class function LookAndFeelStyle: TcxLookAndFeelStyle; override;
    // border
    class function BorderSize: Integer; override;
    class procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); override;
    // buttons
    class function ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer; override;
    class function ButtonTextOffset: Integer; override;
    class function ButtonTextShift: Integer; override;
    class procedure DrawButtonBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    class procedure DrawGroupExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AState: TcxButtonState); override;
    class function ExpandButtonSize: Integer; override;
    class procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault); override;
    class function IsButtonHotTrack: Boolean; override;
    // checkbox
    class procedure DrawCheckBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    // header
    class procedure DrawHeaderBorder(ACanvas: TcxCanvas; const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders); override;
    class procedure DrawHeaderControlSectionBorder(ACanvas: TcxCanvas; const R: TRect;
      ABorders: TcxBorders; AState: TcxButtonState); override;
    class procedure DrawSortingMark(ACanvas: TcxCanvas; const R: TRect; AAscendingSorting: Boolean); override;
    class function HeaderBorderSize: Integer; override;
    class function HeaderControlSectionBorderSize(
      AState: TcxButtonState = cxbsNormal): Integer; override;
    class function SortingMarkSize: TPoint; override;
    // footer
    class function FooterBorderSize: Integer; override;
    class function FooterCellBorderSize: Integer; override;
    class function FooterCellOffset: Integer; override;
    class procedure DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect); override;
    class procedure DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect); override;
    // filter
    class procedure DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); override;
    // tabs
    class procedure DrawTabBorder(ACanvas: TcxCanvas; R: TRect; ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean); override;
    class procedure DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AVertical: Boolean); override;
    class function TabBorderSize(AVertical: Boolean): Integer; override;
    // scrollbars
    class procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); override;
    // ms outlook
    class function DefaultSchedulerViewContentColor: TColor; override;
    class procedure DrawMonthHeader(ACanvas: TcxCanvas; const ABounds: TRect;
      const AText: string; ANeighbors: TcxNeighbors; const AViewParams: TcxViewParams;
      AArrows: TcxHeaderArrows; ASideWidth: Integer; AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    class procedure DrawSchedulerSplitterBorder(ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams; AIsHorizontal: Boolean); override;
  end;

  TcxFlatLookAndFeelPainter = class(TcxCustomLookAndFeelPainter)
  public
    class function LookAndFeelStyle: TcxLookAndFeelStyle; override;
    // border
    class function BorderSize: Integer; override;
    class procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); override;
    // buttons
    class function ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer; override;
    class function ButtonTextOffset: Integer; override;
    class function ButtonTextShift: Integer; override;
    class procedure DrawButtonBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    class procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault); override;
    class function ExpandButtonSize: Integer; override;
    class function IsButtonHotTrack: Boolean; override;
    // checkbox
    class procedure DrawCheckBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    // header
    class procedure DrawHeaderBorder(ACanvas: TcxCanvas; const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders); override;
    class procedure DrawHeaderControlSectionBorder(ACanvas: TcxCanvas; const R: TRect;
      ABorders: TcxBorders; AState: TcxButtonState); override;
    class procedure DrawSortingMark(ACanvas: TcxCanvas; const R: TRect; AAscendingSorting: Boolean); override;
    class function HeaderBorderSize: Integer; override;
    class function SortingMarkSize: TPoint; override;
    // footer
    class function FooterBorderSize: Integer; override;
    class function FooterCellBorderSize: Integer; override;
    class function FooterCellOffset: Integer; override;
    class procedure DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect); override;
    class procedure DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect); override;
    // filter
    class procedure DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); override;
    // tabs
    class procedure DrawTabBorder(ACanvas: TcxCanvas; R: TRect; ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean); override;
    class procedure DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AVertical: Boolean); override;
    class function TabBorderSize(AVertical: Boolean): Integer; override;
    // scrollbars
    class procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); override;
    // ms outlook
    class procedure DrawSchedulerSplitterBorder(ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams; AIsHorizontal: Boolean); override;
  end;

  TcxUltraFlatLookAndFeelPainter = class(TcxCustomLookAndFeelPainter)
  protected
    // filter
    class function FilterDropDownButtonBorderColor(AState: TcxButtonState): TColor; virtual;
    // tabs
    class function TabBorderHighlightColor: TColor; virtual;
    class function TabBorderDarkColor: TColor; virtual;
  public
    class function LookAndFeelStyle: TcxLookAndFeelStyle; override;
    // default
    class function DefaultSchedulerBorderColor: TColor; override;
    // border
    class function BorderHighlightColor: TColor; virtual;
    class function BorderSize: Integer; override;
    class procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); override;

    //fsd : override drawbutton
    class procedure DrawButton(ACanvas: TcxCanvas;
        R: TRect; const ACaption: string; AState: TcxButtonState; ADrawBorder: Boolean = True;
        AColor: TColor = clDefault; ATextColor: TColor = clDefault);override;

    // buttons
    class function ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer; override;
    class function ButtonColor(AState: TcxButtonState): TColor; override;
    class function ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect; override;
    class function ButtonGroupBorderSizes(AButtonCount, AButtonIndex: Integer): TRect; override;
    class function ButtonSymbolColor(AState: TcxButtonState;
      ADefaultColor: TColor = clDefault): TColor; override;
    class function ButtonSymbolState(AState: TcxButtonState): TcxButtonState; override;
    class function ButtonTextOffset: Integer; override;
    class function ButtonTextShift: Integer; override;
    class procedure DrawButtonBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    class procedure DrawButtonInGroup(ACanvas: TcxCanvas; R: TRect;
      AState: TcxButtonState; AButtonCount, AButtonIndex: Integer;
      ABackgroundColor: TColor); override;
    class procedure DrawButtonGroupBorder(ACanvas: TcxCanvas; R: TRect; AInplace, ASelected: Boolean); override;
    class procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault); override;
    class procedure DrawHeaderControlSectionBorder(ACanvas: TcxCanvas; const R: TRect;
      ABorders: TcxBorders; AState: TcxButtonState); override;
    class procedure DrawHeaderControlSectionContent(ACanvas: TcxCanvas; const ABounds,
      ATextAreaBounds: TRect; AState: TcxButtonState; AAlignmentHorz: TAlignment;
      AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor); override;
    class function ExpandButtonSize: Integer; override;
    class function IsButtonHotTrack: Boolean; override;
    // checkbox
    class procedure DrawCheckBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;

    //fsd:draw header override
    function VclskinDrawHeaderBk(ACanvas: TcxCanvas; const ABounds: TRect):boolean;
    class procedure DrawHeader(ACanvas: TcxCanvas;
            const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
            AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
            AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
            ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil;
            AIsLast: Boolean = False);override;

    // header
    class procedure DrawHeaderBorder(ACanvas: TcxCanvas; const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders); override;
    class procedure DrawHeaderEx(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    class procedure DrawSortingMark(ACanvas: TcxCanvas; const R: TRect; AAscendingSorting: Boolean); override;
    class function HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders; override;
    class function HeaderBorderSize: Integer; override;
    class function SortingMarkSize: TPoint; override;
    // footer
    class procedure DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect); override;
    class procedure DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect); override;
    class function FooterBorders: TcxBorders; override;
    class function FooterBorderSize: Integer; override;
    class function FooterCellBorderSize: Integer; override;
    class function FooterCellOffset: Integer; override;
    // filter
    class procedure DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); override;
    class function FilterCloseButtonSize: TPoint; override;
    // tabs
    class procedure DrawTabBorder(ACanvas: TcxCanvas; R: TRect; ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean); override;
    class procedure DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AVertical: Boolean); override;
    class function TabBorderSize(AVertical: Boolean): Integer; override;
    // scrollbars
    class procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); override;
    // ms outlook
    class procedure DrawSchedulerNavigatorButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    class procedure DrawSchedulerSplitterBorder(ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams; AIsHorizontal: Boolean); override;
  end;

{$IFDEF VCL}
  TcxOffice11LookAndFeelPainter = class(TcxUltraFlatLookAndFeelPainter)
  protected
    class procedure DrawContent(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect; AState: Integer;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsFooter: Boolean = False); override;
    class function HeaderBottomColor: TColor; virtual;
    class function HeaderDarkEdgeColor: TColor; virtual;
    class function HeaderHighlightEdgeColor: TColor; virtual;
    class function HeaderTopColor: TColor; virtual;
    // filter
    class function FilterDropDownButtonBorderColor(AState: TcxButtonState): TColor; override;
    // tabs
    class function TabBorderHighlightColor: TColor; override;
    class function TabBorderDarkColor: TColor; override;
  public
    class function LookAndFeelStyle: TcxLookAndFeelStyle; override;
    // colors
    class function DefaultDateNavigatorHeaderColor: TColor; override;
    class function DefaultDateNavigatorSelectionColor: TColor; override;
    class function DefaultDateNavigatorSelectionTextColor: TColor; override;
    class function DefaultFilterBoxColor: TColor; override;
    class function DefaultFilterBoxTextColor: TColor; override;
    class function DefaultFooterColor: TColor; override;
    class function DefaultFooterTextColor: TColor; override;
    class function DefaultGroupColor: TColor; override;
    class function DefaultGroupByBoxColor: TColor; override;
    class function DefaultGroupByBoxTextColor: TColor; override;
    class function DefaultHeaderColor: TColor; override;
    class function DefaultHeaderBackgroundColor: TColor; override;
    class function DefaultSchedulerBorderColor: TColor; override;
    class function DefaultSchedulerControlColor: TColor; override;
    class function DefaultTabColor: TColor; override;
    class function DefaultTabsBackgroundColor: TColor; override;
    class function DefaultTimeGridMinorScaleColor: TColor; override;
    class function DefaultTimeGridSelectionBarColor: TColor; override;
    // border
    class function BorderHighlightColor: TColor; override;
    class procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); override;
    // buttons
    class function ButtonColor(AState: TcxButtonState): TColor; override;
    class function ButtonSymbolColor(AState: TcxButtonState;
      ADefaultColor: TColor = clDefault): TColor; override;
    class procedure DrawButtonBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    class procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean;
      AColor: TColor = clDefault); override;
    class function DrawExpandButtonFirst: Boolean; override;
    class procedure DrawSmallExpandButton(ACanvas: TcxCanvas; R: TRect; AExpanded: Boolean;
      ABorderColor: TColor; AColor: TColor = clDefault); override;
    class function ExpandButtonSize: Integer; override;
    class function SmallExpandButtonSize: Integer; override;
    // checkbox
    class function CheckButtonColor(AState: TcxButtonState): TColor; override;
    // filter
    class procedure DrawFilterDropDownButton(ACanvas: TcxCanvas;
      R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); override;

    // header
    class procedure DrawHeader(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsLast: Boolean = False); override;
    class procedure DrawHeaderBorder(ACanvas: TcxCanvas; const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders); override;
    class procedure DrawHeaderControlSection(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine,
      AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor,
      ABkColor: TColor); override;
    class procedure DrawSortingMark(ACanvas: TcxCanvas; const R: TRect; AAscendingSorting: Boolean); override;
    class function HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders; override;
    class function HeaderBorderSize: Integer; override;
    class function IsHeaderHotTrack: Boolean; override;
    // footer
    class function FooterSeparatorColor: TColor; override;
    // tabs
    // scrollbars
    class procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); override;
    // ms outlook
    class procedure DrawMonthHeader(ACanvas: TcxCanvas; const ABounds: TRect;
      const AText: string; ANeighbors: TcxNeighbors; const AViewParams: TcxViewParams;
      AArrows: TcxHeaderArrows; ASideWidth: Integer; AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    class procedure DrawSchedulerNavigatorButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    class procedure DrawSchedulerBorder(ACanvas: TcxCanvas; R: TRect); override;
  end;

  TcxWinXPLookAndFeelPainter = class(TcxStandardLookAndFeelPainter)
  protected
    class procedure DrawContent(ACanvas: TcxCanvas; ATheme: TTheme; APartId, AStateId: Integer;
      const ABounds, ATextAreaBounds: TRect; AAlignmentHorz: TAlignment;
      AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis, AShowPrefix: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor); reintroduce; virtual;
  public
    class function LookAndFeelStyle: TcxLookAndFeelStyle; override;
    // colors
    class function DefaultSchedulerBorderColor: TColor; override;
    // arrow
    class procedure DrawArrow(ACanvas: TcxCanvas; const R: TRect; AArrowDirection: TcxArrowDirection; AColor: TColor); override;
    class procedure DrawArrow(ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState; AArrowDirection: TcxArrowDirection; ADrawBorder: Boolean = True); override;
    class procedure DrawArrowBorder(ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState); override;
    // border
    class function BorderSize: Integer; override;
    class procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); override;
    // buttons
    class function AdjustGroupButtonDisplayRect(const R: TRect; AButtonCount, AButtonIndex: Integer): TRect; override;
    class function ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer; override;
    class function ButtonColor(AState: TcxButtonState): TColor; override;
    class function ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect; override;
    class function ButtonGroupBorderSizes(AButtonCount, AButtonIndex: Integer): TRect; override;
    class function ButtonSymbolColor(AState: TcxButtonState;
      ADefaultColor: TColor = clDefault): TColor; override;
    class function ButtonTextOffset: Integer; override;
    class function ButtonTextShift: Integer; override;
    class procedure DrawButton(ACanvas: TcxCanvas; R: TRect; const ACaption: string; AState: TcxButtonState; ADrawBorder: Boolean = True;
    AColor: TColor = clDefault; ATextColor: TColor = clDefault); override;
    class procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault); override;
    class function DrawExpandButtonFirst: Boolean; override;
    class procedure DrawGroupExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AState: TcxButtonState); override;
    class procedure DrawSmallExpandButton(ACanvas: TcxCanvas; R: TRect; AExpanded: Boolean;
      ABorderColor: TColor; AColor: TColor = clDefault); override;
    class function ExpandButtonSize: Integer; override;
    class function GroupExpandButtonSize: Integer; override;
    class function SmallExpandButtonSize: Integer; override;
    class function IsButtonHotTrack: Boolean; override;
    class function IsPointOverGroupExpandButton(const R: TRect; const P: TPoint): Boolean; override;
    // checkbox
    class function CheckBorderSize: Integer; override;
    class function CheckButtonSize: TSize; override;
    class procedure DrawCheck(ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState;
      AChecked: Boolean; AColor: TColor); override;
    class procedure DrawCheckBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    // RadioGroup
    class procedure DrawRadioButton(ACanvas: TcxCanvas; X, Y: Integer;
      AButtonState: TcxButtonState; AChecked: Boolean; AFocused: Boolean; ABrushColor: TColor;  AIsDesigning: Boolean = False); override;
    class function RadioButtonSize: TSize; override;
    // header
    class procedure DrawHeader(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsLast: Boolean = False); override;
    class procedure DrawHeaderPressed(ACanvas: TcxCanvas; const ABounds: TRect); override;
    class procedure DrawHeaderControlSection(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine,
      AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor,
      ABkColor: TColor); override;
    class procedure DrawSortingMark(ACanvas: TcxCanvas; const R: TRect; AAscendingSorting: Boolean); override;
    class function HeaderBorderSize: Integer; override;
    class function HeaderControlSectionBorderSize(
      AState: TcxButtonState = cxbsNormal): Integer; override;
    class function HeaderControlSectionContentBounds(const ABounds: TRect;
      AState: TcxButtonState): TRect; override;
    class function HeaderDrawCellsFirst: Boolean; override;
    class function IsHeaderHotTrack: Boolean; override;
    class function SortingMarkSize: TPoint; override;
    // footer
    class procedure DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect); override;
    class procedure DrawFooterCell(ACanvas: TcxCanvas; const ABounds: TRect;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    class function FooterBorderSize: Integer; override;
    class function FooterCellBorderSize: Integer; override;
    class function FooterCellOffset: Integer; override;
    class function FooterDrawCellsFirst: Boolean; override;
    // filter
    class procedure DrawFilterCloseButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    class procedure DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); override;
    class function FilterActivateButtonSize: TPoint; override;
    class function FilterCloseButtonSize: TPoint; override;
    // tabs
    class procedure DrawTab(ACanvas: TcxCanvas; R: TRect; ABorders: TcxBorders;
      const AText: string; AState: TcxButtonState; AVertical: Boolean; AFont: TFont;
      ATextColor, ABkColor: TColor; AShowPrefix: Boolean = False); override;
    class procedure DrawTabBorder(ACanvas: TcxCanvas; R: TRect; ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean); override;
    class procedure DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AVertical: Boolean); override;
    class function IsDrawTabImplemented(AVertical: Boolean): Boolean; override;
    class function IsTabHotTrack(AVertical: Boolean): Boolean; override;
    class function TabBorderSize(AVertical: Boolean): Integer; override;
    // indicator
    class procedure DrawIndicatorItem(ACanvas: TcxCanvas; const R: TRect;
      AKind: TcxIndicatorKind; AColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    //class function IndicatorDrawItemsFirst: Boolean; override;
    // scrollbars
    class procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); override;
    // ms outlook
    class function DefaultSchedulerViewContentColor: TColor; override;
    class procedure DrawMonthHeader(ACanvas: TcxCanvas; const ABounds: TRect;
      const AText: string; ANeighbors: TcxNeighbors; const AViewParams: TcxViewParams;
      AArrows: TcxHeaderArrows; ASideWidth: Integer; AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    class procedure DrawSchedulerNavigatorButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    class procedure DrawSchedulerSplitterBorder(ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams; AIsHorizontal: Boolean); override;
  end;

function BtnStateToXPBtnState(AState: TcxButtonState): Integer;
{$ENDIF}

function GetCurrentPainterClass: TcxCustomLookAndFeelPainterClass;
procedure PrepareRadioButtonImageList;
procedure UpdateScrollBarBitmaps;

function cxTextRect(const R: TRect): TRect;

var
  cxIndicatorImages: TImageList;

implementation

{$R cxLookAndFeelPainters.res}

uses
  Messages,
{$IFDEF CLR}
  WinUtils,
{$ENDIF}
  Forms, SysUtils, cxControls, cxLookAndFeels;

const
  FilterDropDownButtonWidth = 15;

  SortingMarkAreaWidth = 16;
  FilterActiveButtonWidth = 13;
  FilterActiveButtonHeight = 13;
  FilterCloseButtonWidth = 16;
  FilterCloseButtonHeight = 14;

  ActiveFilterButtonArrowColor = clBlue;

type
  { TSystemPaletteChangedNotifier }
   
  TSystemPaletteChangedNotifier = class(TcxSystemPaletteChangedNotifier)
  protected
    procedure DoChanged; override;
  end;

  { TcxRadioButtonImageList }

  TcxRadioButtonImageList = class
  private
    FButtonMask: TBitmap;
    FList: TImageList;
    function GetImageIndex(ALookAndFeelKind: TcxLookAndFeelKind;
      AButtonState: TcxButtonState;
      AChecked, AFocused, AIsDesigning: Boolean): Integer;
    function GetImageListIndexMapIndex(ALookAndFeelKind: TcxLookAndFeelKind;
      AButtonState: TcxButtonState;
      AChecked, AFocused, AIsDesigning: Boolean): Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Draw(ACanvas: TcxCanvas; X, Y: Integer; ABrushColor: TColor;
      ALookAndFeelKind: TcxLookAndFeelKind; AButtonState: TcxButtonState;
      AChecked, AFocused, AIsDesigning: Boolean);
    function GetSize: TSize;
    procedure Prepare;
    procedure Reset;
  end;
  
var
  FCheckButtonSize: TSize;
  FRadioButtonImageList: TcxRadioButtonImageList;
  FRadioButtonImageListIndexes: array of Integer;
  FSystemPaletteChangedNotifier: TSystemPaletteChangedNotifier;

  AutoHideBitmaps: array[Boolean] of TBitmap;
  StdScrollBitmaps: array[Boolean] of TBitmap;

function LookAndFeelStyleToLookAndFeelKind(
  ALookAndFeelStyle: TcxLookAndFeelStyle): TcxLookAndFeelKind;
begin
  case ALookAndFeelStyle of
    lfsFlat:
      Result := lfFlat;
    lfsStandard:
      Result := lfStandard;
    lfsUltraFlat:
      Result := lfUltraFlat;
    lfsOffice11:
      Result := lfOffice11;
    else
      Result := lfStandard;
  end;
end;

function MulDiv(nNumber, nNumerator, nDenominator: Integer): Integer;
begin
{$IFDEF VCL}
  Result := Windows.MulDiv(nNumber, nNumerator, nDenominator)
{$ELSE}
  try
    Result := Int64(nNumber) * nNumerator div nDenominator;
    if Abs(Int64(nNumber) * nNumerator mod nDenominator) >= Abs(nDenominator div 2) then
      if Result < 0 then
        Dec(Result)
      else
        Inc(Result);
  except
    Result := -1
  end
{$ENDIF}
end;

{ TSystemPaletteChangedNotifier }

procedure TSystemPaletteChangedNotifier.DoChanged;
begin
  if FRadioButtonImageList <> nil then
    FRadioButtonImageList.Reset;
end;

{ TcxCustomLookAndFeelPainter }

{$IFDEF CLR}
constructor TcxCustomLookAndFeelPainter.Create;
begin
  inherited Create;
end;
{$ENDIF}

class procedure TcxCustomLookAndFeelPainter.DrawButtonArrow(ACanvas: TcxCanvas;
  const R: TRect; AColor: TColor);
var
  P: array[0..2] of TPoint;

  procedure CalculatePoints;
  var
    ASize: TPoint;

    function _GetSize: TPoint;
    begin
      Result.X := (R.Right - R.Left) div 2;
      if not Odd(Result.X) then Inc(Result.X);
      Result.Y := Result.X div 2 + 1;
    end;

  begin
    with R do
    begin
      ASize := _GetSize;
      P[0] := Point((Left + Right - ASize.X) div 2, MulDiv(Top + Bottom - ASize.Y, 1, 2));
      P[1] := Point(P[0].X + ASize.X - 1, P[0].Y);
      P[2] := Point(P[0].X + ASize.X div 2, P[0].Y + ASize.Y - 1);
    end;
  end;

begin
  CalculatePoints;
  with ACanvas do
  begin
    Brush.Color := AColor;
    Pen.Color := AColor;
    Polygon(P);
  end;
end;

class procedure TcxCustomLookAndFeelPainter.DrawContent(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; AState: Integer; AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsFooter: Boolean = False);
const
  AlignmentsHorz: array[TAlignment] of Integer =
    (cxAlignLeft, cxAlignRight, cxAlignHCenter);
  AlignmentsVert: array[TcxAlignmentVert] of Integer =
    (cxAlignTop, cxAlignBottom, cxAlignVCenter);
  MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
  ShowEndEllipsises: array[Boolean] of Integer = (0, cxShowEndEllipsis);
begin
  with ACanvas do
  begin
    if not Assigned(AOnDrawBackground) or not AOnDrawBackground(ACanvas, ABounds) then
    begin
      SetBrushColor(ABkColor);
      FillRect(ABounds);
    end;
    if AText <> '' then
    begin
      Brush.Style := bsClear;
      Font := AFont;
      Font.Color := ATextColor;
      DrawText(AText, ATextAreaBounds, AlignmentsHorz[AAlignmentHorz] or
        AlignmentsVert[AAlignmentVert] or MultiLines[AMultiLine] or
        ShowEndEllipsises[AShowEndEllipsis]);
      Brush.Style := bsSolid;
    end;
  end;
end;

class procedure TcxCustomLookAndFeelPainter.DrawExpandButtonCross(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor);
var
  ASize, X, Y: Integer;
begin
  with R do
  begin
    ASize := Right - Left - 2 * 2;
    X := GetRangeCenter(Left, Right);
    Y := GetRangeCenter(Top, Bottom);
  end;
  ACanvas.Brush.Color := AColor;
  ACanvas.FillRect(Rect(X - ASize div 2, Y, X + ASize div 2 + 1, Y + 1));
  if not AExpanded then
    ACanvas.FillRect(Rect(X, Y - ASize div 2, X + 1, Y + ASize div 2 + 1));
end;

class procedure TcxCustomLookAndFeelPainter.DrawGroupExpandButtonMark(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AState: TcxButtonState);
var
  Size, X, MainY, I: Integer;

  procedure DrawOneMark(Y: Integer);
  var
    ASign, ADelta: Integer;
  begin
    if AExpanded then Inc(Y, Size);
    ASign := 2 * Ord(AExpanded) - 1;
    ADelta := Ord(Odd(I - MainY));
    if not AExpanded then
      ADelta := Ord(not Boolean(ADelta));
    ACanvas.MoveTo(X + ADelta, Y - ASign * ADelta);
    ACanvas.LineTo(X + Size, Y - ASign * Size);
    ACanvas.LineTo(X + 2 * Size + 1 - ADelta, Y + ASign * (1 - ADelta));
  end;

begin
  Size := 3;
  ACanvas.Pen.Color := ButtonSymbolColor(AState);
  with R do
  begin
    X := (Left + Right - (2 * Size + 1)) div 2;
    MainY := (Top + Bottom - 2 * (Size + 1)) div 2;
    for I := MainY to MainY + 4 - 1 do
      DrawOneMark(I + Ord(I >= MainY + 2) * (Size - 1));
  end;
end;

class procedure TcxCustomLookAndFeelPainter.DrawIndicatorImage(ACanvas: TcxCanvas;
  const R: TRect; AKind: TcxIndicatorKind);
var
  X, Y: Integer;
begin
  if AKind = ikNone then Exit;
  with cxIndicatorImages, R do
  begin
    X := (Left + Right - Width) div 2;
    Y := (Top + Bottom - Height) div 2;
  end;
  cxIndicatorImages.Draw(ACanvas.Canvas, X, Y, Ord(AKind) - 1);
end;

class procedure TcxCustomLookAndFeelPainter.DrawMonthHeaderArrows(
  ACanvas: TcxCanvas; const ABounds: TRect; AArrows: TcxHeaderArrows;
  ASideWidth: Integer; AColor: TColor);
var
  R: TRect;

  procedure InternalDrawArrow(LeftArrow: Boolean);
  var
    X, Sign, ArrowHeight: Integer;
    P: array[1..3] of TPoint;
  begin
    with R do
    begin
      ArrowHeight := (Bottom - Top) div 2;
      if not Odd(ArrowHeight) then Inc(ArrowHeight);
      if LeftArrow then X := Left
      else X := Right;
      Sign := 2 * Byte(LeftArrow) - 1;
      P[1] := Point(X + Sign * (ASideWidth - 1), (Top + Bottom - ArrowHeight) div 2 - 1);
      P[2] := Point(P[1].X, P[1].Y + ArrowHeight + 1);
      P[3] := Point(P[1].X - Sign * (ArrowHeight div 2 + 1), P[1].Y + ArrowHeight div 2 + 1);
      ACanvas.SetBrushColor(AColor);
      ACanvas.Pen.Color := AColor;
      ACanvas.Polygon(P);
    end;
  end;

begin
  R := ABounds;
  Inc(R.Top, BorderSize);
  InflateRect(R, 0, -1);
  if AArrows in [haLeft, haBoth] then
    InternalDrawArrow(True);
  if AArrows in [haRight, haBoth] then
    InternalDrawArrow(False);
end;

class procedure TcxCustomLookAndFeelPainter.DrawSortingArrow(ACanvas: TcxCanvas;
  const R: TRect; AColor1, AColor2: TColor; AAscendingSorting: Boolean);
var
  Sign, AWidth, AHeight, X, Y, ALeftSide, ARightSide: Integer;
begin
  Sign := 2 * Byte(AAscendingSorting) - 1;
  with SortingMarkSize do
  begin
    AWidth := X;
    AHeight := Y;
  end;

  X := (R.Left + R.Right) div 2;
  if not Odd(AWidth) then Dec(X);
  if AAscendingSorting then
    Y := (R.Top + R.Bottom - AHeight) div 2
  else
    Y := (R.Top + R.Bottom + AHeight) div 2 - 1;

  ALeftSide := AWidth div 2;
  if not Odd(AWidth) then Dec(ALeftSide);
  ARightSide := AWidth div 2;

  ACanvas.Pen.Color := AColor2;
  ACanvas.MoveTo(X + ARightSide, Y + Sign * (AHeight - 2{$IFDEF LINUX} + 1{$ENDIF}));
  ACanvas.LineTo(X + ARightSide - ALeftSide,
    Y{$IFDEF LINUX}{$IFNDEF KYLIX3} + Sign * Ord(Odd(AHeight)){$ENDIF}{$ENDIF});
{$IFDEF LINUX}
{$IFNDEF KYLIX3}
  ACanvas.MoveTo(X + ARightSide - ALeftSide, Y);
{$ENDIF}
{$ENDIF}
  ACanvas.LineTo(X + ARightSide,
    Y + Sign * (AHeight - 1{$IFDEF LINUX}{$IFNDEF KYLIX3} - Ord(Odd(AHeight)){$ENDIF}{$ENDIF}));
  if not AAscendingSorting then
    ACanvas.Pen.Color := AColor1;
{$IFDEF LINUX}
  ACanvas.MoveTo(X + ARightSide{$IFDEF KYLIX3} + 1{$ENDIF}, Y + Sign * (AHeight - 1));
{$ENDIF}
  ACanvas.LineTo(X - ALeftSide, Y + Sign * (AHeight - 1));
  if AAscendingSorting then
    ACanvas.Pen.Color := AColor1;
  ACanvas.LineTo(X,
    Y{$IFNDEF VCL} {$IFDEF KYLIX3}-{$ELSE}+{$ENDIF} Sign * Ord(Odd(AHeight)){$ENDIF});
{$IFNDEF VCL}
  ACanvas.MoveTo(X, Y);
{$ENDIF}
  ACanvas.LineTo(X - ALeftSide, Y + Sign * (AHeight - Ord(Odd(AWidth))
    {$IFNDEF VCL}- {$IFNDEF KYLIX3}2 * {$ENDIF}Ord(Odd(AHeight)){$ENDIF}));
end;

class function TcxCustomLookAndFeelPainter.FooterCellContentBounds(const ABounds: TRect): TRect;
begin
  Result := ABounds;
  InflateRect(Result, -FooterCellBorderSize, -FooterCellBorderSize);
end;

class function TcxCustomLookAndFeelPainter.FooterCellTextAreaBounds(const ABounds: TRect): TRect;
begin
  Result := FooterCellContentBounds(ABounds);
  InflateRect(Result, -cxTextOffset, -cxTextOffset);
end;

class function TcxCustomLookAndFeelPainter.GetArrowDirection(AHorizontal: Boolean;
  APart: TcxScrollBarPart): TcxArrowDirection;
const
  ArrowKind: array[Boolean, Boolean] of TcxArrowDirection =
   ((adUp, adDown), (adLeft, adRight));
begin
  Result := ArrowKind[AHorizontal, APart <> sbpLineUp];
end;

class function TcxCustomLookAndFeelPainter.LookAndFeelStyle: TcxLookAndFeelStyle;
begin
  Result := lfsStandard;
end;

class function TcxCustomLookAndFeelPainter.DefaultContentColor: TColor;
begin
  Result := clWindow;
end;

class function TcxCustomLookAndFeelPainter.DefaultContentTextColor: TColor;
begin
  Result := clWindowText;
end;

class function TcxCustomLookAndFeelPainter.DefaultSchedulerBackgroundColor: TColor;
begin
  Result := clWindow;
end;

class function TcxCustomLookAndFeelPainter.DefaultSchedulerTextColor: TColor;
begin
  Result := clWindowText;
end;

class function TcxCustomLookAndFeelPainter.DefaultDateNavigatorHeaderColor: TColor;
begin
  Result := clBtnFace;
end;

class function TcxCustomLookAndFeelPainter.DefaultDateNavigatorSelectionColor: TColor;
begin
  Result := clHighlight;
end;

class function TcxCustomLookAndFeelPainter.DefaultDateNavigatorSelectionTextColor: TColor;
begin
  Result := clHighlightText;
end;

class function TcxCustomLookAndFeelPainter.DefaultFilterBoxColor: TColor;
begin
  Result := clBtnShadow;
end;

class function TcxCustomLookAndFeelPainter.DefaultFilterBoxTextColor: TColor;
begin
  Result := clBtnHighlight;
end;

class function TcxCustomLookAndFeelPainter.DefaultFixedSeparatorColor: TColor;
begin
  Result := clBtnText;
end;

class function TcxCustomLookAndFeelPainter.DefaultFooterColor: TColor;
begin
  Result := clBtnFace;
end;

class function TcxCustomLookAndFeelPainter.DefaultFooterTextColor: TColor;
begin
  Result := clBtnText;
end;

class function TcxCustomLookAndFeelPainter.DefaultGridLineColor: TColor;
begin
  Result := {$IFDEF LINUX}clMid{$ELSE}clBtnShadow{$ENDIF};
end;

class function TcxCustomLookAndFeelPainter.DefaultGroupColor: TColor;
begin
  Result := clBtnFace;
end;

class function TcxCustomLookAndFeelPainter.DefaultGroupTextColor: TColor;
begin
  Result := clBtnText;
end;

class function TcxCustomLookAndFeelPainter.DefaultGroupByBoxColor: TColor;
begin
  Result := clBtnShadow;
end;

class function TcxCustomLookAndFeelPainter.DefaultGroupByBoxTextColor: TColor;
begin
  Result := clBtnFace;
end;

class function TcxCustomLookAndFeelPainter.DefaultHeaderColor: TColor;
begin
  Result := clBtnFace;
end;

class function TcxCustomLookAndFeelPainter.DefaultHeaderTextColor: TColor;
begin
  Result := clBtnText;
end;

class function TcxCustomLookAndFeelPainter.DefaultHeaderBackgroundColor: TColor;
begin
  Result := clBtnShadow;
end;

class function TcxCustomLookAndFeelPainter.DefaultHeaderBackgroundTextColor: TColor;
begin
  Result := clBtnFace;
end;

class function TcxCustomLookAndFeelPainter.DefaultHyperlinkTextColor: TColor;
begin
  Result := clBlue;
end;

class function TcxCustomLookAndFeelPainter.DefaultInactiveColor: TColor;
begin
  Result := clBtnFace;
end;

class function TcxCustomLookAndFeelPainter.DefaultInactiveTextColor: TColor;
begin
  Result := clBtnText;
end;

class function TcxCustomLookAndFeelPainter.DefaultPreviewTextColor: TColor;
begin
  Result := clBlue;
end;

class function TcxCustomLookAndFeelPainter.DefaultRecordSeparatorColor: TColor;
begin
  Result := DefaultGridLineColor;
end;

class function TcxCustomLookAndFeelPainter.DefaultSchedulerBorderColor: TColor;
begin
  Result := clRed;//todo:
end;

class function TcxCustomLookAndFeelPainter.DefaultSchedulerControlColor: TColor;
begin
  Result := clBtnFace;
end;

class function TcxCustomLookAndFeelPainter.DefaultSchedulerViewContentColor: TColor;
begin
  Result := $D5FFFF;
end;

class function TcxCustomLookAndFeelPainter.DefaultSchedulerViewTextColor: TColor;
begin
  Result := clWindowText;
end;

class function TcxCustomLookAndFeelPainter.DefaultSelectionColor: TColor;
begin
  Result := clHighlight;
end;

class function TcxCustomLookAndFeelPainter.DefaultSelectionTextColor: TColor;
begin
  Result := clHighlightText;
end;

class function TcxCustomLookAndFeelPainter.DefaultSeparatorColor: TColor;
begin
  Result := clBtnFace;
end;

class function TcxCustomLookAndFeelPainter.DefaultTabColor: TColor;
begin
  Result := clBtnFace;
end;

class function TcxCustomLookAndFeelPainter.DefaultTabTextColor: TColor;
begin
  Result := clBtnText;
end;

class function TcxCustomLookAndFeelPainter.DefaultTabsBackgroundColor: TColor;
begin
  Result := clBtnFace;
end;

class function TcxCustomLookAndFeelPainter.DefaultTimeGridMajorScaleColor: TColor;
begin
  Result := clWhite;
end;

class function TcxCustomLookAndFeelPainter.DefaultTimeGridMajorScaleTextColor: TColor;
begin
  Result := clBlack;
end;

class function TcxCustomLookAndFeelPainter.DefaultTimeGridMinorScaleColor: TColor;
begin
  Result := clBtnFace;
end;

class function TcxCustomLookAndFeelPainter.DefaultTimeGridMinorScaleTextColor: TColor;
begin
  Result := clBtnText;
end;

class function TcxCustomLookAndFeelPainter.DefaultTimeGridSelectionBarColor: TColor;
begin
  Result := clWhite;
end;

class function TcxCustomLookAndFeelPainter.DefaultChartDiagramValueBorderColor: TColor;
begin
  Result := clBlack;
end;

class function TcxCustomLookAndFeelPainter.DefaultChartDiagramValueCaptionTextColor: TColor;
begin
  Result := clBlack;
end;

class function TcxCustomLookAndFeelPainter.DefaultChartHistogramAxisColor: TColor;
begin
  Result := clBlack;
end;

class function TcxCustomLookAndFeelPainter.DefaultChartHistogramGridLineColor: TColor;
begin
  Result := clcxLightGray;
end;

class function TcxCustomLookAndFeelPainter.DefaultChartHistogramPlotColor: TColor;
begin
  Result := clWhite;
end;

class function TcxCustomLookAndFeelPainter.DefaultChartPieDiagramSeriesSiteBorderColor: TColor;
begin
  Result := clBtnShadow;
end;

class function TcxCustomLookAndFeelPainter.DefaultChartPieDiagramSeriesSiteCaptionColor: TColor;
begin
  Result := clSkyBlue;
end;

class function TcxCustomLookAndFeelPainter.DefaultChartPieDiagramSeriesSiteCaptionTextColor: TColor;
begin
  Result := clNavy;
end;

class function TcxCustomLookAndFeelPainter.DefaultChartToolBoxDataLevelInfoBorderColor: TColor;
begin
  Result := clBtnShadow;
end;

class function TcxCustomLookAndFeelPainter.DefaultChartToolBoxItemSeparatorColor: TColor;
begin
  Result := clBtnShadow;
end;

class procedure TcxCustomLookAndFeelPainter.CalculateArrowPoints(R: TRect;
  var P: TcxArrowPoints; AArrowDirection: TcxArrowDirection; AProportional: Boolean);
var
  ASize: TPoint;
  ADelta: Integer;

  function _GetSize: TPoint;
  begin
    if AArrowDirection in [adUp, adDown] then
    begin
      Result.X := (R.Right - R.Left - 1) div 2;
      if not Odd(Result.X) then Inc(Result.X);
      Result.Y := Result.X div 2 + 1;
    end
    else
    begin
      Result.Y := (R.Bottom - R.Top - 1) div 2;
      if not Odd(Result.Y) then Inc(Result.Y);
      Result.X := Result.Y div 2 + 1;
    end;
  end;

begin
  with R do
  begin
    if AProportional then
    begin
      ADelta := (Right - Left) - (Bottom - Top);
      if ADelta > 0 then
        InflateRect(R, -ADelta div 2, 0)
      else
        InflateRect(R, 0, ADelta div 2);
    end;
    ASize := _GetSize;
    case AArrowDirection of
      adUp:
        begin
          P[0] := Point((Left + Right - 1) div 2, MulDiv(Top + Bottom - ASize.Y, 1, 2){$IFDEF VCL}{ - 1}{$ENDIF});
          P[1] := Point((Left + Right - ASize.X) div 2, P[0].Y + ASize.Y - 1);
          P[2] := Point(P[1].X + ASize.X - 1, P[1].Y);
        end;
      adDown:
        begin
          P[0] := Point((Left + Right - ASize.X) div 2, MulDiv(Top + Bottom - ASize.Y, 1, 2));
          P[1] := Point(P[0].X + ASize.X - 1, P[0].Y);
          P[2] := Point((Left + Right - 1) div 2, P[0].Y + ASize.Y - 1);
        end;
      adLeft:
        begin
          P[0] := Point((Left + Right - ASize.X) div 2, (Top + Bottom (*{$IFNDEF VCL}- 1{$ENDIF}*)) div 2);
          P[1] := Point(P[0].X + ASize.X - 1, MulDiv(Top + Bottom - ASize.Y, 1, 2));
          P[2] := Point(P[1].X, P[1].Y + ASize.Y - 1);
        end;
      adRight:
        begin
          P[0] := Point((Left + Right - ASize.X) div 2, MulDiv(Top + Bottom - ASize.Y, 1, 2));
          P[1] := Point(P[0].X + ASize.X - 1, (Top + Bottom (*{$IFNDEF VCL}- 1{$ENDIF}*)) div 2);
          P[2] := Point(P[0].X, P[0].Y + ASize.Y - 1);
        end;
    end;
  end;
end;

class procedure TcxCustomLookAndFeelPainter.DrawArrow(ACanvas: TcxCanvas; const R: TRect; AArrowDirection: TcxArrowDirection; AColor: TColor);
var
  P: TcxArrowPoints;
begin
  CalculateArrowPoints(R, P, AArrowDirection, True);
  with ACanvas do
  begin
    Brush.Style := bsSolid;
    SetBrushColor(AColor);
    Pen.Color := AColor;
    Polygon(P);
  end;
end;

class procedure TcxCustomLookAndFeelPainter.DrawArrow(ACanvas: TcxCanvas; const R: TRect;
  AState: TcxButtonState; AArrowDirection: TcxArrowDirection; ADrawBorder: Boolean = True);
var
  P: TcxArrowPoints;
begin
  CalculateArrowPoints(R, P, AArrowDirection, False);
  with ACanvas do
  begin
    Brush.Style := bsSolid;
    if ADrawBorder then
      DrawArrowBorder(ACanvas, R, AState)
    else
    begin
      SetBrushColor(ButtonColor(AState));
      FillRect(R);
    end;
    SetBrushColor(ButtonSymbolColor(AState));
    Pen.Color := Brush.Color;
    Polygon(P);
  end;
end;

class procedure TcxCustomLookAndFeelPainter.DrawArrowBorder(ACanvas: TcxCanvas;
  const R: TRect; AState: TcxButtonState);
begin
  with ACanvas do
  begin
    Brush.Color := ButtonColor(AState);
    Brush.Style := bsSolid;
    FillRect(R);
  end;
  DrawButtonBorder(ACanvas, R, AState);
end;

class procedure TcxCustomLookAndFeelPainter.DrawScrollBarArrow(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AArrowDirection: TcxArrowDirection);
var
  P: TcxArrowPoints;

  procedure OffsetPoints(ADelta: Integer);
  var
    I: Integer;
  begin
    for I := 0 to 2 do
    begin
      Inc(P[I].X, ADelta);
      Inc(P[I].Y, ADelta);
    end;
  end;

begin
  if AState = cxbsPressed then
    OffsetRect(R, ButtonTextShift, ButtonTextShift);
  CalculateArrowPoints(R, P, AArrowDirection, True);
  with ACanvas do
  begin
    Brush.Style := bsSolid;
    if AState <> cxbsDisabled then
      Brush.Color := ButtonSymbolColor(AState)
    else
    begin
      OffsetPoints(1);
      Brush.Color := clBtnHighlight;
      Pen.Color := Brush.Color;
      Polygon(P);
    {$IFDEF KYLIX3}
      if AArrowDirection in [adUp, adLeft] then
        ACanvas.Canvas.Pixels[P[2].X, P[2].Y] := Pen.Color;
    {$ENDIF}
      OffsetPoints(-1);
      Brush.Color := clBtnShadow;
    end;
    Pen.Color := Brush.Color;
    Polygon(P);
  {$IFDEF KYLIX3}
    if AArrowDirection in [adUp, adLeft] then
      ACanvas.Canvas.Pixels[P[2].X, P[2].Y] := Pen.Color;
  {$ENDIF}
  end;
end;

class function TcxCustomLookAndFeelPainter.BorderSize: Integer;
begin
  Result := 0;
end;

class procedure TcxCustomLookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
begin
end;

class function TcxCustomLookAndFeelPainter.AdjustGroupButtonDisplayRect(
  const R: TRect; AButtonCount, AButtonIndex: Integer): TRect;
begin
  Result := R;
end;

class function TcxCustomLookAndFeelPainter.ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer;
begin
  Result := 0;
end;

class function TcxCustomLookAndFeelPainter.ButtonColor(AState: TcxButtonState): TColor;
begin
  Result := clBtnFace;
end;

class function TcxCustomLookAndFeelPainter.ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect;
begin
  Result := R;
  InflateRect(Result, -4, -4);
  if IsRectEmpty(Result) then
    Result := R;
end;

class function TcxCustomLookAndFeelPainter.ButtonGroupBorderSizes(AButtonCount,
  AButtonIndex: Integer): TRect;
var
  AButtonBorderWidth: Integer;
begin
  AButtonBorderWidth := ButtonBorderSize;
  Result := Rect(AButtonBorderWidth, AButtonBorderWidth, AButtonBorderWidth,
    AButtonBorderWidth);
end;

class function TcxCustomLookAndFeelPainter.ButtonTextOffset: Integer;
begin
  Result := 0;
end;

class function TcxCustomLookAndFeelPainter.ButtonTextShift: Integer;
begin
  Result := 0;
end;

class function TcxCustomLookAndFeelPainter.ButtonSymbolColor(
  AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor;
begin
  if AState = cxbsDisabled then
    Result := clBtnShadow
  else
    if ADefaultColor = clDefault then
      Result := clBtnText
    else
      Result := ADefaultColor;
end;

class function TcxCustomLookAndFeelPainter.ButtonSymbolState(AState: TcxButtonState): TcxButtonState;
begin
  Result := AState;
end;

class procedure TcxCustomLookAndFeelPainter.DrawButton(ACanvas: TcxCanvas;
  R: TRect; const ACaption: string; AState: TcxButtonState; ADrawBorder: Boolean = True;
  AColor: TColor = clDefault; ATextColor: TColor = clDefault);
begin
  with ACanvas do
  begin
    if ADrawBorder then
    begin
      DrawButtonBorder(ACanvas, R, AState);
      InflateRect(R, -ButtonBorderSize(AState), -ButtonBorderSize(AState));
    end;
    if AColor = clDefault then
      Brush.Color := ButtonColor(AState)
    else
      Brush.Color := AColor;
    FillRect(R);
    if ATextColor = clDefault then
      Font.Color := ButtonSymbolColor(AState)
    else
      Font.Color := ATextColor;
    Brush.Style := bsClear;
    with R do // for compatible with standard buttons
    begin
      Dec(Bottom, Ord(Odd(Bottom - Top)));
      if (Bottom - Top) < 18 then Dec(Top);
    end;
    if AState = cxbsPressed then
      OffsetRect(R, ButtonTextShift, ButtonTextShift);
    if Length(ACaption) > 0 then
      DrawText(ACaption, R, cxAlignHCenter or cxAlignVCenter or cxSingleLine or
        cxShowPrefix, AState <> cxbsDisabled);
    Brush.Style := bsSolid;
  end;
end;

class procedure TcxCustomLookAndFeelPainter.DrawButtonCross(ACanvas: TcxCanvas;
  const R: TRect; AColor: TColor; AState: TcxButtonState);
var
  ASize: TPoint;

  function GetSize: TPoint;
  begin
    Result.X := FilterCloseButtonSize.X div 2;
    if not Odd(Result.X) then Dec(Result.X);
    Result.Y := Result.X;
  end;

  procedure DrawOneMark(ADelta: Integer);
  var
    P: TPoint;
    AFix: Integer;
  begin
    with R do
      P := Point((Left + Right - ASize.X) div 2 + ADelta, (Top + Bottom - ASize.Y) div 2);
    if AState = cxbsPressed then
    begin
      Inc(P.X);
      Inc(P.Y);
    end;
    AFix := 0;
    {$IFDEF WIN32}
    {$IFNDEF VCL}
    AFix := 1;  //Fix for CLX Windows
    {$ENDIF}
    {$ENDIF}
    with ACanvas, P do
    begin
      MoveTo(X, Y);
      LineTo(X + ASize.X - AFix, Y + ASize.Y - AFix);
      MoveTo(X, Y + ASize.Y - 1);
      LineTo(X + ASize.X - AFix, Y - 1 + AFix);
    end;
  end;

begin
  ASize := GetSize;
  ACanvas.Pen.Color := AColor;
  DrawOneMark(0);
  DrawOneMark(1);
end;

class procedure TcxCustomLookAndFeelPainter.DrawButtonInGroup(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AButtonCount, AButtonIndex: Integer;
  ABackgroundColor: TColor);
begin
  DrawButton(ACanvas, R, '', AState);
end;

class procedure TcxCustomLookAndFeelPainter.DrawButtonBorder(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState);
begin
end;

class procedure TcxCustomLookAndFeelPainter.DrawButtonGroupBorder(ACanvas: TcxCanvas;
  R: TRect; AInplace, ASelected: Boolean); 
begin
end;

class procedure TcxCustomLookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
begin
end;

class function TcxCustomLookAndFeelPainter.DrawExpandButtonFirst: Boolean;
begin
  Result := True; 
end;

class procedure TcxCustomLookAndFeelPainter.DrawGroupExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AState: TcxButtonState);
begin
  DrawButton(ACanvas, R, '', AState);
  DrawGroupExpandButtonMark(ACanvas, R, AExpanded, AState);
end;

class procedure TcxCustomLookAndFeelPainter.DrawSmallExpandButton(ACanvas: TcxCanvas;
  R: TRect; AExpanded: Boolean; ABorderColor: TColor; AColor: TColor = clDefault);
begin
  ACanvas.Brush.Color := ABorderColor;
  ACanvas.FrameRect(R);
  if AColor <> clDefault then
  begin
    InflateRect(R, -1, -1);
    ACanvas.Brush.Color := AColor;
    ACanvas.FillRect(R);
    InflateRect(R, 1, 1);
  end;
  DrawExpandButtonCross(ACanvas, R, AExpanded, clBtnText);
end;

class function TcxCustomLookAndFeelPainter.ExpandButtonSize: Integer;
begin
  Result := 0;
end;

class function TcxCustomLookAndFeelPainter.GroupExpandButtonSize: Integer;
begin
  Result := 15;
end;

class function TcxCustomLookAndFeelPainter.IsButtonHotTrack: Boolean;
begin
  Result := False;
end;

class function TcxCustomLookAndFeelPainter.IsPointOverGroupExpandButton(const R: TRect;
  const P: TPoint): Boolean;
begin
  Result := PtInRect(R, P);
end;

class function TcxCustomLookAndFeelPainter.SmallExpandButtonSize: Integer;
begin
  Result := 9;
end;

class function TcxCustomLookAndFeelPainter.CheckBorderSize: Integer;
begin
  Result := 2;
end;

class function TcxCustomLookAndFeelPainter.CheckButtonColor(AState: TcxButtonState): TColor;
const
  Colors: array[TcxButtonState] of TColor = (clWindow, clWindow, clWindow, clBtnFace, clBtnFace);
begin
  Result := Colors[AState];
end;

class function TcxCustomLookAndFeelPainter.CheckButtonSize: TSize;
begin
  Result := FCheckButtonSize;
end;

class procedure TcxCustomLookAndFeelPainter.DrawCheck(ACanvas: TcxCanvas; const R: TRect;
  AState: TcxButtonState; AChecked: Boolean; AColor: TColor);
var
  ASize: TPoint;

  function GetSize: TPoint;
  begin
    with R do
    begin
      Result.X := Right - Left - 2;
      Result.Y := Bottom - Top - 2 - 2;
    end;
  end;

  procedure DrawOneCheck(ADelta: Integer);
  var
    ARoot: TPoint;
    AFix: Integer;
  begin
    with R do
    begin
      ARoot.X := (Left + Right) div 2 - 1;
      ARoot.Y := (Top + Bottom + ASize.Y) div 2 - 2 + ADelta;
    end;
    AFix := {$IFDEF VCL}0{$ELSE}{$IFDEF KYLIX3}0{$ELSE}1{$ENDIF}{$ENDIF};
    with ACanvas do
    begin
      MoveTo(ARoot.X - (ASize.X div 2 - 1), ARoot.Y - ASize.Y div 2);
      LineTo(ARoot.X, ARoot.Y);
      LineTo(ARoot.X + ASize.X div 2 + 2 - AFix, ARoot.Y - ASize.Y + AFix);
    end;
  end;

begin
  ACanvas.Brush.Color := CheckButtonColor(AState);
  ACanvas.FillRect(R);
  if not AChecked then Exit;
  ASize := GetSize;
  ACanvas.Pen.Color := AColor;
  DrawOneCheck(0);
  DrawOneCheck(1);
  DrawOneCheck(2);
end;

class procedure TcxCustomLookAndFeelPainter.DrawCheckBorder(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState);
begin
end;

class procedure TcxCustomLookAndFeelPainter.DrawCheckButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AChecked: Boolean);
var
  AColor: TColor;
begin
  DrawCheckBorder(ACanvas, R, AState);
  InflateRect(R, -CheckBorderSize, -CheckBorderSize);
  if AState <> cxbsDisabled then
    AColor := clBtnText
  else
    AColor := clGrayText;
  DrawCheck(ACanvas, R, AState, AChecked, AColor);
end;

var
  FRadioButtonMaskSize: TSize;
  FRadioButtonSize: TSize;
  FRadioButtonRect: TRect;
  FRadioButtonCheckRect: TRect;
  FRadioButtonCheckSize: TSize;
  FRadioButtonPattern: array of array of Integer;

{$IFDEF VCL}
procedure CalculateRadioButtonSize;
var
  B: Windows.TBitmap;
  HB: HBITMAP;
  ABitmap: TBitmap;
  I, J: Integer;
begin
  HB := LoadBitmap(0, {$IFNDEF CLR}PChar{$ENDIF}(OBM_CHECKBOXES));
  try
    GetObject(HB, SizeOf(Windows.TBitmap), {$IFNDEF CLR}@{$ENDIF}B);
  finally
    DeleteObject(HB);
  end;
  FRadioButtonMaskSize.cx := B.bmWidth div 4;
  FRadioButtonMaskSize.cy := B.bmHeight div 3;
  ABitmap := TBitmap.Create;
  try
    ABitmap.Width := FRadioButtonMaskSize.cx;
    ABitmap.Height := FRadioButtonMaskSize.cy;
    ABitmap.Canvas.Brush.Color := 0;
    ABitmap.Canvas.FillRect(Rect(0, 0, FRadioButtonMaskSize.cx, FRadioButtonMaskSize.cy));
    DrawFrameControl(ABitmap.Canvas.Handle, Rect(0, 0, FRadioButtonMaskSize.cx,
      FRadioButtonMaskSize.cy), DFC_BUTTON, DFCS_BUTTONRADIOMASK + DFCS_FLAT);
    FRadioButtonSize.cX := 0;
    FRadioButtonSize.cY := 0;
    FRadioButtonRect.Left := -1;
    FRadioButtonRect.Top := -1;
    for J := 0 to FRadioButtonMaskSize.cx - 1 do
      for I := 0 to FRadioButtonMaskSize.cy - 1 do
        if ABitmap.Canvas.Pixels[J, I] = 0 then
        begin
          if FRadioButtonRect.Left = -1 then
            FRadioButtonRect.Left := J;
          {$IFNDEF CLR}
            Inc(FRadioButtonSize.cX);
          {$ELSE}
            Inc(FRadioButtonSize.Width);
          {$ENDIF}
          Break;
        end;
    for I := 0 to FRadioButtonMaskSize.cy - 1 do
      for J := 0 to FRadioButtonMaskSize.cx - 1 do
        if ABitmap.Canvas.Pixels[J, I] = 0 then
        begin
          if FRadioButtonRect.Top = -1 then
            FRadioButtonRect.Top := I;
          {$IFNDEF CLR}
            Inc(FRadioButtonSize.cY);
          {$ELSE}
            Inc(FRadioButtonSize.Height);
          {$ENDIF}
          Break;
        end;
    FRadioButtonRect.Right := FRadioButtonRect.Left + FRadioButtonSize.cx;
    FRadioButtonRect.Bottom := FRadioButtonRect.Top + FRadioButtonSize.cy;
    ABitmap.Canvas.Brush.Color := 0;
    ABitmap.Canvas.FillRect(Rect(0, 0, FRadioButtonMaskSize.cx, FRadioButtonMaskSize.cy));
    DrawFrameControl(ABitmap.Canvas.Handle, Rect(0, 0, FRadioButtonMaskSize.cx,
      FRadioButtonMaskSize.cy), DFC_BUTTON, DFCS_BUTTONRADIOIMAGE + DFCS_FLAT + DFCS_CHECKED);
    I := FRadioButtonRect.Top + (FRadioButtonSize.cy div 2) - 2;
    J := FRadioButtonRect.Left + (FRadioButtonSize.cx div 2) - 1;
    while ABitmap.Canvas.Pixels[J, I] = ColorToRGB(clWindowText) do
      Dec(I);
    Inc(I);
    FRadioButtonCheckRect.Top := I;
    repeat
      Inc(I);
    until ABitmap.Canvas.Pixels[J, I] <> ColorToRGB(clWindowText);
    FRadioButtonCheckRect.Bottom := I;
    FRadioButtonCheckSize.cy := FRadioButtonCheckRect.Bottom - FRadioButtonCheckRect.Top;

    I := FRadioButtonRect.Top + (FRadioButtonSize.cy div 2) - 1;
    J := FRadioButtonRect.Left + (FRadioButtonSize.cx div 2) - 2;
    while ABitmap.Canvas.Pixels[J, I] = ColorToRGB(clWindowText) do
      Dec(J);
    Inc(J);
    FRadioButtonCheckRect.Left := J;
    repeat
      Inc(J);
    until ABitmap.Canvas.Pixels[J, I] <> ColorToRGB(clWindowText);
    FRadioButtonCheckRect.Right := J;
    FRadioButtonCheckSize.cx := FRadioButtonCheckRect.Right - FRadioButtonCheckRect.Left;
  finally
    ABitmap.Free;
  end;
end;
{$ELSE}
procedure CalculateRadioButtonSize;
begin
  FRadioButtonMaskSize := Size(13, 13);
  FRadioButtonSize := Size(12, 12);
  FRadioButtonRect := Rect(0, 0, 12, 12);
  FRadioButtonCheckSize := Size(4, 4);
  FRadioButtonCheckRect := Rect(4, 4, 8, 8);
  (*QStyle_exclusiveIndicatorSize(QApplication_style, @FRadioButtonMaskSize);
  FRadioButtonSize := FRadioButtonMaskSize;
  FRadioButtonCheckSize.cx := FRadioButtonSize.cx - 4;
  FRadioButtonCheckSize.cy := FRadioButtonSize.cy - 4;
  FRadioButtonCheckRect := Rect(4, 4, 4 + FRadioButtonCheckSize.cx, 4 +
    FRadioButtonCheckSize.cy);*)
end;
{$ENDIF}

const
//  FilledRadioButtonListSize = 48;
  cxPixelColorMask = $FFFFFF;

procedure InternalRoundRect(ACanvas: TCanvas; const R: TRect);
begin
  with ACanvas, R do
{$IFDEF VCL}
    RoundRect(Left, Top, Right, Bottom, Right - Left - 1, Bottom - Top - 1);
{$ELSE}
  {$IFDEF WIN32}
    RoundRect(Left, Top, Right, Bottom, 99, 99);
  {$ENDIF}
  {$IFDEF LINUX}
    Ellipse(R);
  {$ENDIF}
{$ENDIF}
end;

procedure PrepareRadioButtonPattern;

  procedure PrepareOuterCircle;
  var
    ABitmap: TBitmap;
    I, J: Integer;
  begin
    ABitmap := TBitmap.Create;
    try
      ABitmap.Width := FRadioButtonSize.cx;
      ABitmap.Height := FRadioButtonSize.cy;
      ABitmap.PixelFormat := pf32bit;
      with ABitmap.Canvas do
      begin
        Brush.Color := clWhite;
        FillRect(Rect(0, 0, FRadioButtonSize.cx, FRadioButtonSize.cy));
        Pen.Color := clBlack;
        with FRadioButtonSize do
          InternalRoundRect(ABitmap.Canvas, Rect(0, 0, cx, cy));
      end;
      SetLength(FRadioButtonPattern, FRadioButtonSize.cy, FRadioButtonSize.cx);
      for I := 0 to FRadioButtonSize.cy - 1 do
      begin
        for J := 0 to FRadioButtonSize.cx - 1 do
        begin
          if ABitmap.Canvas.Pixels[J, I] and cxPixelColorMask <> 0 then
            FRadioButtonPattern[I, J] := 0
          else
            if (FRadioButtonSize.cy - 1) * (FRadioButtonSize.cx - 1 - J) < I * (FRadioButtonSize.cx - 1) then
              FRadioButtonPattern[I, J] := 2
            else
              FRadioButtonPattern[I, J] := 1;
        end;
      end;
    finally
      ABitmap.Free;
    end;
  end;

  procedure PrepareInnerCircle;
  var
    I, I1, J, J1: Integer;
    AFirstColumn, ALastColumn, AFirstRow, ALastRow: Integer;

    procedure FillPoint;
    var
      ASign: Integer;
    begin
      ASign := (FRadioButtonSize.cy - 1) * (FRadioButtonSize.cx - 1 - J) - I * (FRadioButtonSize.cx - 1);
      if ASign = 0 then
        if J <= FRadioButtonSize.cx div 2 - 1 then
          FRadioButtonPattern[I, J] := 3
        else
          FRadioButtonPattern[I, J] := 4
      else
        if ASign < 0 then
          FRadioButtonPattern[I, J] := 4
        else
          FRadioButtonPattern[I, J] := 3;
    end;

  begin
    AFirstRow := 1;
    ALastRow := FRadioButtonSize.cy - 2;
    J1 := FRadioButtonSize.cx div 2 - 1;

    for I := AFirstRow to ALastRow do
    begin
      J := J1;
      while FRadioButtonPattern[I, J] = 0 do
      begin
        FRadioButtonPattern[I, J] := 5;
        Dec(J);
      end;
      J := J1 + 1;
      while FRadioButtonPattern[I, J] = 0 do
      begin
        FRadioButtonPattern[I, J] := 5;
        Inc(J);
      end;
    end;

    for I := AFirstRow to ALastRow do
    begin
      J := J1;
      while not(FRadioButtonPattern[I, J] in [1, 2]) do
      begin
        if (I = AFirstRow) or (I = ALastRow) then
          FillPoint;
        Dec(J);
      end;
      Inc(J);
      FillPoint;
      J := J1 + 1;
      while not(FRadioButtonPattern[I, J] in [1, 2]) do
      begin
        if (I = AFirstRow) or (I = ALastRow) then
          FillPoint;
        Inc(J);
      end;
      Dec(J);
      FillPoint;
    end;

    AFirstColumn := 1;
    ALastColumn := FRadioButtonSize.cx - 2;
    I1 := FRadioButtonSize.cy div 2 - 1;
    for J := AFirstColumn to ALastColumn do
    begin
      I := I1;
      while not(FRadioButtonPattern[I, J] in [1, 2]) do
      begin
        if (J = AFirstColumn) or (J = ALastColumn) then
          FillPoint;
        Dec(I);
      end;
      Inc(I);
      FillPoint;
      I := I1 + 1;
      while not(FRadioButtonPattern[I, J] in [1, 2]) do
      begin
        if (J = AFirstColumn) or (J = ALastColumn) then
          FillPoint;
        Inc(I);
      end;
      Dec(I);
      FillPoint;
    end;
  end;

  procedure PrepareCheck;
  var
    ABitmap: TBitmap;
    I, J: Integer;
    R: TRect;
  begin
    ABitmap := TBitmap.Create;
    try
      ABitmap.Width := FRadioButtonSize.cx;
      ABitmap.Height := FRadioButtonSize.cy;
      ABitmap.PixelFormat := pf32Bit;
      with ABitmap.Canvas do
      begin
        Brush.Color := clWhite;
        FillRect(Rect(0, 0, FRadioButtonSize.cx, FRadioButtonSize.cy));
        Pen.Color := clBlack;
        Brush.Color := clBlack;
        R := FRadioButtonCheckRect;
        OffsetRect(R, -FRadioButtonRect.Left, -FRadioButtonRect.Top);
        InternalRoundRect(ABitmap.Canvas, R);
        for I := 0 to FRadioButtonSize.cy - 1 do
        begin
          for J := 0 to FRadioButtonSize.cx - 1 do
          begin
            if ABitmap.Canvas.Pixels[J, I] and cxPixelColorMask = 0 then
              FRadioButtonPattern[I, J] := 6;
          end;
        end;
      end;
    finally
      ABitmap.Free;
    end;
  end;

begin
  PrepareOuterCircle;
  PrepareInnerCircle;
  PrepareCheck;
end;

constructor TcxRadioButtonImageList.Create;

  procedure PrepareButtonMask;
  var
    R: TRect;
  begin
    FButtonMask := TBitmap.Create;
    FButtonMask.Monochrome := True;
    FButtonMask.Width := FRadioButtonSize.cx;
    FButtonMask.Height := FRadioButtonSize.cy;

    with FButtonMask.Canvas do
    begin
      Brush.Color := clWhite;
      R := Rect(0, 0, FRadioButtonSize.cx, FRadioButtonSize.cy);
      FillRect(R);
      Brush.Color := clBlack;
      Pen.Color := clBlack;
      InternalRoundRect(FButtonMask.Canvas, R);
    end;
  end;

begin
  inherited Create;
  CalculateRadioButtonSize;
  FList := TImageList.Create(nil);
  with FList do
  begin
    Width := FRadioButtonSize.cx;
    Height := FRadioButtonSize.cy;
    Masked := True;
{$IFDEF VCL}
    ImageType := itImage;
{$ENDIF}
  end;
  PrepareButtonMask;
  PrepareRadioButtonPattern;
end;

destructor TcxRadioButtonImageList.Destroy;
begin
  FreeAndNil(FList);
  FreeAndNil(FButtonMask);
  inherited Destroy;
end;

procedure TcxRadioButtonImageList.Draw(ACanvas: TcxCanvas; X, Y: Integer;
  ABrushColor: TColor; ALookAndFeelKind: TcxLookAndFeelKind;
  AButtonState: TcxButtonState; AChecked, AFocused, AIsDesigning: Boolean);

  procedure DrawGlyph(ACanvas: TcxCanvas; AImageList: TCustomImageList;
    AImageIndex: {$IFDEF DELPHI5}TImageIndex{$ELSE}Integer{$ENDIF};
    const AGlyphRect: TRect; ABrushColor: TColor; AEnabled: Boolean;
    ABackgroundBitmap: TBitmap = nil);
  var
    ABitmap: TBitmap;
    ABrush: HBRUSH;
  begin
    ABitmap := nil;
    try
      if ABackgroundBitmap = nil then
      begin
        ABitmap := TBitmap.Create;
        ABitmap.Width := AImageList.Width;
        ABitmap.Height := AImageList.Height;
        ABrush := CreateSolidBrush(ColorToRGB(ABrushColor));
        Windows.FillRect(ABitmap.Canvas.Handle, Rect(0, 0, ABitmap.Width, ABitmap.Height), ABrush);
        DeleteObject(ABrush);
      end;
      if ABackgroundBitmap <> nil then
      begin
        AImageList.Draw(ABackgroundBitmap.Canvas, 0, 0, AImageIndex{$IFNDEF VCL}, itImage{$ENDIF}, AEnabled); // ??? itMask TODO
        ACanvas.Draw(AGlyphRect.Left, AGlyphRect.Top, ABackgroundBitmap);
      end else
      begin
        AImageList.Draw(ABitmap.Canvas, 0, 0, AImageIndex{$IFNDEF VCL}, itImage{$ENDIF}, AEnabled); // ??? itMask TODO
        ACanvas.Draw(AGlyphRect.Left, AGlyphRect.Top, ABitmap);
      end;
    finally
      if ABitmap <> nil then
        ABitmap.Free;
    end;
  end;

var
  AImageIndex: Integer;
begin
  AImageIndex := GetImageIndex(ALookAndFeelKind, AButtonState, AChecked,
    AFocused, AIsDesigning);
  if ABrushColor = clDefault then
    FList.Draw(ACanvas.Canvas, X, Y, AImageIndex)
  else
    DrawGlyph(ACanvas, FList, AImageIndex, Rect(X, Y, X + FList.Width,
      Y + FList.Height), ABrushColor, True);
end;

function TcxRadioButtonImageList.GetSize: TSize;
begin
  Result := Size(FList.Width, FList.Height);
end;

procedure TcxRadioButtonImageList.Prepare;
var
  AColorMap: array[0 .. 6] of TColor;

  function GetRadioButtonBodyColor(ALookAndFeelKind: TcxLookAndFeelKind; AButtonState: TcxButtonState): TColor;
  begin
    // TODO: to method
    if ALookAndFeelKind = lfOffice11 then
    begin
      if AButtonState = cxbsNormal then
        Result := clWindow
      else
        Result := TcxOffice11LookAndFeelPainter.ButtonColor(AButtonState);
    end
    else
      if AButtonState <> cxbsDisabled then
      begin
        if ALookAndFeelKind = lfUltraFlat then
        begin
          Result := clBtnFace;
          case AButtonState of
            cxbsHot:
              Result := GetLightSelColor;
            cxbsNormal:
              Result := clWindow{clBtnFace};
            cxbsPressed:
              Result := GetLightDownedSelColor;
          end;
        end
        else
          if AButtonState = cxbsPressed then
            Result := clBtnFace
          else
            Result := clWindow;
      end
      else
        Result := clBtnFace;
  end;

  procedure PrepareColorMap(ALookAndFeelKind: TcxLookAndFeelKind;
    AButtonState: TcxButtonState; AChecked, AFocused, AIsDesigning: Boolean);
  var
    I: Integer;
  begin
    AColorMap[0] := clBlack;
    AColorMap[5] := GetRadioButtonBodyColor(ALookAndFeelKind, AButtonState);
    case ALookAndFeelKind of
      lfStandard:
        begin
          AColorMap[1] := clBtnShadow;
          AColorMap[2] := clBtnHighlight;
          AColorMap[3] := {$IFDEF VCL}cl3DDkShadow{$ELSE}clShadow{$ENDIF};
          AColorMap[4] := cl3DLight;
        end;
      lfFlat:
        begin
          AColorMap[1] := clBtnShadow;
          AColorMap[2] := clBtnHighlight;
          AColorMap[3] := cl3DLight;
          AColorMap[4] := cl3DLight;
        end;
      lfUltraFlat:
        begin
          if AFocused or (AButtonState in [cxbsHot, cxbsPressed]) or (AIsDesigning and
              (AButtonState <> cxbsDisabled)) then
            AColorMap[1] := clHighlight
          else
            AColorMap[1] := clBtnShadow;
          AColorMap[2] := AColorMap[1];
          AColorMap[3] := AColorMap[5];
          AColorMap[4] := AColorMap[5];
        end;
      lfOffice11: // TODO: to method
        begin
          if AButtonState = cxbsDisabled then
            AColorMap[1] := dxOffice11TextDisabledColor
          else
            if AFocused or (AButtonState in [cxbsHot, cxbsPressed]) or AIsDesigning then
              AColorMap[1] := dxOffice11SelectedBorderColor
            else
              AColorMap[1] := clBtnText;//dxOffice11BarFloatingBorderColor1; //clBtnShadow;
          AColorMap[2] := AColorMap[1];
          AColorMap[3] := AColorMap[5];
          AColorMap[4] := AColorMap[5];
        end;
    end;

    if not AChecked then
      AColorMap[6] := AColorMap[5]
    else
      if AButtonState <> cxbsDisabled then
        AColorMap[6] := clWindowText
      else
        if ALookAndFeelKind = lfOffice11 then
          AColorMap[6] := dxOffice11TextDisabledColor
        else
          AColorMap[6] := clBtnShadow;

    for I := 0 to 6 do
    begin
      AColorMap[I] := ColorToRGB(AColorMap[I]);
    {$IFNDEF CLR}
      AColorMap[I] := RGB(GetBValue(AColorMap[I]), GetGValue(AColorMap[I]), GetRValue(AColorMap[I]));
    {$ENDIF}
    end;
  end;

var
  ABitmap: TBitmap;
  AButtonState: TcxButtonState;
  AChecked, AFocused, AIsDesigning: Boolean;
  AImageListIndexMapIndex, I, J: Integer;
  ALookAndFeelKind: TcxLookAndFeelKind;
{$IFNDEF CLR}
  ABitmapInfo: TBitmapInfo;
  RGBs: array of Integer;
{$ELSE}
  ABrush: HBRUSH;
{$ENDIF}
begin
  if FList.Count > 0 then exit;
  ABitmap := TBitmap.Create;
  try
    ABitmap.Width := FRadioButtonSize.cx;
    ABitmap.Height := FRadioButtonSize.cy;
  {$IFNDEF CLR}
    ABitmap.PixelFormat := pf32bit;
    ABitmap.HandleType := bmDDB;
    SetLength(RGBs, ABitmap.Width * ABitmap.Height);
    ABitmapInfo.bmiHeader.biSize := SizeOf(ABitmapInfo.bmiHeader);
    ABitmapInfo.bmiHeader.biWidth := ABitmap.Width;
    ABitmapInfo.bmiHeader.biHeight := -ABitmap.Height;
    ABitmapInfo.bmiHeader.biPlanes := 1;
    ABitmapInfo.bmiHeader.biBitCount := 32;
    ABitmapInfo.bmiHeader.biCompression := BI_RGB;
  {$ENDIF}

    for AFocused := False to True do
      for AIsDesigning := False to True do
        for ALookAndFeelKind := Low(TcxLookAndFeelKind) to High(TcxLookAndFeelKind) do
          for AChecked := False to True do
            for AButtonState := Succ(Low(TcxButtonState)) to High(TcxButtonState) do
            begin
              PrepareColorMap(ALookAndFeelKind, AButtonState, AChecked,
                AFocused, AIsDesigning);
              for I := 0 to FRadioButtonSize.cy - 1 do
                for J := 0 to FRadioButtonSize.cx - 1 do
                {$IFNDEF CLR}
                  RGBs[I * ABitmap.Width + J] := AColorMap[FRadioButtonPattern[I, J]];
                {$ELSE}
                  begin
                    ABrush := CreateSolidBrush(AColorMap[FRadioButtonPattern[I, J]]);
                    FillRect(ABitmap.Canvas.Handle, Rect(J, I, J + 1, I + 1), ABrush);
                    DeleteObject(ABrush);
                  end;
                {$ENDIF}
            {$IFNDEF CLR}
              SetDIBits(ABitmap.Canvas.Handle, ABitmap.Handle, 0, ABitmap.Height, RGBs, ABitmapInfo, DIB_RGB_COLORS);
            {$ENDIF}
              FList.Add(ABitmap, FButtonMask);
              AImageListIndexMapIndex := GetImageListIndexMapIndex(
                ALookAndFeelKind, AButtonState, AChecked, AFocused, AIsDesigning);
              if AImageListIndexMapIndex + 1 > Length(FRadioButtonImageListIndexes) then
                SetLength(FRadioButtonImageListIndexes, AImageListIndexMapIndex + 1);
              FRadioButtonImageListIndexes[AImageListIndexMapIndex] := FList.Count - 1;
            end;
  finally
    ABitmap.Free;
  end;
end;

procedure TcxRadioButtonImageList.Reset;
begin
  FList.Clear;
  Prepare;
end;

function TcxRadioButtonImageList.GetImageIndex(
  ALookAndFeelKind: TcxLookAndFeelKind; AButtonState: TcxButtonState;
  AChecked, AFocused, AIsDesigning: Boolean): Integer;
begin
  Result := FRadioButtonImageListIndexes[
    GetImageListIndexMapIndex(ALookAndFeelKind, AButtonState, AChecked,
    AFocused, AIsDesigning)];
end;

function TcxRadioButtonImageList.GetImageListIndexMapIndex(
  ALookAndFeelKind: TcxLookAndFeelKind; AButtonState: TcxButtonState;
  AChecked, AFocused, AIsDesigning: Boolean): Integer;
var
  AButtonStateIndex: Integer;
  ALookAndFeelKindCount: Integer;
begin
  AButtonStateIndex := Integer(AButtonState) - 1;
  ALookAndFeelKindCount := Integer(High(TcxLookAndFeelKind)) -
    Integer(Low(TcxLookAndFeelKind)) + 1;

  Result := (Integer(AFocused) * 2 * ALookAndFeelKindCount + Integer(AIsDesigning) * ALookAndFeelKindCount +
    Integer(ALookAndFeelKind)) * 8 + Integer(AChecked) * 4 + AButtonStateIndex;
end;

function RadioButtonImageList: TcxRadioButtonImageList;
begin
  if FRadioButtonImageList = nil then
  begin
    FRadioButtonImageList := TcxRadioButtonImageList.Create;
    FRadioButtonImageList.Prepare;
  end;
  Result := FRadioButtonImageList;
end;

class procedure TcxCustomLookAndFeelPainter.DrawRadioButton(ACanvas: TcxCanvas;
  X, Y: Integer; AButtonState: TcxButtonState; AChecked, AFocused: Boolean;
  ABrushColor: TColor; AIsDesigning: Boolean = False);
begin
  RadioButtonImageList.Draw(ACanvas, X, Y, ABrushColor,
    LookAndFeelStyleToLookAndFeelKind(LookAndFeelStyle), AButtonState, AChecked,
    AFocused, AIsDesigning);
end;

class function TcxCustomLookAndFeelPainter.RadioButtonSize: TSize;
begin
  Result := RadioButtonImageList.GetSize;
end;

class procedure TcxCustomLookAndFeelPainter.DrawHeader(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
  ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil;
  AIsLast: Boolean = False);
begin
  DrawHeaderBorder(ACanvas, ABounds, ANeighbors, ABorders);
  DrawContent(ACanvas, HeaderContentBounds(ABounds, ABorders), ATextAreaBounds, Integer(AState), 
    AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
    AFont, ATextColor, ABkColor, AOnDrawBackground);
end;

class procedure TcxCustomLookAndFeelPainter.DrawHeaderEx(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
  ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawHeader(ACanvas, ABounds, ATextAreaBounds, ANeighbors,
    ABorders, AState, AAlignmentHorz, AAlignmentVert, AMultiLine,
      AShowEndEllipsis, AText, AFont, ATextColor, ABkColor, AOnDrawBackground);
end;

class procedure TcxCustomLookAndFeelPainter.DrawHeaderBorder(ACanvas: TcxCanvas;
  const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders);
begin
end;

class procedure TcxCustomLookAndFeelPainter.DrawHeaderPressed(ACanvas: TcxCanvas;
  const ABounds: TRect);
begin
  ACanvas.InvertRect(ABounds);
end;

class procedure TcxCustomLookAndFeelPainter.DrawHeaderControlSection(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors;
  ABorders: TcxBorders; AState: TcxButtonState; AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor);
begin
  DrawHeaderControlSectionBorder(ACanvas, ABounds, ABorders, AState);
  DrawHeaderControlSectionContent(ACanvas,
    HeaderControlSectionContentBounds(ABounds, AState), ATextAreaBounds, AState,
    AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
    AFont, ATextColor, ABkColor);
end;

class procedure TcxCustomLookAndFeelPainter.DrawHeaderControlSectionBorder(
  ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AState: TcxButtonState);
begin
end;

class procedure TcxCustomLookAndFeelPainter.DrawHeaderControlSectionContent(
  ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
  AState: TcxButtonState; AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor);
begin
  ACanvas.SetBrushColor(ABkColor);
  ACanvas.FillRect(ABounds);
  DrawHeaderControlSectionText(ACanvas,
    HeaderControlSectionTextAreaBounds(ATextAreaBounds, AState), AState, AAlignmentHorz,
    AAlignmentVert, AMultiLine, AShowEndEllipsis, AText, AFont, ATextColor);
end;

class procedure TcxCustomLookAndFeelPainter.DrawHeaderControlSectionText(
  ACanvas: TcxCanvas; const ATextAreaBounds: TRect; AState: TcxButtonState;
  AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine,
  AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor: TColor);

  procedure DoDrawText(ATextRect: TRect; ATextColor: TColor);
  const
    AlignmentsHorz: array[TAlignment] of Integer =
      (cxAlignLeft, cxAlignRight, cxAlignHCenter);
    AlignmentsVert: array[TcxAlignmentVert] of Integer =
      (cxAlignTop, cxAlignBottom, cxAlignVCenter);
    MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
    ShowEndEllipsises: array[Boolean] of Integer = (0, cxShowEndEllipsis);
  begin
    with ACanvas do
    begin
      if AText <> '' then
      begin
        Font := AFont;
        Font.Color := ATextColor;
        DrawText(AText, ATextRect, AlignmentsHorz[AAlignmentHorz] or
          AlignmentsVert[AAlignmentVert] or MultiLines[AMultiLine] or
          ShowEndEllipsises[AShowEndEllipsis]);
      end;
    end;
  end;
var
  R: TRect;
  AColor: TColor;
begin
  R := ATextAreaBounds;
  ACanvas.Brush.Style := bsClear;
  AColor := ATextColor;
  if AState = cxbsDisabled then
  begin
    OffsetRect(R, 1, 1);
    DoDrawText(R, clBtnHighlight);
    OffsetRect(R, -1, -1);
    AColor := clBtnShadow;
  end;
  DoDrawText(R, AColor);
  ACanvas.Brush.Style := bsSolid;
end;

class procedure TcxCustomLookAndFeelPainter.DrawSortingMark(ACanvas: TcxCanvas;
  const R: TRect; AAscendingSorting: Boolean);
begin
end;
  
class function TcxCustomLookAndFeelPainter.HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders;
begin
  Result := cxBordersAll;
end;

class function TcxCustomLookAndFeelPainter.HeaderBorderSize: Integer;
begin
  Result := 0;
end;

class function TcxCustomLookAndFeelPainter.HeaderBounds(const ABounds: TRect;
  ANeighbors: TcxNeighbors; ABorders: TcxBorders = cxBordersAll): TRect;
begin
  Result := ABounds;
  ABorders := ABorders - HeaderBorders(ANeighbors);
  if bLeft in ABorders then
    Dec(Result.Left, HeaderBorderSize);
  if bTop in ABorders then
    Dec(Result.Top, HeaderBorderSize);
  if bRight in ABorders then
    Inc(Result.Right, HeaderBorderSize);
  if bBottom in ABorders then
    Inc(Result.Bottom, HeaderBorderSize);
end;

class function TcxCustomLookAndFeelPainter.HeaderContentBounds(const ABounds: TRect;
  ABorders: TcxBorders): TRect;
begin
  Result := ABounds;
  if bLeft in ABorders then
    Inc(Result.Left, HeaderBorderSize);
  if bTop in ABorders then
    Inc(Result.Top, HeaderBorderSize);
  if bRight in ABorders then
    Dec(Result.Right, HeaderBorderSize);
  if bBottom in ABorders then
    Dec(Result.Bottom, HeaderBorderSize);
end;

class function TcxCustomLookAndFeelPainter.HeaderDrawCellsFirst: Boolean;
begin
  Result := True;
end;

class function TcxCustomLookAndFeelPainter.HeaderHeight(AFontHeight: Integer): Integer;
begin
  Result := AFontHeight + 2 * (HeaderBorderSize + cxHeaderTextOffset);
end;

class function TcxCustomLookAndFeelPainter.HeaderControlSectionBorderSize(
  AState: TcxButtonState = cxbsNormal): Integer;
begin
  Result := 1;
end;

class function TcxCustomLookAndFeelPainter.HeaderControlSectionTextAreaBounds(
  ABounds: TRect; AState: TcxButtonState): TRect;
begin
  Result := ABounds;
  if AState = cxbsPressed then
    OffsetRect(Result, 1, 1);
end;

class function TcxCustomLookAndFeelPainter.HeaderControlSectionContentBounds(
  const ABounds: TRect; AState: TcxButtonState): TRect;
begin
  Result := ABounds;
  InflateRect(Result, -HeaderControlSectionBorderSize(AState),
    -HeaderControlSectionBorderSize(AState));
end;

class function TcxCustomLookAndFeelPainter.HeaderWidth(ACanvas: TcxCanvas;
  ABorders: TcxBorders; const AText: string; AFont: TFont): Integer;
begin
  ACanvas.Font := AFont;
  Result := ACanvas.TextWidth(AText) + 2 * cxHeaderTextOffset;
  if bLeft in ABorders then
    Inc(Result, HeaderBorderSize);
  if bRight in ABorders then
    Dec(Result, HeaderBorderSize);
end;

class function TcxCustomLookAndFeelPainter.IsHeaderHotTrack: Boolean;
begin
  Result := False;
end;

class function TcxCustomLookAndFeelPainter.SortingMarkAreaSize: TPoint;
begin
  Result := Point(SortingMarkAreaWidth, SortingMarkSize.Y);
end;

class function TcxCustomLookAndFeelPainter.SortingMarkSize: TPoint;
begin
  Result := Point(0, 0);
end;

class procedure TcxCustomLookAndFeelPainter.DrawFooterCell(ACanvas: TcxCanvas;
  const ABounds: TRect; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine: Boolean; const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawFooterCellBorder(ACanvas, ABounds);
  DrawContent(ACanvas, FooterCellContentBounds(ABounds), FooterCellTextAreaBounds(ABounds), 0, 
    AAlignmentHorz, AAlignmentVert, AMultiLine, False, AText, AFont, ATextColor, ABkColor,
    AOnDrawBackground, True);
end;

class function TcxCustomLookAndFeelPainter.FooterBorders: TcxBorders;
begin
  Result := cxBordersAll;
end;

class function TcxCustomLookAndFeelPainter.FooterBorderSize: Integer;
begin
  Result := 0;
end;

class function TcxCustomLookAndFeelPainter.FooterCellBorderSize: Integer;
begin
  Result := 0;
end;

class function TcxCustomLookAndFeelPainter.FooterCellOffset: Integer;
begin
  Result := 0;
end;

class function TcxCustomLookAndFeelPainter.FooterDrawCellsFirst: Boolean;
begin
  Result := True;
end;

class function TcxCustomLookAndFeelPainter.FooterSeparatorColor: TColor;
begin
  Result := clBtnShadow;
end;

class function TcxCustomLookAndFeelPainter.FooterSeparatorSize: Integer;
begin
  Result := 1;
end;

class procedure TcxCustomLookAndFeelPainter.DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect);
begin
end;

class procedure TcxCustomLookAndFeelPainter.DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect);
begin
end;

class procedure TcxCustomLookAndFeelPainter.DrawFooterSeparator(ACanvas: TcxCanvas;
  const R: TRect);
begin
  ACanvas.Brush.Color := FooterSeparatorColor;
  ACanvas.FillRect(R);
end;

class procedure TcxCustomLookAndFeelPainter.DrawFilterActivateButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AChecked: Boolean);
begin
  DrawCheckButton(ACanvas, R, AState, AChecked);
end;

class procedure TcxCustomLookAndFeelPainter.DrawFilterCloseButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState);
begin
  DrawButtonBorder(ACanvas, R, AState);
  InflateRect(R, -ButtonBorderSize, -ButtonBorderSize);
  ACanvas.Brush.Color := ButtonColor(AState);
  ACanvas.FillRect(R);
  DrawButtonCross(ACanvas, R, ButtonSymbolColor(AState), ButtonSymbolState(AState));
end;

class procedure TcxCustomLookAndFeelPainter.DrawFilterDropDownButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean);
begin
end;
  
class function TcxCustomLookAndFeelPainter.FilterActivateButtonSize: TPoint;
begin
  Result := Point(FilterActiveButtonWidth, FilterActiveButtonHeight);
end;

class function TcxCustomLookAndFeelPainter.FilterCloseButtonSize: TPoint;
begin
  Result := Point(FilterCloseButtonWidth, FilterCloseButtonHeight);
end;

class function TcxCustomLookAndFeelPainter.FilterDropDownButtonSize: TPoint;
begin
  Result := Point(FilterDropDownButtonWidth, 0);
end;

class function TcxCustomLookAndFeelPainter.PopupBorderStyle: TcxPopupBorderStyle;
begin
  Result := pbsUltraFlat;
end;

class procedure TcxCustomLookAndFeelPainter.DrawTab(ACanvas: TcxCanvas; R: TRect;
  ABorders: TcxBorders; const AText: string; AState: TcxButtonState;
  AVertical: Boolean; AFont: TFont; ATextColor, ABkColor: TColor; AShowPrefix: Boolean = False);
begin
end;

class procedure TcxCustomLookAndFeelPainter.DrawTabBorder(ACanvas: TcxCanvas;
  R: TRect; ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean);
begin
end;

class procedure TcxCustomLookAndFeelPainter.DrawTabsRoot(ACanvas: TcxCanvas;
  const R: TRect; ABorders: TcxBorders; AVertical: Boolean);
begin
end;

class function TcxCustomLookAndFeelPainter.IsDrawTabImplemented(AVertical: Boolean): Boolean;
begin
  Result := False;
end;

class function TcxCustomLookAndFeelPainter.IsTabHotTrack(AVertical: Boolean): Boolean;
begin
  Result := False;
end;

class function TcxCustomLookAndFeelPainter.TabBorderSize(AVertical: Boolean): Integer;
begin
  Result := 0;
end;

class procedure TcxCustomLookAndFeelPainter.DrawIndicatorItem(ACanvas: TcxCanvas;
  const R: TRect; AKind: TcxIndicatorKind; AColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawHeader(ACanvas, R, R, [], HeaderBorders([nTop, nBottom]), cxbsNormal,
    taLeftJustify, vaTop, False, False, '', nil, clNone, AColor, AOnDrawBackground);
  DrawIndicatorImage(ACanvas, R, AKind);
end;

class procedure TcxCustomLookAndFeelPainter.DrawIndicatorItemEx(ACanvas: TcxCanvas;
  const R: TRect; AKind: TcxIndicatorKind; AColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawHeaderEx(ACanvas, R, R, [], cxBordersAll, cxbsNormal,
    taLeftJustify, vaTop, False, False, '', nil, clNone, AColor, AOnDrawBackground);
  DrawIndicatorImage(ACanvas, R, AKind);
end;

class function TcxCustomLookAndFeelPainter.IndicatorDrawItemsFirst: Boolean;
begin
  Result := True;
end;

class procedure TcxCustomLookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas;
  AHorizontal: Boolean; R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);
begin
end;

class procedure TcxCustomLookAndFeelPainter.DrawMonthHeader(ACanvas: TcxCanvas;
  const ABounds: TRect; const AText: string; ANeighbors: TcxNeighbors;
  const AViewParams: TcxViewParams; AArrows: TcxHeaderArrows;
  ASideWidth: Integer; AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawHeader(ACanvas, ABounds, ABounds, ANeighbors, HeaderBorders(ANeighbors),
    cxbsNormal, taCenter, vaCenter, False, False, AText, AViewParams.Font,
    AViewParams.TextColor, AViewParams.Color, AOnDrawBackground);
  DrawMonthHeaderArrows(ACanvas, ABounds, AArrows, ASideWidth, clWindowText);
end;

class procedure TcxCustomLookAndFeelPainter.DrawSchedulerBorder(
  ACanvas: TcxCanvas; R: TRect);
begin
  DrawBorder(ACanvas, R);
end;

class procedure TcxCustomLookAndFeelPainter.DrawSchedulerNavigatorButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
begin
  DrawButton(ACanvas, R, '', AState);
end;

class procedure TcxCustomLookAndFeelPainter.DrawSchedulerSplitterBorder(
  ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams; AIsHorizontal: Boolean);
begin
end;

class function TcxCustomLookAndFeelPainter.ChartToolBoxDataLevelInfoBorderSize: Integer;
begin
  Result := 1;
end;

{ TcxStandardLookAndFeelPainter }

class function TcxStandardLookAndFeelPainter.LookAndFeelStyle: TcxLookAndFeelStyle;
begin
  Result := lfsStandard;
end;

class function TcxStandardLookAndFeelPainter.BorderSize: Integer;
begin
  Result := 2;
end;

class procedure TcxStandardLookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
begin
  ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnHighlight);
  InflateRect(R, -1, -1);
  ACanvas.DrawComplexFrame(R, cl3DDkShadow, cl3DLight);
end;

class function TcxStandardLookAndFeelPainter.ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer;
begin
  if AState = cxbsDefault then Result := 3 else Result := 2;
end;

class function TcxStandardLookAndFeelPainter.ButtonTextOffset: Integer;
begin
  Result := 1;
end;

class function TcxStandardLookAndFeelPainter.ButtonTextShift: Integer;
begin
  Result := 1;
end;

class procedure TcxStandardLookAndFeelPainter.DrawButtonBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);
begin
  if AState <> cxbsPressed then
  begin
    if AState = cxbsDefault then
    begin
      ACanvas.FrameRect(R, clBlack);
      InflateRect(R, -1, -1);
    end;
    ACanvas.DrawComplexFrame(R, clBtnHighlight, {$IFDEF VCL}cl3DDkShadow{$ELSE}clShadow{$ENDIF});
    InflateRect(R, -1, -1);
    ACanvas.DrawComplexFrame(R, cl3DLight, clBtnShadow);
  end
  else
  begin
    ACanvas.FrameRect(R, clBlack);
    InflateRect(R, -1, -1);
    ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnShadow);
  end;
end;

class procedure TcxStandardLookAndFeelPainter.DrawGroupExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AState: TcxButtonState);
begin
  TcxFlatLookAndFeelPainter.DrawGroupExpandButton(ACanvas, R, AExpanded, AState);
end;

class function TcxStandardLookAndFeelPainter.ExpandButtonSize: Integer;
begin
  Result := 12;
end;

class procedure TcxStandardLookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
var
  ARect: TRect;

  procedure DrawButton;
  begin
    ACanvas.DrawEdge(ARect, False, False, [bLeft, bTop]);
    ACanvas.DrawEdge(ARect, False, True, [bRight, bBottom]);
    InflateRect(ARect, -1, -1);
    ACanvas.DrawEdge(ARect, False, False, [bRight, bBottom]);
    Dec(ARect.Right);
    Dec(ARect.Bottom);
    if AColor = clDefault then
      ACanvas.Brush.Color := clBtnFace
    else
      ACanvas.Brush.Color := AColor;
    ACanvas.FillRect(ARect);
  end;

begin
  ARect := R;
  DrawButton;
  DrawExpandButtonCross(ACanvas, ARect, AExpanded, clBtnText);
  ACanvas.ExcludeClipRect(R);
end;

class function TcxStandardLookAndFeelPainter.IsButtonHotTrack: Boolean;
begin
  Result := False;
end;

class procedure TcxStandardLookAndFeelPainter.DrawCheckBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);
begin
  ACanvas.DrawEdge(R, True, False{True});
  InflateRect(R, -1, -1);
  ACanvas.DrawEdge(R, True, True{False});
end;

class procedure TcxStandardLookAndFeelPainter.DrawHeaderBorder(ACanvas: TcxCanvas;
  const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders);
var
  I: TcxNeighbor;
begin
  with ACanvas do
  begin
    DrawEdge(R, False, False);
    for I := Low(I) to High(I) do
      if I in ANeighbors then
        case I of
          nLeft:
            begin
              Pixels[R.Left, R.Top + 1] := clBtnFace;  //!!!
              Pixels[R.Left, R.Bottom - 2] := clBtnFace;  //!!!
            end;
          nRight:
            begin
              Pixels[R.Right - 1, R.Top] := clBtnHighlight;
              Pixels[R.Right - 1, R.Top + 1] := clBtnFace;  //!!!
              Pixels[R.Right - 1, R.Bottom - 2] := clBtnFace;  //!!!
            end;
          nTop:;
          nBottom:;
        end;
  end;
end;

class procedure TcxStandardLookAndFeelPainter.DrawHeaderControlSectionBorder(
  ACanvas: TcxCanvas; const R: TRect;
  ABorders: TcxBorders; AState: TcxButtonState);
var
  ARect: TRect;
begin
  ARect := R;
  if AState <> cxbsPressed then
  begin
    ACanvas.DrawComplexFrame(ARect, clBtnHighlight,
      {$IFDEF VCL}cl3DDkShadow{$ELSE}clShadow{$ENDIF}, ABorders);
    InflateRect(ARect, -1, -1);
    ACanvas.DrawComplexFrame(ARect, cl3DLight, clBtnShadow, ABorders);
  end
  else
    ACanvas.DrawComplexFrame(ARect, clBtnShadow, clBtnShadow, ABorders);
end;

class procedure TcxStandardLookAndFeelPainter.DrawSortingMark(ACanvas: TcxCanvas;
  const R: TRect; AAscendingSorting: Boolean);
begin
  DrawSortingArrow(ACanvas, R, clBtnShadow, clBtnHighlight, AAscendingSorting);
end;

class function TcxStandardLookAndFeelPainter.HeaderBorderSize: Integer;
begin
  Result := 1;
end;

class function TcxStandardLookAndFeelPainter.HeaderControlSectionBorderSize(
  AState: TcxButtonState = cxbsNormal): Integer;
begin
  if AState = cxbsPressed then
    Result := 1
  else
    Result := 2;
end;

class function TcxStandardLookAndFeelPainter.SortingMarkSize: TPoint;
begin
  Result := Point(8, 7);
end;

class function TcxStandardLookAndFeelPainter.FooterBorderSize: Integer;
begin
  Result := 1;
end;

class function TcxStandardLookAndFeelPainter.FooterCellBorderSize: Integer;
begin
  Result := 1;
end;

class function TcxStandardLookAndFeelPainter.FooterCellOffset: Integer;
begin
  Result := 1;
end;

class procedure TcxStandardLookAndFeelPainter.DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect);
begin
  ACanvas.DrawEdge(R, False, False);
end;

class procedure TcxStandardLookAndFeelPainter.DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect);
begin
  ACanvas.DrawEdge(R, True, True);
end;

class procedure TcxStandardLookAndFeelPainter.DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState; AIsFilterActive: Boolean);

  class function GetArrowColor: TColor;
  begin
    if AIsFilterActive then
      Result := ActiveFilterButtonArrowColor
    else
      Result := clBtnText;
  end;

begin
  if AState <> cxbsPressed then
    ACanvas.DrawEdge(R, False, False)
  else
    ACanvas.DrawEdge(R, True, True);
  InflateRect(R, -1, -1);
  ACanvas.Brush.Color := clBtnFace;
  ACanvas.FillRect(R);
  DrawButtonArrow(ACanvas, R, GetArrowColor);
end;

class procedure TcxStandardLookAndFeelPainter.DrawTabBorder(ACanvas: TcxCanvas; R: TRect;
  ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean);
const
  Colors: array[Boolean] of TColor = (clBtnShadow, clBtnHighlight);

  procedure ProcessVerticalTabBorder;
  begin
    case ABorder of
       bLeft:
         begin
           Inc(R.Top);
           if bTop in ABorders then Inc(R.Top);
           Dec(R.Bottom);
           if bBottom in ABorders then Dec(R.Bottom);
         end;
       bTop, bBottom:
         if bLeft in ABorders then Inc(R.Left);
    end;
    if ABorder = bLeft then
    begin
      ACanvas.Pixels[R.Left + 1, R.Top - 1] := Colors[True];
      ACanvas.Pixels[R.Left + 1, R.Bottom] := Colors[True];
    end;
    ACanvas.Brush.Color := Colors[ABorder <> bBottom];
  end;

  procedure ProcessHorizontalTabBorder;
  begin
    case ABorder of
       bTop:
         begin
           Inc(R.Left);
           Dec(R.Right);
         end;
       bLeft, bRight:
         begin
           if bTop in ABorders then Inc(R.Top, 2);
           if bBottom in ABorders then Dec(R.Bottom);
         end;
    end;
    if ABorder = bTop then
    begin
      ACanvas.Pixels[R.Left - 1, R.Top + 1] := Colors[True];
      ACanvas.Pixels[R.Right, R.Top + 1] := Colors[True];
    end;
    ACanvas.Brush.Color := Colors[ABorder <> bRight];
  end;

begin
  if AVertical then
    ProcessVerticalTabBorder
  else
    ProcessHorizontalTabBorder;
  ACanvas.FillRect(R);
end;

class procedure TcxStandardLookAndFeelPainter.DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect;
  ABorders: TcxBorders; AVertical: Boolean);
begin
  ACanvas.DrawEdge(R, False, False, ABorders);
end;

class function TcxStandardLookAndFeelPainter.TabBorderSize(AVertical: Boolean): Integer;
begin
  Result := 1;
end;

class procedure TcxStandardLookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas;
  AHorizontal: Boolean; R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);

{$IFDEF VCL}
  function GetArrowState: Integer;
  const
    States: array[Boolean, Boolean] of Integer = ((DFCS_SCROLLUP, DFCS_SCROLLDOWN),
     (DFCS_SCROLLLEFT, DFCS_SCROLLRIGHT));
  begin
    Result := States[AHorizontal, APart = sbpLineDown];
    if AState = cxbsDisabled then Result := Result or DFCS_INACTIVE
    else if AState = cxbsPressed then Result := Result or DFCS_FLAT;
  end;
{$ENDIF}

  procedure DrawScrollBarButtonBorder(R: TRect);
  begin
    if (AState <> cxbsPressed) or (APart = sbpThumbnail) then
    begin
      ACanvas.DrawComplexFrame(R, clBtnFace, cl3DDkShadow);
      InflateRect(R, -1, -1);
      ACanvas.DrawComplexFrame(R, clBtnHighlight, clBtnShadow);
    end
    else
    begin
      ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnShadow);
      InflateRect(R, -1, -1);
      ACanvas.DrawComplexFrame(R, clBtnFace, clBtnFace);
    end;
  end;

begin
  if IsRectEmpty(R) or ((APart = sbpThumbnail) and (AState = cxbsDisabled)) then Exit;
  if AState = cxbsHot then AState := cxbsNormal;
  case APart of
    sbpThumbnail, sbpLineUp, sbpLineDown:
      begin
      {$IFDEF VCL}
        // for compatibility with standard painting
        if APart <> sbpThumbnail then
        begin
          if AState = cxbsPressed then OffsetRect(R, 1, 1);
          DrawFrameControl(ACanvas.Canvas.Handle, R, DFC_SCROLL, GetArrowState);
          if AState = cxbsPressed then OffsetRect(R, -1, -1);
          DrawScrollBarButtonBorder(R);
        end
        else
        begin
          DrawScrollBarButtonBorder(R);
          InflateRect(R, -ButtonBorderSize, -ButtonBorderSize);
          ACanvas.Brush.Color := clBtnFace;
          ACanvas.FillRect(R);
        end;
      {$ELSE}
        ACanvas.Brush.Style := bsSolid;
        DrawScrollBarButtonBorder(R);
        InflateRect(R, -ButtonBorderSize, -ButtonBorderSize);
        ACanvas.Brush.Color := clBtnFace;
        ACanvas.FillRect(R);
        if APart <> sbpThumbnail then
          DrawScrollBarArrow(ACanvas, R, AState, GetArrowDirection(AHorizontal, APart));
      {$ENDIF}
      end;
    sbpPageUp, sbpPageDown:
      begin
        ACanvas.Brush.Bitmap := StdScrollBitmaps[AState = cxbsPressed];
        ACanvas.FillRect(R);
        ACanvas.Brush.Bitmap := nil;
        ACanvas.Brush.Style := bsSolid;
      end;
  end;
end;

class procedure TcxStandardLookAndFeelPainter.DrawMonthHeader(ACanvas: TcxCanvas;
  const ABounds: TRect; const AText: string; ANeighbors: TcxNeighbors;
  const AViewParams: TcxViewParams; AArrows: TcxHeaderArrows;
  ASideWidth: Integer; AOnDrawBackground: TcxDrawBackgroundEvent = nil);
const
  Borders: array[Boolean, Boolean] of TcxBorders =
  ((cxBordersAll, [bTop, bBottom, bLeft]), ([bTop, bBottom, bRight], [bTop, bBottom]));
var
  ABorders: TcxBorders;
  R: TRect;
begin
  ABorders := Borders[nLeft in ANeighbors, nRight in ANeighbors];
  ACanvas.FrameRect(ABounds, clBlack, 1, ABorders);
  R := HeaderContentBounds(ABounds, ABorders);
  DrawHeader(ACanvas, R, R, ANeighbors, cxBordersAll, cxbsNormal, taCenter,
    vaCenter, False, False, AText, AViewParams.Font, AViewParams.TextColor,
    AViewParams.Color, AOnDrawBackground);
  DrawMonthHeaderArrows(ACanvas, ABounds, AArrows, ASideWidth, clWindowText);
end;

class function TcxStandardLookAndFeelPainter.DefaultSchedulerViewContentColor: TColor;
begin
  Result := clWindow;
end;

class procedure TcxStandardLookAndFeelPainter.DrawSchedulerSplitterBorder(
  ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams;
  AIsHorizontal: Boolean);

  procedure DrawHorzBorders(const R: TRect; ATopColor, ABottomColor: TColor);
  begin
    ACanvas.SetBrushColor(ATopColor);
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Top + 1));
    ACanvas.SetBrushColor(ABottomColor);
    ACanvas.FillRect(Rect(R.Left, R.Bottom - 1, R.Right, R.Bottom));
  end;

  procedure DrawVertBorders(const R: TRect; ALeftColor, ARightColor: TColor);
  begin
    ACanvas.SetBrushColor(ALeftColor);
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Left + 1, R.Bottom));
    ACanvas.SetBrushColor(ARightColor);
    ACanvas.FillRect(Rect(R.Right - 1, R.Top, R.Right, R.Bottom));
  end;

begin
  if AIsHorizontal then
  begin
    DrawHorzBorders(R, clBtnFace, cl3DDkShadow);
    InflateRect(R, 1, -1);
    DrawHorzBorders(R, clBtnHighlight, clBtnShadow);
    InflateRect(R, 1, -1);
  end
  else
  begin
    DrawVertBorders(R, clBtnFace, cl3DDkShadow);
    InflateRect(R, -1, 1);
    DrawVertBorders(R, clBtnHighlight, clBtnShadow);
    InflateRect(R, -1, 1);
  end;
  ACanvas.FillRect(R, AViewParams);
end;

{ TcxFlatLookAndFeelPainter }

class function TcxFlatLookAndFeelPainter.LookAndFeelStyle: TcxLookAndFeelStyle;
begin
  Result := lfsFlat;
end;

class function TcxFlatLookAndFeelPainter.BorderSize: Integer;
begin
  Result := 1;
end;

class procedure TcxFlatLookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
begin
  ACanvas.DrawEdge(R, True, True);
end;

class function TcxFlatLookAndFeelPainter.ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer;
begin
  if AState = cxbsDefault then Result := 2 else Result := 1;
end;

class function TcxFlatLookAndFeelPainter.ButtonTextOffset: Integer;
begin
  Result := 1;
end;

class function TcxFlatLookAndFeelPainter.ButtonTextShift: Integer;
begin
  Result := 1;
end;

class procedure TcxFlatLookAndFeelPainter.DrawButtonBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);
begin
  if AState <> cxbsPressed then
  begin
    if AState = cxbsDefault then
    begin
      ACanvas.FrameRect(R, clBlack);
      InflateRect(R, -1, -1);
    end;
    ACanvas.DrawComplexFrame(R, clBtnHighlight, clBtnShadow)
  end
  else
    ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnHighlight);
end;

class procedure TcxFlatLookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
var
  ARect: TRect;
begin
  ARect := R;
  DrawButton(ACanvas, ARect, '', cxbsNormal, True, AColor);
  InflateRect(ARect, -1, -1);
  DrawExpandButtonCross(ACanvas, ARect, AExpanded, clBtnText);
  ACanvas.ExcludeClipRect(R);
end;

class function TcxFlatLookAndFeelPainter.ExpandButtonSize: Integer;
begin
  Result := 11;
end;

class function TcxFlatLookAndFeelPainter.IsButtonHotTrack: Boolean;
begin
  Result := False;
end;

class procedure TcxFlatLookAndFeelPainter.DrawCheckBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);
begin
  ACanvas.DrawEdge(R, True, True);
  InflateRect(R, -1, -1);
  ACanvas.FrameRect(R, CheckButtonColor(AState));
end;

class procedure TcxFlatLookAndFeelPainter.DrawHeaderBorder(ACanvas: TcxCanvas;
  const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders);
var
  I: TcxNeighbor;
begin
  with ACanvas do
  begin
    DrawEdge(R, False, False);
    for I := Low(I) to High(I) do
      if I in ANeighbors then
        case I of
          nLeft:
            begin
              Pixels[R.Left, R.Top + 1] := clBtnFace;  //!!!
              Pixels[R.Left, R.Bottom - 2] := clBtnFace;  //!!!
            end;
          nRight:
            begin
              Pixels[R.Right - 1, R.Top] := clBtnHighlight;
              Pixels[R.Right - 1, R.Top + 1] := clBtnFace;  //!!!
              Pixels[R.Right - 1, R.Bottom - 2] := clBtnFace;  //!!!
            end;
          nTop:;
          nBottom:;
        end;
  end;
end;

class procedure TcxFlatLookAndFeelPainter.DrawHeaderControlSectionBorder(
  ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AState: TcxButtonState);
begin
  if AState <> cxbsPressed then
    ACanvas.DrawComplexFrame(R, clBtnHighlight, clBtnShadow, ABorders)
  else
    ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnHighlight, ABorders);
end;

class procedure TcxFlatLookAndFeelPainter.DrawSortingMark(ACanvas: TcxCanvas;
  const R: TRect; AAscendingSorting: Boolean);
begin
  DrawSortingArrow(ACanvas, R, clBtnShadow, clBtnHighlight, AAscendingSorting);
end;

class function TcxFlatLookAndFeelPainter.HeaderBorderSize: Integer;
begin
  Result := 1;
end;

class function TcxFlatLookAndFeelPainter.SortingMarkSize: TPoint;
begin
  Result := Point(8, 7);
end;

class function TcxFlatLookAndFeelPainter.FooterBorderSize: Integer;
begin
  Result := 1;
end;

class function TcxFlatLookAndFeelPainter.FooterCellBorderSize: Integer;
begin
  Result := 1;
end;

class function TcxFlatLookAndFeelPainter.FooterCellOffset: Integer;
begin
  Result := 1;
end;

class procedure TcxFlatLookAndFeelPainter.DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect);
begin
  ACanvas.DrawEdge(R, False, False);
end;

class procedure TcxFlatLookAndFeelPainter.DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect);
begin
  ACanvas.DrawEdge(R, True, True);
end;

class procedure TcxFlatLookAndFeelPainter.DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState; AIsFilterActive: Boolean);

  class function GetArrowColor: TColor;
  begin
    if AIsFilterActive then
      Result := ActiveFilterButtonArrowColor
    else
      Result := clBtnText;
  end;

begin
  if AState <> cxbsPressed then
    ACanvas.DrawEdge(R, False, False)
  else
    ACanvas.DrawEdge(R, True, True);
  InflateRect(R, -1, -1);
  ACanvas.Brush.Color := clBtnFace;
  ACanvas.FillRect(R);
  DrawButtonArrow(ACanvas, R, GetArrowColor);
end;

class procedure TcxFlatLookAndFeelPainter.DrawTabBorder(ACanvas: TcxCanvas; R: TRect;
  ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean);
const
  Colors: array[Boolean] of TColor = (clBtnShadow, clBtnHighlight);

  procedure ProcessVerticalTabBorder;
  begin
    case ABorder of
       bLeft:
         begin
           Inc(R.Top);
           if bTop in ABorders then Inc(R.Top);
           Dec(R.Bottom);
           if bBottom in ABorders then Dec(R.Bottom);
         end;
       bTop, bBottom:
         if bLeft in ABorders then Inc(R.Left);
    end;
    if ABorder = bLeft then
    begin
      ACanvas.Pixels[R.Left + 1, R.Top - 1] := Colors[True];
      ACanvas.Pixels[R.Left + 1, R.Bottom] := Colors[True];
    end;
    ACanvas.Brush.Color := Colors[ABorder <> bBottom];
  end;

  procedure ProcessHorizontalTabBorder;
  begin
    case ABorder of
       bTop:
         begin
           Inc(R.Left);
           Dec(R.Right);
         end;
       bLeft, bRight:
         begin
           if bTop in ABorders then Inc(R.Top, 2);
           if bBottom in ABorders then Dec(R.Bottom);
         end;
    end;
    if ABorder = bTop then
    begin
      ACanvas.Pixels[R.Left - 1, R.Top + 1] := Colors[True];
      ACanvas.Pixels[R.Right, R.Top + 1] := Colors[True];
    end;
    ACanvas.Brush.Color := Colors[ABorder <> bRight];
  end;

begin
  if AVertical then
    ProcessVerticalTabBorder
  else
    ProcessHorizontalTabBorder;
  ACanvas.FillRect(R);
end;

class procedure TcxFlatLookAndFeelPainter.DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect;
  ABorders: TcxBorders; AVertical: Boolean);
begin
  ACanvas.DrawEdge(R, False, False, ABorders);
end;

class function TcxFlatLookAndFeelPainter.TabBorderSize(AVertical: Boolean): Integer;
begin
  Result := 1;
end;

class procedure TcxFlatLookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
  R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);
begin
  if IsRectEmpty(R) or ((APart = sbpThumbnail) and (AState = cxbsDisabled)) then Exit;
  if AState = cxbsHot then AState := cxbsNormal;
  case APart of
    sbpThumbnail, sbpLineUp, sbpLineDown:
      begin
        DrawButton(ACanvas, R, '', AState);
        InflateRect(R, -ButtonBorderSize, -ButtonBorderSize);
        if APart <> sbpThumbnail then
          DrawScrollBarArrow(ACanvas, R, AState, GetArrowDirection(AHorizontal, APart));
      end;
    sbpPageUp, sbpPageDown:
      begin
        ACanvas.Brush.Bitmap := StdScrollBitmaps[AState = cxbsPressed];
        ACanvas.FillRect(R);
        ACanvas.Brush.Bitmap := nil;
        ACanvas.Brush.Style := bsSolid;
      end;
  end;
end;

class procedure TcxFlatLookAndFeelPainter.DrawSchedulerSplitterBorder(
  ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams;
  AIsHorizontal: Boolean);
begin
  if AIsHorizontal then
  begin
    ACanvas.SetBrushColor(clBtnHighlight);
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Top + 1));
    ACanvas.SetBrushColor(clBtnShadow);
    ACanvas.FillRect(Rect(R.Left, R.Bottom - 1, R.Right, R.Bottom));
    InflateRect(R, 1, -1);
  end
  else
  begin
    ACanvas.SetBrushColor(clBtnHighlight);
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Left + 1, R.Bottom));
    ACanvas.SetBrushColor(clBtnShadow);
    ACanvas.FillRect(Rect(R.Right - 1, R.Top, R.Right, R.Bottom));
    InflateRect(R, -1, 1);
  end;
  ACanvas.FillRect(R, AViewParams);
end;

{ TcxUltraFlatLookAndFeelPainter }

class function TcxUltraFlatLookAndFeelPainter.LookAndFeelStyle: TcxLookAndFeelStyle;
begin
  Result := lfsUltraFlat;
end;

class function TcxUltraFlatLookAndFeelPainter.DefaultSchedulerBorderColor: TColor;
begin
  Result := clBtnShadow;
end;

class function TcxUltraFlatLookAndFeelPainter.BorderHighlightColor: TColor;
begin
  Result := clHighlight;
end;

class function TcxUltraFlatLookAndFeelPainter.BorderSize: Integer;
begin
  Result := 1;
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
begin
  ACanvas.FrameRect(R, clBtnShadow);
end;

class function TcxUltraFlatLookAndFeelPainter.ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer;
begin
  if AState = cxbsDefault then Result := 2 else Result := 1;
end;

//vclskin button color
class function TcxUltraFlatLookAndFeelPainter.ButtonColor(AState: TcxButtonState): TColor;
var fsd:Tskindata;
begin
  fsd:=Skinmanager.maindata;

  case AState of
    cxbsHot:
      Result := GetLightSelColor;
    cxbsPressed:
      Result := GetLightDownedSelColor;
  else begin
    if fsd.active then result:= fsd.colors[csbuttonface]
    else
    Result := inherited ButtonColor(AState);
  end end;
end;

class function TcxUltraFlatLookAndFeelPainter.ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect;
begin
  Result := R;
  InflateRect(Result, -3, -3);
  if IsRectEmpty(Result) then
    Result := R;
end;

class function TcxUltraFlatLookAndFeelPainter.ButtonGroupBorderSizes(AButtonCount,
  AButtonIndex: Integer): TRect;
begin
  Result := Rect(1, 2, 1, 2);
  if AButtonIndex = 0 then
    Inc(Result.Left)
  else
    if AButtonIndex = AButtonCount - 1 then
      Inc(Result.Right);
end;

class function TcxUltraFlatLookAndFeelPainter.ButtonSymbolColor(
  AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor;
begin
  if AState = cxbsPressed then
    Result := clHighlightText
  else
    Result := inherited ButtonSymbolColor(AState, ADefaultColor);
end;

class function TcxUltraFlatLookAndFeelPainter.ButtonSymbolState(AState: TcxButtonState): TcxButtonState;
begin
  Result := cxbsNormal;
end;

class function TcxUltraFlatLookAndFeelPainter.ButtonTextOffset: Integer;
begin
  Result := 2;
end;

class function TcxUltraFlatLookAndFeelPainter.ButtonTextShift: Integer;
begin
  Result := 0;
end;

//override Drawbutton for vclskin
class procedure TcxUltraFlatLookAndFeelPainter.DrawButton(ACanvas: TcxCanvas;
  R: TRect; const ACaption: string; AState: TcxButtonState; ADrawBorder: Boolean = True;
  AColor: TColor = clDefault; ATextColor: TColor = clDefault);
var  fsd:TSkinData;
     w,h,w1,h1:integer;
     x,i:integer;
     bmp:Tbitmap;
begin
   fsd:=Skinmanager.maindata;
   if not fsd.Active then begin
       inherited DrawButton(acanvas,r,acaption,astate,adrawborder,acolor,atextcolor);
       exit;
   end;
   w:=fsd.Button.Map.Width div fsd.Button.frame;
   h:=fsd.Button.Map.Height;
   w1:=r.Right-r.Left;
   h1:=r.Bottom-r.Top;
   i:=1;
   case astate of
      cxbsDefault:i:=5;
      cxbsNormal:i:=1;
      cxbsHot:i:=4;
      cxbsPressed:i:=2;
      cxbsDisabled:i:=3;
   end;
   acanvas.Brush.Color := fsd.colors[csButtonFace];
   acanvas.FillRect(R);
   if w*h*4<w1*h1 then begin
      DrawRect2(acanvas.Handle,r,fsd.Button.map,fsd.Button.r,
              i,fsd.Button.frame,fsd.Button.trans);
   end else begin;
      bmp:=Tbitmap.create;
      bmp.Width:=w1;
      bmp.Height:=h1;
      x:=(i-1)*w;
      bmp.canvas.copyrect( rect(0,0,w1,h1),
             fsd.Button.Map.canvas,rect(x,0,x+w,h));
      if fsd.Button.trans=1 then begin
         bmp.Transparent:=true;
         bmp.Transparentcolor:=clFuchsia;
      end;
      acanvas.draw(r.left,r.top,bmp);
      bmp.free;
  end;

  with ACanvas do
  begin
    if ATextColor = clDefault then
      Font.Color := ButtonSymbolColor(AState)
    else
      Font.Color := ATextColor;
    Brush.Style := bsClear;
    with R do // for compatible with standard buttons
    begin
      Dec(Bottom, Ord(Odd(Bottom - Top)));
      if (Bottom - Top) < 18 then Dec(Top);
    end;
    if AState = cxbsPressed then
      OffsetRect(R, ButtonTextShift, ButtonTextShift);
    if Length(ACaption) > 0 then
      DrawText(ACaption, R, cxAlignHCenter or cxAlignVCenter or cxSingleLine or
        cxShowPrefix, AState <> cxbsDisabled);
    Brush.Style := bsSolid;
  end;
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawButtonBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);

  function GetBorderColor: TColor;
  begin
    case AState of
//      cxbsDefault:
//        Result := clNavy;
      cxbsDisabled:
        Result := clBtnShadow;
      cxbsNormal:
        Result := clBtnText;
    else
      Result := clHighlight;
    end;    
  end;

begin
  if AState = cxbsDefault then
  begin
    ACanvas.FrameRect(R, clWindowFrame);
    InflateRect(R, -1, -1);
    ACanvas.FrameRect(R, clWindowFrame);
  end
  else
    ACanvas.FrameRect(R, GetBorderColor);
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawButtonInGroup(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AButtonCount, AButtonIndex: Integer;
  ABackgroundColor: TColor);
begin
  Inc(R.Top);
  Dec(R.Bottom);
  if AButtonIndex = 0 then
    Inc(R.Left);
  if AButtonIndex = AButtonCount - 1 then
    Dec(R.Right);
  with ACanvas do
  begin
    if AState in [cxbsDisabled, cxbsNormal] then
    begin
      FrameRect(R, ABackgroundColor);
      InflateRect(R, -1, -1);
    end else
    begin
      Brush.Color := BorderHighlightColor;
      if AButtonIndex > 0 then
      begin
        FillRect(Rect(R.Left, R.Top, R.Left + 1, R.Bottom));
        Inc(R.Left);
      end;
      if AButtonIndex < AButtonCount - 1 then
      begin
        FillRect(Rect(R.Right - 1, R.Top, R.Right, R.Bottom));
        Dec(R.Right);
      end;
    end;
    Brush.Color := ButtonColor(AState);
    FillRect(R);
  end;
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawButtonGroupBorder(ACanvas: TcxCanvas;
  R: TRect; AInplace, ASelected: Boolean);
var
  AColor: TColor;
begin
  if AInplace then
    AColor := clBtnText
  else
    if ASelected then
      AColor := BorderHighlightColor
    else
      AColor := clBtnShadow;
  ACanvas.FrameRect(R, AColor);
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
var
  ARect: TRect;
begin
  ARect := R;
  ACanvas.FrameRect(ARect, clBtnShadow);
  InflateRect(ARect, -1, -1);
  if AColor = clDefault then
    ACanvas.Brush.Color := clBtnFace
  else
    ACanvas.Brush.Color := AColor;
  ACanvas.FillRect(ARect);
  DrawExpandButtonCross(ACanvas, ARect, AExpanded, clBtnText);
  ACanvas.ExcludeClipRect(R);
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawHeaderControlSectionBorder(
  ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AState: TcxButtonState);
begin
  if AState <> cxbsDisabled then
    ACanvas.DrawComplexFrame(R, clBlack, clBlack, ABorders)
  else
    ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnShadow, ABorders);
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawHeaderControlSectionContent(
  ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
  AState: TcxButtonState; AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor);
begin
  if AState in [cxbsDefault, cxbsNormal] then
    ACanvas.SetBrushColor(ABkColor)
  else
    ACanvas.SetBrushColor(ButtonColor(AState));
  ACanvas.FillRect(ABounds);
  ACanvas.Font.Color := ATextColor;
  DrawHeaderControlSectionText(ACanvas, ATextAreaBounds, AState, AAlignmentHorz,
    AAlignmentVert, AMultiLine, AShowEndEllipsis, AText, AFont, ATextColor);
end;

class function TcxUltraFlatLookAndFeelPainter.ExpandButtonSize: Integer;
begin
  Result := 11;
end;

class function TcxUltraFlatLookAndFeelPainter.IsButtonHotTrack: Boolean;
begin
  Result := True;
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawCheckBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);
begin
  ACanvas.FrameRect(R, clBtnText);
  InflateRect(R, -1, -1);
  ACanvas.FrameRect(R, CheckButtonColor(AState));
end;


function TcxUltraFlatLookAndFeelPainter.VclskinDrawHeaderBk(ACanvas: TcxCanvas; const ABounds: TRect):boolean;
begin
       result:=true;
end;

//fsd : add new procedure, override DrawHeader
class procedure TcxUltraFlatLookAndFeelPainter.DrawHeader(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
  ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil;
  AIsLast: Boolean = False);
var
  R: TRect;
  fsd:TSkinData;
  w,h,w1,h1:integer;
  x,i:integer;

const
  AlignmentsHorz: array[TAlignment] of Integer =
    (cxAlignLeft, cxAlignRight, cxAlignHCenter);
  AlignmentsVert: array[TcxAlignmentVert] of Integer =
    (cxAlignTop, cxAlignBottom, cxAlignVCenter);
  MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
  ShowEndEllipsises: array[Boolean] of Integer = (0, cxShowEndEllipsis);

begin
   fsd:=Skinmanager.maindata;
   if fsd.Active and assigned(fsd.header) then begin
      i:=1;
      case astate of
         cxbsDefault:i:=1;
         cxbsNormal:i:=1;
         cxbsHot:i:=4;
         cxbsPressed:i:=2;
         cxbsDisabled:i:=3;
      end;
      DrawRectH(acanvas.Handle,ABounds,fsd.Header.map,fsd.header.r,
                i,fsd.Header.frame);

      with ACanvas do
      begin
         if AText <> '' then
         begin
           Brush.Style := bsClear;
           Font := AFont;
           Font.Color := ATextColor;
           DrawText(AText, ATextAreaBounds, AlignmentsHorz[AAlignmentHorz] or
           AlignmentsVert[AAlignmentVert] or MultiLines[AMultiLine] or
           ShowEndEllipsises[AShowEndEllipsis]);
           Brush.Style := bsSolid;
        end;
      end;
    end else inherited;
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawHeaderBorder(ACanvas: TcxCanvas;
  const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders);
begin
  ACanvas.Brush.Color := clBtnText;
  with R do
  begin
    if bLeft in ABorders then
      ACanvas.FillRect(Rect(Left, Top, Left + 1, Bottom));
    if bTop in ABorders then
      ACanvas.FillRect(Rect(Left, Top, Right, Top + 1));
    ACanvas.FillRect(Rect(Right - 1, Top, Right, Bottom));
    ACanvas.FillRect(Rect(Left, Bottom - 1, Right, Bottom));
  end;
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawHeaderEx(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
  ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil);
var
  R: TRect;
begin
  R := ATextAreaBounds;
  InflateRect(R, -1, -1);
  DrawContent(ACanvas, ABounds, R, Integer(AState), 
    AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
      AFont, ATextColor, ABkColor, AOnDrawBackground);
  R := ABounds;
  InflateRect(R, -1, -1);
  DrawHeaderBorder(ACanvas, R, ANeighbors, ABorders);
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawSortingMark(ACanvas: TcxCanvas;
  const R: TRect; AAscendingSorting: Boolean);
begin
  DrawSortingArrow(ACanvas, R, clBtnShadow, clBtnShadow, AAscendingSorting);
end;

class function TcxUltraFlatLookAndFeelPainter.HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders;
begin
  Result := inherited HeaderBorders(ANeighbors);
  if nLeft in ANeighbors then Exclude(Result, bLeft);
  if nTop in ANeighbors then Exclude(Result, bTop);
end;

class function TcxUltraFlatLookAndFeelPainter.HeaderBorderSize: Integer;
begin
  Result := 1;
end;

class function TcxUltraFlatLookAndFeelPainter.SortingMarkSize: TPoint;
begin
  Result := Point(7, 8);
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawFooterBorder(ACanvas: TcxCanvas;
  const R: TRect);
begin
  ACanvas.Brush.Color := FooterSeparatorColor;
  with R do
  begin
    ACanvas.FillRect(Rect(Right - 1, Top, Right, Bottom));
    ACanvas.FillRect(Rect(Left, Bottom - 1, Right, Bottom));
  end;
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawFooterCellBorder(ACanvas: TcxCanvas;
  const R: TRect);
begin
  ACanvas.FrameRect(R, FooterSeparatorColor);
end;

class function TcxUltraFlatLookAndFeelPainter.FooterBorders: TcxBorders;
begin
  Result := [bRight, bBottom];
end;

class function TcxUltraFlatLookAndFeelPainter.FooterBorderSize: Integer;
begin
  Result := 1;
end;

class function TcxUltraFlatLookAndFeelPainter.FooterCellBorderSize: Integer;
begin
  Result := 1;
end;

class function TcxUltraFlatLookAndFeelPainter.FooterCellOffset: Integer;
begin
  Result := 2;
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawFilterDropDownButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean);

  function GetArrowColor: TColor;
  begin
    if AIsFilterActive then
      Result := ActiveFilterButtonArrowColor
    else
      Result := ButtonSymbolColor(AState);
  end;

begin
  ACanvas.FrameRect(R, FilterDropDownButtonBorderColor(AState));
  InflateRect(R, -1, -1);
  ACanvas.Brush.Color := ButtonColor(AState);
  ACanvas.FillRect(R);
  DrawButtonArrow(ACanvas, R, GetArrowColor);
end;

class function TcxUltraFlatLookAndFeelPainter.FilterCloseButtonSize: TPoint;
begin
  Result := inherited FilterCloseButtonSize;
  Inc(Result.Y);
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawTabBorder(ACanvas: TcxCanvas; R: TRect;
  ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean);
begin
  if AVertical and (ABorder = bBottom) or not AVertical and (ABorder = bRight) then
  begin
    if not AVertical then
      Dec(R.Bottom, TabBorderSize(AVertical));
    ACanvas.Brush.Color := TabBorderDarkColor;
  end
  else
    ACanvas.Brush.Color := TabBorderHighlightColor;
  ACanvas.FillRect(R);
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawTabsRoot(ACanvas: TcxCanvas;
  const R: TRect; ABorders: TcxBorders; AVertical: Boolean);
begin
  ACanvas.DrawComplexFrame(R, TabBorderHighlightColor, TabBorderHighlightColor, ABorders, TabBorderSize(AVertical));
end;

class function TcxUltraFlatLookAndFeelPainter.TabBorderSize(AVertical: Boolean): Integer;
begin
  Result := 1;
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas;
  AHorizontal: Boolean; R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);
begin
  if IsRectEmpty(R) or ((APart = sbpThumbnail) and (AState = cxbsDisabled)) then Exit;
  case APart of
    sbpThumbnail, sbpLineUp, sbpLineDown:
      begin
        DrawButton(ACanvas, R, '', AState);
        if APart <> sbpThumbnail then
          DrawScrollBarArrow(ACanvas, R, AState, GetArrowDirection(AHorizontal, APart));
      end;
    sbpPageUp, sbpPageDown:
      begin
        ACanvas.Brush.Bitmap := StdScrollBitmaps[AState = cxbsPressed];
        ACanvas.FillRect(R);
        ACanvas.Brush.Bitmap := nil;
        ACanvas.Brush.Style := bsSolid;
      end;
  end;
end;

class function TcxUltraFlatLookAndFeelPainter.FilterDropDownButtonBorderColor(AState: TcxButtonState): TColor;
begin
  if AState = cxbsNormal then
    Result := clBtnShadow
  else
    Result := clHighlight;
end;

class function TcxUltraFlatLookAndFeelPainter.TabBorderHighlightColor: TColor;
begin
  Result := clBtnShadow;
end;

class function TcxUltraFlatLookAndFeelPainter.TabBorderDarkColor: TColor;
begin
  Result := clBtnText;
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawSchedulerNavigatorButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
begin
  DrawButton(ACanvas, R, '', AState, AState in [cxbsHot, cxbsPressed]);
end;

class procedure TcxUltraFlatLookAndFeelPainter.DrawSchedulerSplitterBorder(
  ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams;
  AIsHorizontal: Boolean);
begin
  ACanvas.SetBrushColor(DefaultSchedulerBorderColor);
  if AIsHorizontal then
  begin
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Top + 1));
    ACanvas.FillRect(Rect(R.Left, R.Bottom - 1, R.Right, R.Bottom));
    InflateRect(R, 1, -1);
  end
  else
  begin
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Left + 1, R.Bottom));
    ACanvas.FillRect(Rect(R.Right - 1, R.Top, R.Right, R.Bottom));
    InflateRect(R, -1, 1);
  end;
  ACanvas.FillRect(R, AViewParams);
end;

{$IFDEF VCL}
{ TcxOffice11LookAndFeelPainter }

class function TcxOffice11LookAndFeelPainter.LookAndFeelStyle: TcxLookAndFeelStyle;
begin
  Result := lfsOffice11;
end;

class function TcxOffice11LookAndFeelPainter.DefaultDateNavigatorHeaderColor: TColor;
begin
  Result := dxOffice11DockColor1;
end;

class function TcxOffice11LookAndFeelPainter.DefaultDateNavigatorSelectionColor: TColor;
begin
  Result := dxOffice11DayNavigatorSelectedColor;
end;

class function TcxOffice11LookAndFeelPainter.DefaultDateNavigatorSelectionTextColor: TColor;
begin
  Result := clWindowText;
end;

class function TcxOffice11LookAndFeelPainter.DefaultFilterBoxColor: TColor;
begin
  Result := dxOffice11BarFloatingBorderColor1;
end;

class function TcxOffice11LookAndFeelPainter.DefaultFilterBoxTextColor: TColor;
begin
  Result := dxOffice11BarFloatingCaptionTextColor1;
end;

class function TcxOffice11LookAndFeelPainter.DefaultFooterColor: TColor;
begin
  Result := dxOffice11DockColor1;  //DefaultHeaderColor;
end;

class function TcxOffice11LookAndFeelPainter.DefaultFooterTextColor: TColor;
begin
  Result := DefaultHeaderTextColor;
end;

class function TcxOffice11LookAndFeelPainter.DefaultGroupColor: TColor;
begin
  Result := dxOffice11GroupColor;
end;

class function TcxOffice11LookAndFeelPainter.DefaultGroupByBoxColor: TColor;
begin
  Result := dxOffice11InPlaceSubItemColor{dxOffice11DockColor2};
end;

class function TcxOffice11LookAndFeelPainter.DefaultGroupByBoxTextColor: TColor;
begin
  Result := dxOffice11ToolbarsColor1{dxOffice11TextEnabledColor};
end;

class function TcxOffice11LookAndFeelPainter.DefaultHeaderColor: TColor;
begin
  Result := HeaderTopColor;  //dxOffice11DockColor1;
end;

class function TcxOffice11LookAndFeelPainter.DefaultHeaderBackgroundColor: TColor;
begin
  Result := DefaultGroupByBoxColor;
end;

class function TcxOffice11LookAndFeelPainter.DefaultSchedulerBorderColor: TColor;
begin
  Result := dxOffice11OutlookBorderColor;
end;

class function TcxOffice11LookAndFeelPainter.DefaultSchedulerControlColor: TColor;
begin
  Result := dxOffice11OutlookControlColor;
end;

class function TcxOffice11LookAndFeelPainter.DefaultTabColor: TColor;
begin
  Result := dxOffice11DockColor2;
end;

class function TcxOffice11LookAndFeelPainter.DefaultTabsBackgroundColor: TColor;
begin
  Result := DefaultTabColor;
end;

class function TcxOffice11LookAndFeelPainter.DefaultTimeGridMinorScaleColor: TColor;
begin
  Result := dxOffice11DockColor1;
end;

class function TcxOffice11LookAndFeelPainter.DefaultTimeGridSelectionBarColor: TColor;
begin
  Result := DefaultSchedulerControlColor;
end;

class function TcxOffice11LookAndFeelPainter.BorderHighlightColor: TColor;
begin
  Result := dxOffice11SelectedBorderColor;
end;

class procedure TcxOffice11LookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
begin
  ACanvas.FrameRect(R, dxOffice11ControlBorderColor);
end;

class function TcxOffice11LookAndFeelPainter.ButtonColor(AState: TcxButtonState): TColor;
begin
  case AState of
    cxbsHot:
      Result := dxOffice11SelectedColor1;
    cxbsPressed:
      Result := dxOffice11SelectedDownColor1;
    cxbsDisabled:
      Result := {dxOffice11ToolbarsColor2}clBtnFace;
  else
    Result := dxOffice11DockColor1{inherited ButtonColor(AState)};
  end;
end;

class function TcxOffice11LookAndFeelPainter.ButtonSymbolColor(
  AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor;
begin
  if (AState = cxbsPressed) and not IsXPStandardScheme then
    Result := clHighlightText
  else
    if AState = cxbsDisabled then
      Result := dxOffice11TextDisabledColor
    else
      Result := dxOffice11TextEnabledColor;
end;

class procedure TcxOffice11LookAndFeelPainter.DrawButtonBorder(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState);

  function GetBorderColor: TColor;
  begin
    case AState of
      cxbsNormal:
        Result := clBtnText;
      cxbsDisabled:
        Result := dxOffice11TextDisabledColor;   
    else
      Result := dxOffice11SelectedBorderColor;
    end;
  end;

begin
  if AState = cxbsDefault then
    inherited
  else
    ACanvas.FrameRect(R, GetBorderColor);
end;

class procedure TcxOffice11LookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
var
  AColor2: TColor;
  ABitmap: TBitmap;
begin
  if AExpanded then
    ABitmap := dxOffice11ExpandButtonBitmap1
  else
    ABitmap := dxOffice11ExpandButtonBitmap2;
  AColor2 := GetMiddleRGB(dxOffice11ExpandButtonColor1, ACanvas.Canvas.Pixels[R.Left, R.Top], 25);
  ABitmap.Canvas.Pixels[0, 0] := AColor2;
  AColor2 := GetMiddleRGB(dxOffice11ExpandButtonColor2, ACanvas.Canvas.Pixels[R.Right - 1, R.Bottom - 1], 25);
  ABitmap.Canvas.Pixels[10, 10] := AColor2;
  ABitmap.Canvas.Pixels[0, 10] := AColor2;
  ABitmap.Canvas.Pixels[10, 0] := AColor2;
  ACanvas.Draw(R.Left, R.Top, ABitmap);
//  ACanvas.ExcludeClipRect(R);
end;

class function TcxOffice11LookAndFeelPainter.DrawExpandButtonFirst: Boolean;
begin
  Result := False;
end;

class procedure TcxOffice11LookAndFeelPainter.DrawSmallExpandButton(ACanvas: TcxCanvas;
  R: TRect; AExpanded: Boolean; ABorderColor: TColor; AColor: TColor = clDefault);
begin
  DrawExpandButton(ACanvas, R, AExpanded, AColor);
end;

class function TcxOffice11LookAndFeelPainter.ExpandButtonSize: Integer;
begin
  Result := 11;
end;

class function TcxOffice11LookAndFeelPainter.SmallExpandButtonSize: Integer;
begin
  Result := ExpandButtonSize;
end;

class function TcxOffice11LookAndFeelPainter.CheckButtonColor(AState: TcxButtonState): TColor;
begin
  case AState of
    cxbsHot, cxbsPressed, cxbsDisabled:
      Result := ButtonColor(AState);
  else
    Result := inherited CheckButtonColor(AState);
  end;
end;

class procedure TcxOffice11LookAndFeelPainter.DrawFilterDropDownButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean);

  function GetArrowColor: TColor;
  begin
    if AIsFilterActive then
      Result := ActiveFilterButtonArrowColor
    else
      Result := ButtonSymbolColor(AState);
  end;

begin
//  inherited;
  ACanvas.FrameRect(R, FilterDropDownButtonBorderColor(AState));
  InflateRect(R, -1, -1);
  ACanvas.Brush.Color := ButtonColor(AState);
  ACanvas.FillRect(R);
  DrawButtonArrow(ACanvas, R, GetArrowColor);
end;

class procedure TcxOffice11LookAndFeelPainter.DrawHeader(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor,
  ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsLast: Boolean = False);
begin
  inherited DrawHeader(ACanvas, ABounds, ATextAreaBounds, ANeighbors, ABorders,
    AState, AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
    AFont, ATextColor, ABkColor, nil, AIsLast);
end;

class procedure TcxOffice11LookAndFeelPainter.DrawHeaderBorder(ACanvas: TcxCanvas;
  const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders);
var
  AColor1, AColor2: TColor;
  Y1, Y2: Integer;
begin
  AColor1 := HeaderTopColor;
  AColor2 := HeaderBottomColor;
  if bTop in ABorders then
  begin
    ACanvas.Brush.Color := AColor1;
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Top + 1));
  end;
  if bBottom in ABorders then
  begin
    ACanvas.Brush.Color := HeaderDarkEdgeColor;
    ACanvas.FillRect(Rect(R.Left, R.Bottom - 1, R.Right, R.Bottom));
  end;
  if bLeft in ABorders then
  begin
    ACanvas.Pixels[R.Left, R.Top + 1] := AColor1;
    if nLeft in ANeighbors then
    begin
      Y1 := R.Top + 2;
      Y2 := R.Bottom - 3;
      ACanvas.Pixels[R.Left, Y1] := AColor1;
      ACanvas.Pixels[R.Left, Y2] := GetMiddleRGB(AColor1, AColor2, 25);
      ACanvas.Pixels[R.Left, R.Bottom - 2] := AColor2;
    end
    else
    begin
      Y1 := R.Top + 1;
      Y2 := R.Bottom - 2;
      ACanvas.Pixels[R.Left, R.Bottom - 2] := AColor2;
    end;
    ACanvas.Brush.Color := HeaderHighlightEdgeColor;
    ACanvas.FillRect(Rect(R.Left, Y1, R.Left + 1, Y2));
  end;
  if bRight in ABorders then
  begin
    if nRight in ANeighbors then
    begin
      Y1 := R.Top + 2;
      Y2 := R.Bottom - 3;
      ACanvas.Pixels[R.Right - 1, R.Top + 1] := AColor1;
      ACanvas.Pixels[R.Right - 1, Y1] := AColor1;
      ACanvas.Pixels[R.Right - 1, Y2] := GetMiddleRGB(AColor1, AColor2, 25);
      ACanvas.Pixels[R.Right - 1, R.Bottom - 2] := AColor2;
    end
    else
    begin
      Y1 := R.Top + 1;
      ACanvas.Pixels[R.Right - 1, R.Top] := GetMiddleRGB(AColor1, HeaderDarkEdgeColor, 50);
      Y2 := R.Bottom - 2;
      ACanvas.Pixels[R.Right - 1, R.Bottom - 2] := GetMiddleRGB(AColor2, HeaderDarkEdgeColor, 50);
    end;
    ACanvas.Brush.Color := HeaderDarkEdgeColor;
    ACanvas.FillRect(Rect(R.Right - 1, Y1, R.Right, Y2));
  end;
end;

class procedure TcxOffice11LookAndFeelPainter.DrawHeaderControlSection(
  ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
  ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
  AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine,
  AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor,
  ABkColor: TColor);
begin
  DrawHeader(ACanvas, ABounds, ATextAreaBounds, ANeighbors, ABorders,
    AState, AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
    AFont, ATextColor, ABkColor);
  if AState = cxbsPressed then
    DrawHeaderPressed(ACanvas, ABounds);
end;

class procedure TcxOffice11LookAndFeelPainter.DrawSortingMark(ACanvas: TcxCanvas;
  const R: TRect; AAscendingSorting: Boolean);
begin
  DrawSortingArrow(ACanvas, R, HeaderDarkEdgeColor, HeaderHighlightEdgeColor, AAscendingSorting);
end;

class function TcxOffice11LookAndFeelPainter.HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders;
begin
  Result := cxBordersAll;
end;

class function TcxOffice11LookAndFeelPainter.HeaderBorderSize: Integer;
begin
  Result := 1;
end;

class function TcxOffice11LookAndFeelPainter.IsHeaderHotTrack: Boolean;
begin
  Result := True;
end;

class function TcxOffice11LookAndFeelPainter.FooterSeparatorColor: TColor;
begin
  Result := HeaderDarkEdgeColor;
end;

class procedure TcxOffice11LookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas;
  AHorizontal: Boolean; R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);
begin
  if AreVisualStylesAvailable([totScrollBar]) then
    TcxWinXPLookAndFeelPainter.DrawScrollBarPart(ACanvas, AHorizontal, R, APart, AState)
  else
    TcxStandardLookAndFeelPainter.DrawScrollBarPart(ACanvas, AHorizontal, R, APart, AState);
end;

class procedure TcxOffice11LookAndFeelPainter.DrawMonthHeader(
  ACanvas: TcxCanvas; const ABounds: TRect; const AText: string;
  ANeighbors: TcxNeighbors; const AViewParams: TcxViewParams;
  AArrows: TcxHeaderArrows; ASideWidth: Integer;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
var
  R: TRect;
begin
  R := ABounds;
  InflateRect(R, -1, -1);
  with ACanvas do
  begin
    if not Assigned(AOnDrawBackground) or not AOnDrawBackground(ACanvas, R) then
      FillRect(R, AViewParams);
    if AText <> '' then
    begin
      Brush.Style := bsClear;
      Font := AViewParams.Font;
      Font.Color := AViewParams.TextColor;
      DrawText(AText, R, cxAlignCenter or cxSingleLine);
      Brush.Style := bsSolid;
    end;
  end;
  DrawMonthHeaderArrows(ACanvas, ABounds, AArrows, ASideWidth, clWindowText);
end;

class procedure TcxOffice11LookAndFeelPainter.DrawSchedulerNavigatorButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
begin
  TcxWinXPLookAndFeelPainter.DrawSchedulerNavigatorButton(ACanvas, R, AState);
end;

class procedure TcxOffice11LookAndFeelPainter.DrawSchedulerBorder(
  ACanvas: TcxCanvas; R: TRect);
begin
  ACanvas.FrameRect(R, DefaultSchedulerBorderColor);
end;

class procedure TcxOffice11LookAndFeelPainter.DrawContent(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; AState: Integer; AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsFooter: Boolean = False);
const
  AlignmentsHorz: array[TAlignment] of Integer =
    (cxAlignLeft, cxAlignRight, cxAlignHCenter);
  AlignmentsVert: array[TcxAlignmentVert] of Integer =
    (cxAlignTop, cxAlignBottom, cxAlignVCenter);
  MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
  ShowEndEllipsises: array[Boolean] of Integer = (0, cxShowEndEllipsis);
var
  R: TRect;
  AColor1, AColor2: TColor;
begin
  with ACanvas do
  begin
    R := ABounds;
    if not Assigned(AOnDrawBackground) or not AOnDrawBackground(ACanvas, ABounds) then
    begin
      if AState = Integer(cxbsHot) then
      begin
        AColor1 := dxOffice11ToolbarsColor1;
        AColor2 := dxOffice11ToolbarsColor1;
      end
      else
      begin
        AColor1 := HeaderTopColor;
        AColor2 := HeaderBottomColor;
      end;
      with ABounds do
      begin
        if AIsFooter then
          FillRectByColor(ACanvas.Handle, Rect(Left, Top, Right, Bottom), AColor1)
        else
        begin
          FillRectByColor(ACanvas.Handle, Rect(Left, Top, Right, Bottom - 3), AColor1);
          FillGradientRect(ACanvas.Handle, Rect(Left, Bottom - 4, Right, Bottom), AColor1, AColor2, False);
        end;
      end;
    end;
    if AText <> '' then
    begin
      Brush.Style := bsClear;
      Font := AFont;
      Font.Color := ATextColor;
      DrawText(AText, ATextAreaBounds, AlignmentsHorz[AAlignmentHorz] or
        AlignmentsVert[AAlignmentVert] or MultiLines[AMultiLine] or
        ShowEndEllipsises[AShowEndEllipsis]);
      Brush.Style := bsSolid;
    end;
    if AState = Integer(cxbsHot) then
      with ABounds do
        FillGradientRect(ACanvas.Handle, Rect(Left - 1, Bottom - 2, Right, Bottom + 1),
          dxOffice11SelectedColor1, dxOffice11SelectedColor2, False);
  end;
end;

class function TcxOffice11LookAndFeelPainter.HeaderBottomColor: TColor;
begin
  Result := dxOffice11ToolbarsColor2;
end;

class function TcxOffice11LookAndFeelPainter.HeaderDarkEdgeColor: TColor;
begin
  Result := dxOffice11BarSeparatorColor1;
end;

class function TcxOffice11LookAndFeelPainter.HeaderHighlightEdgeColor: TColor;
begin
  Result := dxOffice11BarSeparatorColor2;
end;

class function TcxOffice11LookAndFeelPainter.HeaderTopColor: TColor;
begin
  Result := GetMiddleRGB(dxOffice11ToolbarsColor1, dxOffice11ToolbarsColor2, 50);
end;

class function TcxOffice11LookAndFeelPainter.FilterDropDownButtonBorderColor(AState: TcxButtonState): TColor;
begin
  if AState = cxbsNormal then
    Result := HeaderDarkEdgeColor
  else
    Result := dxOffice11SelectedBorderColor;
end;

class function TcxOffice11LookAndFeelPainter.TabBorderHighlightColor: TColor;
begin
  Result := HeaderDarkEdgeColor;
end;

class function TcxOffice11LookAndFeelPainter.TabBorderDarkColor: TColor;
begin
  Result := inherited TabBorderDarkColor;
end;

function BtnStateToXPBtnState(AState: TcxButtonState): Integer;
const
  ButtonStates: array[TcxButtonState] of Integer =(PBS_DEFAULTED, PBS_NORMAL,
    PBS_HOT, PBS_PRESSED, PBS_DISABLED);
begin
  Result := ButtonStates[AState];
end;

{ TcxWinXPLookAndFeelPainter }

class procedure TcxWinXPLookAndFeelPainter.DrawContent(ACanvas: TcxCanvas;
  ATheme: TTheme; APartId, AStateId: Integer; const ABounds, ATextAreaBounds: TRect;
  AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis, AShowPrefix: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor);
const
  AlignmentsHorz: array[TAlignment] of Integer = (DT_LEFT, DT_RIGHT, DT_CENTER);
  AlignmentsVert: array[TcxAlignmentVert] of Integer = (DT_TOP, DT_BOTTOM, DT_VCENTER);
  MultiLines: array[Boolean] of Integer = (DT_SINGLELINE, DT_WORDBREAK);
  ShowEndEllipsises: array[Boolean] of Integer = (0, DT_END_ELLIPSIS);
  ShowPrefixes: array[Boolean] of Integer = (DT_NOPREFIX, 0);
var
  R: TRect;
begin
  if AText = '' then Exit;
  R := ATextAreaBounds;
  ACanvas.Font := AFont;
  ACanvas.Font.Color := ATextColor;
  if AMultiLine then
    ACanvas.AlignMultiLineTextRectVertically(R, AText, AAlignmentVert, True, AShowPrefix);
  DrawThemeText(ATheme, ACanvas.Handle, APartId, AStateId, AText,
    -1, DT_EDITCONTROL or AlignmentsHorz[AAlignmentHorz] or AlignmentsVert[AAlignmentVert] or
    ShowEndEllipsises[AShowEndEllipsis] or ShowPrefixes[AShowPrefix] or
    MultiLines[AMultiLine], 0, R);
end;

class function TcxWinXPLookAndFeelPainter.LookAndFeelStyle: TcxLookAndFeelStyle;
begin
  Result := lfsNative;
end;

class function TcxWinXPLookAndFeelPainter.DefaultSchedulerBorderColor: TColor;
var
  AColor: TColorRef;
begin
  GetThemeColor(OpenTheme(totComboBox), CP_DROPDOWNBUTTON, CBXS_NORMAL, TMT_BORDERCOLOR, AColor);
  Result := AColor;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawArrow(ACanvas: TcxCanvas;
  const R: TRect; AArrowDirection: TcxArrowDirection; AColor: TColor);
begin
  inherited; // for BCB6 conversion
end;

class procedure TcxWinXPLookAndFeelPainter.DrawArrow(ACanvas: TcxCanvas;
  const R: TRect; AState: TcxButtonState; AArrowDirection: TcxArrowDirection;
  ADrawBorder: Boolean = True);

{$WARNINGS OFF}
  function GetState: Integer;
  begin
    case AArrowDirection of
      adUp:
        case AState of
          cxbsDefault, cxbsNormal:
            Result := ABS_UPNORMAL;
          cxbsHot:
            Result := ABS_UPHOT;
          cxbsPressed:
            Result := ABS_UPPRESSED;
          cxbsDisabled:
            Result := ABS_UPDISABLED;
        end;
      adDown:
        case AState of
          cxbsDefault, cxbsNormal:
            Result := ABS_DOWNNORMAL;
          cxbsHot:
            Result := ABS_DOWNHOT;
          cxbsPressed:
            Result := ABS_DOWNPRESSED;
          cxbsDisabled:
            Result := ABS_DOWNDISABLED;
        end;
      adLeft:
        case AState of
          cxbsDefault, cxbsNormal:
            Result := ABS_LEFTNORMAL;
          cxbsHot:
            Result := ABS_LEFTHOT;
          cxbsPressed:
            Result := ABS_LEFTPRESSED;
          cxbsDisabled:
            Result := ABS_LEFTDISABLED;
        end;
      adRight:
        case AState of
          cxbsDefault, cxbsNormal:
            Result := ABS_RIGHTNORMAL;
          cxbsHot:
            Result := ABS_RIGHTHOT;
          cxbsPressed:
            Result := ABS_RIGHTPRESSED;
          cxbsDisabled:
            Result := ABS_RIGHTDISABLED;
        end;
    end;
  end;
{$WARNINGS ON}

var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totScrollBar);
  if ATheme <> 0 then
  {$IFNDEF CLR}
    DrawThemeBackground(ATheme, ACanvas.Handle, SBP_ARROWBTN, GetState, @R)
  {$ELSE}
    DrawThemeBackground(ATheme, ACanvas.Handle, SBP_ARROWBTN, GetState, R)
  {$ENDIF}
  else
    inherited
end;

class procedure TcxWinXPLookAndFeelPainter.DrawArrowBorder(ACanvas: TcxCanvas;
  const R: TRect; AState: TcxButtonState);
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
  {$IFNDEF CLR}
    DrawThemeBackground(ATheme, ACanvas.Handle, BP_PUSHBUTTON, BtnStateToXPBtnState(AState), @R)
  {$ELSE}
    DrawThemeBackground(ATheme, ACanvas.Handle, BP_PUSHBUTTON, BtnStateToXPBtnState(AState), R)
  {$ENDIF}
  else
    inherited;
end;

class function TcxWinXPLookAndFeelPainter.BorderSize: Integer;
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totListView);
  if ATheme <> 0 then
    Result := 1 //!!! lcm corrected
  else
    Result := inherited BorderSize;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
var
  ATheme: TTheme;
  ASavedDC: HDC;
begin
  ATheme := OpenTheme(totListView);
  if ATheme <> 0 then
  begin
    //DrawThemeEdge(ATheme, ACanvas.Handle, 0, 0, @R, EDGE_SUNKEN, BF_RECT, nil)
    ASavedDC := SaveDC(ACanvas.Handle);
    InflateRect(R, -1, -1);
    ACanvas.ExcludeClipRect(R);
    InflateRect(R, 1, 1);
  {$IFNDEF CLR}
    DrawThemeBackground(ATheme, ACanvas.Handle, LVP_EMPTYTEXT, 0, @R);
  {$ELSE}
    DrawThemeBackground(ATheme, ACanvas.Handle, LVP_EMPTYTEXT, 0, R);
  {$ENDIF}
    RestoreDC(ACanvas.Handle, ASavedDC);
  end
  else
    inherited;
end;

class function TcxWinXPLookAndFeelPainter.AdjustGroupButtonDisplayRect(
  const R: TRect; AButtonCount, AButtonIndex: Integer): TRect;
begin
  Result := inherited AdjustGroupButtonDisplayRect(R, AButtonCount, AButtonIndex);
  if IsThemeBackgroundPartiallyTransparent(OpenTheme(totButton), BP_PUSHBUTTON, PBS_NORMAL) then
    InflateRect(Result, 1, 1);
end;

class function TcxWinXPLookAndFeelPainter.ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer;
var
  ATheme: TTheme;
  R: TRect;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
  begin
    R := Rect(0, 0, 100, 100);
    GetThemeBackgroundContentRect(ATheme, 0, BP_PUSHBUTTON, BtnStateToXPBtnState(AState), {$IFNDEF CLR}@{$ENDIF}R, R);
    Result := R.Left;
  end
  else
    Result := inherited ButtonBorderSize;
end;

class function TcxWinXPLookAndFeelPainter.ButtonColor(AState: TcxButtonState): TColor;
var
  ATheme: TTheme;
  AColorRef: TColorRef;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
  begin
    GetThemeColor(ATheme, BP_PUSHBUTTON, BtnStateToXPBtnState(AState),
      TMT_COLOR, AColorRef);
    Result := AColorRef;
  end
  else
    Result := inherited ButtonColor(AState);
end;

class function TcxWinXPLookAndFeelPainter.ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect;
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totButton);
  if (ATheme <> 0) and (GetThemeBackgroundContentRect(ATheme, ACanvas.Canvas.Handle, BP_PUSHBUTTON, PBS_NORMAL, {$IFNDEF CLR}@{$ENDIF}R, R) = S_OK) then
    Result := R
  else
    Result := inherited ButtonFocusRect(ACanvas, R);
end;

class function TcxWinXPLookAndFeelPainter.ButtonGroupBorderSizes(AButtonCount,
  AButtonIndex: Integer): TRect;
var
  ATheme: TTheme;
  CR, R: TRect;
  DC: HDC;
begin
  ATheme := OpenTheme(totButton);
  R := Rect(0, 0, 100, 100);
  DC := GetDC(0);
  GetThemeBackgroundContentRect(ATheme, DC, BP_PUSHBUTTON, PBS_NORMAL, {$IFNDEF CLR}@{$ENDIF}R, CR);
  ReleaseDC(0, DC);
  Result := Rect(CR.Left, CR.Top, R.Right - CR.Right, R.Bottom - CR.Bottom);
  if IsThemeBackgroundPartiallyTransparent(ATheme, BP_PUSHBUTTON, PBS_NORMAL) then
    OffsetRect(Result, -1, -1);
end;

class function TcxWinXPLookAndFeelPainter.ButtonSymbolColor(
  AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor;
var
  ATheme: TTheme;
  AColorRef: TColorRef;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
  begin
    GetThemeColor(ATheme, BP_PUSHBUTTON, BtnStateToXPBtnState(AState),
      TMT_TEXTCOLOR, AColorRef);
      Result := AColorRef;
  end
  else
    Result := inherited ButtonSymbolColor(AState, ADefaultColor);
end;

class function TcxWinXPLookAndFeelPainter.ButtonTextOffset: Integer;
begin
  Result := cxTextOffset;
end;

class function TcxWinXPLookAndFeelPainter.ButtonTextShift: Integer;
begin
  Result := 0;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawButton(ACanvas: TcxCanvas; R: TRect;
  const ACaption: string; AState: TcxButtonState; ADrawBorder: Boolean = True;
  AColor: TColor = clDefault; ATextColor: TColor = clDefault);
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
  begin
    //DrawThemeParentBackground(0, ACanvas.Handle, @R);
    DrawThemeBackground(ATheme, ACanvas.Handle, BP_PUSHBUTTON,
      BtnStateToXPBtnState(AState), R);
    DrawThemeText(ATheme, ACanvas.Handle, BP_PUSHBUTTON, BtnStateToXPBtnState(AState),
      ACaption, -1, DT_CENTER or DT_VCENTER or DT_SINGLELINE, 0, R);
  end
  else
    inherited;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
const
  States: array[Boolean] of Integer = (GLPS_CLOSED, GLPS_OPENED);
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totTreeview);
  if ATheme <> 0 then
  begin
  {$IFNDEF CLR}
    DrawThemeBackground(ATheme, ACanvas.Handle, TVP_GLYPH, States[AExpanded], @R);
  {$ELSE}
    DrawThemeBackground(ATheme, ACanvas.Handle, TVP_GLYPH, States[AExpanded], R);
  {$ENDIF}
    ACanvas.ExcludeClipRect(R);
  end
  else
    inherited;
end;

class function TcxWinXPLookAndFeelPainter.DrawExpandButtonFirst: Boolean;
begin
  Result := False;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawGroupExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AState: TcxButtonState);
const
  Buttons: array[Boolean] of Integer = (EBP_NORMALGROUPEXPAND, EBP_NORMALGROUPCOLLAPSE);
  States: array[cxbsNormal..cxbsPressed] of Integer = (EBNGE_NORMAL, EBNGE_HOT, EBNGE_PRESSED);
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totExplorerBar);
  if ATheme <> 0 then
  {$IFNDEF CLR}
    DrawThemeBackground(ATheme, ACanvas.Handle, Buttons[AExpanded], States[AState], @R)
  {$ELSE}
    DrawThemeBackground(ATheme, ACanvas.Handle, Buttons[AExpanded], States[AState], R)
  {$ENDIF}
  else
    inherited;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawSmallExpandButton(ACanvas: TcxCanvas; R: TRect;
  AExpanded: Boolean; ABorderColor: TColor; AColor: TColor = clDefault);
begin
  if OpenTheme(totTreeview) <> 0 then
    DrawExpandButton(ACanvas, R, AExpanded)
  else
    inherited DrawSmallExpandButton(ACanvas, R, AExpanded, AColor);
end;

class function TcxWinXPLookAndFeelPainter.ExpandButtonSize: Integer;
var
  ATheme: TTheme;
  ASize: TSize;
begin
  ATheme := OpenTheme(totTreeview);
  if ATheme <> 0 then
  begin
  {$IFNDEF CLR}
    GetThemePartSize(ATheme, 0, TVP_GLYPH, GLPS_OPENED, nil, TS_TRUE, @ASize);
  {$ELSE}
    GetThemePartSize(ATheme, 0, TVP_GLYPH, GLPS_OPENED, TS_TRUE, ASize);
  {$ENDIF}
    Result := ASize.cx;
  end
  else
    Result := inherited ExpandButtonSize;
end;

class function TcxWinXPLookAndFeelPainter.GroupExpandButtonSize: Integer;
var
  ATheme: TTheme;
  ASize: TSize;
begin
  ATheme := OpenTheme(totExplorerBar);
  if ATheme <> 0 then
  begin
  {$IFNDEF CLR}
    GetThemePartSize(ATheme, 0, EBP_NORMALGROUPEXPAND, EBNGE_NORMAL, nil, TS_TRUE, @ASize);
  {$ELSE}
    GetThemePartSize(ATheme, 0, EBP_NORMALGROUPEXPAND, EBNGE_NORMAL, TS_TRUE, ASize);
  {$ENDIF}
    Result := ASize.cx;
  end
  else
    Result := inherited GroupExpandButtonSize;
end;

class function TcxWinXPLookAndFeelPainter.SmallExpandButtonSize: Integer;
begin
  if OpenTheme(totTreeview) <> 0 then
    Result := ExpandButtonSize
  else
    Result := inherited SmallExpandButtonSize;
end;

class function TcxWinXPLookAndFeelPainter.IsButtonHotTrack: Boolean;
begin
  Result := True;
end;

class function TcxWinXPLookAndFeelPainter.IsPointOverGroupExpandButton(const R: TRect;
  const P: TPoint): Boolean;
var
  ATheme: TTheme;
  ARegion: HRGN;
begin
  ATheme := OpenTheme(totExplorerBar);
  if ATheme <> 0 then
  begin
  {$IFNDEF CLR}
    GetThemeBackgroundRegion(ATheme, 0, EBP_NORMALGROUPEXPAND, EBNGE_NORMAL, @R, ARegion);
  {$ELSE}
    GetThemeBackgroundRegion(ATheme, 0, EBP_NORMALGROUPEXPAND, EBNGE_NORMAL, R, ARegion);
  {$ENDIF}
    Result := PtInRegion(ARegion, P.X, P.Y);
    DeleteObject(ARegion);
  end
  else
    Result := inherited IsPointOverGroupExpandButton(R, P);
end;

class function TcxWinXPLookAndFeelPainter.CheckBorderSize: Integer;
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
    Result := 0
  else
    Result := inherited CheckBorderSize;
end;

class function TcxWinXPLookAndFeelPainter.CheckButtonSize: TSize;
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
    GetThemePartSize(ATheme, 0, BP_CHECKBOX, CBS_CHECKEDNORMAL, TS_TRUE, Result)
  else
    Result := inherited CheckButtonSize;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawCheck(ACanvas: TcxCanvas; const R: TRect;
  AState: TcxButtonState; AChecked: Boolean; AColor: TColor);
const
  States: array[Boolean, TcxButtonState] of Integer =
    ((CBS_UNCHECKEDNORMAL, CBS_UNCHECKEDNORMAL, CBS_UNCHECKEDHOT, CBS_UNCHECKEDPRESSED, CBS_UNCHECKEDDISABLED),
     (CBS_CHECKEDNORMAL, CBS_CHECKEDNORMAL, CBS_CHECKEDHOT, CBS_CHECKEDPRESSED, CBS_CHECKEDDISABLED));
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
  begin
    //DrawThemeParentBackground(0, ACanvas.Handle, @R);
  {$IFNDEF CLR}
    DrawThemeBackground(ATheme, ACanvas.Handle, BP_CHECKBOX, States[AChecked, AState], @R);
  {$ELSE}
    DrawThemeBackground(ATheme, ACanvas.Handle, BP_CHECKBOX, States[AChecked, AState], R);
  {$ENDIF}
  end
  else
    inherited;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawCheckBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totButton);
  if ATheme = 0 then inherited;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawRadioButton(ACanvas: TcxCanvas; X, Y: Integer;
  AButtonState: TcxButtonState; AChecked: Boolean; AFocused: Boolean; ABrushColor: TColor;  AIsDesigning: Boolean = False);

  function GetNativeState: Integer;
  const
    ANativeStateMap: array [Boolean, TcxButtonState] of Integer = (
      (RBS_UNCHECKEDNORMAL, RBS_UNCHECKEDNORMAL, RBS_UNCHECKEDHOT,
      RBS_UNCHECKEDPRESSED, RBS_UNCHECKEDDISABLED),
      (RBS_CHECKEDNORMAL,RBS_CHECKEDNORMAL, RBS_CHECKEDHOT,
      RBS_CHECKEDPRESSED, RBS_CHECKEDDISABLED)
    );
  begin
    Result := ANativeStateMap[AChecked, AButtonState];
  end;

var
  ARadioButtonSize: TSize;
begin
  ARadioButtonSize := RadioButtonSize;
  DrawThemeBackground(OpenTheme(totButton), ACanvas.Handle, BP_RADIOBUTTON,
    GetNativeState, Rect(X, Y, X + ARadioButtonSize.cx, Y + ARadioButtonSize.cy));
end;

class function TcxWinXPLookAndFeelPainter.RadioButtonSize: TSize;
begin
  GetThemePartSize(OpenTheme(totButton), 0, BP_RADIOBUTTON, RBS_UNCHECKEDNORMAL,
    TS_TRUE, Result);
end;

class procedure TcxWinXPLookAndFeelPainter.DrawHeader(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
  ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil;
  AIsLast: Boolean = False);
const
  States: array[TcxButtonState] of Integer = (HIS_NORMAL, HIS_NORMAL, HIS_HOT, HIS_PRESSED, HIS_NORMAL);

  function GetHeaderItem: Integer;
  begin
    if AIsLast and (States[AState] = HIS_NORMAL) and
      (GetOffice11Scheme in [schNormalColor, schHomestead]) then
      Result := HP_HEADERITEMRIGHT
    else
      Result := HP_HEADERITEM;
  end;

var
  ATheme: TTheme;
  R: TRect;
  AItem: Integer;
begin
  ATheme := OpenTheme(totHeader);
  if ATheme <> 0 then
  begin
    AItem := GetHeaderItem;
  //  DrawThemeParentBackground(0, ACanvas.Handle, @ABounds);
  {$IFNDEF CLR}
    DrawThemeBackground(ATheme, ACanvas.Handle, AItem, States[AState], @ABounds);
  {$ELSE}
    DrawThemeBackground(ATheme, ACanvas.Handle, AItem, States[AState], ABounds);
  {$ENDIF}
    R := ATextAreaBounds;
    if AState = cxbsPressed then OffsetRect(R, 1, 1);
    DrawContent(ACanvas, ATheme, AItem, States[AState], ABounds, R,
      AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, False, AText,
      AFont, ATextColor, ABkColor);
  end
  else
    inherited;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawHeaderPressed(ACanvas: TcxCanvas;
  const ABounds: TRect);
begin
end;

class procedure TcxWinXPLookAndFeelPainter.DrawHeaderControlSection(
  ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
  ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
  AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine,
  AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor,
  ABkColor: TColor);
begin
  ACanvas.Brush.Color := clBtnFace;
  ACanvas.FillRect(ABounds);
  DrawHeader(ACanvas, ABounds, ATextAreaBounds, ANeighbors, ABorders,
    AState, AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
    AFont, ATextColor, ABkColor);
end;

class procedure TcxWinXPLookAndFeelPainter.DrawSortingMark(ACanvas: TcxCanvas;
  const R: TRect; AAscendingSorting: Boolean);
begin
  TcxUltraFlatLookAndFeelPainter.DrawSortingMark(ACanvas, R, AAscendingSorting);
end;

class function TcxWinXPLookAndFeelPainter.HeaderBorderSize: Integer;
var
  ATheme: TTheme;
  R: TRect;
begin
  ATheme := OpenTheme(totHeader);
  if ATheme <> 0 then
  begin
    R := Rect(0, 0, 100, 100);
  {$IFNDEF CLR}
    GetThemeBackgroundContentRect(ATheme, 0, HP_HEADERITEM, HIS_NORMAL, @R, R);
  {$ELSE}
    GetThemeBackgroundContentRect(ATheme, 0, HP_HEADERITEM, HIS_NORMAL, R, R);
  {$ENDIF}
    Result := (R.Left + R.Top) div 2;
  end
  else
    Result := inherited HeaderBorderSize;
end;

class function TcxWinXPLookAndFeelPainter.HeaderControlSectionBorderSize(
  AState: TcxButtonState = cxbsNormal): Integer;
begin
  Result := HeaderBorderSize;
end;

class function TcxWinXPLookAndFeelPainter.HeaderControlSectionContentBounds(
  const ABounds: TRect; AState: TcxButtonState): TRect;
var
  ABorderWidth: Integer;
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totHeader);
  if ATheme <> 0 then
  begin
    ABorderWidth := HeaderBorderSize;
    Result := ABounds;
    InflateRect(Result, -ABorderWidth, -ABorderWidth);
  end
  else
    Result := inherited HeaderControlSectionContentBounds(ABounds, AState);
end;

class function TcxWinXPLookAndFeelPainter.HeaderDrawCellsFirst: Boolean;
begin
  Result := False;
end;

class function TcxWinXPLookAndFeelPainter.IsHeaderHotTrack: Boolean;
begin
  Result := True;
end;

class function TcxWinXPLookAndFeelPainter.SortingMarkSize: TPoint;
begin
  Result := TcxUltraFlatLookAndFeelPainter.SortingMarkSize;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawFooterBorder(ACanvas: TcxCanvas;
  const R: TRect);
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totEdit);
  if ATheme <> 0 then
  {$IFNDEF CLR}
    DrawThemeEdge(ATheme, ACanvas.Handle, 0, 0, @R, BDR_RAISEDINNER, BF_RECT, nil)
  {$ELSE}
    DrawThemeEdge(ATheme, ACanvas.Handle, 0, 0, R, BDR_RAISEDINNER, BF_RECT)
  {$ENDIF}
  else
    inherited;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawFooterCell(ACanvas: TcxCanvas;
  const ABounds: TRect; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine: Boolean; const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totTrackBar);
  if ATheme <> 0 then
  begin
    //DrawThemeParentBackground(0, ACanvas.Handle, @ABounds);
  {$IFNDEF CLR}
    DrawThemeBackground(ATheme, ACanvas.Handle, TKP_TRACK, TRS_NORMAL, @ABounds);
  {$ELSE}
    DrawThemeBackground(ATheme, ACanvas.Handle, TKP_TRACK, TRS_NORMAL, ABounds);
  {$ENDIF}
    DrawContent(ACanvas, ATheme, TKP_TRACK, TRS_NORMAL, ABounds, FooterCellTextAreaBounds(ABounds),
      AAlignmentHorz, AAlignmentVert, AMultiLine, False, False, AText, AFont,
      ATextColor, ABkColor);
  end
  else
    inherited;
end;

class function TcxWinXPLookAndFeelPainter.FooterBorderSize: Integer;
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totEdit);
  if ATheme <> 0 then
    Result := 1 //!!!
  else
    Result := inherited FooterBorderSize;
end;

class function TcxWinXPLookAndFeelPainter.FooterCellBorderSize: Integer;
var
  ATheme: TTheme;
  R: TRect;
begin
  ATheme := OpenTheme(totTrackBar);
  if ATheme <> 0 then
  begin
    R := Rect(0, 0, 100, 100);
  {$IFNDEF CLR}
    GetThemeBackgroundContentRect(ATheme, 0, TKP_TRACK, TRS_NORMAL, @R, R);
  {$ELSE}
    GetThemeBackgroundContentRect(ATheme, 0, TKP_TRACK, TRS_NORMAL, R, R);
  {$ENDIF}
    Result := R.Left;
  end
  else
    Result := inherited FooterCellBorderSize;
end;

class function TcxWinXPLookAndFeelPainter.FooterCellOffset: Integer;
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totTrackBar);
  if ATheme <> 0 then
    Result := 1
  else
    Result := inherited FooterCellOffset;
end;

class function TcxWinXPLookAndFeelPainter.FooterDrawCellsFirst: Boolean;
begin
  Result := False;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawFilterCloseButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState);
const
  States: array[TcxButtonState] of Integer = (CBS_NORMAL, CBS_NORMAL, CBS_HOT,
    CBS_PUSHED, CBS_DISABLED);
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totWindow);
  if ATheme <> 0 then
  begin
    //DrawThemeParentBackground(0, ACanvas.Handle, @R);
  {$IFNDEF CLR}
    DrawThemeBackground(ATheme, ACanvas.Handle, WP_SMALLCLOSEBUTTON, States[AState], @R);
  {$ELSE}
    DrawThemeBackground(ATheme, ACanvas.Handle, WP_SMALLCLOSEBUTTON, States[AState], R);
  {$ENDIF}
  end
  else
    inherited;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawFilterDropDownButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean);
const
  States: array[TcxButtonState] of Integer =(CBXS_NORMAL, CBXS_NORMAL, CBXS_HOT,
    CBXS_PRESSED, CBXS_DISABLED);
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totComboBox);
  if ATheme <> 0 then
  begin
    //DrawThemeParentBackground(0, ACanvas.Handle, @R);
  {$IFNDEF CLR}
    DrawThemeBackground(ATheme, ACanvas.Handle, CP_DROPDOWNBUTTON, States[AState], @R);
  {$ELSE}
    DrawThemeBackground(ATheme, ACanvas.Handle, CP_DROPDOWNBUTTON, States[AState], R);
  {$ENDIF}
  end
  else
    inherited;
end;

class function TcxWinXPLookAndFeelPainter.FilterActivateButtonSize: TPoint;
var
  ATheme: TTheme;
  ASize: TSize;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
  begin
  {$IFNDEF CLR}
    GetThemePartSize(ATheme, 0, BP_CHECKBOX, CBS_CHECKEDNORMAL, nil, TS_TRUE, @ASize);
  {$ELSE}
    GetThemePartSize(ATheme, 0, BP_CHECKBOX, CBS_CHECKEDNORMAL, TS_TRUE, ASize);
  {$ENDIF}
    Result.X := ASize.cx; Result.Y := ASize.cy;
  end
  else
    Result := inherited FilterActivateButtonSize;
end;

class function TcxWinXPLookAndFeelPainter.FilterCloseButtonSize: TPoint;
var
  ATheme: TTheme;
  ASize: TSize;
begin
  ATheme := OpenTheme(totWindow);
  if ATheme <> 0 then
  begin
  {$IFNDEF CLR}
    GetThemePartSize(ATheme, 0, WP_SMALLCLOSEBUTTON, CBXS_NORMAL, nil, TS_TRUE, @ASize);
  {$ELSE}
    GetThemePartSize(ATheme, 0, WP_SMALLCLOSEBUTTON, CBXS_NORMAL, TS_TRUE, ASize);
  {$ENDIF}
    Result := Point(ASize.cx + 4, ASize.cy + 4);
  end
  else
    Result := inherited FilterCloseButtonSize
end;

class procedure TcxWinXPLookAndFeelPainter.DrawTab(ACanvas: TcxCanvas; R: TRect;
  ABorders: TcxBorders; const AText: string; AState: TcxButtonState; AVertical: Boolean;
  AFont: TFont; ATextColor, ABkColor: TColor; AShowPrefix: Boolean = False);
const
  States: array[TcxButtonState] of Integer =
    (TIS_NORMAL, TIS_NORMAL, TIS_HOT, TIS_SELECTED, TIS_DISABLED);
var
  ATheme: TTheme;
  AOriginalR, ADrawR: TRect;
  B: TBitmap;
  DC: HDC;

  procedure RotateRect(var R: TRect);
  var
    I: Integer;
  begin
    with R do
    begin
      I := Right;
      Right := Bottom;
      Bottom := I;
    end;
  end;

  procedure PrepareRects;
  begin
    ADrawR := R;
    if AVertical then
    begin
      if not (bTop in ABorders) then Dec(ADrawR.Left, 2);
      if not (bBottom in ABorders) then Inc(ADrawR.Right, 2);
    end
    else
    begin
      if not (bLeft in ABorders) then Dec(ADrawR.Left, 2);
      if not (bRight in ABorders) then Inc(ADrawR.Right, 2);
    end;
    if AState = cxbsPressed then
      Inc(ADrawR.Bottom)
    else
      Dec(R.Bottom);
  end;

begin
  ATheme := OpenTheme(totTab);
  if ATheme <> 0 then
  begin
    if AVertical then
    begin
      AOriginalR := R;
      OffsetRect(R, -R.Left, -R.Top);
      RotateRect(R);
      B := TBitmap.Create;
      B.PixelFormat := pf32bit;
      B.HandleType := bmDDB;
      B.Width := R.Right;
      B.Height := R.Bottom;
      DC := B.Canvas.Handle;
    end
    else
    begin
      B := nil;
      DC := ACanvas.Handle;
    end;

    PrepareRects;
  {$IFNDEF CLR}
    DrawThemeBackground(ATheme, DC, TABP_TABITEM, States[AState], @ADrawR, @R);
  {$ELSE}
    DrawThemeBackground(ATheme, DC, TABP_TABITEM, States[AState], ADrawR, R);
  {$ENDIF}

    if AVertical then
    begin
      ACanvas.RotateBitmap(B, raPlus90, True);
      RotateRect(R);
      RotateRect(ADrawR);
      ACanvas.CopyRect(Bounds(AOriginalR.Left, AOriginalR.Top, R.Right, R.Bottom),
        B.Canvas, R);
      B.Free;
      OffsetRect(R, AOriginalR.Left, AOriginalR.Top);
      OffsetRect(ADrawR, AOriginalR.Left, AOriginalR.Top);
    end;

    if AState = cxbsPressed then
      if AVertical then
        Dec(ADrawR.Right, 2)
      else
        Dec(ADrawR.Bottom, 2);
    DrawContent(ACanvas, ATheme, TABP_TABITEM, States[AState], R, ADrawR,
      taCenter, vaCenter, False, False, AShowPrefix, AText, AFont, ATextColor, ABkColor);
  end
  else
    inherited;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawTabBorder(ACanvas: TcxCanvas; R: TRect;
  ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean);
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totTab);
  if ATheme <> 0 then
  begin
    //
  end
  else
    inherited;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawTabsRoot(ACanvas: TcxCanvas;
  const R: TRect; ABorders: TcxBorders; AVertical: Boolean);
var
  ATheme: TTheme;
  AContentR, AFullR: TRect;
begin
  ATheme := OpenTheme(totTab);
  if ATheme <> 0 then
  begin
    //DrawThemeParentBackground(0, ACanvas.Handle, @R);
  {$IFNDEF CLR}
    GetThemeBackgroundContentRect(ATheme, 0, TABP_PANE, 0, @R, AContentR);
  {$ELSE}
    GetThemeBackgroundContentRect(ATheme, 0, TABP_PANE, 0, R, AContentR);
  {$ENDIF}
    AFullR := R;
    if AVertical then
    begin
      Inc(AFullR.Bottom, (R.Bottom - AContentR.Bottom) - (AContentR.Top - R.Top));
      Inc(AFullR.Right, 10);
    end
    else
    begin
      Inc(AFullR.Right, (R.Right - AContentR.Right) - (AContentR.Left - R.Left));
      Inc(AFullR.Bottom, 10);
    end;
  {$IFNDEF CLR}
    DrawThemeBackground(ATheme, ACanvas.Handle, TABP_PANE, 0, @AFullR, @R);
  {$ELSE}
    DrawThemeBackground(ATheme, ACanvas.Handle, TABP_PANE, 0, AFullR, R);
  {$ENDIF}
  end
  else
    inherited;
end;

class function TcxWinXPLookAndFeelPainter.IsDrawTabImplemented(AVertical: Boolean): Boolean;
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totTab);
  if ATheme <> 0 then
    Result := True
  else
    Result := inherited IsDrawTabImplemented(AVertical);
end;

class function TcxWinXPLookAndFeelPainter.IsTabHotTrack(AVertical: Boolean): Boolean;
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totTab);
  if ATheme <> 0 then
    Result := True
  else
    Result := inherited IsTabHotTrack(AVertical);
end;

class function TcxWinXPLookAndFeelPainter.TabBorderSize(AVertical: Boolean): Integer;
var
  ATheme: TTheme;
  //R: TRect;
begin
  ATheme := OpenTheme(totTab);
  if ATheme <> 0 then
  begin
    {R := Rect(0, 0, 100, 100);
    GetThemeBackgroundContentRect(ATheme, 0, TABP_TABITEM, TIS_NORMAL, @R, R);}
    Result := 1;//R.Left;
  end
  else
    Result := inherited TabBorderSize(AVertical);
end;

class procedure TcxWinXPLookAndFeelPainter.DrawIndicatorItem(ACanvas: TcxCanvas;
  const R: TRect; AKind: TcxIndicatorKind; AColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  TcxFlatLookAndFeelPainter.DrawIndicatorItem(ACanvas, R, AKind, AColor, AOnDrawBackground);
end;

{class function TcxWinXPLookAndFeelPainter.IndicatorDrawItemsFirst: Boolean;
begin
  Result := False;
end;}

class procedure TcxWinXPLookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);
const
  ThumbnailKind: array[Boolean] of Integer = (SBP_THUMBBTNVERT, SBP_THUMBBTNHORZ);
  ThumbnailGripperKind: array[Boolean] of Integer = (SBP_GRIPPERVERT, SBP_GRIPPERHORZ);
  ThumbnailPage: array[Boolean, Boolean] of Integer =
    ((SBP_UPPERTRACKVERT, SBP_LOWERTRACKVERT), (SBP_UPPERTRACKHORZ, SBP_LOWERTRACKHORZ));

  function GetThumbnailState: Integer;
  begin
    case AState of
      cxbsHot: Result := SCRBS_HOT;
      cxbsPressed: Result := SCRBS_PRESSED;
      cxbsDisabled: Result := SCRBS_DISABLED;
    else
      Result := SCRBS_NORMAL;
    end;
  end;

var
  ATheme: TTheme;
begin
  if IsRectEmpty(R) then Exit;
  case APart of
    sbpLineUp, sbpLineDown:
      begin
        ATheme := OpenTheme(totScrollBar);
        if ATheme <> 0 then
          DrawArrow(ACanvas, R, AState, GetArrowDirection(AHorizontal, APart))
        else
          inherited;  
      end;
    sbpThumbnail:
      begin
        ATheme := OpenTheme(totScrollBar);
        if ATheme <> 0 then
        begin
        {$IFNDEF CLR}
          DrawThemeBackground(ATheme, ACanvas.Handle, ThumbnailKind[AHorizontal],
            GetThumbnailState, @R);
        {$ELSE}
          DrawThemeBackground(ATheme, ACanvas.Handle, ThumbnailKind[AHorizontal],
            GetThumbnailState, R);
        {$ENDIF}
        {$IFNDEF CLR}
          DrawThemeBackground(ATheme, ACanvas.Handle, ThumbnailGripperKind[AHorizontal], 0, @R);
        {$ELSE}
          DrawThemeBackground(ATheme, ACanvas.Handle, ThumbnailGripperKind[AHorizontal], 0, R);
        {$ENDIF}
        end
        else
          inherited;
      end;
    sbpPageUp, sbpPageDown:
      begin
        ATheme := OpenTheme(totScrollBar);
        if ATheme <> 0 then
        {$IFNDEF CLR}
          DrawThemeBackground(ATheme, ACanvas.Handle,
            ThumbnailPage[AHorizontal, APart = sbpPageUp], GetThumbnailState, @R)
        {$ELSE}
          DrawThemeBackground(ATheme, ACanvas.Handle,
            ThumbnailPage[AHorizontal, APart = sbpPageUp], GetThumbnailState, R)
        {$ENDIF}
        else
          inherited;
      end;
  end;
end;

class function TcxWinXPLookAndFeelPainter.DefaultSchedulerViewContentColor: TColor;
begin
  Result := $D5FFFF;
end;

class procedure TcxWinXPLookAndFeelPainter.DrawMonthHeader(
  ACanvas: TcxCanvas; const ABounds: TRect; const AText: string;
  ANeighbors: TcxNeighbors; const AViewParams: TcxViewParams;
  AArrows: TcxHeaderArrows; ASideWidth: Integer;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawHeader(ACanvas, ABounds, ABounds, ANeighbors, cxBordersAll, cxbsNormal, taCenter,
    vaCenter, False, False, AText, AViewParams.Font, AViewParams.TextColor,
    AViewParams.Color, AOnDrawBackground, not (nRight in ANeighbors));
  DrawMonthHeaderArrows(ACanvas, ABounds, AArrows, ASideWidth, clWindowText);
end;

class procedure TcxWinXPLookAndFeelPainter.DrawSchedulerNavigatorButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
const
  ButtonStates: array[TcxButtonState] of Integer =
    (TS_HOT, TS_HOT, TS_CHECKED, TS_PRESSED, TS_DISABLED);
var
  ATheme: TTheme;
begin
  ATheme := OpenTheme(totToolBar);
  if ATheme <> 0 then
    DrawThemeBackground(ATheme, ACanvas.Handle, TP_BUTTON,
      ButtonStates[AState], {$IFNDEF CLR}@{$ENDIF}R)
  else
    inherited;  
end;

class procedure TcxWinXPLookAndFeelPainter.DrawSchedulerSplitterBorder(
  ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams;
  AIsHorizontal: Boolean);
var
  ATheme: TTheme;
  AColor: TColorRef;
begin
  ATheme := OpenTheme(totComboBox);
  if (OpenTheme(totListView) <> 0) and (ATheme <> 0) then
  begin
    GetThemeColor(ATheme, CP_DROPDOWNBUTTON, CBXS_NORMAL, TMT_BORDERCOLOR, AColor);
    ACanvas.SetBrushColor(AColor);
    if AIsHorizontal then
    begin
      ACanvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Top + 1));
      ACanvas.FillRect(Rect(R.Left, R.Bottom - 1, R.Right, R.Bottom));
      InflateRect(R, 1, -1);
    end
    else
    begin
      ACanvas.FillRect(Rect(R.Left, R.Top, R.Left + 1, R.Bottom));
      ACanvas.FillRect(Rect(R.Right - 1, R.Top, R.Right, R.Bottom));
      InflateRect(R, -1, 1);
    end;
    ACanvas.FillRect(R, AViewParams);
  end
  else
    TcxStandardLookAndFeelPainter.DrawSchedulerSplitterBorder(ACanvas, R,
      AViewParams, AIsHorizontal);
end;
{$ENDIF}

function GetCurrentPainterClass: TcxCustomLookAndFeelPainterClass;
begin
  Result := TcxUltraFlatLookAndFeelPainter;
end;

procedure PrepareRadioButtonImageList;
begin
  RadioButtonImageList;
end;

procedure CalculateCheckButtonSize;
var
  AButtonsBitmap: HBITMAP;
  B: Windows.TBitmap;
begin
  AButtonsBitmap := LoadBitmap(0, {$IFNDEF CLR}PChar{$ENDIF}(OBM_CHECKBOXES));
  try
    GetObject(AButtonsBitmap, SizeOf(Windows.TBitmap), {$IFNDEF CLR}@B{$ELSE}B{$ENDIF});
    FCheckButtonSize := Size(B.bmWidth div 4, B.bmHeight div 3);
  finally
    DeleteObject(AButtonsBitmap);
  end;
end;

procedure CreateIndicatorImages;
var
  B: TBitmap;

  procedure AddImage(const AResourceName: string);
  begin
    B.LoadFromResourceName(HInstance, AResourceName);
    if cxIndicatorImages = nil then
      cxIndicatorImages := TImageList.CreateSize(B.Width, B.Height);
    cxIndicatorImages.AddMasked(B, clWhite);
  end;

begin
  B := TBitmap.Create;
  try
    AddImage('CX_ARROWBITMAP');
    AddImage('CX_EDITBITMAP');
    AddImage('CX_INSERTBITMAP');
    AddImage('CX_MULTIDOTBITMAP');
    AddImage('CX_MULTIARROWBITMAP');
    AddImage('CX_FILTERBITMAP');
  finally
    B.Free;
  end;
end;

procedure DestroyIndicatorImages;
begin
  FreeAndNil(cxIndicatorImages);
end;

procedure CreateAutoHideBitmaps;
const
  Names: array[Boolean] of string = ('CX_AUTOHIDEON', 'CX_AUTOHIDEOFF');
var
  B: Boolean;
begin
  for B := False to True do
  begin
    AutoHideBitmaps[B] := TBitmap.Create;
    with AutoHideBitmaps[B] do
    begin
      Height := 16;
      Width := 16;
      Transparent := True;
      LoadFromResourceName(HInstance, Names[B]);
    end;
  end;
end;

procedure CreateStdScrollBarBitmaps;
begin
  StdScrollBitmaps[False] := TBitmap.Create;
  with StdScrollBitmaps[False] do
  begin
    Width := 8;
    Height := 8;
  end;
  StdScrollBitmaps[True] := TBitmap.Create;
  with StdScrollBitmaps[True] do
  begin
    Width := 8;
    Height := 8;
  end;
  UpdateScrollBarBitmaps;
end;

procedure UpdateScrollBarBitmaps;
var
  X, Y: Integer;
begin
  if StdScrollBitmaps[False] = nil then
    CreateStdScrollBarBitmaps;
  for X := 0 to 7 do
    for Y := 0 to 7 do
      if (Y mod 2) = (X mod 2) then
    {$IFDEF VCL}
      begin
        StdScrollBitmaps[False].Canvas.Pixels[X, Y] := clBtnFace;
        StdScrollBitmaps[True].Canvas.Pixels[X, Y] := clBlack;
      end
      else
      begin
        StdScrollBitmaps[False].Canvas.Pixels[X, Y] := clBtnHighlight;
        StdScrollBitmaps[True].Canvas.Pixels[X, Y] := cl3DDkShadow;
      end;
    {$ELSE}
      begin
        StdScrollBitmaps[False].Canvas.Pen.Color := clBtnFace;
        StdScrollBitmaps[False].Canvas.DrawPoint(X, Y);
        StdScrollBitmaps[True].Canvas.Pen.Color := clBlack;
        StdScrollBitmaps[True].Canvas.DrawPoint(X, Y);
      end
      else
      begin
        StdScrollBitmaps[False].Canvas.Pen.Color := clBtnHighlight;
        StdScrollBitmaps[False].Canvas.DrawPoint(X, Y);
        StdScrollBitmaps[True].Canvas.Pen.Color := cl3DDkShadow;
        StdScrollBitmaps[True].Canvas.DrawPoint(X, Y);
      end;
    {$ENDIF}
end;

function cxTextRect(const R: TRect): TRect;
begin
  Result := R;
  InflateRect(Result, -cxTextOffset, -cxTextOffset);
end;

procedure DestroyStdScrollBarBitmaps;
begin
  FreeAndNil(StdScrollBitmaps[False]);
  FreeAndNil(StdScrollBitmaps[True]);
end;

procedure DestroyAutoHideBitmaps;
begin
  FreeAndNil(AutoHideBitmaps[False]);
  FreeAndNil(AutoHideBitmaps[True]);
end;

initialization
  CreateIndicatorImages;
  CreateStdScrollBarBitmaps;
  CreateAutoHideBitmaps;
  FSystemPaletteChangedNotifier := TSystemPaletteChangedNotifier.Create(True);
  CalculateCheckButtonSize;

finalization
  FreeAndNil(FSystemPaletteChangedNotifier);
  DestroyAutoHideBitmaps;
  DestroyStdScrollBarBitmaps;
  DestroyIndicatorImages;
  FreeAndNil(FRadioButtonImageList);

end.

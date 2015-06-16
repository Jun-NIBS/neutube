/**@file zstackpresenter.h
 * @brief Stack presenter
 * @author Ting Zhao
 */

#ifndef _ZSTACKPRESENTER_H_
#define _ZSTACKPRESENTER_H_

#include <QPoint>
#include <QSize>
#include <QObject>
#include <vector>
#include <QMap>

#include "zinteractivecontext.h"
#include "zstroke2d.h"
#include "swctreenode.h"
#include "zactionactivator.h"
#include "zkeyeventswcmapper.h"
#include "zmouseeventmapper.h"
#include "zmouseeventprocessor.h"
#include "qthreadfuturemap.h"
#include "zsharedpointer.h"
#include "zkeyoperationmap.h"

class ZStackView;
class ZStackDoc;
class ZStackFrame;
class QMouseEvent;
class QKeyEvent;
class QAction;
class QMenu;
class ZInteractionEvent;
class ZStackOperator;
class ZStackMvc;

class ZStackPresenter : public QObject {
  Q_OBJECT

public:
  explicit ZStackPresenter(ZStackFrame *parent = 0);
  explicit ZStackPresenter(QWidget *parent = 0);
  ~ZStackPresenter();
  ZStackDoc* buddyDocument() const;
  ZStackView* buddyView() const;
  ZSharedPointer<ZStackDoc> getSharedBuddyDocument() const;

  void updateView() const;

  enum MouseButtonAction {
    LEFT_RELEASE, RIGHT_RELEASE, LEFT_PRESS, RIGHT_PRESS, LEFT_DOUBLE_CLICK, MOVE
  };

  enum EMouseEventProcessStatus {
    MOUSE_EVENT_PASSED, CONTEXT_MENU_POPPED, MOUSE_HIT_OBJECT,
    MOUSE_COMMAND_EXECUTED, MOUSE_EVENT_CAPTURED
  };

  enum EActionItem {
    ACTION_EXTEND_SWC_NODE, ACTION_SMART_EXTEND_SWC_NODE,
    ACTION_CONNECT_TO_SWC_NODE, ACTION_ADD_SWC_NODE,
    ACTION_LOCK_SWC_NODE_FOCUS, ACTION_CHANGE_SWC_NODE_FOCUS,
    ACTION_MOVE_SWC_NODE,
    ACTION_ESTIMATE_SWC_NODE_RADIUS,
    ACTION_PAINT_STROKE, ACTION_ERASE_STROKE,
    ACTION_LOCATE_SELECTED_SWC_NODES_IN_3D,
    ACTION_SPLIT_DATA, ACTION_SHOW_BODY_IN_3D,
    ACTION_BODY_SPLIT_START, ACTION_ADD_SPLIT_SEED,
    ACTION_BODY_ANNOTATION
  };

  inline double greyScale(int c = 0) const {return m_greyScale[c];}
  inline double greyOffset(int c = 0) const {return m_greyOffset[c];}
  //inline int zoomRatio() const { return m_zoomRatio; }
  //int zoomRatio() const;
  inline QList<ZStackObject*>* decorations() { return &m_decorationList; }
  inline const QList<ZStackObject*>& getActiveDecorationList() const {
    return m_activeDecorationList;
  }
  inline ZStackObject::EDisplayStyle objectStyle() { return m_objStyle; }
  inline ZInteractiveContext& interactiveContext() {
    return m_interactiveContext;
  }

  void clearData();

  bool hasObjectToShow() const;
  void setObjectVisible(bool v);
  void toggleObjectVisible();
  bool isObjectVisible();
  void setObjectStyle(ZStackObject::EDisplayStyle style);

  void initInteractiveContext();

  /*
  void updateZoomOffset(int cx, int cy, int r0);
  void updateZoomOffset(int cx, int cy, int wx, int wy);
  void setZoomOffset(int x, int y);
*/
  void processMouseReleaseEvent(QMouseEvent *event);
  virtual bool processKeyPressEvent(QKeyEvent *event);
  void processMouseMoveEvent(QMouseEvent *event);
  void processMousePressEvent(QMouseEvent *event);
  void processMouseDoubleClickEvent(QMouseEvent *eventint);

  virtual bool customKeyProcess(QKeyEvent *event);
  virtual void processCustomOperator(const ZStackOperator &op);

  void createActions();
  void createTraceActions();
  void createPunctaActions();
  void createSwcActions();
  //void createTubeActions();
  void createStrokeActions();
  void createDocDependentActions();
  void createBodyActions();
  void createMainWindowActions();

  inline QAction* getAction(EActionItem item) const {
    return m_actionMap[item];
  }

  void createSwcNodeContextMenu();
  QMenu* getSwcNodeContextMenu();

  void createStrokeContextMenu();
  QMenu* getStrokeContextMenu();

  void createStackContextMenu();
  QMenu* getStackContextMenu();

  void createBodyContextMenu();
  QMenu* getBodyContextMenu();

  bool isContextMenuOn();

  void setStackBc(double scale, double offset, int c = 0);

  /* optimize stack brightness and contrast */
  void optimizeStackBc();

  void autoThreshold();
  void binarizeStack();
  void solidifyStack();

  void autoTrace();

  void prepareView();

  void updateLeftMenu(QAction *action, bool clear = true);
  void updateRightMenu(QAction *action, bool clear = true);
  void updateRightMenu(QMenu *submenu, bool clear = true);
  void updateLeftMenu();

  //void addTubeEditFunctionToRightMenu();
  void addPunctaEditFunctionToRightMenu();
  //void addSwcEditFunctionToRightMenu();

  void setViewPortCenter(int x, int y, int z);

  const QPointF stackPositionFromMouse(MouseButtonAction mba);

  QStringList toStringList() const;

  //void enterSwcEditMode();

  void updateCursor();

  inline const ZStroke2d& getStroke() const { return m_stroke; }

  void setZoomRatio(int ratio);

  ZStackFrame* getParentFrame() const;
  ZStackMvc* getParentMvc() const;
  QWidget* getParentWidget() const;

  void setViewMode(ZInteractiveContext::ViewMode mode);

  //void updateInteractiveContext();

  //void moveImage(int mouseX, int mouseY);
  void moveViewPort(int dx, int dy);

  /*!
   * \brief Move the viewport to a certain position.
   *
   * Move the viewport to (\a x, \a y) if possible.
   */
  void moveViewPortTo(int x, int y);

  /*!
   * \brief Move a data point to the specified mouse position.
   *
   * Move the point at the canvas coordinates (\a srcX, \a srcY) under
   * the mouse point at (\a mouseX, \a mouseY), which are widget coordinates.
   */
  void moveImageToMouse(double srcX, double srcY, int mouseX, int mouseY);

  void increaseZoomRatio();
  void decreaseZoomRatio();

  /*!
   * \brief Zoom at a certain point.
   *
   * (\a x, \a y) is the reference point.
   */
  void increaseZoomRatio(int x, int y);
  void decreaseZoomRatio(int x, int y);

  /*!
   * \brief Get the current slice index.
   *
   * It returns the index of the current active slice. When no slice is active,
   * such as in the senario of the projection mode, the index is set to -1.
   */
  int getSliceIndex() const;

//  ZStackOperator makeOperator(ZStackOperator::EOperation op);

  bool isOperatable(ZStackOperator::EOperation op);
//  bool isOperatable(const ZStackOperator &op) const;

public slots:
  void addDecoration(ZStackObject *obj, bool tail = true);
  void removeLastDecoration(ZStackObject *obj);
  void removeDecoration(ZStackObject *obj, bool redraw = true);
  void removeAllDecoration();
  void traceTube();
  void fitSegment();
  void fitEllipse();
  void dropSegment();
  void enterMouseCapturingMode();
  void markPuncta();
  void deleteSelected();
  //void deleteAllPuncta();
  void enlargePuncta();
  void narrowPuncta();
  void meanshiftPuncta();
  void meanshiftAllPuncta();
  void updateStackBc();

  void enterSwcConnectMode();
  bool enterSwcExtendMode();
  void exitSwcExtendMode();
  //void enterSwcSmartExtendMode();
  void enterSwcMoveMode();
  void enterSwcAddNodeMode(double x, double y);
  void enterSwcSelectMode();
  void enterDrawStrokeMode(double x, double y);
  void enterEraseStrokeMode(double x, double y);
  void exitStrokeEdit();
  void deleteSwcNode();
  void lockSelectedSwcNodeFocus();
  void changeSelectedSwcNodeFocus();
  void processSliceChangeEvent(int z);
  void estimateSelectedSwcRadius();
  void connectSelectedSwcNode();
  void breakSelectedSwcNode();
  void selectAllSwcTreeNode();

  void trySwcAddNodeMode(double x, double y);
  void trySwcAddNodeMode();
  void tryPaintStrokeMode();
  void tryEraseStrokeMode();
  void tryDrawStrokeMode(double x, double y, bool isEraser);

  void tryDrawRectMode(double x, double y);
  void enterDrawRectMode(double x, double y);
  void tryDrawRectMode();
  void exitRectEdit();

  void selectDownstreamNode();
  void selectSwcNodeConnection(Swc_Tree_Node *lastSelected = NULL);
  void selectUpstreamNode();
  void selectBranchNode();
  void selectTreeNode();
  void selectConnectedNode();

  void notifyBodySplitTriggered();
  void notifyBodyAnnotationTriggered();
  void slotTest();

  void notifyUser(const QString &msg);

  /*!
   * \brief Turn on the active stroke
   */
  void turnOnStroke();


  /*!
   * \brief Turn off the active stroke
   */
  void turnOffStroke();

  inline bool isStrokeOn() { return m_isStrokeOn; }
  inline bool isStrokeOff() { return !isStrokeOn(); }

  const Swc_Tree_Node* getSelectedSwcNode() const;

  void updateSwcExtensionHint();

signals:
  void mousePositionCaptured(double x, double y, double z);
  void bodySplitTriggered();
  void bodyAnnotationTriggered();
  void labelSliceSelectionChanged();
  void objectVisibleTurnedOn();

private:
  void init();

  EMouseEventProcessStatus processMouseReleaseForPuncta(
      QMouseEvent *event, const ZPoint &positionInStack);
  /*
  EMouseEventProcessStatus processMouseReleaseForTube(
      QMouseEvent *event, double *positionInStack);
      */
  EMouseEventProcessStatus processMouseReleaseForSwc(
      QMouseEvent *event, const ZPoint &positionInStack);
  EMouseEventProcessStatus processMouseReleaseForStroke(
      QMouseEvent *event, const ZPoint &positionInStack);

  bool processKeyPressEventForSwc(QKeyEvent *event);
  bool processKeyPressEventForStroke(QKeyEvent *event);
  bool processKeyPressEventForStack(QKeyEvent *event);

  bool isPointInStack(double x, double y);
  QPointF mapFromWidgetToStack(const QPoint &pos);
  QPointF mapFromGlobalToStack(const QPoint &pos);

  bool estimateActiveStrokeWidth();

  void processEvent(ZInteractionEvent &event);
  void process(const ZStackOperator &op);

  void acceptActiveStroke();

protected:
  //ZStackFrame *m_parent;
  QList<ZStackObject*> m_decorationList;
  QList<ZStackObject*> m_activeDecorationList;

  bool m_showObject;
  std::vector<double> m_greyScale;
  std::vector<double> m_greyOffset;
  int m_threshold;
  ZStackObject::EDisplayStyle m_objStyle;
  //MouseState m_mouseState;
  bool m_mouseLeftButtonPressed;
  bool m_mouseRightButtonPressed;
  ZInteractiveContext m_interactiveContext;
  int m_cursorRadius;

  //actions
  QAction *m_traceAction;
  QAction *m_fitsegAction;
  QAction *m_fitEllipseAction;
  QAction *m_dropsegAction;
  QAction *m_markPunctaAction;
  QAction *m_deleteSelectedAction;
  //QAction *m_deleteAllPunctaAction;
  QAction *m_enlargePunctaAction;
  QAction *m_narrowPunctaAction;
  QAction *m_meanshiftPunctaAction;
  QAction *m_meanshiftAllPunctaAction;

  QAction *m_swcConnectToAction;
  QAction *m_swcExtendAction;
  //QAction *m_swcSmartExtendAction;
  QAction *m_swcMoveSelectedAction;
  //QAction *m_swcDeleteAction;
  //QAction *m_swcConnectSelectedAction;
  QAction *m_swcSelectConnectionAction;
  QAction *m_swcLockFocusAction;
  QAction *m_swcChangeFocusAction;
  QAction *m_swcEstimateRadiusAction;
  //QAction *m_swcSelectAllNodeAction;
  //QAction *m_swcBreakSelectedAction;

  QAction *m_selectSwcNodeDownstreamAction;
  QAction *m_selectSwcConnectionAction;
  QAction *m_selectSwcNodeBranchAction;
  QAction *m_selectSwcNodeUpstreamAction;
  QAction *m_selectSwcNodeTreeAction;
  QAction *m_selectAllConnectedSwcNodeAction;
  QAction *m_selectAllSwcNodeAction;

  QAction *m_paintStrokeAction;
  QAction *m_eraseStrokeAction;

  //  Action map
  QMap<EActionItem, QAction*> m_actionMap;

  QMenu *m_swcNodeContextMenu;
  QMenu *m_strokePaintContextMenu;
  QMenu *m_stackContextMenu;
  QMenu *m_bodyContextMenu;

  //recorded information
  int m_mouseMovePosition[3];
  int m_mouseLeftReleasePosition[3];
  int m_mouseRightReleasePosition[3];
  int m_mouseLeftPressPosition[3];
  int m_mouseRightPressPosition[3];
  int m_mouseLeftDoubleClickPosition[3];
//  QPointF m_grabPosition;
  ZPoint m_lastMouseDataCoord;

  ZStroke2d m_stroke;
  ZStroke2d m_swcStroke;
  bool m_isStrokeOn;

  ZSingleSwcNodeActionActivator m_singleSwcNodeActionActivator;
  int m_skipMouseReleaseEvent;

  ZKeyOperationMap m_swcKeyOperationMap;
  ZKeyOperationMap m_stackKeyOperationMap;

  ZKeyEventSwcMapper m_swcKeyMapper;
  //ZMouseEventLeftButtonReleaseMapper m_leftButtonReleaseMapper;
  //ZMouseEventMoveMapper m_moveMapper;

  ZMouseEventProcessor m_mouseEventProcessor;

  int m_zOrder;

  QThreadFutureMap m_futureMap;

signals:
  void viewModeChanged();
};

#endif

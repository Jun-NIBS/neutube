#ifndef ZQTHEADER_H
#define ZQTHEADER_H

#ifndef _QT_GUI_USED_
class QObject {
  QObject(QObject *parent = 0x0) {}
};
class QImage {};
class QPainter{};
class QPoint {
public:
  QPoint() {}
  QPoint(int, int) {}
};
class QPointF {
public:
  QPointF() {}
  QPointF(double, double) {}
};
class QPaintDevice{};
class QString{};
class QStringList{};
class QList{};
class QColor{};
class QRectF{};
class QRect{};
typedef double qreal;
#endif

#endif // ZQTHEADER_H

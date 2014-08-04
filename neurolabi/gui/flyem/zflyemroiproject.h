#ifndef ZFLYEMROIPROJECT_H
#define ZFLYEMROIPROJECT_H

#include <QObject>
#include "dvid/zdvidtarget.h"
#include "zclosedcurve.h"
#include "dvid/zdvidinfo.h"

class ZStackFrame;
class ZSwcTree;

class ZFlyEmRoiProject : public QObject
{
  Q_OBJECT
public:
  explicit ZFlyEmRoiProject(QObject *parent = 0);
  ~ZFlyEmRoiProject();

  void initRoi();
  void clear();
  void shallowClear();
  void setDvidTarget(const ZDvidTarget &target);
  void showDataFrame() const;
  bool hasDataFrame() const;
  void setDataFrame(ZStackFrame *frame);
  void shallowClearDataFrame();
  bool addRoi();
  void setRoi(ZClosedCurve *roi, int z);
  int getCurrentZ() const;
  int getDataZ() const;

  void setZ(int z);

  inline const ZDvidTarget& getDvidTarget() const {
    return m_dvidTarget;
  }

  const ZClosedCurve* getRoi() const;
  ZSwcTree* getRoiSwc() const;

  const ZClosedCurve* getRoi(int z) const;
  ZSwcTree* getRoiSwc(int z) const;
  ZSwcTree* getAllRoiSwc() const;

  double getMarkerRadius() const;

  bool hasOpenedRoi() const;
  int uploadRoi();
  int uploadRoi(int z);
  void downloadRoi();
  void downloadRoi(int z);
  void downloadAllRoi();
  void estimateRoi();
  inline const ZDvidInfo& getDvidInfo() const {
    return m_dvidInfo;
  }

  int findSliceToCreateRoi() const;

  void setRoiUploaded(int z, bool uploaded);
  bool isRoiCurveUploaded(int z) const;

signals:

public slots:

private:
  ZDvidTarget m_dvidTarget;
  ZDvidInfo m_dvidInfo;
  int m_z;
  ZStackFrame *m_dataFrame;
  std::vector<bool> m_isRoiCurveUploaded;
  std::vector<ZClosedCurve*> m_curveArray; //curve array sorted by z position
};

#endif // ZFLYEMROIPROJECT_H
# #####################################################################
# Automatically generated by qmake (2.01a) Mon Dec 15 16:16:33 2008
# #####################################################################
TEMPLATE = app

QMAKE_PATH = $(QMAKE)

!exists($$QMAKE_PATH) {
    QMAKE_PATH = $$[QT_INSTALL_BINS]/qmake
}


message("qmake path: $$QMAKE_PATH")

exists($$QMAKE_PATH) {
    win32 {
      DEPLOYMENT_COMMAND = $$PWD/deploy_win.bat $$QMAKE_PATH $$OUT_PWD
    }

    macx {
      DEPLOYMENT_COMMAND = $$PWD/deploy_mac $$QMAKE_PATH $$OUT_PWD
    }

    unix:!macx {
      DEPLOYMENT_COMMAND = $$PWD/deploy_linux $$QMAKE_PATH $$OUT_PWD
    }
}


CONFIG(debug, debug|release) {
    TARGET = neuTube_d
    DEFINES += _DEBUG_ _ADVANCED_ PROJECT_PATH=\"\\\"$$PWD\\\"\"
} else {
    TARGET = neuTube
}

include(extratarget.pri)

CONFIG(release, debug|release):!isEmpty(DEPLOYMENT_COMMAND) {
    QMAKE_POST_LINK += $$DEPLOYMENT_COMMAND
}

message($$DEPLOYMENT_COMMAND)
message("Post link: $$QMAKE_POST_LINK")

include(extlib.pri)

# suppress warnings from 3rd party library, works for gcc and clang
QMAKE_CXXFLAGS += -isystem ../gui/ext

CONFIG += rtti exceptions

CONFIG += static_glew
CONFIG += static_gtest

DEFINES += _QT_APPLICATION_ _QT_GUI_USED_ _NEUTUBE_ HAVE_CONFIG_H _ENABLE_DDP_ _ENABLE_WAVG_

#Machine information
HOSTNAME = $$system(echo $HOSTNAME)
USER = $$system(echo $USER)
HOME = $$system(echo $HOME)

include(add_itk.pri)

#Qt5
QT += opengl xml network
isEqual(QT_MAJOR_VERSION,5) | greaterThan(QT_MAJOR_VERSION,5) {
    isEqual(QT_MAJOR_VERSION,5) {
      lessThan(QT_MINOR_VERSION,4) {
        message("Unstable Qt version $${QT_VERSION}.")
        error("Use at least Qt 5.4.0.")
      }
    }
    message("Qt 5")
    QT += concurrent gui
    DEFINES += _QT5_
    CONFIG += c++11
    QMAKE_MACOSX_DEPLOYMENT_TARGET=10.7
}

#Qt4
isEqual(QT_MAJOR_VERSION,4) {
    message("Qt 4")
}

#QT += webkit

contains(CONFIG, static_glew) { # glew from ext folder
    include($$PWD/ext/glew.pri)
} else { # use your own glew

  win32 {
    LIBS += -lglew32 -lopengl32 -lglu32
  }


  macx {
    LIBS += -lGLEW -framework AGL -framework OpenGL
  }

  unix:!macx {
    LIBS += -lGL -lGLEW -lGLU
  }
} # static glew

contains(CONFIG, static_gtest) { # gtest from ext folder
    include($$PWD/ext/gtest.pri)
}

LIBS += -lstdc++

unix {

    macx {
        DEFINES += _NEUTUBE_MAC_
        LIBS += -framework AppKit -framework IOKit \
            -framework ApplicationServices \
            -framework CoreFoundation

        ICON = images/app.icns
        QMAKE_INFO_PLIST = images/Info.plist
        QMAKE_CXXFLAGS += -m64

        exists($${NEUROLABI_DIR}/macosx10.9) {
            QMAKE_CXXFLAGS += -std=c++11 -stdlib=libc++
            QMAKE_MAC_SDK = macosx10.9
            QMAKE_MACOSX_DEPLOYMENT_TARGET=10.9
        }

        doc.files = doc
        doc.path = Contents/MacOS
        QMAKE_BUNDLE_DATA += doc

#        config.files = config.xml
#        config.path = Contents/MacOS
#        QMAKE_BUNDLE_DATA += config
    } else {
        DEFINES += _NEUTUBE_LINUX_
        DEFINES += _LINUX_
        LIBS += -lXt -lSM -lICE \
          -lX11 -lm \
          -lpthread \
          -lGL -lrt -lGLU
        message(Checking arch...)
        contains(QMAKE_HOST.arch, x86_64) {
            message($$QMAKE_HOST.arch)
            QMAKE_CXXFLAGS += -m64
        }
        RC_FILE = images/app.icns
    }
}

win32 {
    DEFINES += _NEUTUBE_WINDOWS_
    RC_FILE = images/app.rc
}

QMAKE_CXXFLAGS += -Wno-deprecated

include(ext/QsLog/QsLog.pri)
include(ext/libqxt.pri)
include (gui_free.pri)
include(test/test.pri)

# Input
RESOURCES = gui.qrc
HEADERS += mainwindow.h \
    zimagewidget.h \
    zstackview.h \
    zimage.h \
    zstackframe.h \
    zstackpresenter.h \
    zslider.h \
    settingdialog.h \
    frameinfodialog.h \
    plotsettings.h \
    plotter.h \
    zinteractivecontext.h \
    traceoutputdialog.h \
    bcadjustdialog.h \
    ztraceproject.h \
    channeldialog.h \
    zpunctum.h \
    zeditswcdialog.h \
    cannyedgedialog.h \
    medianfilterdialog.h \
    diffusiondialog.h \
    connectedthresholddialog.h \
    zsinglechannelstack.h \
    zrescaleswcdialog.h \
    zbenchtimer.h \
    zrandom.h \
    zlocsegchainconn.h \
    distancemapdialog.h \
    regionexpanddialog.h \
    neuroniddialog.h \
    flyemskeletonizationdialog.h \
    parameterdialog.h \
    pixelquerydialog.h \
    z3dwindow.h \
    z3dinteractionhandler.h \
    zobjsitem.h \
    zobjsmodel.h \
    z3dvolumesource.h \
    z3dvolumeraycaster.h \
    zdirectionaltemplatechain.h \
    zcolormap.h \
    zclickablelabel.h \
    zcolormapeditor.h \
    z3dcanvasrenderer.h \
    zselectfilewidget.h \
    z3dtakescreenshotwidget.h \
    z3drendererbase.h \
    z3dprimitiverenderer.h \
    z3dsphererenderer.h \
    z3dlinerenderer.h \
    z3dlinewithfixedwidthcolorrenderer.h \
    z3dconerenderer.h \
    zcolormapwidgetwitheditorwindow.h \
    z3dbackgroundrenderer.h \
    z3daxis.h \
    zwidgetsgroup.h \
    z3dcanvas.h \
    zspinbox.h \
    zparameter.h \
    zstringparameter.h \
    z3drenderprocessor.h \
    z3drenderport.h \
    z3dnetworkevaluator.h \
    z3dprocessor.h \
    z3dport.h \
    z3dapplication.h \
    zoptionparameter.h \
    zcombobox.h \
    znumericparameter.h \
    zspinboxwithslider.h \
    z3dcameraparameter.h \
    zeventlistenerparameter.h \
    z3dtransferfunction.h \
    z3dtransferfunctioneditor.h \
    z3dtransferfunctionwidgetwitheditorwindow.h \
    z3dvolume.h \
    z3dpickingmanager.h \
    z3dsdfont.h \
    z3dfontrenderer.h \
    z3dcanvaseventlistener.h \
    zspanslider.h \
    z3dutils.h \
    z3dmesh.h \
    zcuboid.h \
    ztest.h \
    z3dgpuinfo.h \
    z3dtexture.h \
    z3dcamera.h \
    z3dgl.h \
    zglmutils.h \
    znormcolormap.h \
    swctypedialog.h \
    z3dshaderprogram.h \
    z3dtexturecopyrenderer.h \
    z3dtextureblendrenderer.h \
    z3dtexturecoordinaterenderer.h \
    z3dvolumeraycasterrenderer.h \
    zlocsegchain.h \
    zcurve.h \
    z3dvolumeslicerenderer.h \
    zstackfile.h \
    zxmldoc.h \
    zintmap.h \
    flyem/zsegmentationanalyzer.h \
    flyem/zsegmentationbundle.h \
    flyem/zflyemstackframe.h \
    flyem/zflyemstackdoc.h \
    z3drendertarget.h \
    z3dgraph.h \
    swcsizedialog.h \
    swcskeletontransformdialog.h \
    zprocessprogressbase.h \
    zopencv_header.h \
    mexicanhatdialog.h \
    zhdf5writer.h \
    flyem/zbcfset.h \
    zmoviescene.h \
    zmovieactor.h \
    zswcmovieactor.h \
    zmoviemaker.h \
    zmoviephotographer.h \
    zmoviescript.h \
    z3drotation.h \
    zpunctamovieactor.h \
    zstackmovieactor.h \
    zmoviesceneclipper.h\
    z3darrowrenderer.h \
    zmoviecamera.h \
    z3dimage2drenderer.h \
    flyem/zflyemdatabundle.h \
    flyem/zflyemdataframe.h \
    flyemdataform.h \
    zswcobjsmodel.h \
    zpunctaobjsmodel.h \
    zobjsmanagerwidget.h \
    zmoviescriptgenerator.h \
    zmoviestage.h \
    zalphadialog.h \
    flyem/flyemdataframeoptiondialog.h \
    z3dshadergroup.h \
    z3dcompositor.h \
    z3dgeometryfilter.h \
    z3dgraphfilter.h \
    z3dpunctafilter.h \
    z3dswcfilter.h \
    z3dscene.h \
    zqtbarprogressreporter.h \
    zstackdoccommand.h \
    zcursorstore.h \
    zmessagereporter.h \
    zqtmessagereporter.h \
    zstroke2d.h \
    neutube.h \
    zreportable.h \
    helpdialog.h \
    zswcnodeobjsmodel.h \
    zstackstatistics.h \
    zswcconnector.h \
    biocytin/biocytin.h \
    biocytin/zstackprojector.h \
    projectiondialog.h \
    zstackviewlocator.h \
    startsettingdialog.h \
    zstackreadthread.h \
    zswccolorscheme.h \
    moviedialog.h \
    zpunctumio.h \
    zstatisticsutils.h \
    zswcrangeanalyzer.h \
    zellipsoid.h \
    informationdialog.h \
    zswcnodezrangeselector.h \
    zswcnodecompositeselector.h \
    zswcnodeellipsoidrangeselector.h \
    flyemdataquerydialog.h \
    flyemdataprocessdialog.h \
    flyem/zstitchgrid.h \
    autosaveswclistdialog.h \
    zswcfilelistmodel.h \
    flyem/zflyemqualityanalyzer.h \
    flyem/zintcuboidcomposition.h \
    zswcglobalfeatureanalyzer.h \
    zcommandline.h \
    zswclocationanalyzer.h \
    flyem/zflyemneuronlistmodel.h \
    flyem/zflyemneuronpresenter.h \
    biocytin/zbiocytinfilenameparser.h \
    diagnosisdialog.h \
    zerror.h \
    zhistogram.h \
    flyem/zflyemneuronrange.h \
    flyem/zflyemneuronaxis.h \
    zswcgenerator.h \
    zpaintbundle.h \
    flyemdataexportdialog.h \
    zflyemqueryview.h \
    flyemgeosearchdialog.h \
    zqslogmessagereporter.h \
    flyemgeofilterdialog.h \
    zactionactivator.h \
    zswccurvaturefeatureanalyzer.h \
    zstackdoc.h \
    zstackdocmenustore.h \
    zstackdocmenufactory.h \
    zglew.h \
    penwidthdialog.h \
    dvid/zdvidclient.h \
    dvidobjectdialog.h \
    zpainter.h \
    resolutiondialog.h \
    dvid/zdvidbuffer.h \
    dvid/zdvidrequest.h \
    zmatlabprocess.h \
    zneuronseed.h \
    dvidimagedialog.h \
    ztiledstackframe.h \
    ztilemanager.h \
    ztilemanagerview.h \
    ztilegraphicsitem.h \
    ztileinfo.h \
    flyem/zflyemneuronimagefactory.h \
    flyem/zflyemneuronfeatureanalyzer.h \
    flyemneuronthumbnaildialog.h \
    flyem/zflyemneuronexporter.h \
    flyem/zswctreebatchmatcher.h \
    zmultitaskmanager.h \
    flyem/zflyemneuronmatchtaskmanager.h \
    flyem/zflyemneuronfiltertaskmanager.h \
    zinteractionevent.h \
    flyemhotspotdialog.h \
    flyem/zflyemqualityanalyzertaskmanager.h \
    zworkspacefactory.h \
    dvid/zdvidreader.h \
    flyembodyiddialog.h \
    zdviddialog.h \
    flyembodyfilterdialog.h \
    flyem/zskeletonizeservice.h \
    zflyemdvidreader.h \
    zstroke2darray.h \
    tilemanager.h \
    flyem/zflyemservice.h \
    zactionfactory.h \
    zstackreadfactory.h \
    zstackdoclabelstackfactory.h \
    flyem/zinteractionengine.h \
    zsparseobject.h \
    zlabelcolortable.h \
    zdocplayer.h \
    zlinesegmentobject.h \
    openvdb_header.h \
    zopenvdbobject.h \
    flyembodysplitprojectdialog.h \
    flyem/zflyembodysplitproject.h \
    zflyemnewbodysplitprojectdialog.h \
    zstroke2dobjsmodel.h \
    zdocplayerobjsmodel.h \
    flyem/zflyembookmarklistmodel.h \
    flyem/zflyembookmark.h \
    zabstractmodelpresenter.h \
    flyem/zflyembookmarkpresenter.h \
    flyem/zflyembookmarkarray.h \
    zstackobjectarray.h \
    zwindowfactory.h \
    dvid/zdvidwriter.h \
    dvidskeletonizedialog.h \
    zdialogfactory.h \
    zdvidserverwidget.h \
    zwidgetfactory.h \
    zlabelededitwidget.h \
    zlabeledcombowidget.h \
    zspinboxdialog.h \
    zbuttonbox.h \
    zkeyeventswcmapper.h \
    zflyemroidialog.h \
    flyem/zflyemroiproject.h \
    newprojectmainwindow.h \
    zmouseeventmapper.h \
    shapepaperdialog.h \
    zparameterarray.h \
    zframefactory.h \
    zactionbutton.h \
    dvid/zdvidbufferreader.h \
    zmouseevent.h \
    zmouseeventrecorder.h \
    zmouseeventprocessor.h \
    zstackoperator.h \
    zsleeper.h \
    dvid/libdvidheader.h \
    dvidoperatedialog.h \
    z3dwindowfactory.h \
    qthreadfuturemap.h \
    zstackball.h \
    zstackdochittest.h \
    zkeyeventmapper.h \
    zuserinputevent.h \
    zstackobjectmanager.h \
    zstackobjectgroup.h \
    zcolorscheme.h \
    zpunctumcolorscheme.h \
    zstackpatch.h \
    zrect2d.h \
    zobjectcolorscheme.h \
    flyem/zflyembodymerger.h \
    synapseimportdialog.h \
    flyem/zflyembodymergeproject.h \
    flyembodymergeprojectdialog.h \
    zstackdvidgrayscalefactory.h \
    zstackdocreader.h \
    flyem/zflyembodymergedoc.h \
    flyemprojectdialog.h \
    flyem/zflyembodymergeframe.h \
    zsegmentationprojectdialog.h \
    zsegmentationproject.h \
    zsegmentationprojectmodel.h \
    zsubtractswcsdialog.h \
    zmarkswcsomadialog.h \
    zlabeledspinboxwidget.h \
    zspinboxgroupdialog.h \
    zautotracedialog.h \
    zstackviewmanager.h \
    zstackviewparam.h \
    zflyemprojectmanager.h \
    zflyemdataloader.h \
    swcexportdialog.h \
    zprogressmanager.h \
    dvid/zdvidtile.h \
    dvid/zdvidresolution.h \
    dvid/zdvidtileinfo.h \
    zstackmvc.h \
    dvid/zdvidversionmodel.h \
    flyem/zflyemhackathonconfigdlg.h \
    flyem/zflyemmisc.h \
    zmessagemanager.h \
    zmessageprocessor.h \
    zmessage.h \
    zmainwindowmessageprocessor.h \
    ztestdialog.h \
    zstackdocloader.h \
    zstackwidget.h \
    dvid/zdvidversiondag.h \
    dvid/zdvidversion.h \
    dvid/zdvidversionnode.h \
    zbodysplitbutton.h \
    zmessagefactory.h \
    zmessagemanagermodel.h \
    zflyemcontrolform.h \
    dvid/zdvidtileensemble.h \
    dvid/zdvidlabelslice.h \
    zsttransform.h \
    zpixmap.h \
    flyem/flyemproofcontrolform.h \
    flyem/zflyemproofmvc.h \
    flyem/zflyemproofdoc.h \
    flyem/zflyembookmarkview.h \
    dvid/zdvidgrayslice.h \
    flyem/zproofreadwindow.h \
    dvid/zdvidsparsestack.h \
    flyem/flyemsplitcontrolform.h \
    flyem/zflyemmessagewidget.h \
    zwidgetmessage.h \
    zprogresssignal.h

FORMS += settingdialog.ui \
    frameinfodialog.ui \
    mainwindow.ui \
    traceoutputdialog.ui \
    bcadjustdialog.ui \
    channeldialog.ui \
    cannyedgedialog.ui \
    medianfilterdialog.ui \
    diffusiondialog.ui \
    connectedthresholddialog.ui \
    zmergeimagedialog.ui \
    zrescaleswcdialog.ui \
    distancemapdialog.ui \
    regionexpanddialog.ui \
    neuroniddialog.ui \
    flyemskeletonizationdialog.ui \
    parameterdialog.ui \
    pixelquerydialog.ui \
    swctypedialog.ui \
    swcsizedialog.ui \
    swcskeletontransformdialog.ui \
    mexicanhatdialog.ui \
    informationdialog.ui \
    flyemdataform.ui \
    zalphadialog.ui \
    flyem/flyemdataframeoptiondialog.ui \
    helpdialog.ui \
    projectiondialog.ui \
    startsettingdialog.ui \
    moviedialog.ui \
    flyemdataquerydialog.ui \
    flyemdataprocessdialog.ui \
    autosaveswclistdialog.ui \
    diagnosisdialog.ui \
    flyemdataexportdialog.ui \
    flyemgeosearchdialog.ui \
    flyemgeofilterdialog.ui \
    penwidthdialog.ui \
    dvidobjectdialog.ui \
    resolutiondialog.ui \
    dvidimagedialog.ui \
    flyemneuronthumbnaildialog.ui \
    flyemhotspotdialog.ui \
    flyembodyiddialog.ui \
    zdviddialog.ui \
    flyembodyfilterdialog.ui \
    tilemanager.ui \
    flyembodysplitprojectdialog.ui \
    zflyemnewbodysplitprojectdialog.ui \
    dvidskeletonizedialog.ui \
    zflyemroidialog.ui \
    newprojectmainwindow.ui \
    shapepaperdialog.ui \
    dvidoperatedialog.ui \
    synapseimportdialog.ui \
    flyembodymergeprojectdialog.ui \
    zsegmentationprojectdialog.ui \
    zmarkswcsomadialog.ui \
    swcexportdialog.ui \
    flyem/zflyemhackathonconfigdlg.ui \
    ztestdialog.ui \
    zflyemcontrolform.ui \
    flyem/flyemproofcontrolform.ui \
    flyem/flyemsplitcontrolform.ui
SOURCES += main.cpp \
    mainwindow.cpp \
    zstackview.cpp \
    zimagewidget.cpp \
    zimage.cpp \
    zstackframe.cpp \
    zstackdoc.cpp \
    zstackpresenter.cpp \
    zslider.cpp \
    settingdialog.cpp \
    frameinfodialog.cpp \
    plotsettings.cpp \
    plotter.cpp \
    zinteractivecontext.cpp \
    traceoutputdialog.cpp \
    bcadjustdialog.cpp \
    ztraceproject.cpp \
    channeldialog.cpp \
    zpunctum.cpp \
    zeditswcdialog.cpp \
    cannyedgedialog.cpp \
    zdirectionaltemplatechain.cpp \
    medianfilterdialog.cpp \
    diffusiondialog.cpp \
    connectedthresholddialog.cpp \
    zrescaleswcdialog.cpp \
    zbenchtimer.cpp \
    zrandom.cpp \
    distancemapdialog.cpp \
    regionexpanddialog.cpp \
    neuroniddialog.cpp \
    flyemskeletonizationdialog.cpp \
    parameterdialog.cpp \
    pixelquerydialog.cpp \
    z3dwindow.cpp \
    z3dinteractionhandler.cpp \
    zobjsitem.cpp \
    zobjsmodel.cpp \
    z3dvolumesource.cpp \
    z3dvolumeraycaster.cpp \
    zcolormap.cpp \
    zclickablelabel.cpp \
    zcolormapeditor.cpp \
    zlocsegchainconn.cpp \
    zlocsegchain.cpp \
    zcurve.cpp \
    z3dcanvasrenderer.cpp \
    zselectfilewidget.cpp \
    z3dtakescreenshotwidget.cpp \
    z3drendererbase.cpp \
    z3dprimitiverenderer.cpp \
    z3dsphererenderer.cpp \
    z3dlinerenderer.cpp \
    z3dlinewithfixedwidthcolorrenderer.cpp \
    z3dconerenderer.cpp \
    zcolormapwidgetwitheditorwindow.cpp \
    z3dbackgroundrenderer.cpp \
    z3daxis.cpp \
    zwidgetsgroup.cpp \
    z3dcanvas.cpp \
    zspinbox.cpp \
    zparameter.cpp \
    zstringparameter.cpp \
    z3drenderprocessor.cpp \
    z3drenderport.cpp \
    z3dnetworkevaluator.cpp \
    z3dprocessor.cpp \
    z3dport.cpp \
    z3dapplication.cpp \
    zcombobox.cpp \
    znumericparameter.cpp \
    zspinboxwithslider.cpp \
    z3dcameraparameter.cpp \
    zeventlistenerparameter.cpp \
    z3dtransferfunction.cpp \
    z3dtransferfunctioneditor.cpp \
    z3dtransferfunctionwidgetwitheditorwindow.cpp \
    z3dvolume.cpp \
    z3dpickingmanager.cpp \
    z3dsdfont.cpp \
    z3dfontrenderer.cpp \
    zspanslider.cpp \
    z3dutils.cpp \
    z3dmesh.cpp \
    ztest.cpp \
    z3dgpuinfo.cpp \
    z3dtexture.cpp \
    z3dcamera.cpp \
    z3dgl.cpp \
    znormcolormap.cpp \
    swctypedialog.cpp \
    z3dshaderprogram.cpp \
    z3dtexturecopyrenderer.cpp \
    z3dtextureblendrenderer.cpp \
    z3dtexturecoordinaterenderer.cpp \
    z3dvolumeraycasterrenderer.cpp \
    z3dvolumeslicerenderer.cpp \
    flyem/zflyemstackframe.cpp \
    flyem/zflyemstackdoc.cpp \
    z3drendertarget.cpp \
    z3dgraph.cpp \
    swcsizedialog.cpp \
    swcskeletontransformdialog.cpp \
    zprocessprogressbase.cpp \
    mexicanhatdialog.cpp \
    informationdialog.cpp \
    zmoviescene.cpp \
    zmovieactor.cpp \
    zswcmovieactor.cpp \
    zmoviemaker.cpp \
    zmoviephotographer.cpp \
    zmoviescript.cpp \
    z3drotation.cpp \
    zpunctamovieactor.cpp \
    zstackmovieactor.cpp \
    zmoviesceneclipper.cpp \
    z3darrowrenderer.cpp \
    zmoviecamera.cpp \
    z3dimage2drenderer.cpp \
    flyem/zflyemdatabundle.cpp \
    flyem/zflyemdataframe.cpp \
    flyemdataform.cpp \
    zswcobjsmodel.cpp \
    zpunctaobjsmodel.cpp \
    zobjsmanagerwidget.cpp \
    zmoviescriptgenerator.cpp \
    zmoviestage.cpp \
    zalphadialog.cpp \
    flyem/flyemdataframeoptiondialog.cpp \
    z3dshadergroup.cpp \
    z3dcompositor.cpp \
    z3dgeometryfilter.cpp \
    z3dgraphfilter.cpp \
    z3dpunctafilter.cpp \
    z3dswcfilter.cpp \
    z3dscene.cpp \
    zqtbarprogressreporter.cpp \
    zstackdoccommand.cpp \
    zcursorstore.cpp \
    zqtmessagereporter.cpp \
    zstroke2d.cpp \
    helpdialog.cpp \
    zswcnodeobjsmodel.cpp \
    biocytin/biocytin.cpp \
    projectiondialog.cpp \
    zstackviewlocator.cpp \
    startsettingdialog.cpp \
    zstackreadthread.cpp \
    zswccolorscheme.cpp \
    moviedialog.cpp \
    zpunctumio.cpp \
    flyemdataquerydialog.cpp \
    flyemdataprocessdialog.cpp \
    autosaveswclistdialog.cpp \
    zswcfilelistmodel.cpp \
    zcommandline.cpp \
    flyem/zflyemneuronlistmodel.cpp \
    flyem/zflyemneuronpresenter.cpp \
    neutube.cpp \
    diagnosisdialog.cpp \
    zpaintbundle.cpp \
    flyemdataexportdialog.cpp \
    zflyemqueryview.cpp \
    flyemgeosearchdialog.cpp \
    zqslogmessagereporter.cpp \
    flyemgeofilterdialog.cpp \
    zactionactivator.cpp \
    zswccurvaturefeatureanalyzer.cpp \
    zstackdocmenustore.cpp \
    zstackdocmenufactory.cpp \
    penwidthdialog.cpp \
    dvid/zdvidclient.cpp \
    dvidobjectdialog.cpp \
    zpainter.cpp \
    resolutiondialog.cpp \
    dvid/zdvidbuffer.cpp \
    dvid/zdvidrequest.cpp \
    zmatlabprocess.cpp \
    zneuronseed.cpp \
    dvidimagedialog.cpp \
    ztiledstackframe.cpp \
    ztilemanager.cpp \
    ztilemanagerview.cpp \
    ztilegraphicsitem.cpp \
    ztileinfo.cpp \
    flyem/zflyemneuronimagefactory.cpp \
    flyem/zflyemneuronfeatureanalyzer.cpp \
    flyemneuronthumbnaildialog.cpp \
    flyem/zflyemneuronexporter.cpp \
    flyem/zswctreebatchmatcher.cpp \
    zmultitaskmanager.cpp \
    flyem/zflyemneuronmatchtaskmanager.cpp \
    flyem/zflyemneuronfiltertaskmanager.cpp \
    zinteractionevent.cpp \
    flyemhotspotdialog.cpp \
    flyem/zflyemqualityanalyzertaskmanager.cpp \
    zworkspacefactory.cpp \
    dvid/zdvidreader.cpp \
    flyembodyiddialog.cpp \
    zdviddialog.cpp \
    flyembodyfilterdialog.cpp \
    flyem/zskeletonizeservice.cpp \
    zflyemdvidreader.cpp \
    zstroke2darray.cpp \
    tilemanager.cpp \
    flyem/zflyemservice.cpp \
    zactionfactory.cpp \
    zstackreadfactory.cpp \
    zstackdoclabelstackfactory.cpp \
    flyem/zinteractionengine.cpp \
    zsparseobject.cpp \
    zlabelcolortable.cpp \
    zdocplayer.cpp \
    zlinesegmentobject.cpp \
    zopenvdbobject.cpp \
    flyembodysplitprojectdialog.cpp \
    flyem/zflyembodysplitproject.cpp \
    zflyemnewbodysplitprojectdialog.cpp \
    zstroke2dobjsmodel.cpp \
    zdocplayerobjsmodel.cpp \
    flyem/zflyembookmarklistmodel.cpp \
    flyem/zflyembookmark.cpp \
    zabstractmodelpresenter.cpp \
    flyem/zflyembookmarkpresenter.cpp \
    flyem/zflyembookmarkarray.cpp \
    zstackobjectarray.cpp \
    zwindowfactory.cpp \
    dvid/zdvidwriter.cpp \
    dvidskeletonizedialog.cpp \
    zdialogfactory.cpp \
    zdvidserverwidget.cpp \
    zwidgetfactory.cpp \
    zlabelededitwidget.cpp \
    zlabeledcombowidget.cpp \
    zspinboxdialog.cpp \
    zbuttonbox.cpp \
    zkeyeventswcmapper.cpp \
    zflyemroidialog.cpp \
    flyem/zflyemroiproject.cpp \
    newprojectmainwindow.cpp \
    zmouseeventmapper.cpp \
    shapepaperdialog.cpp \
    zparameterarray.cpp \
    zframefactory.cpp \
    zactionbutton.cpp \
    dvid/zdvidbufferreader.cpp \
    zmouseevent.cpp \
    zmouseeventrecorder.cpp \
    zmouseeventprocessor.cpp \
    zstackoperator.cpp \
    zsleeper.cpp \
    dvidoperatedialog.cpp \
    z3dwindowfactory.cpp \
    qthreadfuturemap.cpp \
    zstackball.cpp \
    zstackdochittest.cpp \
    zkeyeventmapper.cpp \
    zuserinputevent.cpp \
    zstackobjectmanager.cpp \
    zstackobjectgroup.cpp \
    zcolorscheme.cpp \
    zpunctumcolorscheme.cpp \
    zstackpatch.cpp \
    zrect2d.cpp \
    zobjectcolorscheme.cpp \
    flyem/zflyembodymerger.cpp \
    synapseimportdialog.cpp \
    flyem/zflyembodymergeproject.cpp \
    flyembodymergeprojectdialog.cpp \
    zstackdvidgrayscalefactory.cpp \
    zstackdocreader.cpp \
    flyem/zflyembodymergedoc.cpp \
    flyemprojectdialog.cpp \
    flyem/zflyembodymergeframe.cpp \
    zsegmentationprojectdialog.cpp \
    zsegmentationproject.cpp \
    zsegmentationprojectmodel.cpp \
    zsubtractswcsdialog.cpp \
    zmarkswcsomadialog.cpp \
    zlabeledspinboxwidget.cpp \
    zspinboxgroupdialog.cpp \
    zautotracedialog.cpp \
    zstackviewmanager.cpp \
    zstackviewparam.cpp \
    zflyemprojectmanager.cpp \
    zflyemdataloader.cpp \
    swcexportdialog.cpp \
    zprogressmanager.cpp \
    dvid/zdvidtile.cpp \
    dvid/zdvidresolution.cpp \
    dvid/zdvidtileinfo.cpp \
    zstackmvc.cpp \
    dvid/zdvidversionmodel.cpp \
    flyem/zflyemhackathonconfigdlg.cpp \
    flyem/zflyemmisc.cpp \
    zmessagemanager.cpp \
    zmessageprocessor.cpp \
    zmessage.cpp \
    zmainwindowmessageprocessor.cpp \
    ztestdialog.cpp \
    zstackdocloader.cpp \
    zstackwidget.cpp \
    dvid/zdvidversiondag.cpp \
    dvid/zdvidversion.cpp \
    dvid/zdvidversionnode.cpp \
    zbodysplitbutton.cpp \
    zmessagefactory.cpp \
    zmessagemanagermodel.cpp \
    zflyemcontrolform.cpp \
    dvid/zdvidtileensemble.cpp \
    dvid/zdvidlabelslice.cpp \
    zsttransform.cpp \
    zpixmap.cpp \
    flyem/flyemproofcontrolform.cpp \
    flyem/zflyemproofmvc.cpp \
    flyem/zflyemproofdoc.cpp \
    flyem/zflyembookmarkview.cpp \
    dvid/zdvidgrayslice.cpp \
    flyem/zproofreadwindow.cpp \
    dvid/zdvidsparsestack.cpp \
    flyem/flyemsplitcontrolform.cpp \
    flyem/zflyemmessagewidget.cpp \
    zwidgetmessage.cpp \
    zprogresssignal.cpp

OTHER_FILES += \
    extlib.pri \
    extratarget.pri

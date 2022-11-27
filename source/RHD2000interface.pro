TEMPLATE = app

QT += widgets multimedia

CONFIG += static c++11 app_bundle

HEADERS = \
    okFrontPanelDLL.h \
    rhd2000evalboard.h \
    rhd2000registers.h \
    rhd2000datablock.h \
    waveplot.h \
    mainwindow.h \
    signalprocessor.h \
    bandwidthdialog.h \
    renamechanneldialog.h \
    signalchannel.h \
    signalgroup.h \
    signalsources.h \
    spikescopedialog.h \
    spikeplot.h \
    keyboardshortcutdialog.h \
    randomnumber.h \
    impedancefreqdialog.h \
    globalconstants.h \
    triggerrecorddialog.h \
    setsaveformatdialog.h \
    helpdialoghighpassfilter.h \
    helpdialognotchfilter.h \
    helpdialogdacs.h \
    helpdialogcomparators.h \
    helpdialogchipfilters.h \
    auxdigoutconfigdialog.h \
    cabledelaydialog.h \
    helpdialogfastsettle.h

SOURCES = main.cpp \
    okFrontPanelDLL.cpp \
    rhd2000evalboard.cpp \
    rhd2000registers.cpp \
    rhd2000datablock.cpp \
    waveplot.cpp \
    mainwindow.cpp \
    signalprocessor.cpp \
    bandwidthdialog.cpp \
    renamechanneldialog.cpp \
    signalchannel.cpp \
    signalgroup.cpp \
    signalsources.cpp \
    spikescopedialog.cpp \
    spikeplot.cpp \
    keyboardshortcutdialog.cpp \
    randomnumber.cpp \
    impedancefreqdialog.cpp \
    triggerrecorddialog.cpp \
    setsaveformatdialog.cpp \
    helpdialoghighpassfilter.cpp \
    helpdialognotchfilter.cpp \
    helpdialogdacs.cpp \
    helpdialogcomparators.cpp \
    helpdialogchipfilters.cpp \
    auxdigoutconfigdialog.cpp \
    cabledelaydialog.cpp \
    helpdialogfastsettle.cpp
    
RESOURCES = RHD2000interface.qrc

macx: {
    QMAKE_LFLAGS = -Wl,-install_name,@rpath/Content/Frameworks/

    contains(QMAKE_HOST.arch, arm64): {
        LibFile.files = "$$PWD/../Opal Kelly library files/Mac OS X ARM/libokFrontPanel.dylib"
        LibFile.path = $$OUT_PWD/$$join(TARGET,,,.app)/Contents/Frameworks
        COPIES += LibFile
    } else {
        LibFile.files = "$$PWD/../Opal Kelly library files/Mac OS X Intel/libokFrontPanel.dylib"
        LibFile.path = $$OUT_PWD/$$join(TARGET,,,.app)/Contents/Frameworks
        COPIES += LibFile
    }

    BitFile.files = "$$PWD/../main.bit"
    BitFile.path = $$OUT_PWD/$$join(TARGET,,,.app)/Contents/MacOS
    COPIES += BitFile
}

unix:!macx {
    LIBS += -ldl

    contains(QMAKE_HOST.arch, x86_64): {
        LibFile.files = "$$PWD/../Opal Kelly library files/Linux 64-bit/libokFrontPanel.so"
        LibFile.path = $$OUT_PWD
        COPIES += LibFile
    } else {
        LibFile.files = "$$PWD/../Opal Kelly library files/Linux 32-bit/libokFrontPanel.so"
        LibFile.path = $$OUT_PWD
        COPIES += LibFile
    }

    BitFile.files = "$$PWD/../main.bit"
    BitFile.path = $$OUT_PWD
    COPIES += BitFile
}

win32: {
    CONFIG(debug, debug|release){
        CopyFiles.path = $$OUT_PWD/debug
    } else {
        CopyFiles.path = $$OUT_PWD/release
    }
    contains(QMAKE_HOST.arch, x86_64): {
        CopyFiles.files += $$PWD/../"Opal Kelly library files"/"Windows 64-bit"/okFrontPanel.dll
    } else {
        CopyFiles.files += $$PWD/../"Opal Kelly library files"/Windows/okFrontPanel.dll
    }
    CopyFiles.files += "$$PWD/../main.bit"
    COPIES += CopyFiles
}

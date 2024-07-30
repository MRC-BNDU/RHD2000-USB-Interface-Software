FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

RUN apt update && apt install -y fuse libfuse2 tree wget qt5-default build-essential libqt5multimedia5-plugins \
    libqt5multimedia5 libqt5multimediawidgets5 qtmultimedia5-dev

COPY . .

WORKDIR source

RUN qmake && make

RUN wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage && \
    chmod +x linuxdeploy-x86_64.AppImage

RUN wget https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage && \
    chmod +x linuxdeploy-plugin-qt-x86_64.AppImage

# note that all AppImages here will be run with --appimage-extract-and-run, to avoid needing FUSE
# see https://docs.appimage.org/user-guide/troubleshooting/fuse.html#fallback-if-fuse-can-t-be-made-working
ENV APPIMAGE_EXTRACT_AND_RUN=1

RUN ./linuxdeploy-x86_64.AppImage -e RHD2000interface --plugin qt --appdir AppDir --create-desktop-file --icon-file RHD2000interface.png

RUN cp libokFrontPanel.so AppDir && cp main.bit AppDir

RUN wget -q https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage && \
    chmod +x appimagetool-x86_64.AppImage

RUN ARCH=x86_64 ./appimagetool-x86_64.AppImage AppDir
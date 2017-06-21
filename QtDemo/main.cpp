#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QStandardPaths>
#include <QOpenGLContext>

#include "filereader.h"

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QSurfaceFormat format;
    if (QOpenGLContext::openGLModuleType() == QOpenGLContext::LibGL) {
        format.setVersion(3, 2);
        format.setProfile(QSurfaceFormat::CoreProfile);
    }
    format.setDepthBufferSize(24);
    format.setStencilBufferSize(8);
    format.setSamples(4);
    // TODO
    // Setting the format breaks video effects demo
    // Not setting the format causes "FBO incomplete" error in the planets demo
    // QSurfaceFormat::setDefaultFormat(format);

    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;

    FileReader fileReader;
    engine.rootContext()->setContextProperty("fileReader", &fileReader);

    const QUrl appPath(QUrl::fromLocalFile(app.applicationDirPath()));
    const QStringList picturesLocation = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    const QUrl imagePath = picturesLocation.isEmpty() ? appPath : QUrl::fromLocalFile(picturesLocation.first());
    engine.rootContext()->setContextProperty("imagePath", imagePath);

    const QStringList moviesLocation = QStandardPaths::standardLocations(QStandardPaths::MoviesLocation);
    const QUrl videoPath = moviesLocation.isEmpty() ? appPath : QUrl::fromLocalFile(moviesLocation.first());
    engine.rootContext()->setContextProperty("videoPath", videoPath);

    engine.load(QUrl(QStringLiteral("qrc:///qml/QtDemo/main.qml")));

    return app.exec();
}

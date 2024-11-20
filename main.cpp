#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSemaphore>
#include <QSharedMemory>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("se.qt.videoEditing", "Window");

    return app.exec();
}

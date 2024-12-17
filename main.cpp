#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSemaphore>
#include <QSharedMemory>
#include <videoedit.h>

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

    // QObject *rootObject = engine->rootObjects().first();

    // connect(VideoEdit, &VideoEdit::synfinished, engine(), [qmlContext](QString out_filmpath) {
    //     // 在这里调用 QML 中的槽函数
    //     QMetaObject::invokeMethod(rootObject,
    //                               "onSynfinished",
    //                               Qt::QueuedConnection,
    //                               Q_ARG(QVariant, out_filmpath));

    //     Qt.callLater(videoEdit, "onSynfinished", Qt.QueuedConnection);
    //     console.log("onFinished called with out_filmpath: " + out_filmpath);
    //     maincontent.audioSource = out_filmpath;
    //     console.log("现在的播放路径： " + out_filmpath);
    //     maincontent.player.play();
    //     messagebox.messageDialog3.open();
    // });

    // QObject::connect(
    //     &VideoEdit,
    //     &VideoEdit::finished,
    //     &VideoEdit,
    //     [videoEdit, out_filmpath]() { emit synfinished(out_filmpath); },
    //     Qt::QueuedConnection);

    // // 创建一个唯一的信号量
    // QString sharedMemoryName = QStringLiteral("MySharedMemory");
    // QSharedMemory sharedMemory(sharedMemoryName);

    // // 创建一个信号量
    // QString semaphoreName = QStringLiteral("MySemaphore");
    // QSemaphore semaphore(1); // 初始值为1，表示信号量被占用

    // // 设置信号量为排他锁模式
    // semaphore.setKey(semaphoreName);
    // semaphore.setScoped(true);

    // // 尝试获取信号量的排他锁
    // if (semaphore.tryAcquire(1)) {
    //     // 信号量被获取，可以发送信号
    //     emit signalToReceiver(QStringLiteral("Hello from sender!"));

    //     // 释放信号量
    //     semaphore.release();
    // } else {
    //     // 信号量被占用，等待直到信号量被释放
    //     semaphore.acquire(1);
    // }

    engine.loadFromModule("se.qt.videoEditing", "Window");

    return app.exec();
}

#include "videoedit.h"
#include <QDebug>
#include <QFile>
#include <QIODevice>
#include <QProcess>
#include <QTextStream>
#include <QtCore>
#include <QProcess>

extern "C" {
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libavutil/timestamp.h> //用于时间戳的操作
#include <libswscale/swscale.h>
}

VideoEdit::VideoEdit(QObject *parent)
    : QObject{parent}
{}

std::string doubleToString(double num)
{
    char str[256];
    sprintf(str, "%lf", num);
    std::string result = str;
    return result;
}

int VideoEdit::videocut(QString in_filename,
                        QString out_filename,
                        const double starttime,
                        const double endtime)
{
    //将输出路径名字转换为index.mp4,再将文件保存在QStringListview中
    // 查找最后一个点的位置
    std::string stdString = out_filename.toStdString(); //qstring->string
    size_t lastDotPos = stdString.find_last_of('.');
    // 提取文件扩展名
    std::string fileExtension = stdString.substr(lastDotPos);
    //生成绝对路径名
    int lastIndex = out_filename.lastIndexOf('/');
    QString juedui = out_filename.left(lastIndex + 1);
    //文件名+扩展名
    out_filename = juedui + QString::number(index) + QString::fromStdString(fileExtension);
    index++;
    //将输出路径保存在QStringlist中
    // storevideo.push_back(out_filename);
    storevideo.append(out_filename);
    readPath(out_filename);
    // 发送信息给QML
    emit videoPathsChanged();

    QString ffmpegPath = "/usr/bin/ffmpeg"; // 设置FFmpeg可执行文件路径
    QStringList arguments;
    arguments << "-ss" << QString::number(starttime, 'f', 3) << "-i" << in_filename << "-t"
              << QString::number(endtime - starttime, 'f', 3) << "-c"
              << "copy" << out_filename;

    QProcess *proc = new QProcess;
    proc->setProgram(ffmpegPath);  //可执行路径
    proc->setArguments(arguments); //命令

    //qDebug() << "开始执行FFmpeg进程...";
    proc->start();
    if (!proc->waitForStarted()) {
        //qDebug() << "无法启动FFmpeg进程.";
        return -1;
    }
    if (!proc->waitForFinished(-1)) {
        //qDebug() << "FFmpeg进程执行失败.";
        return -1;
    }
    return 0;
}

// 添加素材列表中要被合并的视频的路径，然后将他们写如到filepath.txt 文件中，用于视频的合并
void VideoEdit::readPath(QString path)
{
    // 写入文件
    QFile file;
    file.setFileName("/root/Cut/AudioCutter/filepath.txt");
    if (file.open(QIODevice::WriteOnly | QIODevice::Text
                  | QIODevice::Append)) // 以追加路径方式读到文本里面
    {
        QTextStream stream(&file);
        stream << "file '" << path << "'\n";
        file.close();
    }
}

// 视频合并
// 由于我是直接接收readPath 传递过来的路径，所以我直接打开filePath.txt就可以读取视频路径了
void VideoEdit::videoMerge(QString path)
{
    //ffmpeg -f concat -safe 0 -i filepath.txt -c copy videoMerge.mp4‘

    QString ffmpegPath = "/usr/bin/ffmpeg";

    // 读取 filePath.txt 中的路径列表
    QStringList fileList;
    QFile file("/root/Cut/AudioCutter/filepath.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Fail to open filepath.txt for reading";
    }
    QTextStream stream(&file);
    while (!stream.atEnd()) {
        QString line = stream.readLine().trimmed(); // 读取每一行，去除首尾空白字符
        if (!line.isEmpty()) {
            fileList << line;
        }
    }
    file.close();

    // 构建 ffmpeg 命令
    QStringList arguments;
    arguments << "-f"
              << "concat"
              << "-safe"
              << "0"
              << "-i"
              << "/root/Cut/AudioCutter/filepath.txt"
              << "-c"
              << "copy" << path; // 保存的路径
    // 开启 ffmpeg 运行的进程
    QProcess ffmpegProcess;
    ffmpegProcess.setProgram(ffmpegPath);
    ffmpegProcess.setArguments(arguments);

    qDebug() << "Starting ffmpeg construction....";
    ffmpegProcess.start();
    ffmpegProcess.waitForFinished();

    // 检查是否成功创建进程
    if (ffmpegProcess.exitStatus() == QProcess::NormalExit && ffmpegProcess.exitCode() == 0) {
        qDebug() << "video merge successful";
        // 发送信号
        //QString mergeFilePath = dstPath + "/" + dstName;
        // emit videoMergeCompleted(mergeFilePath);
    } else
        qDebug() << "video merge failed" << ffmpegProcess.errorString();
}
QStringList VideoEdit::videoPaths() const
{
    return storevideo;

} //zy：
//从文件(in_filepath)提取字幕流文件(out_filepath)
//（如果视屏本身没有字幕流，则无法进行提取）
void VideoEdit::getSubtitle(QString in_filepath, QString out_filepath)
{
    QProcess process;
    QString ffmpegPath = "/usr/bin/ffmpeg"; // 添加 FFmpeg的执行文件

    //ffmpeg -i inputFile.mp4 -map 0:s:0 output_subtitle.srt
    QStringList arguments1;
    arguments1 << "-i" << in_filepath << "-map"
               << "0:s:0" << out_filepath;
    qDebug() << arguments1;

    // process.start(ffmpegPath, arguments1);//false
    process.setProgram(ffmpegPath);
    process.setArguments(arguments1);
    process.start();

    if (!process.waitForFinished()) {
        qDebug() << "FFmpeg process failed to finish.";
        qDebug() << "Error:" << process.error();
        qDebug() << "Error string:" << process.errorString();
        qDebug() << "Standard error output:" << process.readAllStandardError();
    } else {
        qDebug() << "Video conversion completed.";
    }
}

void VideoEdit::remove()
{
    QFile file("/root/Cut/AudioCutter/filepath.txt");
    if (!file.open(QIODevice::WriteOnly
                   | QIODevice::Truncate)) // 打开文件之前截断文件内容，即清空文件
    {
        qDebug() << "Fail to open filepath.txt for reading";
        return;
    }
    qDebug() << "File filepath.txt opened successfully for writing";
    file.close();
    qDebug() << "File filepath.txt closed successfully";
}

//为文件(in_film)添加字幕(in_subtitle)，会生成一个新的视频文件(out_filmpath)
void VideoEdit::addSubtitle(QString in_film, QString in_subtitle, QString out_filmpath)
{
    QProcess process;
    QString ffmpegPath = "/usr/bin/ffmpeg"; // 添加 FFmpeg的执行文件

    QStringList arguments1;
    arguments1 << "-i" << in_film << "-i" << in_subtitle << "-c:v"
               << "libx264"
               << "-c:a"
               << "aac"
               << "-c:s"
               << "mov_text"
               << "-map"
               << "0:v"
               << "-map"
               << "0:a"
               << "-map"
               << "1"
               << "-metadata:s:s:0"
               << "language=eng"
               << "-disposition:s:0"
               << "default" << out_filmpath;
    qDebug() << arguments1;

    process.setProgram(ffmpegPath);
    process.setArguments(arguments1);
    process.start();

    //最长复制时间为10min.因此不能合并过长的视屏文件
    if (!process.waitForFinished(600000)) {
        qDebug() << "FFmpeg process failed to finish.";
        qDebug() << "Error:" << process.error();
        qDebug() << "Error string:" << process.errorString();
        qDebug() << "Standard error output:" << process.readAllStandardError();
    } else {
        qDebug() << "Video conversion completed.";
        emit finished();
    }
}

void VideoEdit::addSubtitleAsync(const QString &in_film,
                                 const QString &in_subtitle,
                                 const QString &out_filmpath)
{
    // 创建一个新的QThread对象
    QThread *thread = new QThread();

    // 创建一个新的VideoEdit对象
    VideoEdit *worker = new VideoEdit();

    // 将worker对象移动到新线程
    worker->moveToThread(thread);

    // 连接信号和槽
    connect(thread, &QThread::started, worker, [worker, in_film, in_subtitle, out_filmpath]() {
        worker->addSubtitle(in_film, in_subtitle, out_filmpath);
    });

    //用于删除子进程
    connect(thread, &QThread::finished, thread, &QThread::deleteLater);
    QMetaObject::invokeMethod(worker, &VideoEdit::deleteLater, Qt::QueuedConnection);

    // 开始线程
    thread->start();

    //给QML端传送信号
    connect(thread, &QThread::finished, [=]() { emit synfinished(); });
}

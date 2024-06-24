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
}

// 添加素材列表中要被合并的视频的路径，然后将他们写如到filepath.txt 文件中，用于视频的合并
// to do 他需要接收clip的多个路径，没有与QML做交互，需要剪切后的路径
void VideoEdit::readPath(const QStringList *paths)
{
    // 写入文件
    QFile file;
    file.setFileName("/root/Cut/AudioCutter/filepath.txt");
    if (file.open(QIODevice::WriteOnly | QIODevice::Text
                  | QIODevice::Append)) // 以追加路径方式读到文本里面
    {
        QTextStream stream(&file);
        for (const QString &path : *paths) {
            stream << "file '" << path << "'\n";
        }
        file.close();
    }
}

// 视频合并
// 由于我是直接接收readPath 传递过来的路径，所以我直接打开filePath.txt就可以读取视频路径了
void VideoEdit::videoMerge(QString dstName, QString dstPath)
{
    //ffmpeg -f concat -safe 0 -i filepath.txt -c copy -y videoMerge.mp4‘

    QString ffmpegPath = "usr/bin/ffmpeg";

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
              << "copy"
              << "-y" << dstPath + "/" + dstName; // 保存的路径
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
        QString mergeFilePath = dstPath + "/" + dstName;
        emit videoMergeCompleted(mergeFilePath);
    } else
        qDebug() << "video merge failed" << ffmpegProcess.errorString();
}

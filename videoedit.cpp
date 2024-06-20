#include "videoedit.h"
#include <QProcess>
#include <libavformat/avformat.h> //用于封装与解封装操作
#include <libavutil/timestamp.h>  //用于时间戳的操作

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
    //版本1
    // AVFormatContext *ifmt_ctx = NULL;
    // int ret;

    // //将QString转换成char
    // const char *ch = in_filename.toStdString().c_str();
    // //打开输入文件与AVFormatContext关联
    // if ((ret == avformat_open_input(&ifmt_ctx, ch, 0, 0)) < 0) {
    //     fprintf(stderr, "Could not open input file");
    //     return -1;
    // }

    // return 0;
    //版本2
    // AVFormatContext *ofmt_ctx = NULL;
    // AVPacket pkt; //用于存储从视频流中读取的数据包
    // int ret, i;
    // std::string tr = in_filename.toStdString();
    // const char *in_filename1 = tr.data();

    // std::string tr2 = out_filename.toStdString();
    // const char *out_filename2 = tr2.data();

    // std::string cmd = "ffmpeg -i" + tr + "-strict -2 -qscale 0 -input" + "./intercept.mp4";
    // QString Qcmd = QString::fromStdString(cmd); //将string转化成qstring
    // QProcess *proc = new QProcess;
    // if (proc->state() != proc->NotRunning) {
    //     proc->waitForFinished(20000);
    // }
    // proc->start(Qcmd);
    // cmd = "ffmpeg -ss" + doubleToString(starttime) + " -i" + tr + " -t"
    //       + doubleToString(endtime - starttime) + " -c copy" + tr2;
    // Qcmd = QString::fromStdString(cmd);
    // if (proc->sate() != proc->NotRunning) {
    //     proc->waitForFinished(20000);
    // }
    // proc->start(Qcmd);
    // cmd = "rm ./intercept.mp4";
    // Qcmd = QString::fromStdString(cmd);
    // if (proc->state() != proc->NotRunning) {
    //     proc->waitForFinished(20000);
    // }
    // proc->start(Qcmd);
    //版本3
    std::string st1 = in_filename.toStdString();
    const char *in_filename1 = st1.data();

    std::string st2 = out_filename.toStdString();
    const char *out_filename2 = st2.data();
    std::string cmd = "ffmpeg -ss " + doubleToString(starttime) + " -i " + st1 + " -t "
                      + doubleToString(endtime - starttime) + " -c copy " + st2;
    QProcess *proc = new QProcess;
    QString Qcmd = QString::fromStdString(cmd);
    if (proc->state() != proc->NotRunning) {
        proc->waitForFinished(20000);
    }
    proc->start(Qcmd);
    return 0;
}

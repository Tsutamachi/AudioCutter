#include "videoedit.h"
#include <QDebug>
#include <QFile>
#include <QIODevice>
#include <QProcess>
#include <QTextStream>
#include <QtCore>

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
    //av_register_all();
    //版本
    AVFormatContext *ifmt_ctx = NULL;
    AVFormatContext *ofmt_ctx = NULL;
    AVOutputFormat *fmt;
    int ret;

    //将QString转换成char
    // const char *ch = in_filename.toStdString().c_str();
    std::string tr = in_filename.toStdString();
    const char *ch = tr.data();

    std::string tr2 = in_filename.toStdString();
    const char *ch2 = tr2.data();

    //打开输入文件与AVFormatContext关联
    if ((ret == avformat_open_input(&ifmt_ctx, ch, NULL, NULL)) < 0) {
        fprintf(stderr, "Could not open input file");
        return -1;
    }

    //查找音视频流信息
    if (avformat_find_stream_info(ifmt_ctx, NULL) < 0) {
        fprintf(stderr, "could not find stream information\n");
        return -1;
    }
    //输出上下文格式
    avformat_alloc_output_context2(&ofmt_ctx, NULL, "mp4", ch2);
    if (!ofmt_ctx) {
        printf("cannot create ouput context");
        return -1;
    }
    //复制输入文件流
    for (int i = 0; i < ifmt_ctx->nb_streams; i++) {
        AVStream *in_stream = ifmt_ctx->streams[i];
        AVStream *out_stream = avformat_new_stream(ofmt_ctx,
                                                   avcodec_find_decoder(
                                                       in_stream->codecpar->codec_id));
        if (!out_stream) {
            fprintf(stderr, "failed to allocate output stream\n");
            return -1;
        }
        // ret = avcodec_parameters_from_context(out_stream->codecpar, out_stream->codecpar);
        if (ret < 0) {
            fprintf(stderr, "could not copy the stream parameters\n");
            return -1;
        }
        //?
        out_stream->codecpar->codec_tag = 0;
    }

    //打开输出文件
    if (!(ofmt_ctx->oformat->flags & AVFMT_NOFILE)) {
        ret = avio_open(&ofmt_ctx->pb, ch2, AVIO_FLAG_WRITE);
        if (ret < 0) {
            fprintf(stderr, "could not open output file\n");
            return -1;
        }
    }

    //写入输出文件的头部
    ret = avformat_write_header(ofmt_ctx, NULL);
    if (ret < 0) {
        fprintf(stderr, "error occurred whent opening output file\n");
        return -1;
    }
    AVPacket packet;
    av_init_packet(&packet);
    while (av_read_frame(ifmt_ctx, &packet) >= 0) {
        AVStream *in_stream, *out_stream;
        in_stream = ifmt_ctx->streams[packet.stream_index];
        if (packet.stream_index >= ofmt_ctx->nb_streams) {
            av_packet_unref(&packet);
            continue;
        }
        out_stream = ofmt_ctx->streams[packet.stream_index];
        // packet.pts = av_rescale_q_rnd(packet.pts,
        //                               in_stream->time_base,
        //                               out_stream->time_base,
        //                               AV_ROUND_NEAR_INF | AV_ROUND_PASS_MINMAX);
        // packet.dts = av_rescale_q_rnd(packet.dts,
        //                               in_stream->time_base,
        //                               out_stream->time_base,
        //                               AV_ROUND_NEAR_INF | AV_ROUND_PASS_MINMAX);
        // packet.duration = av_rescale_q(packet.duration, in_stream->time_base, out_stream->time_base);
        packet.pos = -1;
        if (packet.pts < starttime * AV_TIME_BASE || packet.pts > endtime * AV_TIME_BASE) {
            av_packet_unref(&packet);
            continue;
        }

        if (av_interleaved_write_frame(ofmt_ctx, &packet) < 0) {
            fprintf(stderr, "Error muxing packet\n");
            break;
        }
        av_packet_unref(&packet);
    }
    //写入文件输出文件的尾部
    av_write_trailer(ofmt_ctx);
    // 清理资源
    avformat_close_input(&ifmt_ctx);
    if (ofmt_ctx && !(ofmt_ctx->oformat->flags & AVFMT_NOFILE)) {
        avio_closep(&ofmt_ctx->pb);
    }
    avformat_free_context(ofmt_ctx);
    return 0;

    //版本二
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
    // if (proc->state() != proc->NotRunning) {
    //     proc->waitForFinished(20000);
    // }
    // proc->start(Qcmd);
    // cmd = "rm ./intercept.mp4";
    // Qcmd = QString::fromStdString(cmd);
    // if (proc->state() != proc->NotRunning) {
    //     proc->waitForFinished(20000);
    // }/;
    // proc->start(Qcmd);

    //版本2
    // std::string st1 = in_filename.toStdString();
    // const char *in_filename1 = st1.data();

    // std::string st2 = out_filename.toStdString();
    // const char *out_filename2 = st2.data();
    // std::string cmd = "ffmpeg -ss " + doubleToString(starttime) + " -i \"" + in_filename1 + "\" -t "
    //                   + doubleToString(endtime - starttime) + " -c copy \"" + out_filename2 + "\"";
    // QString Qcmd = QString::fromStdString(cmd);
    // //创建进程
    // QProcess *proc = new QProcess;
    // if (proc->state() != proc->NotRunning) {
    //     proc->waitForFinished(20000);
    // }
    // proc->start(Qcmd);
    // proc->waitForFinished();
    // QString output = QString::fromStdString(proc->readAllStandardOutput());
    // QString error = QString::fromStdString(proc->readAllStandardError());
    // std::cout << "FFmpeg Output: " << output.toStdString() << std::endl;
    // std::cerr << "FFmpeg Error: " << error.toStdString() << std::endl;
    // //判断是否成功执行
    // if (proc->exitCode() == 0) {
    //     return 0;
    // } else {
    //     return -1;
    // }
    //return 0;
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
        return;
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
    // 开启 ffmpeg 运行的进程
    QProcess ffmpegProcess;
    ffmpegProcess.setProgram(ffmpegPath);
    ffmpegProcess.setArguments(arguments);

    qDebug() << "Starting ffmpeg construction....";
    ffmpegProcess.start();
    ffmpegProcess.waitForFinished();

    // 检查是否成功创建进程
    if (ffmpegProcess.exitStatus() == QProcess::NormalExit && ffmpegProcess.exitCode() == 0)
        qDebug() << "video merge successful";
    else
        qDebug() << "video merge failed" << ffmpegProcess.errorString();
}

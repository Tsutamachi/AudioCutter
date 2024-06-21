#include "videoedit.h"
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
    //qDebug() << "FFmpeg进程执行完毕.";

    return 0;
}

// int VideoEdit::videocut(QString in_filename,
//                         QString out_filename,
//                         const double starttime,
//                         const double endtime)
// {
//     //av_register_all();
//     //版本
//     AVFormatContext *ifmt_ctx = NULL;
//     AVFormatContext *ofmt_ctx = NULL;
//     AVOutputFormat *fmt;
//     int ret;

//     //将QString转换成char
//     // const char *ch = in_filename.toStdString().c_str();
//     std::string tr = in_filename.toStdString();
//     const char *ch = tr.data();

//     std::string tr2 = in_filename.toStdString();
//     const char *ch2 = tr2.data();

//     //打开输入文件与AVFormatContext关联
//     if ((ret == avformat_open_input(&ifmt_ctx, ch, NULL, NULL)) < 0) {
//         fprintf(stderr, "Could not open input file");
//         return -1;
//     }

//     //查找音视频流信息
//     if (avformat_find_stream_info(ifmt_ctx, NULL) < 0) {
//         fprintf(stderr, "could not find stream information\n");
//         return -1;
//     }
//     //输出上下文格式
//     avformat_alloc_output_context2(&ofmt_ctx, NULL, "mp4", ch2);
//     if (!ofmt_ctx) {
//         printf("cannot create ouput context");
//         return -1;
//     }
//     //复制输入文件流
//     for (int i = 0; i < ifmt_ctx->nb_streams; i++) {
//         AVStream *in_stream = ifmt_ctx->streams[i];
//         AVStream *out_stream = avformat_new_stream(ofmt_ctx,
//                                                    avcodec_find_decoder(
//                                                        in_stream->codecpar->codec_id));
//         if (!out_stream) {
//             fprintf(stderr, "failed to allocate output stream\n");
//             return -1;
//         }
//         ret = avcodec_parameters_from_context(out_stream->codecpar, out_stream->codec);
//         if (ret < 0) {
//             fprintf(stderr, "could not copy the stream parameters\n");
//             return -1;
//         }
//         //?
//         out_stream->codecpar->codec_tag = 0;
//     }

//     //打开输出文件
//     if (!(ofmt_ctx->oformat->flags & AVFMT_NOFILE)) {
//         ret = avio_open(&ofmt_ctx->pb, ch2, AVIO_FLAG_WRITE);
//         if (ret < 0) {
//             fprintf(stderr, "could not open output file\n");
//             return -1;
//         }
//     }

//     //写入输出文件的头部
//     ret = avformat_write_header(ofmt_ctx, NULL);
//     if (ret < 0) {
//         fprintf(stderr, "error occurred whent opening output file\n");
//         return -1;
//     }
//     AVPacket packet;
//     av_init_packet(&packet);
//     while (av_read_frame(ifmt_ctx, &packet) >= 0) {
//         AVStream *in_stream, *out_stream;
//         in_stream = ifmt_ctx->streams[packet.stream_index];
//         if (packet.stream_index >= ofmt_ctx->nb_streams) {
//             av_packet_unref(&packet);
//             continue;
//         }
//         out_stream = ofmt_ctx->streams[packet.stream_index];
//         packet.pts = av_rescale_q_rnd(packet.pts,
//                                       in_stream->time_base,
//                                       out_stream->time_base,
//                                       AV_ROUND_NEAR_INF | AV_ROUND_PASS_MINMAX);
//         packet.dts = av_rescale_q_rnd(packet.dts,
//                                       in_stream->time_base,
//                                       out_stream->time_base,
//                                       AV_ROUND_NEAR_INF | AV_ROUND_PASS_MINMAX);
//         packet.duration = av_rescale_q(packet.duration, in_stream->time_base, out_stream->time_base);
//         packet.pos = -1;
//         if (packet.pts < starttime * AV_TIME_BASE || packet.pts > endtime * AV_TIME_BASE) {
//             av_packet_unref(&packet);
//             continue;
//         }

//         if (av_interleaved_write_frame(ofmt_ctx, &packet) < 0) {
//             fprintf(stderr, "Error muxing packet\n");
//             break;
//         }
//         av_packet_unref(&packet);
//     }
//     //写入文件输出文件的尾部
//     av_write_trailer(ofmt_ctx);
//     // 清理资源
//     avformat_close_input(&ifmt_ctx);
//     if (ofmt_ctx && !(ofmt_ctx->oformat->flags & AVFMT_NOFILE)) {
//         avio_closep(&ofmt_ctx->pb);
//     }
//     avformat_free_context(ofmt_ctx);
//     return 0;

//     //版本2
//     // std::string st1 = in_filename.toStdString();
//     // const char *in_filename1 = st1.data();

//     // std::string st2 = out_filename.toStdString();
//     // const char *out_filename2 = st2.data();
//     // std::string cmd = "ffmpeg -ss " + doubleToString(starttime) + " -i \"" + in_filename1 + "\" -t "
//     //                   + doubleToString(endtime - starttime) + " -c copy \"" + out_filename2 + "\"";
//     // QString Qcmd = QString::fromStdString(cmd);
//     // //创建进程
//     // QProcess *proc = new QProcess;
//     // if (proc->state() != proc->NotRunning) {
//     //     proc->waitForFinished(20000);
//     // }
//     // proc->start(Qcmd);
//     // proc->waitForFinished();
//     // QString output = QString::fromStdString(proc->readAllStandardOutput());
//     // QString error = QString::fromStdString(proc->readAllStandardError());
//     // std::cout << "FFmpeg Output: " << output.toStdString() << std::endl;
//     // std::cerr << "FFmpeg Error: " << error.toStdString() << std::endl;
//     // //判断是否成功执行
//     // if (proc->exitCode() == 0) {
//     //     return 0;
//     // } else {
//     //     return -1;
//     // }
//     //return 0;
// }

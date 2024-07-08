// #pragma once
#include <QObject>
#include <QQmlListProperty>
#include <QtQml/qqmlregistration.h> // 注册C++类为QML类型
#include <iostream>
class VideoEdit : public QObject
{
    Q_OBJECT
    QML_ELEMENT // 注册QML类型
    // QML_NAMED_ELEMENT(vedit) // 别名

    // to do
    // Q_PROPERTY(type name READ name WRITE setName NOTIFY nameChanged FINAL)
    Q_PROPERTY(QStringList videoPaths READ videoPaths NOTIFY videoPathsChanged)

public:
    explicit VideoEdit(QObject *parent = nullptr);
    QStringList videoPaths() const;
public slots:
    void deleteDirectory();
    void readPath(QString path); // 添加路径
    void videoMerge(QString path); // 视频合并 一个目标视频的名称，一个目标路径的名称

    int videocut(QString in_filename,
                 QString out_filename,
                 const double starttime,
                 const double endtime); //视频剪辑

    void getSubtitle(QString in_filepath,
                     QString out_filepath); //从文件(in_filepath)提取字幕流文件(out_filepath)
    void addSubtitle(
        QString in_film,
        QString in_subtitle,
        QString out_filmpath); //为文件(in_film)添加字幕(in_subtitle)，会生成一个新的视频文件(out_filmpath)
    void addSubtitleAsync(
        const QString &in_film,
        const QString &in_subtitle,
        const QString &out_filmpath); //为添加字幕的操作设置一个独立的进程，防止软件系统假死
    void remove();
signals:
    void videoMergeCompleted(QString mergeFilePath); //
    void videoPathsChanged();
    void finished();
    void synfinished();

private:
    QStringList storevideo;
    int index = 0;
};

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
public:
    explicit VideoEdit(QObject *parent = nullptr);

public slots:
    void readPath(const QStringList *path); // 添加路径
    void videoMerge(QString dstName,
                    QString dstPath); // 视频合并 一个目标视频的名称，一个目标路径的名称

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

signals:
    void videoMergeCompleted(QString mergeFilePath);

private:
    QStringList storevideo;
    int index = 0;
};

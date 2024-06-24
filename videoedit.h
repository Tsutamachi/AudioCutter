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

signals:
    void videoMergeCompleted(QString mergeFilePath);
};

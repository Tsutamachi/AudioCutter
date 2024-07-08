#pragma once

#include <QObject>

class close : public QObject
{
    Q_OBJECT
public:
    explicit close(QObject *parent = nullptr);
    void showMessageBox(const QString &title, const QString &message);
signals:
};

#ifndef ENTRYMODEL_H
#define ENTRYMODEL_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlRecord>
#include <QJsonObject>
#include <QSqlTableModel>
#include <QRandomGenerator>
#include <QDateTime>

#include "sqlqmlmodel.h"

class EntryModel : public SqlQmlModel
{
    Q_OBJECT
public:
    EntryModel(QObject* parent = nullptr);

public:
    enum Status {
        New,
        Forgot,
        Temporarily,
        Firmly,
    };
    Q_ENUM(Status)

signals:
    void allReviewed();

public slots:
    int randomIndex();
    QJsonObject statusCount();

private:
    qreal weight(const QSqlRecord& entry);
};

#endif // ENTRYMODEL_H

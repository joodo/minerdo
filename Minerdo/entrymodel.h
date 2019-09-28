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
    Q_PROPERTY(int notebookId READ notebookId WRITE setNotebookId NOTIFY notebookIdChanged)

signals:
    void allReviewed();

    void notebookIdChanged(int notebookId);

public:
    enum Status {
        New,
        Forgot,
        Temporarily,
        Firmly,
    };
    Q_ENUM(Status)

    EntryModel(QObject* parent = nullptr);

    void setNotebookId(int notebookId);
    int notebookId() const;

public slots:
    int randomIndex();
    QJsonObject statusCount();

private:
    qreal weight(const QSqlRecord& entry);

    int m_notebookId;
};

#endif // ENTRYMODEL_H

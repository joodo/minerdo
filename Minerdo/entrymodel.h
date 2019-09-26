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

class EntryModel : public QSqlTableModel
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

public slots:
    void append(const QJsonObject& entry);
    void update(const QJsonObject& entry);
    void remove(int index);

    QJsonObject get(int index);
    int randomIndex();
    QJsonObject statusCount();

private:
    qreal weight(const QSqlRecord& entry);

    // QAbstractItemModel interface
public:
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role) const override;
};

#endif // ENTRYMODEL_H

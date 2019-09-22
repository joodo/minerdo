#ifndef ENTRYMODEL_H
#define ENTRYMODEL_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QJsonObject>
#include <QSqlTableModel>

class EntryModel : public QSqlTableModel
{
    Q_OBJECT
public:
    EntryModel(QObject* parent = nullptr);

public slots:
    void append(const QJsonObject& entry);
    void update(int row, const QJsonObject& entry);
    void remove(int index);
    QJsonObject get(int index);
private:

    // QAbstractItemModel interface
public:
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role) const override;
};

#endif // ENTRYMODEL_H

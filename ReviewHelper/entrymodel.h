#ifndef ENTRYMODEL_H
#define ENTRYMODEL_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QDir>
#include <QJsonObject>
#include <QSqlTableModel>

class EntryModel : public QSqlTableModel
{
    Q_OBJECT

public:
    static EntryModel* instance();
private:
    static EntryModel* m_instance;

public slots:
    void open();
    void insert(const QJsonObject& entry);
private:

    // QAbstractItemModel interface
public:
    QHash<int, QByteArray> roleNames() const;
    QVariant data(const QModelIndex &index, int role) const;
};

#endif // ENTRYMODEL_H

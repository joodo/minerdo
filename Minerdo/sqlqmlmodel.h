#ifndef SQLQMLMODEL_H
#define SQLQMLMODEL_H

#include <QSqlTableModel>
#include <QSqlRecord>
#include <QJsonObject>
#include <QSqlError>
#include <qDebug>

class SqlQmlModel : public QSqlTableModel
{
    Q_OBJECT

public:
    SqlQmlModel(QObject* parent) : QSqlTableModel(parent) { }

public slots:
    void append(const QJsonObject& entry);
    void update(const QJsonObject& entry);
    void remove(int index);

    // QAbstractItemModel interface
public:
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role) const override;
};

#endif // SQLQMLMODEL_H

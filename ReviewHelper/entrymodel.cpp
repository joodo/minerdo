#include "entrymodel.h"

#include <qDebug>

EntryModel::EntryModel(QObject *parent) : QSqlTableModel(parent)
{
    //setEditStrategy(QSqlTableModel::OnFieldChange);
    setTable("entrys");
    select();
}

void EntryModel::append(const QJsonObject &entry)
{
    auto rec = record();
    for (auto key : entry.keys()) {
        if (!rec.contains(key)) continue;
        rec.setValue(key, entry[key].toVariant());
    }
    if (!insertRecord(rowCount(), rec)) {
        qWarning() << "Failed to insert record:" << lastError().text();
    }

    select();
}

void EntryModel::update(int row, const QJsonObject &entry)
{
    auto rec = record();
    for (auto key : entry.keys()) {
        if (!rec.contains(key)) continue;
        rec.setValue(key, entry[key].toVariant());
    }
    setRecord(row, rec);
}

void EntryModel::remove(int index)
{
    removeRow(index);
    select();
}

QJsonObject EntryModel::get(int index)
{
    auto rec = record(index);
    QJsonObject object;
    for (int i = 0; i < rec.count(); i++) {
        object.insert(rec.fieldName(i), QJsonValue::fromVariant(rec.value(i)));
    }
    return object;
}

QHash<int, QByteArray> EntryModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    for (int i = 0; i < record().count(); i++) {
        roles.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
    }
    return roles;
}

QVariant EntryModel::data(const QModelIndex &index, int role) const
{
    QVariant value;

    if (index.isValid()) {
        if (role < Qt::UserRole) {
            value = QSqlTableModel::data(index, role);
        } else {
            int columnIdx = role - Qt::UserRole - 1;
            QModelIndex modelIndex = this->index(index.row(), columnIdx);
            value = QSqlTableModel::data(modelIndex, Qt::DisplayRole);
        }
    }
    return value;
}

#include "sqlqmlmodel.h"

void SqlQmlModel::append(const QJsonObject &entry)
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

void SqlQmlModel::update(const QJsonObject &entry)
{
    auto rec = record();
    for (auto key : entry.keys()) {
        if (!rec.contains(key)) continue;
        rec.setValue(key, entry[key].toVariant());
    }
    setRecord(entry["index"].toInt(), rec);
}

void SqlQmlModel::remove(int index)
{
    beginRemoveRows(QModelIndex(), index, index);
    removeRow(index);
    select();
    endRemoveRows();
}

QHash<int, QByteArray> SqlQmlModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    for (int i = 0; i < record().count(); i++) {
        roles.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
    }
    return roles;
}

QVariant SqlQmlModel::data(const QModelIndex &index, int role) const
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

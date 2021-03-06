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

    /* NOTE: QSqlTableModel STRANGE behavior when removing rows.
     * According to the documentation, "The model retains a blank row for
     * successfully deleted row until refreshed with select()."
     * So for correct data when onModelRowsRemoved emitted, I need
     * call select() BEFORE endRemoveRows(); but it will cause modelView remove
     * twice as it received rowsRemoved signal. So another select() is needed
     * AFTER endRemoveRows() called.
     */
    select();
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

#include "entrymodel.h"

#include <qDebug>

EntryModel::EntryModel(QObject *parent) : QSqlTableModel(parent)
{
    setTable("entrys"); // FIXME: typo
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

void EntryModel::update(const QJsonObject &entry)
{
    auto rec = record();
    for (auto key : entry.keys()) {
        if (!rec.contains(key)) continue;
        rec.setValue(key, entry[key].toVariant());
    }
    setRecord(entry["index"].toInt(), rec);
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
    object["index"] = index;
    return object;
}

QJsonObject EntryModel::random()
{
    qreal totalWeight = 0;
    QVector <qreal> weights;

    for (int i = 0; i < rowCount(); i++) {
        auto w = weight(record(i));
        totalWeight += w;
        weights.append(w);
    }
    if (totalWeight < 0.01) {
        return get(QRandomGenerator::global()->bounded(rowCount()));
    }

    auto rand = QRandomGenerator::global()->bounded(totalWeight);

    for (int i = 0; i < weights.length(); i++) {
        rand -= weights.at(i);
        if (rand < 0) {
            return get(i);
        }
    }

    return get(rowCount() - 1);
}

qreal EntryModel::weight(const QSqlRecord &entry)
{
    auto lastReviewedTime = QDateTime::fromMSecsSinceEpoch(entry.value("last_reviewed").toLongLong());
    auto daysToNow = lastReviewedTime.daysTo(QDateTime::currentDateTime());
    auto secsToNow = lastReviewedTime.secsTo(QDateTime::currentDateTime());

    switch (entry.value("status").toInt())
    {
    case EntryModel::New:
        return 5.0;
    case EntryModel::Forgot:
        return secsToNow > 2*60? 10 : 0;
    case EntryModel::Temporarily:
        return daysToNow > 1? 10 : 0;
    case EntryModel::Firmly:
    {
        auto w = daysToNow < 30? daysToNow : 30;
        auto t = entry.value("pass_times").toInt();
        t = t < 3? t : 3;
        return w / t;
    }
    default:
        qWarning() << "Entry status undefined: " << entry.value("status").toInt();
        return 0;
    }
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

#include "entrymodel.h"

#include <QtDebug>

EntryModel::EntryModel(QObject *parent) : SqlQmlModel(parent)
{
    setTable("entries");
    select();
}

int EntryModel::randomIndex()
{
    if (rowCount() == 0) return -1;

    qreal totalWeight = 0;
    QVector <qreal> weights;

    for (int i = 0; i < rowCount(); i++) {
        auto w = weight(record(i));
        totalWeight += w;
        weights.append(w);
    }
    if (totalWeight < 0.01) {
        emit allReviewed();
        return QRandomGenerator::global()->bounded(rowCount());
    }

    auto rand = QRandomGenerator::global()->bounded(totalWeight);

    for (int i = 0; i < weights.length(); i++) {
        rand -= weights.at(i);
        if (rand < 0) {
            qInfo() << "entry id:" << i << ", weight:" << weights.at(i);
            return i;
        }
    }

    return rowCount() - 1;
}

QJsonObject EntryModel::statusCount()
{
    int newCount = 0;
    int forgotCount = 0;
    int temporarilyCount = 0;
    int firmlyCount = 0;

    for (int i = 0; i < rowCount(); i++) {
        switch (record(i).value("status").toInt()) {
        case EntryModel::New:
            newCount += 1;
            break;
        case EntryModel::Forgot:
            forgotCount += 1;
            break;
        case EntryModel::Temporarily:
            temporarilyCount += 1;
            break;
        case EntryModel::Firmly:
            firmlyCount += 1;
            break;
        default: ;
        }
    }

    QJsonObject re;
    re["new"] = newCount;
    re["forgot"] = forgotCount;
    re["temporarily"] = temporarilyCount;
    re["firmly"] = firmlyCount;

    return re;
}

qreal EntryModel::weight(const QSqlRecord &entry)
{
    auto lastReviewedTime = QDateTime::fromMSecsSinceEpoch(entry.value("last_reviewed").toLongLong());
    auto daysToNow = lastReviewedTime.daysTo(QDateTime::currentDateTime());
    auto secsToNow = lastReviewedTime.secsTo(QDateTime::currentDateTime());
    auto passTimes = entry.value("pass_times").toInt();
    passTimes = passTimes < 1? 1 : passTimes;

    switch (entry.value("status").toInt())
    {
    case EntryModel::New:
        return 5.0;
    case EntryModel::Forgot:
        return secsToNow > 2*60? 10 : 0;
    case EntryModel::Temporarily:
        if (passTimes == 1) {
            return secsToNow > 60 * 60? 10 : 0;
        } else {
            auto t = passTimes < 8? passTimes : 8;
            auto w = daysToNow / (t-1) * 10;
            return w < 10? w : 10;
        }
    case EntryModel::Firmly:
    {
        auto t = passTimes < 3? passTimes : 3;
        auto w = daysToNow / t;
        return w < 10? w : 10;
    }
    default:
        qWarning() << "Entry status undefined: " << entry.value("status").toInt();
        return 0;
    }
}

void EntryModel::setNotebookId(int notebookId)
{
    if (m_notebookId == notebookId)
        return;

    m_notebookId = notebookId;
    if (notebookId > 0) {
        setFilter("notebook=" + QString::number(notebookId));
    } else {
        setFilter("");
    }
    select();

    emit dataChanged(index(0,0), index(rowCount() - 1, columnCount() - 1));
    emit notebookIdChanged(m_notebookId);
}

int EntryModel::notebookId() const
{
    return m_notebookId;
}

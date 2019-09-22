#include "entrymodel.h"

EntryModel* EntryModel::m_instance = nullptr;

#include <qDebug>

EntryModel *EntryModel::instance()
{
    if (m_instance == nullptr) {
        m_instance = new EntryModel();
    }
    return m_instance;
}

void EntryModel::open()
{
    if (database().isOpen()) return;

    auto database = QSqlDatabase::addDatabase("QSQLITE");
    QString dbname = QDir::home().path() + "/default.db";
    //qDebug() << dbname;
    database.setDatabaseName(dbname);
    database.open();
    //qDebug() << database.tables();

    QSqlQueryModel::setQuery("select * from entrys", database);
    //setTable("entrys");
    // setEditStrategy(QSqlTableModel::OnFieldChange);
    select();
}

void EntryModel::insert(const QJsonObject &entry)
{
    auto rec = record();
    rec.setValue("question", entry.value("question").toVariant());
    rec.setValue("answer", entry.value("answer").toVariant());
    rec.setValue("note", entry.value("note").toVariant());
    rec.setValue("status", 0);
    qDebug() <<rec;
    qDebug() <<insertRecord(-1, rec);
}

QHash<int, QByteArray> EntryModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    // record() returns an empty QSqlRecord
    for (int i = 0; i < this->record().count(); i ++) {
        roles.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
    }
    return roles;
}

QVariant EntryModel::data(const QModelIndex &index, int role) const
{
    QVariant value;

    if (index.isValid()) {
        if (role < Qt::UserRole) {
            value = QSqlQueryModel::data(index, role);
        } else {
            int columnIdx = role - Qt::UserRole - 1;
            QModelIndex modelIndex = this->index(index.row(), columnIdx);
            value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
        }
    }
    return value;
}

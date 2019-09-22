#include "notebookmanager.h"

NotebookManager* NotebookManager::m_instance = nullptr;

#include <qDebug>

NotebookManager *NotebookManager::instance()
{
    if (m_instance == nullptr) {
        m_instance = new NotebookManager();
    }
    return m_instance;
}

void NotebookManager::open()
{
    if (m_database.isOpen()) return;

    m_database = QSqlDatabase::addDatabase("QSQLITE");
    QString dbname = QDir::home().path() + "/default.db";
    // qDebug() << dbname;
    m_database.setDatabaseName(dbname);
    m_database.open();
    // qDebug() << m_database.tables();
}

void NotebookManager::insert(const QJsonObject &entry)
{
    QSqlQuery query(m_database);
    query.prepare("INSERT INTO entrys (question, answer, note, status) "
                     "VALUES (:question, :answer, :note, 0)");
    query.bindValue(":question", entry.value("question").toVariant());
    query.bindValue(":answer", entry.value("answer").toVariant());
    query.bindValue(":note", entry.value("note").toVariant());
    if (!query.exec()) {
        qDebug() << query.lastError();
    }
}

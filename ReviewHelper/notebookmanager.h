#ifndef NOTEBOOKMANAGER_H
#define NOTEBOOKMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QDir>
#include <QJsonObject>

class NotebookManager : public QObject
{
    Q_OBJECT

public:
    static NotebookManager* instance();
private:
    static NotebookManager* m_instance;

public slots:
    void open();
    void insert(const QJsonObject& entry);
private:
    QSqlDatabase m_database;
};

#endif // NOTEBOOKMANAGER_H

#include "utils.h"

#include <QCoreApplication>
#include <QDir>
#include <qDebug>

Utils* Utils::m_instance = nullptr;

Utils *Utils::instance()
{
    if (m_instance == nullptr) {
        m_instance = new Utils();
    }
    return m_instance;
}

QUrl Utils::urlFromPath(const QString &path)
{
    QDir dir(path);
    return QUrl::fromLocalFile(dir.absolutePath());
}

QString Utils::absolutePath(const QString &path) const
{
    return QDir(path).absolutePath();
}

QString Utils::absoluteFilePath(const QString &path, const QString &filename) const
{
    return QDir(path).absoluteFilePath(filename);
}

QString Utils::currentPath() const
{
    return QCoreApplication::applicationDirPath();
}

bool Utils::save(const QString &filename, const QByteArray &data)
{
    QFile file(filename);
    if (!file.open(QIODevice::WriteOnly)) return false;
    file.write(data);
    file.close();
    return true;
}

bool Utils::fileExists(const QString &path)
{
    return  QFileInfo::exists(path);
}

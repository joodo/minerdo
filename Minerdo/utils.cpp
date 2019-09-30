#include "utils.h"

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
    return QDir(path).exists();
}

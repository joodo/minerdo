#include "utils.h"
#include "platform.h"

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

QSizeF Utils::textSize(const QFont &font, const QString &string) const
{
    return QFontMetricsF(font).size(Qt::TextSingleLine, string);
}

void Utils::setWindowAlwaysOnTop(QWindow *window, bool alwaysOnTop)
{
#ifdef Q_OS_MACOS
    setAlwaysOnTop(window, alwaysOnTop);
#endif
}

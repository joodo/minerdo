#ifndef UTILS_H
#define UTILS_H

#include <QObject>
#include <QUrl>

class Utils : public QObject
{
    Q_OBJECT
public:
    static Utils* instance();

public slots:
    QUrl urlFromPath(const QString& path);
    QString absolutePath(const QString& path) const;
    QString absoluteFilePath(const QString& path, const QString& filename) const;
    QString currentPath() const;
    bool save(const QString& filename, const QByteArray& data);
    bool fileExists(const QString& path);

private:
    static Utils* m_instance;
};

#endif // UTILS_H

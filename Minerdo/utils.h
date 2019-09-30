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
    bool save(const QString& filename, const QByteArray& data);

private:
    static Utils* m_instance;
};

#endif // UTILS_H

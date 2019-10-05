#ifndef UTILS_H
#define UTILS_H

#include <QJsonArray>
#include <QJsonObject>
#include <QUrl>
#include <QFontMetricsF>
#include <QCoreApplication>
#include <QDir>
#include <QTextDocument>
#include <QLocale>
#include <QTranslator>
#include <QSettings>

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
    QSizeF textSize(const QFont& font, const QString& string) const;
    void setWindowAlwaysOnTop(QWindow* window, bool alwaysOnTop = true);
    QString strip(const QString& html) const;

    QJsonArray supportLanguages() const;
    QString systemLanguage() const;

private:
    static Utils* m_instance;

    QTranslator *m_currentTranslator = nullptr;
};

#endif // UTILS_H

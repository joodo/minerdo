#ifndef SEARCHENGINE_H
#define SEARCHENGINE_H

#include <QAbstractItemModel>
#include <QRegularExpression>
#include <QJsonObject>

class SearchEngine : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList searchResult READ searchResult NOTIFY searchResultChanged)
    Q_PROPERTY(bool noResult READ noResult NOTIFY noResultChanged)
public:
    static SearchEngine *instance();

    QVariantList searchResult() const;
    bool noResult() const;

signals:
    void searchResultChanged(QVariantList searchResult);

    void noResultChanged(bool noResult);

public slots:
    void updateIndex(QAbstractItemModel* model, const QStringList& fields);
    void search(const QString& query);
    void clearResult();

private:
    inline QString clipString(const QString& string, int pos);

    static SearchEngine* m_instance;

    QStringList m_data;
    QVariantList m_searchResult;
    bool m_noResult;
};

#endif // SEARCHENGINE_H

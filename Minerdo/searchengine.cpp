#include "searchengine.h"

#include <QtDebug>

SearchEngine* SearchEngine::m_instance = nullptr;

SearchEngine *SearchEngine::instance()
{
    if (m_instance == nullptr) {
        m_instance = new SearchEngine();
    }
    return m_instance;
}

QVariantList SearchEngine::searchResult() const
{
    return m_searchResult;
}

bool SearchEngine::noResult() const
{
    return m_noResult;
}

void SearchEngine::updateIndex(QAbstractItemModel *model, const QStringList &fields)
{
    m_data.clear();

    QVector<int> roles;
    auto roleNames = model->roleNames();

    for (auto field : fields) {
        auto role = roleNames.key(field.toUtf8());
        if (role > 0) {
            roles.append(role);
        } else {
            qWarning() << "Can't find field name: " << field;
        }
    }

    for (auto row = 0; row < model->rowCount(); row++) {
        QString entry;
        for (auto role : roles) {
            auto s = model->data(model->index(row, 0), role).toString();
            if (!s.isEmpty()) {
                entry += s + "; ";
            }
        }
        m_data.append(entry);
    }
}

void SearchEngine::search(const QString &query)
{
    m_searchResult.clear();

    for (auto i = 0; i < m_data.length(); i++) {
        auto pos = m_data.at(i).indexOf(query, 0, Qt::CaseInsensitive);
        if (pos < 0) continue;
        auto result = clipString(m_data.at(i), pos);
        auto regExp = QRegularExpression(QString("(%1)").arg(query),
                                         QRegularExpression::CaseInsensitiveOption);
        result.replace(regExp, "<strong>\\1</strong>").replace("\n", " ");

        QJsonObject o;
        o["index"] = i;
        o["result"] = result;

        m_searchResult.append(o);
    }

    emit searchResultChanged(m_searchResult);

    if (m_noResult != m_searchResult.isEmpty()) {
        m_noResult = m_searchResult.isEmpty();
        emit noResultChanged(m_noResult);
    }
}

void SearchEngine::clearResult()
{
    if (!m_searchResult.isEmpty()) {
        m_searchResult.clear();
        emit searchResultChanged(m_searchResult);
    }

    if (m_noResult) {
        m_noResult = false;
        emit noResultChanged(m_noResult);
    }
}

QString SearchEngine::clipString(const QString &string, int pos)
{
    int start;
    for (start = pos > 10? pos-10 : 0; start > 0; start--) {
        if (string.at(start) == ' ') break;
    }
    QString clip;
    if (start != 0) {
        clip += "...";
    }
    clip += string.mid(start, 150);
    if (start + 150 > string.length()) {
        clip += "...";
    }
    return clip;
}

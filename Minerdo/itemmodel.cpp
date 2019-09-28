#include "itemmodel.h"

#include <qDebug>

bool ItemModel::exists()
{
    return m_index >= 0 && m_index < m_model->rowCount();
}

ItemModel::ItemModel(QObject *parent) : QObject(parent), m_model(nullptr), m_index(-1)
{
    m_item = new QQmlPropertyMap(this);
}

ItemModel::~ItemModel()
{
    m_item->deleteLater();
}

QAbstractItemModel *ItemModel::model() const
{
    return m_model;
}

int ItemModel::index() const
{
    return m_index;
}

void ItemModel::setModel(QAbstractItemModel *model)
{
    if (m_model == model)
        return;

    if (m_model != nullptr) {
        for (auto key : m_item->keys()) {
            m_item->clear(key);
        }
        disconnect(m_model, &QAbstractItemModel::dataChanged,
                   this, &ItemModel::onModelDataChanged);
        disconnect(m_model, &QAbstractItemModel::rowsRemoved,
                   this, &ItemModel::onModelRowsRemoved);
    }

    m_model = model;
    connect(m_model, &QAbstractItemModel::dataChanged,
            this, &ItemModel::onModelDataChanged);
    connect(m_model, &QAbstractItemModel::rowsRemoved,
            this, &ItemModel::onModelRowsRemoved);

    updateProperties();

    emit modelChanged(m_model);
}

void ItemModel::setIndex(int index)
{
    if (m_index == index)
        return;

    m_index = index;
    updateProperties();

    emit indexChanged(m_index);
}

QQmlPropertyMap *ItemModel::item() const
{
    return m_item;
}

void ItemModel::onModelDataChanged(const QModelIndex &topLeft, const QModelIndex &bottomRight)
{
    if (m_index < topLeft.row() || m_index > bottomRight.row()) return;
    updateProperties();
}

void ItemModel::onModelRowsRemoved(const QModelIndex &parent, int first, int last)
{
    Q_UNUSED(parent)
    if (m_index < first || m_index > last) return;
    m_index = -1;
    emit itemRemoved();
}

void ItemModel::updateProperties()
{
    if (m_model == nullptr || !exists()) return;

    auto roleNames = m_model->roleNames();
    for (auto iterator = roleNames.begin();
         iterator != roleNames.end();
         iterator++) {
        auto key = iterator.value();
        auto modelIndex = m_model->index(m_index, 0);
        if (key.isEmpty()) continue;
        m_item->insert(key, m_model->data(modelIndex, iterator.key()));
    }
    m_item->insert("index", m_index);
}

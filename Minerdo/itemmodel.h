#ifndef ITEMMODEL_H
#define ITEMMODEL_H

#include <QAbstractItemModel>
#include <QHash>
#include <QQmlPropertyMap>

class ItemModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QAbstractItemModel* model READ model WRITE setModel NOTIFY modelChanged)
    Q_PROPERTY(int index READ index WRITE setIndex NOTIFY indexChanged)
    Q_PROPERTY(QQmlPropertyMap* item READ item NOTIFY itemChanged)

signals:
    void modelChanged(QAbstractItemModel* model);
    void indexChanged(int index);
    void itemChanged(QQmlPropertyMap* item);
    void itemRemoved();

public slots:
    bool exists();

public:
    ItemModel(QObject *parent = nullptr);
    ~ItemModel();

    void setModel(QAbstractItemModel* model);
    QAbstractItemModel* model() const;

    int index() const;
    void setIndex(int index);

    QQmlPropertyMap *item() const;

private slots:
    void onModelDataChanged(const QModelIndex &topLeft, const QModelIndex &bottomRight);
    void onModelRowsRemoved(const QModelIndex &parent, int first, int last);
    void updateProperties();

private:
    QAbstractItemModel* m_model;
    int m_index;
    QQmlPropertyMap* m_item;
};



#endif // ITEMMODEL_H

#include "notebookmodel.h"

NotebookModel::NotebookModel(QObject *parent) : SqlQmlModel(parent)
{
    setTable("notebooks");
    select();
}

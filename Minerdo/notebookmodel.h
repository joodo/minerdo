#ifndef NOTEBOOKMODEL_H
#define NOTEBOOKMODEL_H

#include "sqlqmlmodel.h"

class NotebookModel : public SqlQmlModel
{
    Q_OBJECT
public:
    NotebookModel(QObject* parent = nullptr);
};

#endif // NOTEBOOKMODEL_H

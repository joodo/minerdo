pragma Singleton

import QtQuick 2.13

QtObject {
    property var currentNotebook: {
        "id": -1,
        "name": "Default Notebook",
    }
    //property var entryListModel: NotebookManager.entryListModel()
}

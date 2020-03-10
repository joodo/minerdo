pragma Singleton

import QtQuick 2.13
import Minerdo 1.0

QtObject {
    property var notebookModel: NotebookModel {}
    property var currentNotebookModel: ItemModel {
        model: notebookModel
        onIndexChanged: {
            if (index >= 0) {
                entryModel.notebookId = item.id
            } else {
                entryModel.notebookId = -1
            }
        }
    }
    property var currentNotebook: currentNotebookModel.item

    property var entryModel: EntryModel { }
    property var currentEntryModel: ItemModel {
        model: entryModel
    }
    property var currentEntry: currentEntryModel.item

    property int reviewCount: 0
}

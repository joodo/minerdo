pragma Singleton

import QtQuick 2.13
import Minerdo 1.0

QtObject {
    property var entryModel: EntryModel {}
    property var notebookModel: NotebookModel {}
    property var currentEntryModel: ItemModel {
        model: entryModel
        onItemRemoved: {
            index = entryModel.randomIndex()
        }
    }
    property var currentEntry: currentEntryModel.item
    property var currentNotebookModel: ItemModel {
        model: notebookModel
    }
    property var currentNotebook: currentNotebookModel.item
    property int reviewCount: 0
}

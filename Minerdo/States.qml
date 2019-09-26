pragma Singleton

import QtQuick 2.13
import Minerdo 1.0

QtObject {
    property var currentNotebook: {
        "id": -1,
        "name": "Default Notebook",
    }
    property var entryModel: EntryModel {}
    property var currentEntryModel: ItemModel {
        model: entryModel
        onItemRemoved: {
            index = Math.floor(Math.random() * model.rowCount())
        }
    }
    property var currentEntry: currentEntryModel.item
    property int reviewCount: 0
}

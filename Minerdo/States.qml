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
            index = entryModel.randomIndex()
        }
    }
    property var currentEntry: currentEntryModel.item
    property int reviewCount: 0
}

pragma Singleton

import QtQuick 2.13
import ReviewHelper 1.0

QtObject {
    property var currentNotebook: {
        "id": -1,
        "name": "Default Notebook",
    }
    property var currentEntry
    property var entryModel: EntryModel {}
    property int reviewCount: 0
}

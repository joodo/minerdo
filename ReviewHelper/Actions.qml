pragma Singleton

import QtQuick 2.13

QtObject {
    function openNotebook() {
        EntryModel.open()
    }
    function insertEntry(entry) {
        EntryModel.insert(entry)
    }
}

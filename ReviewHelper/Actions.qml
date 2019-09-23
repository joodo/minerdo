pragma Singleton

import QtQuick 2.13

import ReviewHelper 1.0

QtObject {
    function openNotebook() {
        //EntryModel.open()
    }
    function newEntry(entry) {
        entry["status"] = EntryModel.New
        States.entryModel.append(entry)
    }
    function updateEntry(row, entry) {
        let e = Object.assign(States.currentEntry, entry)
        States.entryModel.update(row, e)
    }
    function removeEntry(row) {
        States.entryModel.remove(row)
    }
}

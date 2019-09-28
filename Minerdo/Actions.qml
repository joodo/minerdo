pragma Singleton

import QtQuick 2.13

import Minerdo 1.0

QtObject {
    function openNotebook() {
        //EntryModel.open()
    }

    function createEntry(entry) {
        entry["status"] = EntryModel.New
        entry["pass_times"] = 0
        entry["last_reviewed"] = Date.now()
        entry["notebook"] = 1
        States.entryModel.append(entry)
    }

    function createNotebook(notebook) {
        States.notebookModel.append(notebook)
    }

    function setCurrentEntry(index) {
        States.currentEntryModel.index = index
    }

    function updateCurrentEntry(newEntry) {
        let e = Object.assign(States.currentEntry, newEntry)
        States.entryModel.update(e)
    }

    function removeCurrentEntry() {
        States.entryModel.remove(States.currentEntry.index)
    }

    function pickRandomEntry() {
        let randomIndex = States.entryModel.randomIndex()
        setCurrentEntry(randomIndex)
    }

    function markCurrentEntry(status) {
        let pass_times
        if (status === States.currentEntry.status) {
            pass_times = States.currentEntry.pass_times + 1
        } else {
            pass_times = 1
        }

        let last_reviewed = Date.now()

        let entry = Object.assign(States.currentEntry, {
                                  pass_times,
                                  status,
                                  last_reviewed,
                              })
        States.entryModel.update(entry)
    }
}

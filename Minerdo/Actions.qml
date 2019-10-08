pragma Singleton

import QtQuick 2.13

import Minerdo 1.0

QtObject {
    function createNotebook(notebook) {
        States.notebookModel.append(notebook)
    }

    function setCurrentNotebook(index) {
        States.currentNotebookModel.index = index
    }

    function updateCurrentNotebook(data) {
        let e = Object.assign(States.currentNotebook, data)
        States.notebookModel.update(e)
    }

    // TODO: Use transaction to remove notebook
    function removeCurrentNotebook() {
        const notebookId = States.currentNotebook.id
        States.entryModel.removeAllEntriesInNotebook(notebookId)
        States.notebookModel.remove(States.currentNotebook.index)
    }

    function createEntry(entry) {
        entry["status"] = EntryModel.New
        entry["pass_times"] = 0
        entry["last_reviewed"] = Date.now()
        entry["notebook"] = States.currentNotebook.id
        States.entryModel.append(entry)
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
        if (randomIndex < 0) return false
        setCurrentEntry(randomIndex)
        return true
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

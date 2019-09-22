pragma Singleton

import QtQuick 2.13

QtObject {
    function openNotebook() {
        NotebookManager.open()
    }
    function insertEntry(entry) {
        NotebookManager.insert(entry)
    }
}

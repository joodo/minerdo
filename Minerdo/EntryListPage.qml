import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

Page {
    id: entryListPage

    signal backTriggered()
    signal editTriggered()
    signal newTriggered()
    signal editNotebookTriggered()
    
    title: States.currentNotebook.name
    
    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                icon.source: "qrc:/material-icons/chevron_left.svg"
                onClicked: entryListPage.backTriggered()
            }
            Label {
                Layout.fillWidth: true
                verticalAlignment: Qt.AlignVCenter
                text: entryListPage.title
            }
            ToolButton {
                icon.source: "qrc:/material-icons/edit.svg"
                onClicked: entryListPage.editNotebookTriggered()
            }
            ToolButton {
                icon.source: "qrc:/material-icons/search.svg"
                onClicked: {
                    searchPane.state = "show"
                    SearchEngine.updateIndex(States.entryModel, ["question", "answer", "note"])
                    SearchEngine.clearResult()
                }
            }
        }

        SearchPane {
            id: searchPane
            anchors.fill: parent
            state: "hide"
        }
    }

    ListView {
        anchors.fill: parent
        model: States.entryModel
        delegate: ItemDelegate {
            onClicked: {
                Actions.setCurrentEntry(index)
                entryListPage.editTriggered()
            }

            anchors {
                left: parent.left; right: parent.right
            }

            text: question? "[" + index + "] " + question.replace(/\n/g, ' ') : ""
        }

        ScrollBar.vertical: ScrollBar { }
    }

    FloatingActionButton {
        anchors {
            right: parent.right; rightMargin: 16
            bottom: parent.bottom; bottomMargin: 16
        }
        icon.source: "qrc:/material-icons/add.svg"
        onClicked: entryListPage.newTriggered()
        z: 1
        Material.background: Material.Green
    }

    SearchResultPane {
        anchors.fill: parent
        z: 2
        state: searchPane.state
        onEntryClicked: entryListPage.editTriggered()
    }
}

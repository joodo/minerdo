import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

Page {
    id: notebookEditPage

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
                onClicked: notebookEditPage.backTriggered()
            }
            Label {
                Layout.fillWidth: true
                verticalAlignment: Qt.AlignVCenter
                text: notebookEditPage.title
            }
            ToolButton {
                icon.source: "qrc:/material-icons/edit.svg"
                onClicked: notebookEditPage.editNotebookTriggered()
            }
            ToolButton {
                icon.source: "qrc:/material-icons/search.svg"
                onClicked: {
                    searchPane.state = "show"
                    searchPane.focus = true
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
                notebookEditPage.editTriggered()
            }

            anchors {
                left: parent.left; right: parent.right
            }

            text: question? "[" + index + "] " + question.replace(/\n/g, ' ') : ""
        }

        ScrollBar.vertical: ScrollBar { }
    }

    RoundButton {
        text: "+"

        onClicked: notebookEditPage.newTriggered()

        Material.elevation: 10
        z: 1
        anchors {
            right: parent.right; rightMargin: UI.dp(30)
            bottom: parent.bottom; bottomMargin: UI.dp(30)
        }
        highlighted: true
        Material.background: Material.Green
        width: UI.dp(80); height: width
        font.pointSize: 30 // TODO: replace it with icon
    }

    SearchResultPane {
        anchors.fill: parent
        z: 2
        state: searchPane.state
        emptyHintEnabled: searchPane.text.length >=3
    }
}

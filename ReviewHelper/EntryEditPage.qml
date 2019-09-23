import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import ReviewHelper 1.0

Page {
    id: entryEditPage

    title: States.currentNotebook.name

    signal backTriggered()

    state: States.currentEntry? "edit" : "new"

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "<"
                onClicked: entryEditPage.backTriggered()

            }
            Label {
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                text: entryEditPage.title
            }
        }
    }

    ScrollView {
        anchors.fill: parent
        padding: UI.dp(20)
        contentWidth: contentItem.width

        ColumnLayout {
            anchors { left: parent.left; right: parent.right }

            TextArea {
                id: questionTextArea
                placeholderText: qsTr("Question")
                Layout.fillWidth: true
                selectByMouse: true
            }
            TextArea {
                id: answerTextArea
                placeholderText: qsTr("Answer")
                Layout.fillWidth: true
                selectByMouse: true
            }
            TextArea {
                id: noteTextArea
                placeholderText: qsTr("Note (optional)")
                Layout.fillWidth: true
                selectByMouse: true
            }
        }
    }

    footer: ToolBar {
        RowLayout {
            anchors.fill: parent
            enabled: questionTextArea.text && answerTextArea.text
            ToolButton {
                id: button1
                Layout.fillWidth: true
            }
            ToolButton {
                id: button2
                Layout.fillWidth: true
            }
        }
    }

    states: [
        State {
            name: "new"
            PropertyChanges {
                target: button1
                text: qsTr("Add and New")
                onClicked: {
                    Actions.newEntry({
                                         "question": questionTextArea.text,
                                         "answer": answerTextArea.text,
                                         "note": noteTextArea.text,
                                     })
                    questionTextArea.clear()
                    answerTextArea.clear()
                    noteTextArea.clear()
                }
            }
            PropertyChanges {
                target: button2
                text: qsTr("Add")
                onClicked: {
                    Actions.newEntry({
                                         "question": questionTextArea.text,
                                         "answer": answerTextArea.text,
                                         "note": noteTextArea.text,
                                     })
                    entryEditPage.backTriggered()
                }
            }
        },
        State {
            name: "edit"
            PropertyChanges {
                target: button1
                text: qsTr("Update")
                onClicked: {
                    Actions.updateEntry(States.currentEntryRow,
                                             {
                                                 "question": questionTextArea.text,
                                                 "answer": answerTextArea.text,
                                                 "note": noteTextArea.text,
                                             })
                    entryEditPage.backTriggered()
                }
            }
            PropertyChanges {
                target: button2
                text: qsTr("Remove")
                onClicked: {
                    Actions.removeEntry(States.currentEntryRow)
                    entryEditPage.backTriggered()
                }
            }
            PropertyChanges {
                target: questionTextArea
                text: States.currentEntry.question
            }
            PropertyChanges {
                target: answerTextArea
                text: States.currentEntry.answer
            }
            PropertyChanges {
                target: noteTextArea
                text: States.currentEntry.note
            }
        }
    ]
}

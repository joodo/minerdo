import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0
// FIXME: When enter this page from ReviewPage, the last entry in a notebook removed, fix the behavior to jump out and hint
Page {
    id: entryEditPage

    title: States.currentNotebook.name

    signal backTriggered()

    property bool valid: questionTextArea.text && answerTextArea.text

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
        focus: true

        ColumnLayout {
            anchors { left: parent.left; right: parent.right }

            EntryTextArea {
                id: questionTextArea
                placeholderText: qsTr("Question")
                Layout.fillWidth: true
                focus: true
            }
            EntryTextArea {
                id: answerTextArea
                placeholderText: qsTr("Answer")
                Layout.fillWidth: true
            }
            EntryTextArea {
                id: noteTextArea
                placeholderText: qsTr("Note (optional)")
                Layout.fillWidth: true
            }
        }
    }

    footer: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                id: button1
                Layout.fillWidth: true
                enabled: entryEditPage.valid
            }
            ToolButton {
                id: button2
                Layout.fillWidth: true
            }
        }
    }

    states: [
        State {
            name: "create"
            PropertyChanges {
                target: button1
                implicitWidth: 1
                text: qsTr("Add and New")
                onClicked: {
                    if (!entryEditPage.valid) return
                    Actions.createEntry({
                                         "question": questionTextArea.text,
                                         "answer": answerTextArea.text,
                                         "note": noteTextArea.text,
                                     })
                    questionTextArea.clear()
                    questionTextArea.focus = true
                    answerTextArea.clear()
                    noteTextArea.clear()
                }
            }
            PropertyChanges {
                target: button2
                implicitWidth: 1
                text: qsTr("Add")
                enabled: entryEditPage.valid
                onClicked: {
                    if (!entryEditPage.valid) return
                    Actions.createEntry({
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
                    if (!entryEditPage.valid) return
                    Actions.updateCurrentEntry({
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
                enabled: true
                onClicked: {
                    Actions.removeCurrentEntry()
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

    Keys.onPressed: {
        if (event.key === Qt.Key_Return && event.modifiers === Qt.ControlModifier) {
            button1.clicked()
            event.accepted = true
        }
    }
}

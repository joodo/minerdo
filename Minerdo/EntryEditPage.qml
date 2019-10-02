import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0
// FIXME: When enter this page from ReviewPage, the last entry in a notebook removed, fix the behavior to jump out and hint
Page {
    id: entryEditPage

    signal backTriggered()

    property bool valid: questionTextArea.text && answerTextArea.text

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                icon.source: "qrc:/material-icons/chevron_left.svg"
                onClicked: entryEditPage.backTriggered()

            }
            Label {
                Layout.fillWidth: true
                verticalAlignment: Qt.AlignVCenter
                text: entryEditPage.title
            }
        }
    }

    ScrollView {
        anchors.fill: parent
        padding: UI.pagePadding
        contentWidth: contentItem.width
        focus: true

        ColumnLayout {
            anchors { left: parent.left; right: parent.right }

            MinerdoTextArea {
                id: questionTextArea
                placeholderText: qsTr("Question")
                Layout.fillWidth: true
                focus: true
            }
            MinerdoTextArea {
                id: answerTextArea
                placeholderText: qsTr("Answer")
                Layout.fillWidth: true
            }
            MinerdoTextArea {
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
                    questionTextArea.forceActiveFocus()
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
            PropertyChanges {
                target: entryEditPage
                title: qsTr("Create Entry")
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
            PropertyChanges {
                target: entryEditPage
                title: qsTr("Edit Entry")
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

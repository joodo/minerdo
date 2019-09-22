import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import ReviewHelper 1.0

Page {
    id: entryEditPage

    title: States.currentNotebook.name

    signal backTriggered()

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
                text: qsTr("Add and New")
                Layout.fillWidth: true
                onClicked: {
                    Actions.insertEntry({
                                            "question": questionTextArea.text,
                                            "answer": answerTextArea.text,
                                            "note": noteTextArea.text,
                                        })
                    questionTextArea.clear()
                    answerTextArea.clear()
                    noteTextArea.clear()
                }
            }
            ToolButton {
                text: qsTr("Add")
                Layout.fillWidth: true
            }
        }
    }
}

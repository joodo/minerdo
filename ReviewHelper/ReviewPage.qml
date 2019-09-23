import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import ReviewHelper 1.0

Page {
    id: reviewPage
    signal backClicked()

    title: States.currentNotebook.name

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "<"
                onClicked: reviewPage.backClicked()

            }
            Label {
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                text: reviewPage.title
            }
            ToolButton {
                text: "" + States.reviewCount
                onClicked: States.reviewCount = 0
            }
        }
    }

    ScrollView {
        anchors.fill: parent
        width: parent.width
        contentWidth: width

        Pane {
            topPadding: UI.dp(20); bottomPadding: UI.dp(20)
            anchors { left: parent.left; right: parent.right; margins: UI.dp(20) }
            ColumnLayout {
                anchors.fill: parent
                spacing: UI.dp(16)

                Pane {
                    background: Rectangle { radius: UI.dp(8); color: Material.backgroundColor }
                    Material.background: Material.color(Material.LightBlue, UI.backgroundShade)
                    Layout.fillWidth: true
                    Label {
                        anchors.fill: parent
                        wrapMode: Text.Wrap
                        text: States.currentEntry.question
                    }
                }

                Pane {
                    id: answerPane

                    visible: !answerMask.visible
                    background: Rectangle { radius: UI.dp(8); color: Material.backgroundColor }
                    Material.background: Material.color(Material.LightGreen, UI.backgroundShade)
                    Layout.fillWidth: true
                    Label {
                        anchors.fill: parent
                        wrapMode: Text.Wrap
                        text: States.currentEntry.answer
                    }
                }

                Pane {
                    id: notePane

                    visible: !answerMask.visible
                    background: Rectangle { radius: UI.dp(8); color: Material.backgroundColor }
                    Material.background: Material.color(Material.LightGreen, UI.backgroundShade)
                    Layout.fillWidth: true
                    Label {
                        anchors.fill: parent
                        wrapMode: Text.Wrap
                        text: States.currentEntry.note
                    }
                }
            }

        }

        }

    footer: ToolBar {
        Label {
            id: answerMask
            anchors.fill: parent
            background: Rectangle { color: Material.color(Material.BlueGrey) }
            z: 1
            text: qsTr("Show Answer")
            verticalAlignment: Qt.AlignVCenter; horizontalAlignment: Qt.AlignHCenter
            MouseArea {
                anchors.fill: parent
                onClicked: parent.visible = false
            }
        }
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("Remember")
                Layout.fillWidth: true
                onClicked: {
                    States.reviewCount += 1
                    Actions.markCurrentEntry(EntryModel.Temporarily)
                    Actions.pickRandomEntry()
                    answerMask.visible = true
                }
            }
            ToolButton {
                text: qsTr("Forgot")
                Layout.fillWidth: true
                onClicked: {
                    Actions.markCurrentEntry(EntryModel.Forgot)
                    Actions.pickRandomEntry()
                    answerMask.visible = true
                }
            }
            ToolButton {
                text: qsTr("Memorized")
                Layout.fillWidth: true
                onClicked: {
                    States.reviewCount += 1
                    Actions.markCurrentEntry(EntryModel.Firmly)
                    Actions.pickRandomEntry()
                    answerMask.visible = true
                }
            }
        }
    }
}

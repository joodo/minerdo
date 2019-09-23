import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import ReviewHelper 1.0

Page {
    id: reviewPage
    signal backClicked()

    title: States.currentNotebook.name

    property var currentEntry: States.entryModel.random()

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
                        text: reviewPage.currentEntry.question
                    }
                }

                Pane {
                    id: answerPane

                    visible: false
                    background: Rectangle { radius: UI.dp(8); color: Material.backgroundColor }
                    Material.background: Material.color(Material.LightGreen, UI.backgroundShade)
                    Layout.fillWidth: true
                    Label {
                        anchors.fill: parent
                        wrapMode: Text.Wrap
                        text: reviewPage.currentEntry.answer
                    }
                }

                Pane {
                    id: notePane

                    visible: false
                    background: Rectangle { radius: UI.dp(8); color: Material.backgroundColor }
                    Material.background: Material.color(Material.LightGreen, UI.backgroundShade)
                    Layout.fillWidth: true
                    Label {
                        anchors.fill: parent
                        wrapMode: Text.Wrap
                        text: reviewPage.currentEntry.note
                    }
                }
            }

        }

        }

    footer: ToolBar {
        Label {
            anchors.fill: parent
            background: Rectangle { color: Material.color(Material.BlueGrey) }
            z: 1
            text: qsTr("Show Answer")
            verticalAlignment: Qt.AlignVCenter; horizontalAlignment: Qt.AlignHCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    answerPane.visible = true
                    notePane.visible = true
                    parent.visible = false
                }
            }
        }
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("Pass")
                Layout.fillWidth: true
                onClicked: {
                    States.reviewCount += 1
                    reviewPage.currentEntry = States.entryModel.random()
                }
            }
            ToolButton {
                text: qsTr("NVS")
                Layout.fillWidth: true
            }
            ToolButton {
                text: qsTr("Forgot")
                Layout.fillWidth: true
            }
        }
    }
}

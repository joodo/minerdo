import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

Page {
    id: notebookDetailPage

    signal backClicked
    signal reviewClicked
    signal editTriggered

    title: States.currentNotebook.name

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "<"
                onClicked: notebookDetailPage.backClicked()
            }
            Label {
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                text: notebookDetailPage.title
            }
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: contentItem.width
        padding: UI.dp(20)

        ColumnLayout {
            anchors { left: parent.left; right: parent.right }
            EntryTextArea {
                Layout.fillWidth: true
                placeholderText: qsTr("Notebook Name")
            }
            Flow {
                Layout.fillWidth: true
                ColorRadioButton {
                    color: Material.Blue
                }
                ColorRadioButton {
                    color: Material.Green
                }
                ColorRadioButton {
                    color: Material.Teal
                }
                ColorRadioButton {
                    color: Material.Amber
                }
                ColorRadioButton {
                    color: Material.Brown
                }
                ColorRadioButton {
                    color: Material.BlueGrey
                }
                ColorRadioButton {
                    color: Material.Pink
                }
                ColorRadioButton {
                    color: Material.Indigo
                }
            }
        }
    }

    footer: ToolBar {
        RowLayout {
            anchors.fill: parent
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
}

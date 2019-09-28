import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

Page {
    id: notebookDetailPage

    signal backClicked()
    signal reviewClicked()
    signal editTriggered()

    function createNotebook() {
        const data = {
            "name": nameTextArea.text,
            "color": buttonGroup.checkedButton.color,
        }
        Actions.createNotebook(data)
    }

    title: qsTr("New Notebook")

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
        focus: true

        ColumnLayout {
            anchors { left: parent.left; right: parent.right }
            EntryTextArea { // TODO: rename component name
                id: nameTextArea
                Layout.fillWidth: true
                placeholderText: qsTr("Notebook Name")
                focus: true
            }
            ButtonGroup {
                id: buttonGroup
                buttons: flow.children
                Component.onCompleted: {
                    const notebookCount = States.notebookModel.rowCount()
                    const colorCount = buttons.length
                    buttons[notebookCount%colorCount].checked = true
                }
            }
            Flow {
                id: flow
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
                text: qsTr("Create")
                enabled: nameTextArea.text
                onClicked: {
                    notebookDetailPage.createNotebook()
                    notebookDetailPage.backClicked()
                }
            }
            ToolButton {
                id: button2
                Layout.fillWidth: true
                visible: false
            }
        }
    }
}

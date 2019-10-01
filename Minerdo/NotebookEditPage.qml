import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

Page {
    id: notebookDetailPage

    signal backClicked()
    signal removed()
    signal created()

    property bool valid: nameTextArea.text

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                icon.source: "qrc:/material-icons/chevron_left.svg"
                onClicked: notebookDetailPage.backClicked()
            }
            Label {
                Layout.fillWidth: true
                verticalAlignment: Qt.AlignVCenter
                text: notebookDetailPage.title
            }
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: contentItem.width
        padding: UI.pagePadding
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
                enabled: notebookDetailPage.valid
            }
            ToolButton {
                id: buttonRemove
                text: qsTr("Remove")
                Layout.fillWidth: true
                onClicked: {
                    Actions.removeCurrentNotebook()
                    notebookDetailPage.removed()
                }
            }
        }
    }

    states: [
        State {
            name: "create"
            PropertyChanges {
                target: button1
                text: qsTr("Create") // TODO: create? new?
                onClicked: {
                    if (!notebookDetailPage.valid) return
                    const data = {
                        "name": nameTextArea.text,
                        "color": buttonGroup.checkedButton.color,
                    }
                    Actions.createNotebook(data)
                    notebookDetailPage.created()
                }
            }
            PropertyChanges {
                target: buttonRemove
                visible: false
            }
            PropertyChanges {
                target: buttonGroup
                checkedButton: buttons[Math.floor(Math.random() * buttons.length)]
            }
            PropertyChanges {
                target: notebookDetailPage
                title: qsTr("New Notebook")
            }
        },
        State {
            name: "edit"
            PropertyChanges {
                target: button1
                text: qsTr("Update")
                onClicked: {
                    if (!notebookDetailPage.valid) return
                    const data = {
                        "name": nameTextArea.text,
                        "color": buttonGroup.checkedButton.color,
                    }
                    Actions.updateCurrentNotebook(data)
                    notebookDetailPage.backClicked()
                }
            }
            PropertyChanges {
                target: buttonGroup
                checkedButton: {
                    for (let i = 0; i < buttons.length; i++) {
                        if (buttons[i].color === States.currentNotebook.color) {
                            return buttons[i]
                        }
                    }
                }
            }
            PropertyChanges {
                target: notebookDetailPage
                title: qsTr("Edit Notebook")
            }
            PropertyChanges {
                target: nameTextArea
                text: States.currentNotebook.name
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

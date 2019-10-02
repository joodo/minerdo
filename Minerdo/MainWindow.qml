import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13
import Qt.labs.settings 1.1 as QtLabs

import Minerdo 1.0

ApplicationWindow {
    id: window
    visible: true
    width: UI.cardWidth*2 + UI.pagePadding*2 + UI.listSpacing
    height: 400
    minimumWidth: UI.cardWidth + UI.pagePadding*2
    minimumHeight: 300
    title: qsTr("Minerdo")
    flags: Qt.WindowFullscreenButtonHint

    header: Control {
        background: Rectangle {
            color: "black"
            opacity: 0.2
        }

        height: UI.windowTitleBarHeight
    }

    StackView {
        id: stackView

        anchors.fill: parent
        initialItem: noteBookListComponent

        onCurrentItemChanged: {
            const header = currentItem.header
            if (! header) {
                print("No header found in page " + currentItem.title);
                return;
            }

            header.background.y = -UI.windowTitleBarHeight
            header.background.height = Qt.binding(
                        () => header.height + UI.windowTitleBarHeight)
        }

        Component {
            id: noteBookListComponent
            NotebookListPage {
                onReviewTriggered: stackView.push(reviewPageComponent)
                onEditTriggered: stackView.push(entryListPageComponent)
                onNewTriggered: stackView.push(notebookCreatePageComponent)
                onEditEntryTriggered: stackView.push(entryEditPageComponent)
                onSettingsTriggered: stackView.push(settingsPageComponent)
            }
        }

        Component {
            id: notebookEditPageComponent
            NotebookEditPage {
                state: "edit"
                onBackClicked: stackView.pop()
                onRemoved: { stackView.pop(); stackView.pop(); }
            }
        }
        Component {
            id: notebookCreatePageComponent
            NotebookEditPage {
                state: "create"
                onBackClicked: stackView.pop()
                onCreated: {
                    stackView.pop()
                    Actions.setCurrentNotebook(States.notebookModel.rowCount() - 1)
                    stackView.push(entryListPageComponent)
                }
            }
        }

        Component {
            id: reviewPageComponent
            ReviewPage {
                onBackClicked: stackView.pop()
                onEditTriggered: stackView.push(entryEditPageComponent)
            }
        }

        Component {
            id: entryListPageComponent
            EntryListPage {
                onBackTriggered: stackView.pop()
                onNewTriggered: stackView.push(entryCreatePageComponent)
                onEditTriggered: stackView.push(entryEditPageComponent)
                onEditNotebookTriggered: stackView.push(notebookEditPageComponent)
            }
        }

        Component {
            id: entryEditPageComponent
            EntryEditPage {
                state: "edit"
                onBackTriggered: stackView.pop()
            }
        }
        Component {
            id: entryCreatePageComponent
            EntryEditPage {
                state: "create"
                onBackTriggered: stackView.pop()
            }
        }

        Component {
            id: settingsPageComponent
            SettingsPage {
                onBackTriggered: stackView.pop()
            }
        }

        focus: true
        Keys.onPressed: {
            if (event.key === Qt.Key_AsciiTilde) debugWindow.show()
            else event.accept = false
        }
    }

    Snackbar {
        id: snackbar
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Connections {
        target: UI
        onShowMessage: snackbar.show(message)
    }

    QtLabs.Settings {
        category: "interface"
        property alias windowX: window.x
        property alias windowY: window.y
        property alias windowWidth: window.width
        property alias windowHeight: window.height
    }

    ApplicationWindow {
        id: debugWindow
        title: "debug"
        width: 300
        height: 600
        ScrollView {
            anchors.fill: parent
            contentWidth: contentItem.width
            TextEdit {
                id: logTextEdit
                anchors { left: parent.left; right: parent.right }
                wrapMode: Text.Wrap
                Connections {
                    target: MessageHandler
                    onLog: logTextEdit.text += msg + "\n"
                }
            }
        }
    }
}

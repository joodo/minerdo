import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    minimumWidth: UI.cardWidth + UI.dp(48)
    minimumHeight: UI.dp(360)
    title: qsTr("Minerdo")
    flags: Qt.WindowFullscreenButtonHint

    StackView {
        id: stackView

        anchors.fill: parent
        initialItem: noteBookListComponent

        Component {
            id: noteBookListComponent
            NotebookListPage {
                onReviewTriggered: stackView.push(reviewPageComponent)
                onEditTriggered: stackView.push(entryListPageComponent)
                onNewTriggered: stackView.push(notebookCreatePageComponent)
            }
        }

        Component {
            id: notebookEditPageComponent
            NotebookEditPage {
                state: "edit"
                onBackClicked: stackView.pop()
            }
        }
        Component {
            id: notebookCreatePageComponent
            NotebookEditPage {
                state: "create"
                onBackClicked: stackView.pop()
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
    }

    Snackbar {
        id: snackbar
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Connections {
        target: UI
        onShowMessage: snackbar.show(message)
    }
}

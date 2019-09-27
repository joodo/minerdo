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
                onEditTriggered: stackView.push(notebookEditPageComponent)
                onNewTriggered: stackView.push(noteBookDetailPageComponent)
            }
        }

        Component {
            id: noteBookDetailPageComponent
            NotebookDetailPage {
                onBackClicked: stackView.pop()
                onReviewClicked: stackView.push(reviewPageComponent)
                onEditTriggered: stackView.push(notebookEditPageComponent)
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
            id: notebookEditPageComponent
            NotebookEditPage {
                onBackTriggered: stackView.pop()
                onNewTriggered: stackView.push(entryNewPageComponent)
                onEditTriggered: stackView.push(entryEditPageComponent)
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
            id: entryNewPageComponent
            EntryEditPage {
                state: "new"
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

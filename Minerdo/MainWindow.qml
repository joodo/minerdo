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
        initialItem: noteBookList

        Component {
            id: noteBookList
            NotebookListPage {
                onItemClicked: stackView.push(noteBookDetailPage)
            }
        }

        Component {
            id: noteBookDetailPage
            NotebookDetailPage {
                onBackClicked: stackView.pop()
                onReviewClicked: stackView.push(reviewPage)
                onEditTriggered: stackView.push(notebookEditPage)
            }
        }

        Component {
            id: reviewPage
            ReviewPage {
                onBackClicked: stackView.pop()
            }
        }

        Component {
            id: notebookEditPage
            NotebookEditPage {
                onBackTriggered: stackView.pop()
                onNewTriggered: stackView.push(entryEditPage)
            }
        }

        Component {
            id: entryEditPage
            EntryEditPage {
                onBackTriggered: stackView.pop()
            }
        }
    }
}

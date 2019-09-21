import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import ReviewHelper 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    minimumWidth: 640
    minimumHeight: 480
    title: qsTr("Review Helper")

    StackView {
        id: stackView

        property var clickedItemRect
        property string clickedItemName

        anchors.fill: parent
        initialItem: noteBookList

        /*pushEnter: Transition {
            XAnimator {
                from: stackView.clickedItemRect.x
                to: 0
                duration: UI.cardExpandDuration
                easing.type: Easing.OutCubic
            }
            YAnimator {
                from: stackView.clickedItemRect.y
                to: 0
                duration: UI.cardExpandDuration
                easing.type: Easing.OutCubic
            }
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: UI.cardExpandDuration
                easing.type: Easing.OutCubic
            }
            PropertyAnimation {
                property: "width"
                from: stackView.clickedItemRect.width
                to: width
                duration: UI.cardExpandDuration
                easing.type: Easing.OutCubic
            }
            PropertyAnimation {
                property: "height"
                from: stackView.clickedItemRect.height
                to: height
                duration: UI.cardExpandDuration
                easing.type: Easing.OutCubic
            }
        }
        pushExit: Transition {
            PauseAnimation {
                duration: UI.cardExpandDuration
            }
        }
        popEnter: null
        popExit: Transition {
            XAnimator {
                to: stackView.clickedItemRect.x
                from: 0
                duration: UI.cardExpandDuration
                easing.type: Easing.InOutCubic
            }
            YAnimator {
                to: stackView.clickedItemRect.y
                from: 0
                duration: UI.cardExpandDuration
                easing.type: Easing.InOutCubic
            }
            PropertyAnimation {
                property: "width"
                to: stackView.clickedItemRect.width
                from: width
                duration: UI.cardExpandDuration
                easing.type: Easing.InOutCubic
            }
            PropertyAnimation {
                property: "height"
                to: stackView.clickedItemRect.height
                from: height
                duration: UI.cardExpandDuration
                easing.type: Easing.InOutCubic
            }
        }*/

        Component {
            id: noteBookList
            NotebookListPage {
                onItemClicked: {
                    stackView.clickedItemRect = rect
                    stackView.clickedItemName = name
                    stackView.push(noteBookDetailPage)
                }
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

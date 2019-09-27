import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

Page {
    id: notebookListPage

    signal reviewTriggered()
    signal editTriggered()
    signal newTriggered()

    header: ToolBar {
        id: toolBar
        readonly property real maxHeight: UI.dp(240)

        height: maxHeight

        Label {
            fontSizeMode: Text.Fit
            anchors { left: parent.left; right: parent.right; top: parent.top }
            padding: UI.dp(18)
            font.pointSize: 30
            height: (toolBar.implicitHeight + toolBar.height) / 2
            text: {
                const date = new Date()
                const h = date.getHours()
                if (h < 12) {
                    qsTr("Good Morning.")
                } else if (h < 7) {
                    qsTr("Good Afternoon.")
                } else {
                    qsTr("Good Evening.")
                }
            }
        }

        RowLayout {
            anchors {
                right: parent.right; bottom: parent.bottom
            }
            CollapsableToolButton {
                expandText: qsTr("Review All")
                collapsedText: "✓"
                state: toolBar.height < toolBar.maxHeight / 2? "collapse" : "expand"
                onClicked: notebookListPage.reviewTriggered()
            }
            CollapsableToolButton {
                expandText: qsTr("New Notebook")
                collapsedText: "＋"
                state: toolBar.height < toolBar.maxHeight / 2? "collapse" : "expand"
                onClicked: notebookListPage.newTriggered()
            }
        }
    }

    MouseArea {
        acceptedButtons: Qt.NoButton
        anchors.fill: parent
        z: 1
        onWheel: {
            wheel.accepted = false
            if (wheel.angleDelta.y < 0) {
                if (toolBar.height === toolBar.implicitHeight) return
                toolBar.height += wheel.angleDelta.y
                if (toolBar.height < toolBar.implicitHeight) {
                    toolBar.height = toolBar.implicitHeight
                }
            } else {
                if (scrollView.ScrollBar.vertical.position > 0) return
                toolBar.height += wheel.angleDelta.y
                if (toolBar.height > toolBar.maxHeight) {
                    toolBar.height = toolBar.maxHeight
                }
            }
        }
    }

    ScrollView {
        id: scrollView
        anchors.fill: parent
        contentWidth: contentItem.width
        padding: UI.dp(20)

        Flow {
            id: flow
            spacing: UI.dp(16)
            width: {
                if (contentChildren.length === 0) {
                    0
                } else {
                    var itemWidth = UI.cardWidth + spacing
                    Math.floor((parent.width+spacing) / itemWidth) * itemWidth - spacing + 1
                }
            }

            anchors.horizontalCenter: parent.horizontalCenter
//            move: transition
//            add: transition
//            Transition {
//                id: transition
//                XAnimator { duration: UI.mediumExpandDuration }
//                YAnimator { duration: UI.mediumExpandDuration }
//            }

            Repeater{
                model: 20
                delegate: NotebookCard {
                    id: notebookCard
                    text: "Item " + index
                    onClicked: {
                        Actions.openNotebook()
                        notebookListPage.reviewTriggered()
                    }
                    onEditClicked: {
                        notebookListPage.editTriggered()
                    }
                }
            }
        }

    }

}

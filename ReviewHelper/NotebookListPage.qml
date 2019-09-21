import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import ReviewHelper 1.0

ScrollView {
    id: noteBootList

    signal itemClicked(var rect, string name)

    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

    Flickable {
        id: flickable
        contentWidth: width; contentHeight: flow.height + 2 * flow.y

        Flow {
            id: flow
            y: UI.dp(16)
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
            clip: true
            move: transition
            add: transition
            Transition {
                id: transition
                XAnimator { duration: UI.mediumExpandDuration }
                YAnimator { duration: UI.mediumExpandDuration }
            }

            Repeater{
                model: 20
                delegate: NotebookCard {
                    id: notebookCard
                    text: "Item " + index
                    onClicked: {
                        noteBootList.itemClicked(Qt.rect(
                                                     x+flow.x,
                                                     y-flickable.contentY+flow.y,
                                                     width,
                                                     height),
                                                 text)
                    }
                }
            }
        }
    }
}

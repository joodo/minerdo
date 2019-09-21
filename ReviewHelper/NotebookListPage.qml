import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import ReviewHelper 1.0

Page {
    id: notebookListPage

    signal itemClicked(var rect, string name)

    /*header: ToolBar {
        Label {
            anchors.fill: parent
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            text: window.title
        }
    }*/

    ScrollView {
        anchors.fill: parent

        // FIXME: a little dirty
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
                            notebookListPage.itemClicked(Qt.rect(
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

}

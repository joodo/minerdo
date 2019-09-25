import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

Page {
    id: notebookListPage

    signal itemClicked()

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
                        notebookListPage.itemClicked()
                    }
                }
            }
        }

    }

}

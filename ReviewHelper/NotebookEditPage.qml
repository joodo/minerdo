import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import ReviewHelper 1.0

Page {
    id: notebookEditPage

    signal backTriggered()
    signal editTriggered()
    signal newTriggered()
    
    title: States.currentNotebook.name
    
    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "<"
                onClicked: notebookEditPage.backTriggered()
                
            }
            Label {
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                text: notebookEditPage.title
            }
        }
    }

    ListView {
        anchors.fill: parent
        model: 20
        delegate: ItemDelegate {
            onClicked: {
                notebookEditPage.newTriggered()
            }

            anchors {
                left: parent.left; right: parent.right
            }

            text: "[" + index + "] " + "QuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestion"
        }

        ScrollBar.vertical: ScrollBar { }
    }

    RoundButton {
        text: "+"

        onClicked: notebookEditPage.newTriggered()

        Material.elevation: 10
        z: Material.elevation
        anchors {
            right: parent.right; rightMargin: UI.dp(30)
            bottom: parent.bottom; bottomMargin: UI.dp(30)
        }
        highlighted: true
        Material.background: Material.Green
        width: UI.dp(80); height: width
        font.pointSize: 30 // FIXME: replace it with icon
    }
}

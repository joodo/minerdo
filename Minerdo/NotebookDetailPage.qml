import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

Page {
    id: notebookDetailPage

    signal backClicked
    signal reviewClicked
    signal editTriggered

    title: States.currentNotebook.name

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "<"
                onClicked: notebookDetailPage.backClicked()
            }
            Label {
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                text: notebookDetailPage.title
            }
        }
    }
    Column {
        anchors.centerIn: parent
        spacing: UI.dp(8)

        Button {
            text: qsTr("Review")
            width: UI.dp(160)
            highlighted: true
            onClicked: {
                notebookDetailPage.reviewClicked()
                Actions.pickRandomEntry()
            }
        }
        Button {
            text: qsTr("Edit")
            width: UI.dp(160)
            onClicked: notebookDetailPage.editTriggered()
        }
        Button {
            text: qsTr("Remove")
            width: UI.dp(160)
        }
    }
}

import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import ReviewHelper 1.0

Page {
    id: entryEditPage

    title: States.currentNotebook.name

    signal backTriggered()

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "<"
                onClicked: entryEditPage.backTriggered()

            }
            Label {
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                text: entryEditPage.title
            }
        }
    }

    padding: UI.dp(20)

    ColumnLayout {
        anchors.fill: parent
        TextArea {
            placeholderText: qsTr("Question")
            Layout.fillHeight: true; Layout.fillWidth: true
        }
        TextArea {
            placeholderText: qsTr("Answer")
            Layout.fillHeight: true; Layout.fillWidth: true
        }
        TextArea {
            placeholderText: qsTr("Note")
            Layout.fillHeight: true; Layout.fillWidth: true
        }
    }

    footer: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("Add and New")
                Layout.fillWidth: true
            }
            ToolButton {
                text: qsTr("Add")
                Layout.fillWidth: true
            }
        }
    }
}

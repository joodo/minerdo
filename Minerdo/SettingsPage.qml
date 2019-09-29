import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

Page {
    id: settingsPage

    signal backTriggered()

    title: qsTr("Settings")

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                icon.source: "qrc:/material-icons/chevron_left.svg"
                onClicked: settingsPage.backTriggered()
            }
            Label {
                Layout.fillWidth: true
                verticalAlignment: Qt.AlignVCenter
                text: settingsPage.title
            }
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: contentItem.width
        padding: UI.dp(16)

        ColumnLayout {
            anchors { left: parent.left; right: parent.right }
            // General: counter / tray / startup
            // Interface: language / darkmode
            Label {
                text: qsTr("Interface")
                font.pointSize: UI.dp(16)
                Layout.fillWidth: true
            }

            Label {
                text: qsTr("Choose the languages used to display menus and messages from Minerdo.")
                wrapMode: Text.Wrap
                Layout.fillWidth: true
                Layout.topMargin: UI.dp(20)
            }
            AutoSizeComboBox {
                model: ["System(English)", "English", "Chinese"]
            }


            Label {
                text: qsTr("Choose theme to control how user interface display.")
                wrapMode: Text.Wrap
                Layout.fillWidth: true
                Layout.topMargin: UI.dp(20)
            }
            AutoSizeComboBox {
                model: ["System(Light)", "Light", "Dark"]
            }

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.leftMargin: -UI.dp(16)
                Layout.rightMargin: -UI.dp(16)
                Layout.topMargin: UI.dp(20)
                Layout.fillWidth: true
                height: 1
                color: Material.color(Material.Grey)
                opacity: 0.5
            }

            // Voice
            // About
            /*ItemDelegate {
                Layout.fillWidth: true
                icon.source: "qrc:/material-icons/chevron_right.svg"
                icon.color: Material.hintTextColor
                display: AbstractButton.IconOnly
                Component.onCompleted: leftPadding = width - height
            }*/
        }
    }

}

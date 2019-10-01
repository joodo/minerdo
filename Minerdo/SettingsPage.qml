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
        padding: UI.pagePadding

        ColumnLayout {
            anchors { left: parent.left; right: parent.right }
            // General: counter / tray / startup
            // Interface: language / darkmode
            Label {
                text: qsTr("Interface")
                font.pointSize: 24
                color: Material.hintTextColor
                Layout.fillWidth: true
            }
/*
            Label {
                text: qsTr("Language")
                font.bold: true
                Layout.topMargin: UI.pagePadding
            }
            Label {
                text: qsTr("Choose the languages used to display menus and messages from Minerdo.")
                wrapMode: Text.Wrap
                Layout.fillWidth: true
            }
            AutoSizeComboBox {
                model: ["System(English)", "English", "Chinese"]
            }
*/

            Label {
                text: qsTr("Theme")
                font.bold: true
                Layout.topMargin: UI.pagePadding
            }
            AutoSizeComboBox {
                id: themeComboBox
                textRole: "key"
                model: ListModel {
                    ListElement { key: "Light"; value: "Light" }
                    ListElement { key: "Dark"; value: "Dark" }
                }
                onActivated: {
                    const value = model.get(index).value
                    Settings.userInterface.theme = value
                }
                Component.onCompleted: {
                    model.insert(0, {
                                     "key": "System" + (themeTestItem.Material.theme === Material.Light? "(Light)" : "(Dark)"),
                                     "value": "System"
                                 })
                    for (let i = 0; i < model.count; i++) {
                        if (Settings.userInterface.theme === model.get(i).value) {
                            currentIndex = i
                            break
                        }
                    }
                }
                Item {
                    id: themeTestItem
                    Material.theme: Material.System
                }
            }
            Label {
                background: Rectangle {
                    color: Material.color(Material.BlueGrey, UI.backgroundShade)
                }
                text: "⚠︎ " + qsTr("Restart Minerdo to apply these changes.")
                visible: Settings.userInterface.theme !== Settings.init.interface.theme
                padding: 6
                font.pointSize: 11
            }

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.leftMargin: -UI.pagePadding
                Layout.rightMargin: -UI.pagePadding
                Layout.topMargin: UI.pagePadding
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

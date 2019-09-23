import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import ReviewHelper 1.0

Page {
    id: reviewPage
    signal backClicked()

    function hideAnswerMask() {
        answerMask.visible = false
    }

    function markButtonClicked(mark) {
        if (answerMask.visible) return

        Actions.markCurrentEntry(mark)
        Actions.pickRandomEntry()
        answerMask.visible = true
        progressBar.update()

        if (mark !== EntryModel.Forgot) {
            States.reviewCount += 1
        }
    }

    title: States.currentNotebook.name

    header: ToolBar {
        height: implicitHeight + progressBar.height
        RowLayout {
            anchors {
                left: parent.left; right: parent.right; top: parent.top
                bottom: progressBar.top
            }

            ToolButton {
                text: "<"
                onClicked: reviewPage.backClicked()

            }
            Label {
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                text: reviewPage.title
            }
            ToolButton {
                text: "" + States.reviewCount
                onClicked: States.reviewCount = 0
            }
        }

        Control {
            id: progressBar

            property var statusCount

            function update() {
                statusCount = States.entryModel.statusCount()
            }
            Component.onCompleted: update()

            anchors {
                left: parent.left; right: parent.right; bottom: parent.bottom
            }
            height: UI.dp(8)

            ToolTip.visible: hovered
            ToolTip.text: (qsTr("New: %1, Forgotten: %2, Remembered: %3, Memorized: %4")
                           .arg(progressBar.statusCount.new)
                           .arg(progressBar.statusCount.forgot)
                           .arg(progressBar.statusCount.temporarily)
                           .arg(progressBar.statusCount.firmly)
                           )

            RowLayout {
                anchors.fill: parent
                spacing: 0
                z: -1
                Rectangle {
                    visible: implicitWidth !== 0
                    implicitWidth: progressBar.statusCount.new
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: Material.color(Material.Blue)
                }
                Rectangle {
                    visible: implicitWidth !== 0
                    implicitWidth: progressBar.statusCount.forgot
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: Material.color(Material.Orange)
                }
                Rectangle {
                    visible: implicitWidth !== 0
                    implicitWidth: progressBar.statusCount.temporarily
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: Material.color(Material.Teal)
                }
                Rectangle {
                    visible: implicitWidth !== 0
                    implicitWidth: progressBar.statusCount.firmly
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: Material.color(Material.Green)
                }
            }
        }
    }

    ScrollView {
        anchors.fill: parent
        width: parent.width
        contentWidth: contentItem.width
        padding: UI.dp(20)

        ColumnLayout {
            width: parent.width
            spacing: UI.dp(16)

            Pane {
                background: Rectangle { radius: UI.dp(8); color: Material.backgroundColor }
                Material.background: Material.color(Material.LightBlue, UI.backgroundShade)
                Layout.fillWidth: true
                Label {
                    anchors.fill: parent
                    wrapMode: Text.Wrap
                    text: States.currentEntry.question
                }
            }

            Pane {
                id: answerPane

                visible: !answerMask.visible
                background: Rectangle { radius: UI.dp(8); color: Material.backgroundColor }
                Material.background: Material.color(Material.LightGreen, UI.backgroundShade)
                Layout.fillWidth: true
                Label {
                    anchors.fill: parent
                    wrapMode: Text.Wrap
                    text: States.currentEntry.answer
                }
            }

            Pane {
                id: notePane

                visible: !answerMask.visible
                background: Rectangle { radius: UI.dp(8); color: Material.backgroundColor }
                Material.background: Material.color(Material.LightGreen, UI.backgroundShade)
                Layout.fillWidth: true
                Label {
                    anchors.fill: parent
                    wrapMode: Text.Wrap
                    text: States.currentEntry.note
                }
            }
        }
    }

    footer: ToolBar {
        Label {
            id: answerMask
            anchors.fill: parent
            background: Rectangle { color: Material.color(Material.BlueGrey) }
            z: 1
            text: qsTr("Show Answer")
            verticalAlignment: Qt.AlignVCenter; horizontalAlignment: Qt.AlignHCenter
            MouseArea {
                id: answerMaskMouseArea
                anchors.fill: parent
                onClicked: reviewPage.hideAnswerMask()
            }
        }
        RowLayout {
            anchors.fill: parent
            ToolButton {
                implicitWidth: 1
                text: qsTr("Remember")
                Layout.fillWidth: true
                onClicked: reviewPage.markButtonClicked(EntryModel.Temporarily)
            }
            ToolButton {
                implicitWidth: 1
                text: qsTr("Forgot")
                Layout.fillWidth: true
                onClicked: reviewPage.markButtonClicked(EntryModel.Forgot)
            }
            ToolButton {
                implicitWidth: 1
                text: qsTr("Memorized")
                Layout.fillWidth: true
                onClicked: reviewPage.markButtonClicked(EntryModel.Firmly)
            }
        }
    }

    Keys.onPressed: {
        event.accepted = true

        switch (event.key) {
        case Qt.Key_Return:
        case Qt.Key_Space:
            reviewPage.hideAnswerMask()
            break
        case Qt.Key_R:
            reviewPage.markButtonClicked(EntryModel.Temporarily)
            break
        case Qt.Key_F:
            reviewPage.markButtonClicked(EntryModel.Forgot)
            break
        case Qt.Key_M:
            reviewPage.markButtonClicked(EntryModel.Firmly)
            break
        default:
            event.accepted = false
        }
    }
}

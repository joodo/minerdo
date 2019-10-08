import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

Page {
    id: reviewPage
    signal backClicked()
    signal editTriggered()

    property bool allReviewedHinted: false
    Connections {
        target: States.entryModel
        onAllReviewed: {
            if (allReviewedHinted) return
            allReviewedHinted = true
            UI.showMessage({
                               "text": "All entries has been reviewed"
                           })
        }
    }

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

    Component.onCompleted: Actions.pickRandomEntry()

    Connections {
        target: States.currentEntryModel
        onIndexChanged: {
            if (index < 0) {
                backClicked()
                UI.showMessage({
                                   "text": qsTr("There's no entry in %1 anymore.")
                                   .arg(States.currentNotebook.name)
                               })
            }
        }
    }

    title: States.currentNotebook.name || qsTr("Review")

    header: ToolBar {
        height: implicitHeight + progressBar.height
        RowLayout {
            anchors {
                left: parent.left; right: parent.right; top: parent.top
                bottom: progressBar.top
            }

            ToolButton {
                icon.source: "qrc:/material-icons/chevron_left.svg"
                onClicked: reviewPage.backClicked()

            }
            Label {
                Layout.fillWidth: true
                verticalAlignment: Qt.AlignVCenter
                text: reviewPage.title
            }
            ToolButton {
                text: "" + States.reviewCount
                onClicked: States.reviewCount = 0
            }
            ToolButton {
                icon.source: "qrc:/material-icons/edit.svg"
                onClicked: reviewPage.editTriggered()
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
            height: 6

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
        padding: UI.pagePadding

        ColumnLayout {
            width: parent.width
            spacing: UI.listSpacing

            Pane {
                background: Rectangle { radius: 6; color: Material.backgroundColor }
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
                background: Rectangle { radius: 6; color: Material.backgroundColor }
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

                visible: !answerMask.visible && noteLabel.text
                background: Rectangle { radius: 6; color: Material.backgroundColor }
                Material.background: Material.color(Material.LightGreen, UI.backgroundShade)
                Layout.fillWidth: true
                Label {
                    id: noteLabel
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
            enabled: !answerMask.visible
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

    // NOTE: find a more gentle way to solve this
    Keys.onReleased: {
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

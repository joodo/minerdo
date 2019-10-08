import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls.Material.impl 2.12

import Minerdo 1.0

Item {
    id: notebookListPage

    signal reviewTriggered()
    signal editTriggered()
    signal newTriggered()
    signal editEntryTriggered()
    signal settingsTriggered()

    property alias header: page.header

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton
        z: 1
        onWheel: {
            if (wheel.angleDelta.y < 0) {
                if (toolBar.height === toolBar.implicitHeight) {
                    wheel.accepted = false
                    return
                }
                toolBar.height += wheel.angleDelta.y
                if (toolBar.height < toolBar.implicitHeight) {
                    toolBar.height = toolBar.implicitHeight
                }
            } else {
                if (scrollView.ScrollBar.vertical.position > 0 ||
                        searchPane.state === "show") {
                    wheel.accepted = false
                    return
                }
                toolBar.height += wheel.angleDelta.y
                if (toolBar.height > toolBar.maxHeight) {
                    toolBar.height = toolBar.maxHeight
                }
            }
        }
    }

    Page {
        id: page

        anchors.fill: parent

        header: ToolBar {
            id: toolBar
            readonly property real maxHeight: 200
            background: BackgroundRect {
                minimumHeight: toolBar.implicitHeight + UI.windowTitleBarHeight
                maximumHeight: toolBar.maxHeight

                layer.enabled: toolBar.Material.elevation > 0
                layer.effect: ElevationEffect {
                    elevation: toolBar.Material.elevation
                    fullWidth: true
                }
            }

            height: maxHeight

            Label {
                anchors { left: parent.left; right: parent.right; top: parent.top }
                height: (toolBar.implicitHeight + toolBar.height) / 2
                text: {
                    const date = new Date()
                    const h = date.getHours()
                    if (h < 12) {
                        qsTr("Good Morning.")
                    } else if (h < 19) {
                        qsTr("Good Afternoon.")
                    } else {
                        qsTr("Good Evening.")
                    }
                }
                Component.onCompleted: {
                    padding = (toolBar.implicitHeight-Utils.textSize(font, text).height) / 2
                    font.pointSize = 30
                    fontSizeMode = Text.Fit
                }
            }

            CollapsableMenu {
                id: collapsableMenu

                property bool shouldCollapse

                Component.onCompleted: {
                    const expandWidth = implicitWidth
                    shouldCollapse = Qt.binding(() =>
                                                toolBar.height < toolBar.maxHeight/2 || expandWidth > toolBar.width)
                }

                anchors {
                    right: parent.right; bottom: parent.bottom; rightMargin: UI.pagePadding
                }
            }

            SearchPane {
                id: searchPane
                anchors.fill: parent
                state: "hide"
                onStateChanged: if (state === "show") collapseToolbarAnimation.start()

                NumberAnimation {
                    id: collapseToolbarAnimation
                    target: toolBar
                    property: "height"
                    to: toolBar.implicitHeight
                    duration: UI.controlsDuration
                }
            }
        }


        ScrollView {
            id: scrollView
            anchors.fill: parent
            contentWidth: contentItem.width
            padding: UI.pagePadding

            Flow {
                id: flow
                spacing: UI.listSpacing
                anchors { left: parent.left; right: parent.right }

                Repeater {
                    model: States.notebookModel
                    delegate: NotebookCard {
                        id: notebookCard
                        text: name || ""
                        materialColor: color || 0
                        onClicked: {
                            Actions.setCurrentNotebook(index)
                            if (Actions.pickRandomEntry()) {
                                notebookListPage.reviewTriggered()
                            } else {
                                UI.showMessage({
                                                   "text": qsTr("There's no entry in this notebook. Click \"EDIT\" to create one.")
                                               })
                            }
                        }
                        onEditClicked: {
                            Actions.setCurrentNotebook(index)
                            notebookListPage.editTriggered()
                        }
                    }
                }

                CreateCard {
                    onClicked: notebookListPage.newTriggered()
                }
            }

        }

        SearchResultPane {
            anchors.fill: parent
            z: 2
            state: searchPane.state
            onEntryClicked: notebookListPage.editEntryTriggered()
        }
    }
}

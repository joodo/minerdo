import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.13

import Minerdo 1.0

Pane {
    id: noteBookCard

    property string text
    property int materialColor
    signal clicked()
    signal editClicked()

    height: UI.cardHeight; width: UI.cardWidth
    padding: 12
    Material.elevation: noteBookCard.hovered? 4:0
    Behavior on Material.elevation { NumberAnimation { duration: UI.controlsDuration }}

    background: Rectangle {
        color: Material.color(noteBookCard.materialColor, UI.backgroundShade)
        radius: 8
        border.color: Material.color(Material.Grey)
        border.width: 1
        layer.enabled: noteBookCard.enabled && noteBookCard.Material.elevation > 0
        layer.effect: ElevationEffect {
            elevation: noteBookCard.Material.elevation
        }
        clip: true
        Rectangle {
            anchors {
                verticalCenter: parent.top; horizontalCenter: parent.horizontalCenter
            }
            color: Material.color(noteBookCard.materialColor)
            height: 8; width: parent.width - 80
            radius: 4
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: noteBookCard.clicked()
    }

    Label {
        font.pointSize: 22
        text: noteBookCard.text
        anchors {
            left: parent.left; leftMargin: 8
            right: parent.right; rightMargin: 8
            top: parent.top; topMargin: 4
        }
        wrapMode: Text.Wrap
        //anchors.centerIn: parent
    }

    Button {
        flat: true
        text: qsTr("Edit")
        anchors { bottom: parent.bottom; bottomMargin: -8; right: parent.right }
        visible: noteBookCard.hovered
        background: Item {}
        highlighted: hovered
        onClicked: noteBookCard.editClicked()
    }
}

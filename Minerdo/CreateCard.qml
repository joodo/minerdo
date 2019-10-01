import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.13

import Minerdo 1.0

Pane {
    id: createCard

    signal clicked()

    height: UI.cardHeight; width: UI.cardWidth
    Material.elevation: createCard.hovered? 4:0
    Behavior on Material.elevation { NumberAnimation { duration: UI.controlsDuration }}

    background: Rectangle {
        color: Material.background
        radius: 8
        border.color: Material.color(Material.Grey)
        border.width: 1

        layer.enabled: createCard.enabled && createCard.Material.elevation > 0
        layer.effect: ElevationEffect {
            elevation: createCard.Material.elevation
        }
    }

    Rectangle {
        anchors.centerIn: parent
        width: 6; height: 60
        radius: width
        color: Material.color(Material.Grey)
        Rectangle {
            anchors.centerIn: parent
            width: parent.height; height: parent.width
            radius: parent.radius
            color: parent.color
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: createCard.clicked()
    }
}

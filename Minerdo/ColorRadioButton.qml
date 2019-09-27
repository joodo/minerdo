import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

RadioButton {
    id: radioButton
    property int color

    indicator: null
    contentItem: Item {
        implicitHeight: UI.dp(32); implicitWidth: UI.dp(48)
        Rectangle {
            anchors { fill: parent; margins: checked? 0 : 1 }
            radius: UI.dp(8)
            color: Material.color(radioButton.color, checked? Material.Shade500:UI.backgroundShade)
        }
    }
}

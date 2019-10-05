import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

RadioButton {
    id: radioButton
    property int color

    indicator: null
    contentItem: Rectangle {
            implicitHeight: 26; implicitWidth: implicitHeight
            radius: implicitHeight
            color: Material.color(radioButton.color, UI.backgroundShade)
            border.width: radioButton.checked || radioButton.hovered? 2 : 0
            border.color: Material.color(Material.Grey)
    }
}

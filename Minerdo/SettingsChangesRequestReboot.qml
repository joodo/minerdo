import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

Label {
    background: Rectangle {
        color: Material.color(Material.BlueGrey, UI.backgroundShade)
    }
    text: "⚠︎ " + qsTr("Restart Minerdo to apply this change.")
    padding: 6
    font.pointSize: 11
}

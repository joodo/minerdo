pragma Singleton

import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls.Material 2.13

QtObject {
    signal showMessage(var message)

    function dp(pointSize) {
        return Math.round(pointSize * Screen.pixelDensity * 25.4 / 160)
    }

    readonly property int controlsDuration: 100
    readonly property int fadeInDuration: 150
    readonly property int fadeOutDuration: 75
    readonly property int mediumExpandDuration: 250
    readonly property int mediumCollapseDuration: 200
    readonly property int cardExpandDuration: 300
    readonly property int cardCollapseDuration: 250


    readonly property real cardWidth: dp(344)

    readonly property int backgroundShade: Material.theme === Material.Light? Material.Shade100 : Material.Shade500
}

import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

RoundButton {
    icon.color: Material.toolTextColor
    width: 48; height: width
    Material.elevation: pressed? 12 : hovered? 8 : 6
    Behavior on Material.elevation { NumberAnimation { duration: UI.controlsDuration }}
    topInset: 0; bottomInset: 0; leftInset: 0; rightInset: 0
    display: AbstractButton.IconOnly
}

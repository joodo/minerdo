import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

RoundButton {
    icon.color: Material.toolTextColor
    width: UI.dp(60); height: width
    Material.elevation: 10
    topInset: 0; bottomInset: 0; leftInset: 0; rightInset: 0
    display: AbstractButton.IconOnly
}

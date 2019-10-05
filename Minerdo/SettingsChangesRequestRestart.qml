import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

Button {
    text: qsTr("Restart Minerdo to apply this change.")
    icon.source: "qrc:/material-icons/warning.svg"
    icon.height: 20; icon.width: 20
    font.pointSize: 12
    flat: true
    onClicked: Utils.restart()
}

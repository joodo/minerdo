import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13
import Qt.labs.settings 1.1 as QtLabs

import Minerdo 1.0

Button {
    id: alwaysOnTopButton
    checkable: true
    topInset: 0; bottomInset: 0; padding: 0
    height: 12
    width: checked? 30 : height
    Behavior on width { NumberAnimation { duration: UI.controlsDuration} }
    background: Rectangle {
        radius: height
        color: Material.color(Material.Blue)
    }
    contentItem: Text {
        text: "▲"
        font.pointSize: 10
        opacity: 0.5
        visible: alwaysOnTopButton.hovered || alwaysOnTopButton.checked
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    ToolTip.text: qsTr("Stay on top")
    ToolTip.visible: hovered
}

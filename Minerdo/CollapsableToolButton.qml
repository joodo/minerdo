import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

ToolButton {
    id: toolButton
    property bool initedState: false

    onStateChanged: {
        // avoid component blink on loading finished
        if (!initedState) {
            initedState = true
            return
        }
        if (state === "collapse") {
            displayChangePropertyAction.value = AbstractButton.IconOnly
            animation.restart()
        } else if (state === "expand") {
            displayChangePropertyAction.value = AbstractButton.TextBesideIcon
            animation.restart()
        } else {
            print("Unacceptable state:", state)
        }
    }

    SequentialAnimation {
        id: animation
        NumberAnimation {
            target: toolButton.contentItem
            property: "opacity"
            to: 0
            duration: UI.fadeOutDuration
        }
        PropertyAction {
            id: displayChangePropertyAction
            target: toolButton
            property: "display"
        }
        NumberAnimation {
            target: toolButton.contentItem
            property: "opacity"
            to: 1
            duration: UI.fadeInDuration
        }
    }
}

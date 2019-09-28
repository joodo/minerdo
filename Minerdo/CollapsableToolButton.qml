import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

ToolButton {
    id: toolButton
    property string collapsedText
    property string expandText
    property bool initedState: false

    onStateChanged: {
        // avoid component blink on loading finished
        if (!initedState) {
            initedState = true
            text = state === "collapse"? collapsedText : expandText
            return
        }
        if (state === "collapse") {
            textChangePropertyAction.value = collapsedText
            animation.restart()
        } else if (state === "expand") {
            textChangePropertyAction.value = expandText
            animation.restart()
        } else {
            print("Unacceptable state:", state)
        }
    }

    SequentialAnimation {
        id: animation
        PropertyAnimation {
            target: toolButton.contentItem
            property: "opacity"
            to: 0
            duration: UI.fadeOutDuration
        }
        PropertyAction {
            id: textChangePropertyAction
            target: toolButton
            property: "text"
        }
        PropertyAnimation {
            target: toolButton.contentItem
            property: "opacity"
            to: 1
            duration: UI.fadeInDuration
        }
    }
}

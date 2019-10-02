import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

TextArea {
    id: minerdoTextArea
    selectByMouse: true
    wrapMode: TextEdit.Wrap
    Keys.onPressed: {
        if (event.key === Qt.Key_Tab) {
            if (event.modifiers === Qt.NoModifier) {
                nextItemInFocusChain().focus = true
            } else if (event.modifiers === Qt.ShiftModifier) {
                nextItemInFocusChain(false).focus = true
            }
        }
    }

    DropArea {
        anchors.fill: parent
        keys: ["text/plain","text/html"]
        onDropped: {
            if (drop.hasText) {
                const content = Utils.strip(drop.html)
                minerdoTextArea.insert(minerdoTextArea.cursorPosition, content)
            }
        }
        onEntered: {
            minerdoTextArea.forceActiveFocus()
        }
        onPositionChanged: {
            minerdoTextArea.cursorPosition = minerdoTextArea.positionAt(drag.x,
                                                                        drag.y)
        }
    }
}

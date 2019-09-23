import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import ReviewHelper 1.0

TextArea {
    id: entryTextArea
    selectByMouse: true
    Keys.onPressed: {
        if (event.key === Qt.Key_Tab) {
            event.accepted = true
            if (event.modifiers === Qt.NoModifier) {
                nextItemInFocusChain().focus = true
            } else if (event.modifiers === Qt.ShiftModifier) {
                nextItemInFocusChain(false).focus = true
            }
        }
    }
}

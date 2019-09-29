pragma Singleton

import QtQuick 2.13
import Qt.labs.settings 1.0
import QtQuick.Controls.Material 2.13

QtObject {
    readonly property var userInterface: Settings {
        category: "interface"
        property string theme: "System"
    }
    property var init
    Component.onCompleted: {
        init = {
            "interface": {
                "theme": userInterface.theme
            }
        }
    }
}

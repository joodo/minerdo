import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0
import "axios.js" as Axios

Pane {
    id: searchPane
    visible: opacity !== 0
    Behavior on opacity { OpacityAnimator { duration: UI.controlsDuration } }
    TextField {
        id: searchField
        focus: true
        anchors.fill: parent
        background: Item {}
        topPadding: 0
        bottomPadding: 0
        placeholderText: qsTr("Search entries")
        selectByMouse: true
        color: Material.primaryTextColor
    }
    ToolButton {
        anchors { right: parent.right; verticalCenter: parent.verticalCenter }
        icon.source: "qrc:/material-icons/close.svg"
        icon.color: Material.primaryTextColor
        onClicked: searchPane.state = "hide"
    }

    
    states: [
        State {
            name: "show"
            PropertyChanges {
                target: searchPane
                opacity: 1
            }
            PropertyChanges {
                target: searchField
                focus: true
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: searchPane
                opacity: 0
            }
        }
        
    ]
}

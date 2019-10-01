import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

Pane {
    id: snackbar
    
    readonly property real lifeTime: 4000
    readonly property real position: 60
    property var messageQueue: []
    
    function show(newMessage) {
        messageQueue.push(newMessage)
        if (!visible) showNext()
    }
    
    function showNext() {
        if (messageQueue.length === 0) return
        
        const newMessage = messageQueue.pop()
        snackbarLabel.text = newMessage.text
        snackbarHideTimer.interval = newMessage.lifeTime? newMessage.lifeTime: lifeTime
        y = newMessage.position? newMessage.position : position
        y = window.height - y - height
        
        opacity = 1
    }
    
    Material.elevation: 6
    z: 1
    opacity: 0
    Material.theme: parent.Material.theme === Material.Light? Material.Dark : Material.Light
    Component.onCompleted: background.radius = 4
    Behavior on opacity { NumberAnimation {
            alwaysRunToEnd: true
            duration: to === 1? UI.fadeInDuration : UI.fadeOutDuration
        }}
    visible: opacity !== 0
    onOpacityChanged: {
        if (opacity === 0) {
            snackbarHideTimer.stop()
            showNext()
        } else if (opacity === 1) {
            snackbarHideTimer.restart()
        }
    }
    
    Label {
        id: snackbarLabel
        MouseArea {
            anchors.fill: parent
            onClicked: parent.parent.parent.opacity = 0
        }
    }
    
    Timer {
        id: snackbarHideTimer
        onTriggered: snackbar.opacity = 0
    }
}

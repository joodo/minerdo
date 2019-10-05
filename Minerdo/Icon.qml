import QtQuick 2.13
import QtGraphicalEffects 1.13

Item {
    id: icon
    property alias color: background.color
    property alias source: mask.source
    property alias size: icon.width

    implicitWidth: 24; implicitHeight: 24
    Rectangle {
        id: background
        visible: false
        anchors.fill: parent
        width: parent.width; height: icon.height
    }
    Image {
        id: mask
        fillMode: Image.PreserveAspectFit
        visible: false
    }
    OpacityMask {
        anchors.fill: parent
        source: background
        maskSource: mask
    }
}

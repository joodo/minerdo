import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

Pane {
    id: searchResultPane

    signal entryClicked()

    property bool emptyHintEnabled

    visible: opacity !== 0
    Behavior on opacity { OpacityAnimator { duration: UI.controlsDuration } }

    ListView {
        anchors.fill: parent
        model: SearchEngine.searchResult
        delegate: ItemDelegate {
            onClicked: {
                Actions.setCurrentEntry(modelData.index)
                searchResultPane.entryClicked()
            }
            
            anchors {
                left: parent.left; right: parent.right
            }
            
            text: modelData.result
        }
    }

    ColumnLayout {
        id: emptyHint
        z: -1
        visible: SearchEngine.noResult
        anchors.centerIn: parent
        spacing: UI.listSpacing
        Image {
            source: "qrc:/material-icons/no_result.svg"
            Layout.alignment: Qt.AlignHCenter
        }
        Label {
            text: qsTr("No Result")
            font.pointSize: 20
            Layout.alignment: Qt.AlignHCenter
        }
    }

    states: [
        State {
            name: "show"
            PropertyChanges {
                target: searchResultPane
                opacity: 1
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: searchResultPane
                opacity: 0
            }
        }

    ]
}

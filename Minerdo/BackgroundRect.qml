import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0
import "axios.js" as Axios

Rectangle {
    id: backgroundRect

    property real minimumHeight
    property real maximumHeight
    readonly property string imagePath: Utils.absoluteFilePath(Utils.currentPath(), ".background")

    function opacityFromHeight() {
        return (height - minimumHeight) / (maximumHeight - minimumHeight)
    }

    color: Material.toolBarColor
    implicitHeight: 48

    Rectangle {
        id: backgroundImageRect

        Component.onCompleted: {
            opacity = image.status===Image.Ready? Qt.binding(opacityFromHeight) : 0
        }

        color: "black"
        clip: true
        anchors.fill: parent

        Image {
            id: image
            readonly property real stretchRate: 0.01
            property real offsetX: (mouseArea.mouseX-backgroundRect.width/2)*stretchRate
            property real offsetY: (mouseArea.mouseY-backgroundRect.height/2)*stretchRate
            Component.onCompleted: {
                Axios.instance.get("https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&ensearch=1")
                .then(response => {
                          let url = response.data.images[0].url
                          url = "http://www.bing.com" + url
                          if (Settings.userInterface.backgroundUrl === url &&
                              Utils.fileExists(backgroundRect.imagePath)) {
                              return Promise.reject("background cached")
                          } else {
                              Settings.userInterface.backgroundUrl = url
                              return Axios.instance.get(
                                  url,
                                  { responseType: "arraybuffer" },
                                  )
                          }
                      })
                .then(response => {
                          if (!Utils.save(backgroundRect.imagePath, response.data)) {
                              return Promise.reject("cannot save file: " + backgroundRect.imagePath)
                          }

                          if (status !== Image.Ready) {
                              // reload image
                              const t = source
                              source = ""
                              source = t
                              backgroundShowAnimator.start()
                          }
                      })
                .catch(reason => print(reason))
            }
                    width: (stretchRate*2+1) * backgroundRect.width
                height: (stretchRate*2+1) * backgroundRect.height
                x: -stretchRate*backgroundRect.width + offsetX
                y: -stretchRate*backgroundRect.height + offsetY
                fillMode: Image.PreserveAspectCrop
                opacity: .6
                source: Utils.urlFromPath(backgroundRect.imagePath)
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
            }

            OpacityAnimator {
                id: backgroundShowAnimator
                duration: UI.cardExpandDuration
                target: backgroundImageRect
                to: opacityFromHeight()
                onFinished: backgroundImageRect.opacity = Qt.binding(opacityFromHeight)
            }
        }
    }

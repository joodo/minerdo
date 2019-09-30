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

    Component.onCompleted: {
        opacity = image.status===Image.Ready? opacityFromHeight() : 0
    }

    color: "black"

    Image {
        id: image
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
                      print("get pic")
                      if (!Utils.save(backgroundRect.imagePath, response.data)) {
                          return Promise.reject("cannot save file: " + backgroundRect.imagePath)
                      }

                      print("change")
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
        anchors.fill: parent
        fillMode: Image.Tile
        opacity: .6
        source: Utils.urlFromPath(backgroundRect.imagePath)
    }

    OpacityAnimator {
        id: backgroundShowAnimator
        duration: UI.cardExpandDuration
        target: backgroundRect
        to: opacityFromHeight()
        onFinished: backgroundRect.opacity = Qt.binding(opacityFromHeight)
    }
}

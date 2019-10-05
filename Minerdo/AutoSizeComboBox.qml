import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

ComboBox {
    id: autoSizeComboBox

    property real modelWidth: 0
    function adjustSize() {
        for(var i = 0; i < count; i++){
            modelWidth = Math.max(
                        Utils.textSize(font, textAt(i)).width,
                        modelWidth)
        }
    }

    onCountChanged: adjustSize()

    implicitWidth: modelWidth + 2*leftPadding + 2*rightPadding
}

import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

ComboBox {
    id: autoSizeComboBox

    property real modelWidth: 0
    function adjustSize() {
        textMetrics.font = autoSizeComboBox.font
        for(var i = 0; i < model.count; i++){
            modelWidth = Math.max(
                        Utils.textSize(autoSizeComboBox.font, model.get(i).key).width,
                        modelWidth)
        }
    }

    onCountChanged: adjustSize()

    implicitWidth: modelWidth + 2*leftPadding + 2*rightPadding

    // TODO: change other width calculate like this!
    // TODO: refactor it to utils with QFontMetricsF class
    TextMetrics {
        id: textMetrics
    }
}

import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

ComboBox {
    id: autoSizeComboBox

    property real modelWidth

    implicitWidth: modelWidth + 2*leftPadding + 2*rightPadding

    onModelChanged: {
        textMetrics.font = autoSizeComboBox.font
        for(var i = 0; i < model.length; i++){
            textMetrics.text = model[i]
            modelWidth = Math.max(textMetrics.width, modelWidth)
        }
    }

    // TODO: change other width calculate like this!
    TextMetrics {
        id: textMetrics
    }
}

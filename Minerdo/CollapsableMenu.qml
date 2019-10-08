import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.13

import Minerdo 1.0

RowLayout {
    id: collapsableMenu

    Component.onCompleted: Qt.callLater(
                               () => {
                                   for (let i = 0; i < children.length; i++) {
                                       const button = children[i]
                                       button.display = collapsableMenu.shouldCollapse?
                                           AbstractButton.IconOnly : AbstractButton.TextBesideIcon
                                       button.state = Qt.binding(() => collapsableMenu.shouldCollapse?"collapse" : "expand")
                                       button.stateChanged.connect(button.updateDisplayByState)
                                   }
                               })

    spacing: 0
    
    CollapsableToolButton {
        icon.source: "qrc:/material-icons/settings.svg"
        text: qsTr("Settings")
        onClicked: {
            notebookListPage.settingsTriggered()
        }
    }
    CollapsableToolButton {
        icon.source: "qrc:/material-icons/library_books.svg"
        text: qsTr("Review All")
        onClicked: {
            Actions.setCurrentNotebook(-1)
            if (Actions.pickRandomEntry()) {
                notebookListPage.reviewTriggered()
            } else {
                UI.showMessage({
                                   "text": qsTr("There's no entry, please create one.")
                               })
            }
        }
    }
    CollapsableToolButton {
        icon.source: "qrc:/material-icons/search.svg"
        text: qsTr("Search")
        onClicked: {
            searchPane.state = "show"
            Actions.setCurrentNotebook(-1)
            SearchEngine.updateIndex(States.entryModel, ["question", "answer", "note"])
            SearchEngine.clearResult()
        }
    }
}

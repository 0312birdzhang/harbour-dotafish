import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.dotafish.settings 1.0
import "../components"

Dialog {
    id: disclaimer

    Component.onCompleted: {
        settings.set_accepted_status(false);
    }
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: disclaimercolumn.height + disclaimercolumn.spacing

        Column {
            id: disclaimercolumn
            width: parent.width
            spacing: Theme.paddingSmall

            DialogHeader {
                title: qsTr("Disclaimer")
            }

            Label {

                property string disclaimertext: qsTr("This application use some image resource is from valve....balabalabalabalabalabla....")

                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - Theme.paddingMedium * 2
                wrapMode: Text.WordWrap
                text: disclaimertext
            }
        }
    }

    acceptDestinationReplaceTarget: Qt.resolvedUrl("FirstPage.qml");

    onAccepted: settings.set_accepted_status(true)
    onRejected: Qt.quit()
}

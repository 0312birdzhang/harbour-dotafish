import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.dotafish.settings 1.0
import "../components"

Dialog {
    id: disclaimer
    acceptDestinationAction: PageStackAction.Pop

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

                property string disclaimertext: qsTr("This application use some image resource and data resoure is licensed to valve,if you accept this disclaimer,it means you know all about that.I am not liable for any other damage caused by use,balabalabalabalabalabla....")

                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - Theme.paddingMedium * 2
                wrapMode: Text.WordWrap
                text: disclaimertext
            }
        }
    }
    onAccepted: settings.set_accepted_status(true)
    onRejected: Qt.quit();
}

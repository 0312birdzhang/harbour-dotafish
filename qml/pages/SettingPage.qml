import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"
import "./API.js" as API

Page {
    id: aboutPage;
    allowedOrientations: Orientation.Portrait | Orientation.Landscape

    ListModel{
        id:langModel
    }

    SilicaFlickable {
        anchors.fill: parent
        PageHeader{
            id:header
            title:qsTr("About")
        }

        clip: true;
        contentWidth: width;
        contentHeight: contentCol.height + Theme.paddingLarge * 5

        Column {
            id: contentCol;
            anchors {
                left: parent.left;
                right: parent.right;
                margins: Theme.paddingSmall;
                top:header.bottom
            }
            spacing: Theme.paddingLarge;
            Item { width: 1; height: 1 }

            Image{
                id:logo
                fillMode: Image.Stretch;
                source:"../gfx/victory.png"
                anchors.horizontalCenter: parent.horizontalCenter;
            }

            Item { width: 1; height: 1 }
            Label{
                id:version
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("Version")+" 0.1-2"

            }
            Item{width:1;height:1}
            LabelText {
                label: qsTr("Description")
                text: qsTr("DotaFish is a util for dotaers and sailors,all the resource is linsinced to valve")

            }
            Item{width:1;height:1}
            LabelText {
                label: qsTr("Author")
                text: "BirdZhang"

            }
            Item{width:1;height:1}
            LabelText {
                label: qsTr("Donation")
                text:   qsTr("My alipay account: 18520399451 <br/>Donations are welcome :)");

            }
            Item{width:1;height:1}
//            SectionHeader {
//                text: qsTr("Settings")
//            }
//            ComboBox {
//                label: qsTr("Language:")
//                menu: ContextMenu {
//                    Repeater{
//                        model:langModel
//                        MenuItem {
//                            text: country
//                            onClicked: {
//                                application.lang = abbreviation
//                            }
//                        }
//                    }
//                }
//            }



        }
    }
    Component.onCompleted: {
//        for(var i in API.languages){
//            langModel.push(API.languages[i]);
//        }
    }
}

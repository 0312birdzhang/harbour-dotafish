import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: aboutPage;
    allowedOrientations: Orientation.Portrait | Orientation.Landscape
    SilicaFlickable {
        anchors.fill: parent
        PageHeader{
            id:header
            title:qsTr("About")
        }

        clip: true;
        contentWidth: width;
        contentHeight: contentCol.height + Theme.paddingLarge * 5
        RemorsePopup {
            id: remorse
        }
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
                text: qsTr("DotaFish is a util for dotaers and sailfishers")

            }
            Item{width:1;height:1}
            LabelText {
                label: qsTr("Author")
                text: "BirdZhang"

            }
            Item{width:1;height:1}
            LabelText {
                label: qsTr("Donation")
                text:"如果你觉得此软件你有所益处，你可以选择捐赠本人。当然，本软件是完全"
                    +"免费的，你可以尽情使用。<br/>"+
                     "  我的支付宝账号:18520399451 <br/> 狗哥的支付宝账号tngou@tngou.net<br/> Donations are welcome :)"

            }
            Item{width:1;height:1}
            SectionHeader {
                //: headline for application licensing information
                text: "设置"
            }
            Item{
                width: parent.width
                height:imgswitch.height
                TextSwitch {
                    id: imgswitch
//                    checked: openimg == 1
//                    onClicked: updateSetting()
                    text: "显示图片"
                }

            }
            Item{width:1;height:1}
            Button{
                id:clearButton
                text:qsTr("clear cache")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    remorse.execute(qsTr("Begin clear cache..."),function(){
//                        py.clearCache();
                    },3000);
                }
            }


        }
    }
}

import QtQuick 2.0
import Sailfish.Silica 1.0
Item {

    property alias abilityImg: abilityImg.source
    property alias abilityName: abilityName.text
    property alias abilityDesc: abilityDesc.text
    property alias abilityNotes: abilityNotes.text
    property alias abilityList: abilityList.text


    width: parent.width
    height: col.height

    Column{
        id:col
        width: parent.width
        spacing: Theme.paddingLarge
        Row{
            width: parent.width
            spacing: Theme.paddingMedium
            Image{
                id:abilityImg
                width: parent.width/4
                height: width
                anchors{
                    margins: Theme.paddingMedium
                }
            }
            Item { width: 1; height: 1 }
            Column{
                width: parent.width - abilityImg.width
                anchors{
                    margins: Theme.paddingMedium
                }

                Label{
                    id:abilityName
                    anchors{
                        left: parent.left
                    }
                    font.bold: true
                    font.pixelSize: Theme.fontSizeMedium
                }
                Label{
                    id:abilityDesc
                    wrapMode: Text.WordWrap
                    opacity: 0.8
                    anchors{
                        left:parent.left
                        right:parent.right
                        rightMargin: Theme.paddingMedium
                    }
                    font.pixelSize: Theme.fontSizeExtraSmall
                }
            }
        }
        Item { width: 1; height: 1 }
        LabelText{
            id:abilityNotes
            label: qsTr("Tips")
            visible: abilityNotes.text.length > 2

        }
        Item{height: 1;width: 1}
        LabelText{
            id:abilityList
            label: qsTr("Summary")
        }
        Item { width: 1; height: Theme.itemSizeMedium }

    }

//    OpacityRampEffect {
//        id: effect
//        slope: 2.00
//        offset: 0.50
//        sourceItem: col
//        direction:OpacityRamp.TopToBottom
//    }

    Rectangle {
        anchors.fill: parent
        z:-1
        gradient: Gradient {
            GradientStop { position: 0.0; color: Theme.rgba(Theme.highlightBackgroundColor, 0.3) }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

}

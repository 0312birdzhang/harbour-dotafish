import QtQuick 2.0
import Sailfish.Silica 1.0



Page {
    id:itemDetailPage
    property string item
    property variant detail

    allowedOrientations: Orientation.All

    ListModel{
        id:compModel
    }

    SilicaFlickable{
        id:filick
        anchors.fill: parent
        contentHeight: col.height + comps.height + col.spacing * 2
        contentWidth: width;
        PageHeader{
            id:header
            title: detail.dname
        }
        Column{
            id:col
            spacing: Theme.paddingLarge
            anchors{
                top:header.bottom
                left:parent.left
                right: parent.right
            }

            Row{
                spacing: Theme.paddingMedium
                anchors.leftMargin: Theme.paddingMedium
                Image{
                    source: "./items/"+item+"_lg.png"
                }
                Label{
                    text:detail.dname
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeMedium
                    font.bold: true

                }
                Image{
                    source: "../gfx/gold.png"
                    visible: detail.cost>0
                    anchors.verticalCenter: cost.verticalCenter

                }
                Label{
                    id:cost
                    text:detail.cost
                    visible: detail.cost > 0
                    font.pixelSize: Theme.fontSizeSmall

                }
            }

            Label{
                text:detail.desc + "<br/>"+detail.attrib
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.WordWrap
                anchors{
                    left:parent.left
                    right: parent.right
                    margins: Theme.paddingMedium
                }
            }
            Label{
                text:detail.lore
                opacity: 0.7
                font.pixelSize: Theme.fontSizeTiny
                wrapMode: Text.WordWrap
                anchors{
                    left:parent.left
                    right: parent.right
                    margins: Theme.paddingMedium
                }
            }

            Row{
                spacing: Theme.paddingLarge
                anchors.leftMargin: Theme.paddingMedium
                Image{
                    source: "../gfx/cooldown.png"
                    anchors.verticalCenter: cd.verticalCenter
                    visible: "null" != detail.cd && "false" != detail.cd
                }
                Label{
                    id:cd
                    text:detail.cd
                    visible: "null" != detail.cd && "false" != detail.cd
                }
            }

            SectionHeader {
                text: qsTr("Components")
                visible: compModel.count > 0
            }


        }
        Column{
            id:comps
            spacing: Theme.paddingSmall
            width: parent.width
            height: compgrid.height
            anchors{
                top:col.bottom
                left:parent.left
                right: parent.right
            }
            Grid{
                id:compgrid
                width:parent.width
                anchors{
                    left:parent.left
                    right:parent.right
                }
                columns: 4
                Repeater {
                    model: compModel
                    BackgroundItem {
                            id: delegate
                            height: (parent.width - Theme.paddingMedium ) / 4
                            width: (parent.width - Theme.paddingMedium ) / 4
                            Label {
                                id:itemLabel
                                text: citem == "recipe" ?"":application.appJson.itemdata[citem].dname
                                anchors{
                                    left:parent.left
                                    right: parent.right
                                    margins: Theme.paddingSmall
                                }
                                height: Theme.itemSizeSmall
                                opacity:0.8
                                maximumLineCount: 2
                                wrapMode: Text.WordWrap
                                width: parent.width - Theme.paddingSmall * 2
                                font.pixelSize: Theme.fontSizeTiny
                                truncationMode: TruncationMode.Elide
                                horizontalAlignment: Text.AlignLeft
                                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                            }
                            Image{
                                id:cimg
                                anchors{
                                    left:parent.left
                                    right:parent.right
                                    top:itemLabel.bottom
                                    margins: Theme.paddingMedium
                                }
                               source: "items/"+citem+"_lg.png"
                            }
                            onClicked:{
                                enabled:citem != "recipe"
                                application.appJson.itemdata[model.citem].item = model.citem
                                pageStack.replace(Qt.resolvedUrl("ItemDetail.qml"),
                                               {
                                                "item":citem,
                                                "detail":application.appJson.itemdata[citem]
                                               })
                            }
                        }
                }
            }
        }

    }

    Component.onCompleted: {
        var components = application.appJson.itemdata[item].components;
        if(components){
            for(var i in components){
                if(components[i].indexOf("recipe_") > -1){
                    compModel.append({
                                         "citem":"recipe"
                                     })
                }else{
                    compModel.append({
                                         "citem":components[i]
                                     })
                }


            }
        }
    }

}

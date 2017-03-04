import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"
import "./API.js" as API
Page{
    id:heroDetailPage
    property string hero
    property variant detail

    allowedOrientations: Orientation.All

    ListModel{
        id:abilityModel
    }

    SilicaFlickable{
        id:flickable
        anchors.fill:parent
        PageHeader{
            id:header
            title: detail.u.replace("_"," ") + " ["+heroJson[hero].atk_l + "]"
            description:  detail.droles
        }
        clip: true;
        contentWidth: width;
        contentHeight: contentCol.height + Theme.itemSizeExtraLarge
        Column{
            id:contentCol
            width: parent.width
            spacing: Theme.paddingLarge
            anchors{
                left: parent.left
                right: parent.right
                top:header.bottom
                margins: Theme.paddingSmall
            }

            Item { width: 1; height: 1 }
            Column{
                anchors{
                    left:parent.left
                    right:parent.right
                }

                Row{
                    id:avtarAttri
                    width:parent.width/2
                    spacing: Theme.paddingLarge
                    Image{
                        id:fullAvt
                        source: "heroes/"+hero+"_vert.jpg"
                        width: parent.width
                        height: width*1.2
                        Image{
                            source:"../gfx/overviewicon_"+detail.pa+".png"
                            anchors{
                                top:parent.top
                                left:parent.left
                                margins: Theme.paddingMedium
                            }
                        }
                    }

                    Column {
                        id:heroProperty
                        width: parent.width

                        HeroAttribs{
                            width: parent.width
                            icon: "../gfx/overviewicon_int.png"
                            attval: detail.attribs.int.b + " + " +detail.attribs.int.g
                            ext: "../gfx/overviewicon_attack.png"
                            extval:detail.attribs.dmg.min + " - " + detail.attribs.dmg.max
                        }
                        Item{width: 1;height: fullAvt.height/4}
                        HeroAttribs{
                            width: parent.width
                            icon:"../gfx/overviewicon_agi.png"
                            attval: detail.attribs.agi.b + " + " +detail.attribs.int.g
                            ext: "../gfx/overviewicon_speed.png"
                            extval:detail.attribs.ms
                        }
                        Item{width: 1;height: fullAvt.height/4}
                        HeroAttribs{
                            width: parent.width
                            icon:"../gfx/overviewicon_str.png"
                            attval: detail.attribs.str.b + " + " +detail.attribs.int.g
                            ext: "../gfx/overviewicon_defense.png"
                            extval:detail.attribs.armor
                        }

                    }
                }
            }

            Item { width: 1; height: 1 }
            Column{
                anchors{
                    left:parent.left
                    right: parent.right
                }
                width: parent.width
                spacing: Theme.paddingLarge
                LabelText {
                        label: qsTr("Bio")
                        text: heroJson[hero].bio;
                }
                Item{
                    width: 1
                    height: Theme.itemSizeSmall
                }

                LabelText{
                    label:qsTr("Abilities")
                    text:""
                }

                Repeater{
                    id:screenshotview;
                    model: abilityModel
                    delegate: HeroAbilities{
                        abilityImg: "abilities/"+ability+"_hp1.png";
                        abilityDesc: desc
                        abilityName: dname
                        abilityNotes: notes
                        abilityList: affects+attrib
                    }
                }


            }


      }

        VerticalScrollDecorator{flickable: flickable}

    }

    Component.onCompleted: {
//        console.log(hero)
        for(var i in appJson.abilitydata){
            if(i.indexOf(hero+"_") == 0){
                appJson.abilitydata[i].ability = i
                abilityModel.append(appJson.abilitydata[i]);
            }
        }
    }
}

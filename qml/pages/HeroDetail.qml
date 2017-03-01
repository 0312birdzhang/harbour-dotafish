import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"
import "./API.js" as API
Page{
    id:heroDetailPage
    property string heroName
    property string u
    property string hero
    property variant detail

    allowedOrientations: Orientation.All

    PageHeader{
        id:header
        title: u
    }

    SilicaFlickable{
        id:flickable
        anchors{
            top:header.bottom
            left:parent.left
            right: parent.right
            margins: Theme.paddingSmall
        }

        Label{
            id:heroPeoper
            anchors{
                top:parent.top
                horizontalCenter: parent.horizontalCenter
                margins: Theme.paddingSmall
            }
            width: Screen.width> Screen.height?Screen.width/4*3:Screen.width/3*2
            text: detail.droles
            wrapMode: Text.WordWrap
            font.pixelSize: Theme.fontSizeSmall
            color: flickable.highlighted ? Theme.highlightColor : Theme.primaryColor
        }
        Image{
            id:fullAvt
            source: "heroes/"+hero+"_vert.jpg"
            width: Screen.width> Screen.height?Screen.width/3:Screen.width/2
            anchors{
                top:heroPeoper.bottom
                left:parent.left
                margins: Theme.paddingSmall
            }
        }


        Column{
            width: Screen.width -  fullAvt.width
            height: fullAvt.height
            anchors{
                top:fullAvt.top
                left:fullAvt.right
                margins: Theme.paddingSmall

            }

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

    Component.onCompleted: {

    }
}

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
    property variant herodetail

    allowedOrientations: Orientation.All

    PageHeader{
        id:header
        title: detail.u
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

        LabelText {
                label: qsTr("Bio")
                text: herodetail.bio;

            }

    }

// {
//     "antimage": {
//         "name": "Anti-Mage",
//         "bio": "The monks of Turstarkuri watched the rugged valleys below their mountain monastery as wave after wave of invaders swept through the lower kingdoms. Ascetic and pragmatic, in their remote monastic eyrie they remained aloof from mundane strife, wrapped in meditation that knew no gods or elements of magic. Then came the Legion of the Dead God, crusaders with a sinister mandate to replace all local worship with their Unliving Lord's poisonous nihilosophy. From a landscape that had known nothing but blood and battle for a thousand years, they tore the souls and bones of countless fallen legions and pitched them against Turstarkuri. The monastery stood scarcely a fortnight against the assault, and the few monks who bothered to surface from their meditations believed the invaders were but demonic visions sent to distract them from meditation. They died where they sat on their silken cushions. Only one youth survived--a pilgrim who had come as an acolyte, seeking wisdom, but had yet to be admitted to the monastery. He watched in horror as the monks to whom he had served tea and nettles were first slaughtered, then raised to join the ranks of the Dead God's priesthood. With nothing but a few of Turstarkuri's prized dogmatic scrolls, he crept away to the comparative safety of other lands, swearing to obliterate not only the Dead God's magic users--but to put an end to magic altogether. ",
//         "atk": "melee",
//         "atk_l": "Melee",
//         "roles": [
//             "Carry",
//             "Escape",
//             "Nuker"
//         ],
//         "roles_l": [
//             "Carry",
//             "Escape",
//             "Nuker"
//         ]
//     },
    Component.onCompleted: {
        herodetail = heroJson.hero;
    }
}

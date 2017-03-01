import QtQuick 2.0
import Sailfish.Silica 1.0
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
            id:heroLabel
            text:heroName
            anchors{
                left: parent.left
            }
            
        }
        Image{
            id:fullAvt
            source: "heroes/"+hero+"_vert.jpg"
            width: Screen.width> Screen.height?Screen.width/3:Screen.width/2
            anchors{
                top:heroLabel.bottom
                left:parent.left
            }
        }
        Label{
            id:heroPeoper
            anchors{
                top:fullAvt.top
                right: parent.right

            }

            text:detail.droles
        }
    }

    Component.onCompleted: {

    }
}

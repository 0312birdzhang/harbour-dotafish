import QtQuick 2.0
import Sailfish.Silica 1.0
import "./API.js" as API
Page{
    id:heroDetailPage
    property string heroName
    property string u

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
            source: "heroes/"+heroName+"_vert.jpg"
            width: parent.width> parent.height?parent.width/4:parent.width/2
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

            text:""
        }
    }

    Component.onCompleted: {

    }
}

import QtQuick 2.0
import Sailfish.Silica 1.0
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
            text:heroName
            
        }
    }
}

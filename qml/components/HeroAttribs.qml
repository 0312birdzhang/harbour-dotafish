import QtQuick 2.0
import Sailfish.Silica 1.0
Item {
    property alias icon:icon.source
    property alias attval:attval.text
    property alias ext:ext.source
    property alias extval:extval.text

    width: parent.width
    height: attval.height

    Image{
        id:icon
        width: parent.width/8
        height: width
        anchors{
            margins: Theme.paddingSmall
        }
    }

    Label{
        id:attval
        color: Theme.highlightColor
        font.pixelSize: Theme.fontSizeExtraSmall
        anchors{
            left: icon.right
            margins: Theme.paddingSmall
        }
    }

    Image{
        id:ext
        anchors{
            left:attval.right
            margins: Theme.paddingSmall
        }

        width: parent.width/8
        height: width
    }

    Label{
        id:extval
        color: Theme.highlightColor
        font.pixelSize: Theme.fontSizeExtraSmall
        anchors{
            left:ext.right
            right: parent.right
            margins: Theme.paddingSmall
        }
    }
}

/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "API.js" as API

Page {
    id: itemsPage
    property alias listmodel:itemsModel
    property variant itemsArr
    property string searchString
    onSearchStringChanged: API.loadItems(application.appJson,searchString);
    ListModel{
        id:itemsModel
    }

    allowedOrientations: Orientation.All

    Column {
        id: headerContainer

        width: itemsPage.width

        PageHeader {
            title: qsTr("Items")
        }

        SearchField {
            id: searchField
            width: parent.width

            Binding {
                target: itemsPage
                property: "searchString"
                value: searchField.text.toLowerCase().trim()
            }
        }
    }
    SilicaGridView {
        id: gridView
        model: itemsModel
        anchors.fill: parent
        anchors.margins: Theme.paddingSmall
        currentIndex: -1
        pressDelay: 120;
        clip: true
        cacheBuffer: 200;
        cellWidth: Screen.width > Screen.height? gridView.width / 5:gridView.width / 4
        cellHeight: cellWidth * 1.4
        header: Item {
            id: header
            width: headerContainer.width
            height: headerContainer.height
            Component.onCompleted: headerContainer.parent = header
        }
        delegate: BackgroundItem {
            id: delegate
            width: gridView.cellWidth
            height: gridView.cellHeight
            Label {
                id:itemLabel
                text: Theme.highlightText(model.dname, searchString, delegate.highlighted ? Theme.primaryColor:Theme.highlightColor)
                anchors{
                    left:parent.left
                    right: parent.right
                    margins: Theme.paddingSmall
                }
                height: Theme.itemSizeSmall
                opacity:0.8
                font.bold: true
                maximumLineCount: 2
                wrapMode: Text.WordWrap
                width: parent.width - Theme.paddingSmall * 2
                font.pixelSize: Theme.fontSizeSmall
                truncationMode: TruncationMode.Elide
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            Image{
                anchors{
                    left:parent.left
                    right:parent.right
                    top:itemLabel.bottom
                    margins: Theme.paddingMedium
                }
               source: "items/"+model.item+"_lg.png"
            }

            Rectangle {
                anchors.fill: parent
                z:-1
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Theme.rgba(Theme.highlightBackgroundColor, 0.3) }
                    GradientStop { position: 1.0; color: "transparent" }
                }
            }

            onClicked:{
                pageStack.push(Qt.resolvedUrl("ItemDetail.qml"),
                               {
                                "item":model.item,
                                "detail":listmodel.get(index)
                               })
            }
        }
        VerticalScrollDecorator {flickable: flickable}
    }

    Component.onCompleted: {
        API.itemsPage = itemsPage;
        API.loadItems(application.appJson,searchString);
    }

}

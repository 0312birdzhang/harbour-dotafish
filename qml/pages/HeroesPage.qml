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
    id: heroesPage
    property alias listmodel:heroesModel
    ListModel{
        id:heroesModel
    }

    allowedOrientations: Orientation.All

    SilicaGridView {
        id: gridView
        model: heroesModel
        anchors.fill: parent
        anchors.margins: Theme.paddingSmall
        header: PageHeader {
            title: qsTr("Heroes")
        }

        currentIndex: -1
        pressDelay: 120;
        clip: true
        cacheBuffer: 2000;
        cellWidth: gridView.width / 3
        cellHeight: cellWidth
        delegate: BackgroundItem {
            id: delegate
            width: gridView.cellWidth
            height: gridView.cellHeight
            Label {
                id:heroLable
                text: dname
                anchors{
                    left:parent.left
                    right: parent.right
                    margins: Theme.paddingSmall
                }
                height: Theme.itemSizeSmall
                opacity:0.8
                font.bold: true
                maximumLineCount: 2
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                font.pixelSize: Theme.fontSizeSmall
                truncationMode: TruncationMode.Elide
                horizontalAlignment: Text.AlignLeft
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            Image{
                id:heroImg
                anchors{
                    left:parent.left
                    right:parent.right
                    top:heroLable.bottom
                    margins: Theme.paddingMedium
                }
               source: "heroes/"+hero+"_hphover.png"
            }

            onClicked:{
                pageStack.push(Qt.resolvedUrl("HeroDetail.qml"),{
                                    "heroName":dname,
                                   "u":u

                               })
            }
        }
        VerticalScrollDecorator {flickable: flickable}
    }

    Component.onCompleted: {
        console.log("started!");
        API.heroesPage = heroesPage;
        API.getHeroes("dota2api_en.json");
        console.log("ended!");
    }
}

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
import "pages"
import "components"
import "pages/API.js" as API


ApplicationWindow
{
    id:application
    property bool loading: false
    property string datafile: "en.json";
    property string heroDatafile: "hero_en.json";
    property variant appJson
    property variant heroJson
    property string lang: "C"

    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: loading
        size: BusyIndicatorSize.Large
    }

    RemorsePopup {
        id: remorse
    }

    Connections{
            target: signalCenter;
            onLoadStarted:{
                application.loading=true;
                processingtimer.restart();
            }
            onLoadFinished:{
                application.loading=false;
                processingtimer.stop();
            }
            onLoadFailed:{
                application.loading=false;
                processingtimer.stop();
                signalCenter.showMessage(errorstring);
            }
        }
    Signalcenter{
           id: signalCenter;
    }


    PanelView {
        id: panelView

        property Page currentPage: pageStack.currentPage

        width: currentPage.width
        panelWidth: Screen.width *0.6
        panelHeight: pageStack.currentPage.height
        height: currentPage && currentPage.contentHeight || pageStack.currentPage.height
        visible:  (!!currentPage && !!currentPage.withPanelView) || !panelView.closed
        anchors.centerIn: parent
        //anchors.verticalCenterOffset:  -(panelHeight - height) / 2

        anchors.horizontalCenterOffset:  0

        Connections {
            target: pageStack
            onCurrentPageChanged: panelView.hidePanel()
        }

        leftPanel: NavigationPanel {
            id: leftPanel
            busy: false
            onClicked: {
                panelView.hidePanel();
            }

            Component.onCompleted: {
                panelView.hidePanel();
            }
        }
    }

    initialPage: Component {
        Page{
            id:splashPage
            Component.onCompleted: {
                splash.visible = true;
                timerDisplay.running = true;
            }

            SilicaFlickable {
                id: splash
                visible: false
                anchors.fill:parent
                Item{
                    anchors.fill: parent
                    width: parent.width
                    height: parent.height
                    Label{
                        id:welcomFont
                        text:qsTr("Welcome to")
                        font.pixelSize: Theme.fontSizeExtraLarge
                        anchors{
                            left:parent.left
                            leftMargin:Theme.paddingLarge
                            bottom:storeName.top
                            //bottomMargin: Theme.paddingSmall
                        }
                    }
                    Label{
                        id:storeName
                        text:qsTr("DotaFish")
                        font.pixelSize: Theme.fontSizeExtraLarge
                        color: Theme.highlightColor
                        anchors{
                            left:parent.left
                            leftMargin:Theme.paddingLarge
                            bottom:vendor.top
                            bottomMargin: Theme.paddingLarge * 2
                        }
                    }

                    Label{
                        id:vendor
                        text:"BirdZhang"
                        font.pixelSize: Theme.fontSizeMedium
                        //color: Theme.highlightColor
                        opacity:0.5
                        anchors{
                            left:parent.left
                            leftMargin:Theme.paddingLarge
                            bottom:parent.bottom
                            bottomMargin: Theme.paddingLarge
                        }
                    }

                    BusyIndicator{
                        anchors{
                            right:parent.right
                            rightMargin: Theme.paddingLarge
                            bottom:parent.bottom
                            bottomMargin: Theme.paddingLarge
                        }
                        running: true
                        size: BusyIndicatorSize.Small
                    }

                }


                NumberAnimation on opacity {duration: 500}


            }
            Timer {
                id: timerDisplay
                running: false;
                repeat: false;
                triggeredOnStart: false
                interval: 2 * 1000
                onTriggered: {
                    splash.visible = false;
                    loading = false;
                    toIndexPage();
                }
            }
        }
    }

    //主页列表显示
    Component {
        id: indexPageComponent
        FirstPage {
            id: indexPage
            //            property bool _settingsInitialized: false
            property bool _dataInitialized: false
            property bool withPanelView: true
            Binding {
                target: indexPage.contentItem
                property: "parent"
                value: indexPage.status === PageStatus.Active
                       ? (panelView .closed ? panelView : indexPage) //修正listview焦点
                       : indexPage
            }
            //            Component.onCompleted: {
            //                if (!_settingsInitialized) {
            //                    Settings.initialize();
            //                    _settingsInitialized = true;
            //                }
            //            }
            onStatusChanged: {
                if (indexPage.status === PageStatus.Active) {
                    //                    if (!tokenValid) {
                    //                        startLogin();
                    //                    } else {
                    if (!_dataInitialized) {
                        indexPage.refresh();
                        _dataInitialized = true;
                        //                        }
                    }
                }
            }
        }
    }

    function addNotification(msg){

    }

    function toIndexPage() {
          popAttachedPages();
          pageStack.replace(indexPageComponent)
      }

//    function toIndexPage(){
//        pageStack.push(Qt.resolvedUrl("pages/SecondPage.qml"))
//    }

    function popAttachedPages() {
            // find the first page
            var firstPage = pageStack.previousPage();
            if (!firstPage) {
                return;
            }
            while (pageStack.previousPage(firstPage)) {
                firstPage = pageStack.previousPage(firstPage);
            }
            // pop to first page
            pageStack.pop(firstPage);
        }

    Timer{
        id:processingtimer;
        interval: 60000;
        onTriggered: signalCenter.loadFailed(qsTr("error"));
    }


    onLangChanged:{
        application.datafile = lang + ".json";
        application.heroDatafile = "hero_"+lang+".json";

        API.initJson(application.datafile);
        API.initHeroJson(application.heroDatafile);
    }

    Component.onCompleted: {
        API.app = application;
        API.signalcenter = signalCenter;
        lang = Qt.locale().uiLanguages.toString();
        console.log(lang);
        if(lang == "C"){
            lang = "en";
            application.datafile = "en.json";
        }else{
            application.datafile = lang.split("_")[0]+".json";
        }
        API.initJson(application.datafile);
        API.initHeroJson(application.heroDatafile);
    }

}


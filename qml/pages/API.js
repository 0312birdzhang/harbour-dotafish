.pragma library
var signalcenter;
var app;


function readJsonFile(url, callback) {
    var xhr = new XMLHttpRequest;
    xhr.open("GET", url);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            var doc = xhr.responseText;
            callback(doc);
        }
    }

   xhr.send();
}

function sendWebRequest(url, callback, method, postdata) {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
                switch(xmlhttp.readyState) {
                case xmlhttp.OPENED:signalcenter.loadStarted();break;
                case xmlhttp.HEADERS_RECEIVED:if (xmlhttp.status != 200)signalcenter.loadFailed(qsTr("error connection:")+ xmlhttp.status+"  "+xmlhttp.statusText);break;
                case xmlhttp.DONE:if (xmlhttp.status == 200) {
                        try {
                            callback(xmlhttp.responseText);
                            signalcenter.loadFinished();
                        } catch(e) {
                            console.log(e)
                            signalcenter.loadFailed(qsTr("loading erro..."));
                        }
                    } else {
                        signalcenter.loadFailed("");
                    }
                    break;
                }
            }
    if(method==="GET") {
        xmlhttp.open("GET",url);
        xmlhttp.send();
    }
    if(method==="POST") {
        xmlhttp.open("POST",url);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.setRequestHeader("Content-Length", postdata.length);
        xmlhttp.send(postdata);
    }
}

var heroesPage;
function getHeroes(datafile){    
    readJsonFile(datafile,loadHeroes);
}

function loadHeroes(oritxt){
    var obj = JSON.parse(oritxt);
    if(obj){
        heroesPage.listmodel.clear();
        for(var i in obj.herodata){
            obj.herodata[i].hero = i;
            heroesPage.listmodel.append(obj.herodata[i]);
        }
    }
    else signalcenter.showMessage(qsTr("load error"));
}

var listModel;


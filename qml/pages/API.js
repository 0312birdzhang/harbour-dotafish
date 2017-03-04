.pragma library
.import QtQuick.LocalStorage 2.0 as SQL
var signalcenter;
var app;



var languages = ([
                 {
                    "country":"简体中文",
                    "abbreviation":"cn"
                 },
                 {
                     "country":"English",
                     "abbreviation":"en"
                 },
                 {
                     "country":"한국어",
                     "abbreviation":"ko"
                 },
                 {
                     "country":"Deutsch",
                     "abbreviation":"de"
                 }

            ])

function getDatabase() {
    return SQL.LocalStorage.openDatabaseSync("dotafish", "1.0", "languages", 10000);
}

function initDB() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS languages(language TEXT primary key);');

                });
}


function getLanguage() {
    var lang = "en";
    initDB();
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql("SELECT * FROM languages",[]);
        if (rs.rows.length > 0 ) {
            lang = rs.rows[0].language;
            console.log("language:"+lang);
        }
    });
    return lang;
}

function setLanguage(lang){
    var db = getDatabase();
        db.transaction(function(tx) {
            tx.executeSql('INSERT OR REPLACE INTO languages values(?);',[lang]);
           }
        );
}


function readJsonFile(url, callback) {
    var xhr = new XMLHttpRequest;
    xhr.open("GET", "datas/"+url);
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


function initJson(datafile){
    readJsonFile(datafile,loadJson);
}

function loadJson(oritxt){
    var obj = JSON.parse(oritxt);
    app.appJson = obj;
}


function initHeroJson(heroDatafile){
    readJsonFile(heroDatafile,loadHeroJson);
}

function loadHeroJson(oritxt){
    var obj = JSON.parse(oritxt);
    app.heroJson = obj;
}




var heroesPage;
function loadHeroes(obj){
        heroesPage.listmodel.clear();
        for(var i in obj.herodata){
            obj.herodata[i].hero = i;
            heroesPage.listmodel.append(obj.herodata[i]);
        }
}

var listModel;


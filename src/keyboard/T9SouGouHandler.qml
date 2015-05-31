/*
 * Copyright (C) 2012-2013 Jolla ltd and/or its subsidiary(-ies). All rights reserved.
 *
 * Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list
 * of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * Neither the name of Jolla Ltd nor the names of its contributors may be
 * used to endorse or promote products derived from this software without specific
 * prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

import QtQuick 2.0
import com.meego.maliitquick 1.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0
import harbour.saber.py 1.0
import "../saber/py"

InputHandler {
    id: inputHandler

    property string name: canvas.layoutModel.get(canvas.activeIndex).name

    //INPUT
    property string sql: ""
    property string  keys: ""
    property var result: []
    property var alphabet: []
    property string phrase: ""
    property string preedit: ""
    property var chop: []

    property int current: 0
    property int length: 1

    property var data: []
    property string sentence: ""

    property string abcd: ""
    property int split: 0

    property string previous: ""
    property string next: ""

    property int count: 0

    signal candidatesUpdated

    property var haha: preedit.split("'")
    property var word: []

    Database {
        id: database
        Component.onCompleted: {
            database.initial("zh-py")
        }
    }

    Connections {
        target: MInputMethodQuick
        onFocusTargetChanged: {

        }
    }

    Settings {
        id: settings
        property string spacebar: settings.load("spacebar")
        property string keys: settings.load("keys")
        property string word: settings.load("word")
        property string emoji: settings.load("emoji")
    }

    onPreeditChanged: {
        var _keys = preedit
        var _preedit = preedit.split("'")
        console.warn("_preedit[0]", _preedit[0])

        var chop = new Array

        for ( var i = 0; i < _keys.length; i++ ) {
            chop.push('"' + _keys.slice(0, _keys.length - i) + '"')
        }

        var sql = 'SELECT alphabet FROM souGou WHERE keys IN ( ' + chop.toString() + ' ) LIMIT 0, 16'
        //var sql = 'SELECT character FROM souGou Where keys GLOB "' + _preedit[0] + '*" LIMIT 0, 16'
        result = database.load(sql)

        console.warn("result", result)

        sql = 'SELECT alphabet FROM t9 Where keys GLOB "' + convert(_preedit[0]) + '*" LIMIT 0, 16'
        alphabet = database.load(sql)

        console.warn("alphabet", alphabet)

    }


    ListModel {
        id: punctuationList

        ListElement {
            alphabet: "，"
        }

        ListElement {
            alphabet: " 。"
        }

        ListElement {
            alphabet: "？"
        }

        ListElement {
            alphabet: "！"
        }

        ListElement {
            alphabet: "："
        }

        ListElement {
            alphabet: "；"
        }
    }


    function loadKY() {
        // AUTO FORM WHOLE PHRASE

        sql = 'SELECT alphabet FROM souGou Where keys GLOB "' + keys + '*" ORDER BY keys ASC, frequency DESC, sorting DESC LIMIT 0, 16'
        alphabet = database.load(sql)


        candidatesUpdated()
    }

    function loadPR() {
        //Phrase
        console.warn("keys", keys[0])
        phrase = ""
        for ( var i = 0; i < keys.length; i++ ) {
            sql = 'SELECT character FROM souGou Where keys GLOB "' + keys[i] + '*" ORDER BY keys ASC, frequency DESC, sorting DESC LIMIT 1'
            var result = database.load(sql)
            if ( result.length > 0 ) {
                phrase += result[0]
            }

        }

        candidatesUpdated()
    }

    function loadSG() {
        //Single Characters
        sql = 'SELECT character FROM souGou Where keys GLOB "' + keys[current] + '*" ORDER BY keys ASC, frequency DESC, sorting DESC LIMIT 0, 16'

        result = database.load(sql)

        candidatesUpdated()
    }


    function loadWD(phrase) {
        //PREVENT OVELAP OF LOADSG

        var prefix = phrase.length + 1
        sql = 'SELECT SUBSTR(phrase,' + prefix + ') FROM word WHERE phrase GLOB "' + phrase + '*" ORDER BY frequency DESC LIMIT 0, 64'
        result = database.load(sql)

        candidatesUpdated()
    }

    function loadMKY() {



        candidatesUpdated()
    }

    function pushKY(character) {
        if ( settings.keys === "true" ) {
            var sql = 'UPDATE souGou SET frequency = frequency + 1 WHERE character = "' + character + '"'
            database.update(sql)
        }
    }

    function pushWD(phrase) {
        if ( settings.word === "true" ) {

            var sql = 'UPDATE word SET frequency = frequency + 1 WHERE phrase = "'+ phrase + '"'
            database.update(sql)
        }
    }

    function pushT9(alphabet) {
        if ( settings.word === "true" ) {

            var sql = 'UPDATE t9 SET frequency = frequency + 1 WHERE alphabet = "'+ alphabet + '"'
            database.update(sql)
        }
    }


    topItem: Column {
        id: column
        width: parent.width
        height: 80

        Help {
            id: help
        }

        Popup {
            id: popup
        }

        CandidateRow {
            id: candidateRow
        }

        Open {
            id: open
        }

        CandidateDialog {
            id: dialog

            Close {
                id: close
            }

        }

        Rectangle {
            height: keyboard.layout.height - Theme.paddingMedium
            anchors.left: parent.left
            anchors.top: parent.top
            width: 72
            parent: keyboard
            anchors.leftMargin: Theme.paddingMedium
            anchors.topMargin: Theme.paddingMedium
            anchors.bottomMargin: Theme.paddingMedium
            color: "#00000000"
            //clip: true

            Rectangle {
                anchors.fill: parent
                radius: geometry.keyRadius
                color: Theme.highlightBackgroundColor
                opacity: 0.16
            }

            MultiPointTouchArea {
                // prevent events leaking below
                anchors.fill: parent
                z: -1
            }

            ListView {
                id: alphabetView
                anchors.fill: parent
                model: preedit.length === 0? punctuationList: alphabet.length

                delegate: Column {
                    width: parent.width
                    height: candidateRow.width > 540? 48.75: 67.5

                    BackgroundItem {
                        width: parent.width
                        height: parent.height - separator.height

                        Label {
                            anchors.centerIn: parent
                            color: Theme.highlightColor
                            text: preedit.length === 0? model.alphabet: alphabet[model.index]
                            font.pixelSize: width >= parent.width? Theme.fontSizeExtraSmall: Theme.fontSizeMedium
                        }

                        onClicked: {

                        }

                    }

                    Separator {
                        id: separator
                        width: parent.width
                        color: Theme.highlightColor
                    }
                }
            }

        }

    }

    function handleKeyClick() {
        var handled = false
        keyboard.expandedPaste = false

        if ( pressedKey.key === Qt.Key_Space ) {

            if ( preedit.length > 0 && result.length > 0 && settings.spacebar === "true" ) {
                preedit = ""
                commit(result[0])
                pushKY(result[0])

                handled = true

            } else if ( preedit.length === 0 && result.length > 0 && settings.spacebar === "true" ) {
                commit(result[0])

            } else if ( preedit.length > 0 ) {
                commit(preedit)

            } else {
                commit(" ")

            }

            handled = true

        } else if ( pressedKey.key === Qt.Key_Return ) {

            if ( preedit.length > 0 ) {
                commit(preedit)
            } else {
                MInputMethodQuick.sendKey(Qt.Key_Return)
            }

            handled = true

        } else if ( pressedKey.key === Qt.Key_Backspace ) {

            if ( keys.length > 0 ) {
                keys = keys.slice(0, keys.length - 1)
            }

            if ( preedit.length > 0 ) {
                preedit = preedit.slice(0, preedit.length -1)

                MInputMethodQuick.sendPreedit(preedit)

                if ( preedit.length > 1 ) {
                    loadKY()
                }

            } else if ( result.length > 0 ) {
                empty()


            } else {
                MInputMethodQuick.sendKey(Qt.Key_Backspace)
            }

            handled = true

        } else if ( pressedKey.key === Qt.Key_Clear ) {

            reset()
            empty()

            handled = true

        } else if ( pressedKey.text === "分詞" ) {

            handled = true

        } else if ( pressedKey.text.match(/(abc|def|ghi|jkl|mno|pqrs|tuv|wxyz)/) !== null ) {
            keys += pressedKey.caption

            console.warn("keys", keys )
            var _keys = keys
            var _preedit = preedit
            var chop = new Array
            abcd = ""
            //CONVERT KEYS TO ALPHABET
            preedit = ""

            while ( _keys.length > 0 ) {

                chop = []

                for ( var i = 0; i < _keys.length; i++ ) {
                    chop.push('"' + _keys.slice(0, _keys.length - i) + '"')
                }

                console.warn("chop", chop.toString())

                var sql = 'SELECT alphabet FROM souGou WHERE keys IN ( ' + chop.toString() + ' ) LIMIT 1'
                //sql = 'SELECT character FROM souGou WHERE "' + keys + '" GLOB (keys||"*") LIMIT 1'
                data = database.load(sql)


                if ( data.length === 1 ) {
                    console.warn("data", data[0])

                    sql = 'SELECT keys FROM souGou WHERE keys IN ( ' + chop.toString() + ' ) LIMIT 1'
                    //sql = 'SELECT  FROM souGou WHERE "' + keys + '" GLOB (keys||"*") LIMIT 1'

                    var prefix = database.load(sql)

                    _keys = _keys.replace(prefix[0], "")

                    console.warn("prefix", prefix[0])

                    sql = 'SELECT character FROM souGou WHERE keys IN ( ' + chop.toString() + ' ) LIMIT 1'

                    //sql = 'SELECT  FROM souGou WHERE "' + keys + '" GLOB (keys||"*") LIMIT 1'

                    abcd += database.load(sql)
                    console.warn("abcd", abcd)

                    if ( preedit.length > 0 ) {
                        preedit += "'" + data[0]
                    } else {
                        preedit += data[0]
                    }

                    MInputMethodQuick.sendPreedit(preedit)
                } else {
                    break
                }

            }



            handled = true

        } else {
            commit(pressedKey.text)
            handled = true
        }

        return handled
    }

    function convert(text) {

        return text.replace(/[abc]/ig, "2").replace(/[def]/ig, "3").replace(/[ghi]/ig, "4").replace(/[jkl]/ig, "5").replace(/[mno]/ig, "6").replace(/[pqrs]/ig, "7").replace(/[tuv]/ig, "8").replace(/[wxyz]/ig, "9").replace(/\'/ig, "")

    }

    function accept(index) {
        console.log("attempting to accept", index)
    }

    function shift() {

        if ( result.length > 0 ) {
            result = []
        }

    }

    function reset() {
        keys = ""
        preedit = ""
        MInputMethodQuick.sendPreedit("")

        abcd = 0
    }

    function commit(text) {
        //MInputMethodQuick.sendCommit(text)

        var split = preedit.split("'")


        keys = keys.slice(split[0].length, keys.lengthd)

        for ( var i = 0; i < text.length; i++ ) {
            preedit = preedit.replace(split[i], "")
        }

        MInputMethodQuick.sendCommit(text)

        MInputMethodQuick.sendPreedit(preedit)
    }

    function replacePreedit(text) {

        var split = preedit.split("'")

        keys = keys.slice(split[0].length, keys.lengthd)

        for ( var i = 0; i < text.length; i++ ) {
            preedit = preedit.replace(split[i], "")
        }


        MInputMethodQuick.sendPreedit(preedit)
        commit(text)
    }

    function empty() {
        result = []


    }
}

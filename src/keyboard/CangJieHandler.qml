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
import harbour.dolphin.keyboard 1.0
import "../dolphin"

InputHandler {
    id: inputHandler
    type: name ===  "倉頡(三版)"? 0: ( name ===  "倉頡(五版)"? 1: name ===  "速成(三版)"? 2: ( name ===  "速成(五版)"? 3: 0 ) )
    table: "cangjie"

    function checkDict(word) {
        if ( word.length === 1 ) {
            var sql
            switch (type) {

            case 0:
                database.dict("cangJie3")
                break
            case 1:
                database.dict("cangJie3")
                break
            case 2:
                database.dict("cangJie3")
                break
            case 3:
                database.dict("cangJie3")
                break
            }

            if ( data.length > 0 ) {
                help.label = data[0]
            }
        }
    }

    function acceptWord(word) {

        if ( preedit !== "" ) {

            adjustWord(word)
            commit(word)
            predictWord(word)
        } else {

            adjustPredict(word)
            commit(word)
            empty()

        }
    }

    function applyWord() {
        result = database.cangJie(type, preedit, 16)
        candidatesUpdated()
    }

    function applyMoreWord() {
        result = database.cangJie(type, preedit, 128)
        candidatesUpdated()
    }

    function predictWord(word) {
        result = database.predict(word, 32)
        candidatesUpdated()
    }

    function adjustWord(word) {
        if ( config.keys === 1 ) {

            switch (type) {
            case 0: case 2:
                        database.adjust("cangJie3", word)
                        break

                    case 1: case 3:
                                database.adjust("cangJie5", word)
                                break
            }
        }
    }

    function adjustPredict(word) {
        if ( config.word === 1 ) {
            database.adjust("predict", word)
        }
    }


    topItem: Component {
        CandidateRow {
            id: container
        }
    }

    verticalItem: Component {
        CandidateColumn {
            id: container
        }
    }

    EmojiDialog {
        id: emojiDialog
    }

    CandidateDialog {
        id: candidateDialog
    }

    function handleKeyClick() {
        var handled = false
        keyboard.expandedPaste = false

        if ( pressedKey.key === Qt.Key_CapsLock ) {

            clear()
            empty()

            handled = true

        } else if ( pressedKey.key === Qt.Key_Space ) {
            console.warn(config.spacebar)
            if ( preedit.length > 0 && result.length > 0 && config.spacebar === 1 ) {

                acceptWord(result[0])

            } else if ( preedit.length === 0 && result.length > 0 && config.spacebar === 1 ) {

                acceptWord(result[0])

            } else if ( preedit.length > 0 ) {

                if ( config.fusion === 1 ) {
                    commit(preedit + " ")
                }else {
                    commit(preedit)
                }

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

            if ( preedit.length > 0 ) {

                preedit = preedit.slice(0, preedit.length - 1)
                MInputMethodQuick.sendPreedit(preedit, Maliit.PreeditDefault)
                if ( preedit.length > 0 ) {
                    applyWord()
                } else {
                    empty()
                }

            } else if ( result.length > 0 ) {
                empty()

            } else {
                MInputMethodQuick.sendKey(Qt.Key_Backspace)

            }

            handled = true

        } else if ( pressedKey.keyType === KeyType.FunctionKey && pressedKey.keyType === KeyType.SymbolKey ) {

            clear()
            empty()

            handled = true

            //Handle CangJie
        } else if ( pressedKey.text.match(/[日月金木水火土竹戈十大中一弓人心手口尸廿山女田卜難]/) !== null ) {

            //Fusion input
            if ( config.fusion === 1 ) {

                preedit = preedit + pressedKey.abc
                MInputMethodQuick.sendPreedit(preedit, Maliit.PreeditDefault)

                applyWord()

                //No fusion input
            } else {
                if ( preedit.length >= 0 && preedit.length < 5 ) {

                    preedit = preedit + pressedKey.text
                    MInputMethodQuick.sendPreedit(preedit, Maliit.PreeditDefault)

                    applyWord()

                }  else {

                    clear()
                    preedit = preedit + pressedKey.text
                    MInputMethodQuick.sendPreedit(preedit, Maliit.PreeditDefault)
                }
            }

            if ( keyboard.shiftState !== ShiftState.LockedShift ) {
                keyboard.shiftState = ShiftState.NoShift
            }

            handled = true

        } else if ( pressedKey.text === "？" ) {

            //Fusion mode
            if ( config.fusion === 1 ) {

                preedit = preedit + pressedKey.abc
                MInputMethodQuick.sendPreedit(preedit, Maliit.PreeditDefault)

                applyWord()

                //No fusion mode
            } else {
                if ( preedit.length > 0 && preedit.length < 5 ) {
                    preedit = preedit + "?"
                    MInputMethodQuick.sendPreedit(preedit, Maliit.PreeditDefault)

                    applyWord()
                } else {
                    commit(pressedKey.text)
                }
            }

            handled = true

        } else {

            if ( config.fusion === 0 ) {
                commit(pressedKey.text)
            } else {
                MInputMethodQuick.sendCommit(preedit)
                commit(pressedKey.text)
            }

            handled = true

        }

        return handled
    }


    function accept(index) {
        console.log("attempting to accept", index)
    }

    function clear() {
        preedit = ""
        MInputMethodQuick.sendPreedit("")
    }

    function commit(text) {
        clear()
        MInputMethodQuick.sendCommit(text)
    }

    function empty() {
        result = []
    }

    function convert(keys) {
        keys = keys.replace(/a/ig, "日").replace(/b/ig, "月").replace(/c/ig, "金").replace(/d/ig, "木").replace(/e/ig, "水").replace(/f/ig, "火").replace(/g/ig, "土").replace(/h/ig, "竹").replace(/i/ig, "戈").replace(/j/ig, "十").replace(/k/ig, "大").replace(/l/ig, "中").replace(/m/ig, "一").replace(/n/ig, "弓").replace(/o/ig, "人").replace(/p/ig, "心").replace(/q/ig, "手").replace(/r/ig, "口").replace(/s/ig, "尸").replace(/t/ig, "廿").replace(/u/ig, "山").replace(/v/ig, "女").replace(/w/ig, "田").replace(/x/ig, "難").replace(/y/ig, "卜").replace(/z/ig, "?")
        return keys

    }

}

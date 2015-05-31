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
    table: "swype"

    function acceptWord(word) {
        if ( preedit !== "" ) {
            commit(word)
            adjustWord(word)
            predictWord(word)
        } else {
            commit(word)
            adjustPredict(word)
            empty()

        }
    }

    function applyWord(preedit, count) {
        result = database.swype(preedit, count, 16)
        candidatesUpdated()
    }

    function applyMoreWord() {
        result = database.swype(preedit, 32)
        candidatesUpdated()
    }

    function predictWord(word) {
        result = database.predict(word, 32)
        candidatesUpdated()
    }

    function adjustWord(word) {

        if ( config.keys === 1 ) {

        }
    }

    function adjustPredict(word) {
        if ( config.word === 1 ) {
            database.adjust("word", word)
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

    SwypePad {
        id: swypePad
    }

    CandidateDialog {
        id: candidateDialog
    }

    EmojiDialog {
        id: emojiDialog
    }

    function handleKeyClick() {
        var handled = false
        keyboard.expandedPaste = false

        console.warn("handleKeyClick", preedit)

        if ( preedit.length > 1 ) {
            applyWord(preedit, rowCount())
            reset()

            handled = true
        } else {
            commit(preedit)


            handled = true
        }

        return handled
    }


    //Specific function for swype


    function rowCount() {
        var count = ""
        count =  preedit.replace(/[qwertyuiop]/ig, 1).replace(/[asdfghjkl]/ig, 2).replace(/[zxcvbnm]/ig, 3)
        console.warn("count", count)

        count =  count.replace(/1*1/ig, 1).replace(/2*2/ig, 2).replace(/3*3/ig, 3)
        console.warn("count", count)

        console.warn("count.length", count.length)

        return count.length - 3

    }


    function accept(index) {
        console.log("attempting to accept", index)
    }

    function reset() {
        preedit = ""
        MInputMethodQuick.sendPreedit("")
    }

    function commit(text) {
        reset()
        MInputMethodQuick.sendCommit(text)
    }

    function empty() {
        result = []
    }


}

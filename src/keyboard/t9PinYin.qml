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
import Sailfish.Silica 1.0
import harbour.saber.py 1.0
import "../saber/py"

KeyboardLayout {
    type: "Saber"
    id: layout

    property int keyWidth: ( parent.width - shiftKeyWidth ) / 12

    Component.onCompleted: init()

    function init() {
        // force onInputHandlerChanged signal by
        // making sure that the input handler was not
        // previously pasteInputHandler
        if (keyboard.allowLayoutChanges) {
            var oldHandler = keyboard.inputHandler
            oldHandler.active = false
            keyboard.inputHandler = inputHandler
            keyboard.inputHandler.active = true
        }
    }

    property Item primaryHandler: T9PinYinHandler {
        id: t9PinYinHandler
    }

    Xt9Handler {
        id: xt9Handler
    }

    Row {
        height: keyHeight * layout.scale
        opacity: ( keyboard.inputHandler.inEmojiView || keyboard.inputHandler.fetchMany )? 0: 1

        Item {
            width: 72 + Theme.paddingMedium
            height: parent.height

        }

        PhoneKey {
            caption: "1"
            secondaryLabel: "分詞"
            width: keyWidth * 4 - 24 - ( Theme.paddingMedium / 3 )
            height: parent.height

        }

        PhoneKey {
            caption: "2"
            secondaryLabel: "abc"
            width: keyWidth * 4 - 24 - ( Theme.paddingMedium / 3 )
            height: parent.height

        }

        PhoneKey {
            caption: "3"
            secondaryLabel: "def"
            width: keyWidth * 4 - 24 - ( Theme.paddingMedium / 3 )
            height: parent.height

        }

        BackspaceKey { height: keyHeight; width: shiftKeyWidth }

    }

    Row {
         height: keyHeight * layout.scale
         opacity: ( keyboard.inputHandler.inEmojiView || keyboard.inputHandler.fetchMany )? 0: 1

        Item {
            width: 72 + Theme.paddingMedium
            height: parent.height

        }

        PhoneKey {
            caption: "4"
            secondaryLabel: "ghi"
            width: keyWidth * 4 - 24 - ( Theme.paddingMedium / 3 )
            height: parent.height

        }

        PhoneKey {
            caption: "5"
            secondaryLabel: "jkl"
            width: keyWidth * 4 - 24 - ( Theme.paddingMedium / 3 )
            height: parent.height

        }

        PhoneKey {
            caption: "6"
            secondaryLabel: "mno"
            width: keyWidth * 4 - 24 - ( Theme.paddingMedium / 3 )
            height: parent.height

        }

        CharacterKey {
            caption: "？"
            captionShifted: "？"
            symView: "0"
            height: parent.height
            fixedWidth: true
            width: shiftKeyWidth
        }


    }

    Row {
         height: keyHeight * layout.scale
         opacity: ( keyboard.inputHandler.inEmojiView || keyboard.inputHandler.fetchMany )? 0: 1

        Item {
            width: 72 + Theme.paddingMedium
            height: parent.height

        }

        PhoneKey {
            caption: "7"
            secondaryLabel: "pqrs"
            width: keyWidth * 4 - 24 - ( Theme.paddingMedium / 3 )
            height: parent.height
        }

        PhoneKey {
            caption: "8"
            secondaryLabel: "tuv"
            width: keyWidth * 4 - 24 - ( Theme.paddingMedium / 3 )
            height: parent.height
        }

        PhoneKey {
            caption: "9"
            secondaryLabel: "wxyz"
            width: keyWidth * 4 - 24 - ( Theme.paddingMedium / 3 )
            height: parent.height
        }

        FunctionKey {
            caption: "重輸"
            key: Qt.Key_Clear
            height: parent.height
            width: shiftKeyWidth
        }
    }



    Row {
        height: keyHeight * layout.scale

        Item {
            width: 72 + Theme.paddingMedium
            height: parent.height

        }

        PunctuationKey {
            caption: "123"
            width: keyWidth * 4 - 24 - ( Theme.paddingMedium / 3 )
            height: parent.height
        }

        SpacebarKey {
            width: keyWidth * 4 - 24 - ( Theme.paddingMedium / 3 )
            fixedWidth: true
            height: parent.height
        }


        LanguageKey {
            width: keyWidth * 4 - 24 - ( Theme.paddingMedium / 3 )
            height: parent.height
        }

        EnterKey { width: shiftKeyWidth; height: parent.height }
    }
}

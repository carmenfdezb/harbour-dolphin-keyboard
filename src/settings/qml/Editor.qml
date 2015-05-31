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
import harbour.dolphin.keyboard 1.0

Page {
    id: root

    /*function check() {
        if ( search.text.length === 1 ) {

            var sql = 'SELECT keys FROM cangJie3 WHERE character = "' + search.text + '"'
            var cangJie3 = database.load(sql)
            var cangJie5 = database.cangJie(0, "一", Theme.paddingLarge)

            sql = 'SELECT keys FROM stroke WHERE character = "' + search.text + '"'
            var stroke =database.load(sql)

            sql = 'SELECT keys FROM canton WHERE character = "' + search.text + '"'
            var canton = database.load(sql)

            output.text = "倉頡三版：" + cangJie3 + "<br>"
            output.text += "倉頡五版：" + cangJie5 + "<br>"
            output.text += "繁體筆劃：" + stroke + "<br>"
            output.text += "粵語拼音：" + canton
        } else {
            output.text = "輸入有誤"
        }
    }*/

    RemorseItem { id: remorse }

    SilicaFlickable {
        anchors.fill: parent
        clip: true
        contentHeight: header.height + column.height

        VerticalScrollDecorator {  }

        PageHeader {
            id: header
            title: qsTr("Dolphin Settings")
        }

        Column {
            id: column
            width: parent.width
            anchors.top: header.bottom
            spacing: Theme.paddingLarge

            Label {
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingLarge
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.highlightColor
                text: qsTr("Dictionary")
            }

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge

                height: childrenRect.height

                TextField {
                    id: search
                    width: parent.width - button.width
                    placeholderText: qsTr("Word")
                    onClicked: {
                        search.text = ""
                    }

                    EnterKey.onClicked: check()
                }
                BackgroundItem {
                    id: button
                    width: 96
                    Label { anchors.centerIn: parent; text: qsTr("Search") }

                    onClicked: {
                        check()
                    }
                }
            }

            Text {
                id: output
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                color: Theme.highlightColor
                wrapMode: Text.WrapAnywhere
                font.pixelSize: Theme.fontSizeMedium
                horizontalAlignment: Text.AlignLeft
            }

            Heading { text: qsTr("Dictionary Tools") }

            BackgroundItem {
                width: parent.width
                Label { anchors.centerIn: parent; text: qsTr("Backup User Dictionary") }
                onClicked: {
                    remorse.execute(column, qsTr("Processing..."), function() { config.backup() }, 2000 )
                }
            }

            Label {
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingLarge
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingLarge
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.highlightColor
                wrapMode: Text.WrapAnywhere
                text: qsTr("* Backup to ( /home/nemo/Saber )")
            }

            BackgroundItem {
                width: parent.width
                Label { anchors.centerIn: parent; text: qsTr("Restore User Dictionary") }
                onClicked: {


                    remorse.execute(column, qsTr("Processing..."), function() { config.restore() }, 2000 )
                }
            }

            Label {
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingLarge
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingLarge
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.highlightColor
                wrapMode: Text.WrapAnywhere
                text: qsTr("* Restore from ( /home/nemo/Saber )")
            }

            Label {
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingLarge
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.highlightColor
                text: qsTr("Upload User Data")
            }

            /*BackgroundItem {
                width: parent.width
                Label { anchors.centerIn: parent; text: "倉頡三版" }
                onClicked: {
                    database.output("SELECT character, frequency FROM cangJie3 ORDER BY frequency DESC")
                    remorse.execute(column, qsTr("Processing..."), function() {  }, 8000 )
                }
            }

            BackgroundItem {
                width: parent.width
                Label { anchors.centerIn: parent; text: "倉頡五版" }
                onClicked: {
                    database.output("SELECT character, frequency FROM cangJie5 ORDER BY frequency DESC")
                    remorse.execute(column, "正在處理中…", function() {  }, 8000 )
                }
            }

            BackgroundItem {
                width: parent.width
                Label { anchors.centerIn: parent; text: "筆劃" }
                onClicked: {
                    database.output("SELECT character, frequency FROM stroke ORDER BY frequency DESC")
                    remorse.execute(column, "正在處理中…", function() {  }, 8000 )
                }
            }

            BackgroundItem {
                width: parent.width
                Label { anchors.centerIn: parent; text: "粵拼" }
                onClicked: {
                    database.output("SELECT character, frequency FROM canton ORDER BY frequency DESC")
                    remorse.execute(column, "正在處理中…", function() {  }, 8000 )
                }
            }*/

            Label {
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingLarge
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingLarge
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.highlightColor
                wrapMode: Text.WrapAnywhere
                text: qsTr("* ( /home/nemo/Dolphin/user.txt )")
            }



        }

    }

}




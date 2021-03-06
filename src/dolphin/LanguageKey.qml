import QtQuick 2.0
import Sailfish.Silica 1.0

FunctionKey {

    implicitWidth: shiftKeyWidth
    clip: true
    caption: xt9 ? "英" : "中"

    Rectangle {
        color: parent.pressed ? Theme.highlightBackgroundColor : Theme.primaryColor
        opacity: parent.pressed ? 0.6 : 0.16
        radius: geometry.keyRadius
        anchors.fill: parent
        anchors.margins: Theme.paddingMedium
    }

    onClicked: {


        keyboard.inSymView = false
        keyboard.inSymView2 = false

        if ( xt9 ) {

            var oldHandler = keyboard.inputHandler
            oldHandler.active = false

            keyboard.inputHandler = primaryHandler
            keyboard.inputHandler.inEmojiView = false
            keyboard.inputHandler.fetchMany = false
            keyboard.inputHandler.active = true
            console.warn("primaryHandler")

        } else {

            keyboard.inputHandler = secondaryHandler
            keyboard.inputHandler.inEmojiView = false
            keyboard.inputHandler.fetchMany = false
            keyboard.inputHandler.active = true
            console.warn("secondaryHandler")
        }
    }
}

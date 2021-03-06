import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

BackgroundItem {
    id: root
    width: character.width + Theme.paddingMedium * 2
    height: 80

    onClicked: {
        fetchMany = false
        buttonPressEffect.play()
        SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
        acceptWord(modelData)
    }

    onPressAndHold: {
        checkDictionary(modelData)
    }

    Text {
        id: character
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        textFormat: Text.PlainText
        color: ( parent.down || index === 0 ) ? Theme.highlightColor : Theme.primaryColor
        font { pixelSize: ( config.size === 0? Theme.fontSizeMedium: ( config.size === 1? Theme.fontSizeLarge: Theme.fontSizeLarge ) ) }
        text: modelData
    }

    Image {
        source: "graphic-keyboard-highlight-top.png"
        anchors.right: parent.right
    }

}

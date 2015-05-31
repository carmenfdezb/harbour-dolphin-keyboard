import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

BackgroundItem {

    id: root
    property string caption
    property alias src: icon.source

    height: parent.height

    Label {
        id: label
        visible: src !==""? true: false
        anchors.centerIn: parent
        text: caption
        font.pixelSize: Theme.fontSizeMedium
    }

    Image {
        id: icon
        visible: icon.status === Image.Error || icon.status === Image.Null ? false : true
        asynchronous: true
        width: 36
        height: 36
        anchors.centerIn: parent
    }

    Image {
        source: "graphic-keyboard-highlight-top.png"
        anchors.right: parent.right
    }
}

import QtQuick
import "../Theme"

Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    required property string time
    implicitHeight: Colors.itemsHeight
    implicitWidth: 85
    color: Colors.background
    border.color: Colors.barBorder
    radius: 10

    anchors.leftMargin: 141

    Text {
        // text: "  " + parent.time //Clock symbol
        text: parent.time
        color: '#ffffff'
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 14
    }
}

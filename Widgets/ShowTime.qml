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

    anchors.leftMargin: 3

    Text {
        text: "  " + parent.time //Clock symbol
        color: '#ffffff'
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 13
    }
}

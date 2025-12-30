import QtQuick
import "../Theme"

Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    required property string time
    implicitHeight: Colors.itemsHeight
    implicitWidth: 70
    color: Colors.background
    border.color: Colors.barBorder
    radius: 13

    anchors.leftMargin: 10

    Text {
        text: parent.time
        color: '#ffffff'
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 13
    }
}

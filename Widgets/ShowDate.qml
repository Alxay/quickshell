import QtQuick
import "../Theme"

Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    required property string date
    implicitHeight: Colors.itemsHeight
    implicitWidth: 100
    color: Colors.background
    border.color: Colors.barBorder
    radius: 10
    anchors.rightMargin: 155

    anchors.leftMargin: 3

    Text {
        text: "  " + parent.date //Calendar symbol
        color: '#ffffff'
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 13
    }
}

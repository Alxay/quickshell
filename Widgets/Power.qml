import QtQuick
import Quickshell.Io
import "../Theme"

Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    implicitHeight: Colors.itemsHeight
    implicitWidth: 37
    color: Colors.background
    border.color: Colors.barBorder
    radius: 15
    Text {
        text: "\u23FB"  // Unicode symbol for power
        color: '#ffffff'
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 13
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            //menu for power off reboot
            onClicked: {
                shutdownProcess.running = true;
            }
        }
    }
    Process {
        id: shutdownProcess
        running: false
        command: ["poweroff"]
    }
}

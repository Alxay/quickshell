import QtQuick
import Quickshell.Io

import "../../Theme"

Rectangle {
    required property string networkStrength
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    implicitHeight: Colors.itemsHeight
    implicitWidth: 90
    color: Colors.background
    border.color: Colors.barBorder
    radius: 15
    anchors.rightMargin: 45
    Text {
        // Wi-Fi symbol
        // text: "\uF1EB"  // Unicode symbol for Wi-Fi
        text: parent.networkStrength
        color: '#ffffff'
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 13
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                openNetworkManager.running = true;
            }
        }
    }
    Process {
        id: openNetworkManager
        running: false
        command: ["kitty", "-e", "nmtui"]
    }
}

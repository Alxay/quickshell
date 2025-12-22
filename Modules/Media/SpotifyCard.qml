import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "../../Theme/" // Colors

PanelWindow {
    property bool showMedia: root.showMedia
    id: mediaWindow
    anchors.top: true
    anchors.right: true
    visible: showMedia
    margins.right: 70
    margins.top: -2

    width: 300
    height: 120
    color: "transparent" 

Rectangle {
    width: 300
    height: 120
    color: Colors.barBackground

  
    
    // Custom borders to exclude the top
    Rectangle {
    width: parent.width
    height: 1
    color: Colors.barBorder
    anchors.bottom: parent.bottom
    }
    Rectangle {
    width: 1
    height: parent.height
    color: Colors.barBorder
    anchors.left: parent.left
    }
    Rectangle {
    width: 1
    height: parent.height
    color: Colors.barBorder
    anchors.right: parent.right
    }

    GetPlayer {
    id: player
    }
    Text {
    font.family: "JetBrains Mono"
    anchors.centerIn: parent
    text: player.spotifyPlayer?.metadata["xesam:title"] ?? "Brak muzyki"
    color: "white"
    }
    Text{
    font.family: "JetBrains Mono"
    anchors.left: parent.left
    anchors.leftMargin: 0
    anchors.verticalCenter: parent.verticalCenter
    text: "←"
    font.pixelSize: 30
    MouseArea{
        anchors.fill: parent
        onClicked: {
        player.spotifyPlayer.previous()
        }
    }
    color: "white"
    }
    Text{
    font.family: "JetBrains Mono"
    anchors.right: parent.right
    anchors.rightMargin: 0
    anchors.verticalCenter: parent.verticalCenter
    text: "→"
    font.pixelSize: 30
    MouseArea{
        anchors.fill: parent
        onClicked: {
        player.spotifyPlayer.next()
        }
    }
    color: "white"
    }
}
}
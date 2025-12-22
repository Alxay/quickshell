import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Wayland
import "../../Theme/" // Colors

PopupWindow {
    /*anchor.window: toplevel
    anchor.rect.x: parentWindow.width / 2 - width / 2
    anchor.rect.y: parentWindow.height
    width: 300
    height: 120
    visible: true*/
    property bool showMedia: root.showMedia
    id: mediaWindow
    visible: showMedia
    anchor.rect.x: parentWindow.width/2 - implicitWidth/2
    anchor.rect.y: parentWindow.height -5
   
    //Clip parent
    // anchor.rect.x: anchor.window.implicitWidth / 2 - implicitWidth / 2
    //align to right edge of parent window

    

    implicitWidth: 570
    implicitHeight: 300
    color: "transparent" 

Rectangle {
    width: 570
    height: 300
    color: Colors.barBackground

        MouseArea{
        anchors.fill: parent
        hoverEnabled: true  // <--- TO JEST KLUCZOWE
        onExited: root.showMedia = !root.showMedia
    }

  
    
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
import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "../../Theme/" // Colors


// ... wewnątrz twojego elementu ...
// Rectangle {
//     width: 200
//     height: 30
//     color: "transparent"
//     anchors.right: parent.right
//     anchors.rightMargin: 200
//     GetPlayer {
//         id: player
//     }
//     Text {
//         font.family: "JetBrains Mono"
//         anchors.centerIn: parent
//         text: player.spotifyPlayer?.metadata["xesam:title"] ?? "Brak muzyki"
//         color: "white"
//     }
//     Text{
//         font.family: "JetBrains Mono"
//         anchors.left: parent.left
//         anchors.leftMargin: 0
//         anchors.verticalCenter: parent.verticalCenter
//         text: "←"
//         font.pixelSize: 30
//         MouseArea{
//             anchors.fill: parent
//             onClicked: {
//                 player.spotifyPlayer.previous()
//             }
//         }
//         color: "white"
//     }
//     Text{
//         font.family: "JetBrains Mono"
//         anchors.right: parent.right
//         anchors.rightMargin: 0
//         anchors.verticalCenter: parent.verticalCenter
//         text: "→"
//         font.pixelSize: 30
//         MouseArea{
//             anchors.fill: parent
//             onClicked: {
//                 player.spotifyPlayer.next()
//             }
//         }
//         color: "white"
//     }
// }

Rectangle {
    width: 300
    height: 120
    color: Colors.barBackground
    border.color: Colors.barBorder
    border.width: 1
    radius: 20
    

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

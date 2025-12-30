import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Wayland
import QtQuick.Shapes
import "../../Theme/" // Colors

Rectangle {
    id: root
    required property var player
    color: Colors.barBackground
    width: 200
    height: Colors.itemsHeight
    radius: 10
    border.color: Colors.barBorder
    anchors.left: parent.left

    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: 90  // Dodanie marginesu od lewej strony
    visible: root.player.spotifyPlayer !== null // Ukryj, jeśli nie ma odtwarzacza Spotify nie wyswietlamy

    Rectangle {
        width: parent.width - 60
        height: parent.height
        anchors.left: parent.left
        color: "transparent"
        anchors.leftMargin: 7

        Text {
            text: root.player.spotifyPlayer?.metadata["xesam:title"] ?? "Brak muzyki"
            color: "#FFFFFF"
            // Zapewnienie, że tekst nie wychodzi poza prostokąt
            elide: Text.ElideRight  // Zamiast obcinania tekstu, dodaje "..."
            width: parent.width
            anchors.centerIn: parent
            anchors.verticalCenter: parent.verticalCenter
        }
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.player.spotifyPlayer.isPlaying ? root.player.spotifyPlayer.stop() : root.player.spotifyPlayer.play()
        }
    }
    Image {
        source: "../../Assets/arrow_right.svg"
        width: 20
        height: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 30
        rotation: 180
        MouseArea {
            id: maPrev
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: root.player.spotifyPlayer.next()
        }
    }
    Image {
        source: "../../Assets/arrow_right.svg"
        width: 20
        height: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        MouseArea {
            id: maNext
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: root.player.spotifyPlayer.next()
        }
    }
}

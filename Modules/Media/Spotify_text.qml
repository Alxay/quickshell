import Quickshell
import QtQuick
import Quickshell.Wayland

PanelWindow {
    id: root
    WlrLayershell.layer: WlrLayer.Bottom

    GetLyrics {
        id: getLyrics
    }
    WlrLayershell.exclusiveZone: -1

    // Rozmiar samego okna
    width: 400
    height: 600

    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: "#FF0000"
        radius: 20
        Text {
            anchors.centerIn: parent
            color: "#FFFFFF"
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            width: parent.width - 20
            text: getLyrics.lyricsText === "" ? "Brak tekstu piosenki" : getLyrics.lyricsText
        }
    }
}

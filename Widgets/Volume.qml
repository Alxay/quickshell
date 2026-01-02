import QtQuick
import Quickshell.Io

import "../Theme"

Rectangle {
    id: root
    required property string volumeIcon
    required property var getVolume // Zmieniono z 'string' na 'var', aby zachować obiekt Process
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    implicitHeight: Colors.itemsHeight
    implicitWidth: 50
    color: Colors.background
    border.color: Colors.barBorder
    radius: 15
    anchors.rightMargin: 93
    Text {
        // Wi-Fi symbol
        // text: "\uF1EB"  // Unicode symbol for Wi-Fi
        text: parent.volumeIcon
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
            onWheel: wheel => {
                // Sprawdzamy kierunek scrolla (pionowy)

                if (wheel.angleDelta.y > 0) {
                    // console.log("Scroll w górę - Podgłaśniam");
                    increaseVolume.running = true;
                } else {
                    // console.log("Scroll w dół - Ściszam");
                    decreaseVolume.running = true;
                }

                // Opcjonalnie: zatwierdź zdarzenie, żeby nie poszło do elementu pod spodem
                wheel.accepted = true;
            }
        }
    }
    Process {
        id: openNetworkManager
        running: false
        command: ["kitty", "-e", "pavucontrol"]
    }
    Process {
        id: increaseVolume
        running: false
        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "2%+"]
        onExited: root.getVolume.running = true // Odśwież po zakończeniu procesu
    }
    Process {
        id: decreaseVolume
        running: false
        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "2%-"]
        onExited: root.getVolume.running = true // Odśwież po zakończeniu procesu
    }
}

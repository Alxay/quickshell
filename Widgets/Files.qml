import QtQuick
import Quickshell.Io
import Quickshell
import "../Theme"

Rectangle {
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.bottom: parent.bottom
    width: 30
    color: Colors.background
    //left border

    Image {
        source: "../Assets/home2.svg"
        height: 23
        width: 23
        anchors.verticalCenter: parent.verticalCenter
        // open ~/Projects
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                openProjects.running = true;
            }
        }
    }
    Process {
        id: openProjects
        running: false
        command: ["kitty", "bash", "-c", "neofetch; exec bash"]
    }
}

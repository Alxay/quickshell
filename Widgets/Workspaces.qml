import QtQuick 2.15
import Quickshell.Hyprland
import "../Theme/" // Kolory

Rectangle {
    id: bar
    color: Colors.barBackground
    implicitHeight: Colors.itemsHeight
    implicitWidth: 210
    radius: 17
    border.width: 1
    anchors.centerIn: parent
    anchors.verticalCenter: parent.verticalCenter
    border.color: Colors.barBorder
    anchors.topMargin: Colors.topMargin
    property int location: workspaceRepeater.itemAt(Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id - 1 : 0).locationX

    Row {
        id: root
        spacing: 8
        anchors.centerIn: parent

        // Iterujemy 5 razy (tworzy index 0, 1, 2, 3, 4)
        Repeater {
            id: workspaceRepeater
            model: 5

            Rectangle {
                property int wsId: index + 1
                property int locationX: 6 + index * (32 + 8)  // 210:5 = 42 32 + 8 = 40 + 2px wolnej przestrzeni 8px spacing (4 na stronę)
                width: 32
                height: 24
                radius: 15
                color: Colors.wsBg

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // Przełączamy na odpowiedni workspace
                        Hyprland.dispatch("workspace " + parent.wsId);
                    }
                }

                Text {
                    text: parent.wsId
                    anchors.centerIn: parent
                    font.pixelSize: 12
                    color: Colors.wsText
                }
            }
        }
    }
    Rectangle {
        width: 38
        height: 24
        radius: 15
        border.width: 1
        color: Colors.wsActive
        anchors.verticalCenter: parent.verticalCenter
        x: bar.location ? bar.location : 6
        Behavior on x {
            NumberAnimation {
                duration: 200
            }
        }
        MouseArea {
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.XAxis
            drag.minimumX: 6
            drag.maximumX: 6 + 4 * (32 + 8) //
            onReleased: {
                // Obliczamy na który workspace upuściliśmy
                var wsIndex = Math.round((parent.x - 6) / (32 + 8));
                var wsId = wsIndex + 1;
                parent.x = bar.location;
                Hyprland.dispatch("workspace " + wsId);
            }
        }
    }
}

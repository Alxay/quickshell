import QtQuick 2.15
import Quickshell.Hyprland
import "../../Theme/" // Kolory

Rectangle {
    color: Colors.barBackground
    implicitHeight: Colors.itemsHeight
    implicitWidth: 210
    radius: 17
    border.width: 1
    anchors.centerIn: parent
    anchors.verticalCenter: parent.verticalCenter
    border.color: Colors.barBorder
    anchors.topMargin: Colors.topMargin

    Row {
        id: root
        spacing: 8
        anchors.centerIn: parent

        // Iterujemy 5 razy (tworzy index 0, 1, 2, 3, 4)
        Repeater {
            model: 5

            Rectangle {
                // Obliczamy ID workspace'a (1, 2, 3, 4, 5)
                property int wsId: index + 1

                // Sprawdzamy, czy ten workspace jest aktywny
                property bool isActive: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id === wsId : false

                width: isActive ? 38 : 32
                height: 24
                radius: 15
                border.width: 1

                // Kolor prostokąta zależy od stanu
                color: isActive ? Colors.wsActive : Colors.wsEmpty

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }

                // Kolor ramki także zależy od stanu
                border.color: isActive ? Colors.wsActiveBorder : Colors.wsEmpty

                Behavior on border.color {
                    ColorAnimation {
                        duration: 200
                    }
                }

                // Animacja szerokości (rozszerza się, jeśli aktywne)
                Behavior on width {
                    NumberAnimation {
                        duration: 200
                    }
                }

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

                    // Tekst biały dla aktywnego, szary dla zajętego, ciemny dla pustego
                    color: parent.isActive ? Colors.textPrimary : Colors.textSecondary

                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
            }
        }
    }
}

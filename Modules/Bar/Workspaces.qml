import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../../Theme/" // Colors

Row {
    id: root
    spacing: 8

    // Iterujemy 4 razy (tworzy index 0, 1, 2, 3)
    Repeater {
        model: 4 

        Rectangle {
            // Obliczamy ID workspace'a (1, 2, 3, 4)
            property int wsId: index + 1
            
            // Sprawdzamy, czy ten konkretny workspace jest aktualnie aktywny (zaznaczony)
            property bool isActive: Hyprland.focusedWorkspace.id === wsId
            width: 32
            height: 24
            radius: 15
            border.width: 2

            // Logika kolorów:
            // 1. Aktywny -> Jasny
            // 2. Zajęty (ale nie aktywny) -> Ciemniejszy
            // 3. Pusty -> Najciemniejszy / Przezroczysty
            color: isActive ? Colors.wsActive : Colors.wsEmpty
            
            Behavior on color {
                ColorAnimation { duration: 200 }
            }

            // Kolor ramki też może zależeć od stanu
            border.color: isActive ? Colors.wsActiveBorder : Colors.wsEmpty

            Behavior on border.color {
                ColorAnimation { duration: 200 }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // Przełączamy na obliczone ID
                    Hyprland.dispatch("workspace " + parent.wsId)
                }
            }

            Text {
                text: parent.wsId // Wyświetlamy numer
                anchors.centerIn: parent
                font.pixelSize: 12
                
                // Tekst biały dla aktywnego, szary dla zajętego, ciemny dla pustego
                color: parent.isActive ? Colors.textPrimary : Colors.textSecondary

                Behavior on color {
                    ColorAnimation { duration: 200 }
                }
            }
        }
    }
}
import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../../Widgets"
import "../../Theme" 
import "../../Modules/Media"

PanelWindow {
    id: panelWindow
    
    // Ustawiamy warstwę na Top, aby Bar był NA WIERZCHU
    Time { id: clock }

    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 30
    margins { top: 0; left: 0; right: 0 }
    
    // Ustawiamy kolor tła okna na przezroczysty, bo rysujemy własny pasek niżej
    color: "transparent"

    Rectangle { // Top bar
    z:2
    
        id: bar
        anchors.fill: parent
        color: Colors.barBackground
        // border.color: Colors.barBorder // Jeśli masz to w Theme
        border.color: "#444444"
        border.width: 1

        // --- 1. WORKSPACES (Lewa strona) ---
        Workspaces {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
        }

        // --- 2. ZEGAR (Środek) ---
        ShowText {
            anchors.centerIn: parent
            data: clock.time
            color: Colors.textPrimary
        }

        // --- 3. DATA (Prawa strona - punkt odniesienia) ---
        ShowText {
            id: dateText // Nadajemy ID, żeby ikonka muzyki mogła się do tego odnieść
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            data: clock.date
            color: Colors.textPrimary
        }
            Rectangle {
        // Przycisk muzyki w barze
        width: 40; height: 40
        anchors.right: parent.right
        anchors.rightMargin: 150
        anchors.verticalCenter: parent.verticalCenter
        radius: 20
        color: "transparent"

        Text { text: "🎵"; anchors.centerIn: parent }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                // Opcja A: Jeśli 'root' jest widoczny globalnie (zależy od wersji Quickshell):
                root.showMedia = !root.showMedia
                
                // Opcja B (Bardziej 'hackerska' jeśli A nie działa):
                // Znajdź obiekt 'root' przez parenta (może być trudne przy osobnych oknach)
            }
        }
            }        
            
            
            


}
}
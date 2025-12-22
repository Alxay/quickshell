import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import Quickshell.Io
import "../../Components"

PanelWindow {
    id: root 
    required property var controller
    
    // --- KONFIGURACJA OKNA ---
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    WlrLayershell.namespace: "screenshot" 
    color: "transparent"
    anchors { top: true; bottom: true; left: true; right: true }

    // --- ZMIENNE STANU ---
    property int startX: 0
    property int startY: 0
    property int currX: 0
    property int currY: 0
    property bool isSelecting: false 

    // --- MATEMATYKA GEOMETRII ---
    readonly property int selX: Math.min(startX, currX)
    readonly property int selY: Math.min(startY, currY)
    readonly property int selW: Math.abs(currX - startX)
    readonly property int selH: Math.abs(currY - startY)

    // Pomocnicze zmienne dla łatwiejszego przypisania lin (Right i Bottom)
    readonly property int selRight: selX + selW
    readonly property int selBottom: selY + selH

    // 1. TŁO
    ScreencopyView {
        anchors.fill: parent        
    }

    // 2. LINIE (ROPES) - Oryginalne komponenty
    // Widoczne tylko podczas zaznaczania
    
    // Lewa Góra
    Rope {
        visible: root.isSelecting
        anchors.fill: parent
        start: Qt.vector2d(0, 0) // Róg ekranu
        end: Qt.vector2d(root.selX, root.selY) // Róg zaznaczenia
    }

    // Prawa Góra
    Rope {
        visible: root.isSelecting
        anchors.fill: parent
        start: Qt.vector2d(root.width, 0)
        end: Qt.vector2d(root.selRight, root.selY)
    }

    // Lewy Dół
    Rope {
        visible: root.isSelecting
        anchors.fill: parent
        start: Qt.vector2d(0, root.height)
        end: Qt.vector2d(root.selX, root.selBottom)
    }

    // Prawy Dół
    Rope {
        visible: root.isSelecting
        anchors.fill: parent
        start: Qt.vector2d(root.width, root.height)
        end: Qt.vector2d(root.selRight, root.selBottom)
    }

    // 3. WĘZŁY (ROPE TIES) - Obrazki na rogach
    


    // 4. RAMKA ZAZNACZENIA
    // Opcjonalnie: Oryginalny kod używał "wycinania" w Canvasie,
    // ale Rectangle też wygląda dobrze z linami.
    Rectangle {
        visible: root.isSelecting 
        x: root.selX
        y: root.selY
        width: root.selW
        height: root.selH
        color: "#22000000" // Bardzo delikatne przyciemnienie w środku
        border.color: "#824524" // Kolor pasujący do lin
        border.width: 2
    }

    // 5. OBSŁUGA MYSZY
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.CrossCursor 

        onPressed: (mouse) => {
            root.startX = mouse.x
            root.startY = mouse.y
            root.currX = mouse.x
            root.currY = mouse.y
            root.isSelecting = true
        }

        onPositionChanged: (mouse) => {
            root.currX = mouse.x
            root.currY = mouse.y
            // Tu nie musimy wołać requestPaint, bo Ropes to obiekty QML,
            // które same śledzą zmiany zmiennych (bindings)!
        }
        
        onReleased: (mouse) => {
            if (root.selW === 0 || root.selH === 0) {
                controller.close();
                return;
            }
            root.isSelecting = false; // Ukryj liny
            screenshotCmd.running = true;
        }
    }

    // 6. PROCES WYKONAWCZY
    Process {
        id: screenshotCmd
        running: false
        command: ["sh", "-c", `grim -g "${root.selX},${root.selY} ${root.selW}x${root.selH}" - | wl-copy`]

        onExited: (code) => {
            controller.close();
        }
    }
}
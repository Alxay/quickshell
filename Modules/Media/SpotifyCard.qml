import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Wayland
import QtQuick.Shapes
import "../../Theme/" // Colors

PopupWindow {
    id: mediaWindow
    
    // Logika: Okno jest widoczne tak długo, jak animacja trwa (opacity > 0)
    property bool showMedia: root.showMedia
    visible: bgShape.opacity > 0

    // Pozycjonowanie: Środek poziomo, dół pionowo (styk z paskiem)
    anchor.rect.x: parentWindow.width / 2 - implicitWidth / 2
    anchor.rect.y: parentWindow.height - 1 // -1 żeby ładnie stykało się z linią paska

    implicitWidth: 570
    implicitHeight: 300
    color: "transparent" 

    Shape {
        id: bgShape
        width: 570
        height: 300
        
        // --- ANIMACJA WYSUWANIA ---
        transformOrigin: Item.Bottom
        opacity: mediaWindow.showMedia ? 1 : 0
        
        transform: Translate {
            y: mediaWindow.showMedia ? 0 : 300 
            Behavior on y { NumberAnimation { duration: 400; easing.type: Easing.OutExpo } }
        }
        Behavior on opacity { NumberAnimation { duration: 300 } }
        // --------------------------

        layer.enabled: true
        layer.samples: 4
        
        // Zmienna promienia - steruje wielkością wcięć
        property int r: 20

        // TŁO (RYSOWANIE KSZTAŁTU)
       // TŁO (RYSOWANIE KSZTAŁTU)
        ShapePath {
            strokeWidth: 1
            strokeColor: Colors.barBorder
            fillColor: Colors.barBackground
            
            // Punkt startowy: Lewy górny róg (zewnętrzny)
            startX: 0
            startY: 0

            // 1. Lewy Górny Róg (WKLĘSŁY - "Reverse Round")
            // Tworzy łuk od krawędzi ekranu do właściwego boku okna
            PathArc {
                x: bgShape.r
                y: bgShape.r
                radiusX: bgShape.r
                radiusY: bgShape.r
                direction: PathArc.CounterClockwise // Przeciwnie do zegara = wklęsły
            }

            // 2. Lewa krawędź (prosta w dół)
            // Zatrzymujemy się o 'r' przed końcem wysokości, aby zrobić miejsce na łuk
            PathLine { 
                x: bgShape.r
                y: height - bgShape.r 
            }
            
            // 3. Lewy Dolny Róg (WYPUKŁY - "Normal Round")
            // Zauważ przesunięcie x: 2 * r. Dlaczego?
            // Pierwsze 'r' to margines lewy (od wklęsłości), drugie 'r' to szerokość samego łuku.
            PathArc {
                    x: bgShape.r
                y: height

            }

            // 4. Dolna krawędź
            PathLine { 
                x: width - (2 * bgShape.r)
                y: height 
            }
            
            // 5. Prawy Dolny Róg (WYPUKŁY - "Normal Round")
            PathArc {
                    x: width -bgShape.r
                    y:height
            }
            
            // 6. Prawa krawędź
            PathLine { 
                x: width - bgShape.r
                y: bgShape.r 
            }
            
            // 7. Prawy Górny Róg (WKLĘSŁY - "Reverse Round")
            PathArc {
                x: width
                y: 0
                radiusX: bgShape.r
                radiusY: bgShape.r
                direction: PathArc.CounterClockwise
            }
            
            // Nie zamykamy ścieżki na górze (PathLine do 0,0), 
            // dzięki temu nie będzie tam obramowania (stroke), co wygląda lepiej przy styku z paskiem.
        }

        // --- ZAWARTOŚĆ OKNA ---
        // Używamy Item jako kontenera z marginesami, żeby tekst nie wchodził na łuki
        Item {
            anchors.fill: parent
            // Marginesy muszą być >= r (promień), żeby ominąć wcięcia
            anchors.leftMargin: bgShape.r 
            anchors.rightMargin: bgShape.r
            anchors.topMargin: 10
            anchors.bottomMargin: 10

            // Obsługa myszy (Zamykanie po zjechaniu)
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true 
                onExited: root.showMedia = false
                // Opcjonalnie: preventStealing zapobiega problemom z klikaniem przycisków
                preventStealing: true 
            }

            GetPlayer {
                id: player
            }

            // Tytuł
            Text {
                font.family: "JetBrains Mono"
                anchors.centerIn: parent
                text: player.spotifyPlayer?.metadata["xesam:title"] ?? "Brak muzyki"
                color: "white"
                font.bold: true
                elide: Text.ElideRight
                width: parent.width - 100 // Ograniczenie szerokości tekstu
                horizontalAlignment: Text.AlignHCenter
            }

            // Przycisk Wstecz
            Text {
                font.family: "JetBrains Mono"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: "←"
                font.pixelSize: 30
                color: maPrev.containsMouse ? "#bd93f9" : "white"
                
                MouseArea {
                    id: maPrev
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: player.spotifyPlayer.previous()
                }
            }

            // Przycisk Dalej
            Text {
                font.family: "JetBrains Mono"
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: "→"
                font.pixelSize: 30
                color: maNext.containsMouse ? "#bd93f9" : "white"
                
                MouseArea {
                    id: maNext
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: player.spotifyPlayer.next()
                }
            }
        }
    }
}
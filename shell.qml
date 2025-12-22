//@ pragma UseQApplication
import "."
import QtQuick
import Quickshell
import Quickshell.Wayland
import "./Modules/Bar"
import "./Modules/Media"

ShellRoot {
    id: root
    
    // Globalna zmienna sterująca widocznością
    property bool showMedia: false

    // ---------------------------------------------------------
    // 1. GŁÓWNY BAR
    // ---------------------------------------------------------
    // Zamiast Loadera, lepiej załadować Bar bezpośrednio, by mieć kontrolę,
    // ale jeśli Bar.qml zawiera w sobie PanelWindow, to Loader też jest OK.
    // Zakładam, że Bar.qml to PanelWindow.
    
    Bar {
        id: mainBar
        WlrLayershell.layer: WlrLayershell.Layer.Overlay
        // Przekazujemy referencję do roota, żeby przycisk w barze mógł zmieniać 'showMedia'
        // W Bar.qml musisz obsłużyć kliknięcie (zobacz punkt 3)
    }

    // ---------------------------------------------------------
    // 2. OKNO PLAYERA (Pod Barem)
    // ---------------------------------------------------------
    PanelWindow {
        id: mediaWindow
        WlrLayershell.layer: WlrLayershell.Layer.Top
        
        // KLUCZOWE: To sprawia, że okno nie rezerwuje miejsca (nie przesuwa innych okien)
        exclusionMode: ExclusionMode.Ignore 

        // Pozycjonowanie
        anchors.top: true
        anchors.right: true
        
        // Ważne: Margines od góry równy wysokości Bara + mały odstęp
        // Jeśli Twój bar ma np. 40px, dajemy 45px
        margins.top: 20
        margins.right: 70

        width: 300
        height: 120
        
        // Widoczność sterowana zmienną
        visible: root.showMedia
        
        color: "transparent" // Okno przezroczyste, widać tylko SpotifyCard

        // Właściwa zawartość
        SpotifyCard {
            anchors.fill: parent
        }
        
        // Opcjonalna animacja wjazdu/zjazdu
        Behavior on margins.top { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
        
        // Jeśli chcesz animację "wjazdu", możesz sterować opacity lub margins przy zmianie visible

    }
}
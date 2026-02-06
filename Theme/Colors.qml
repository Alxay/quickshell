pragma Singleton
import QtQuick

QtObject {
    property color background: '#00222222'       // Tło ogólne
    property color barBackground: '#ad151515'    // Tło paska
    property color barBorder: '#00444444'           // Ramki
    property color textPrimary: "#ffffff"      // Główny tekst
    property color textSecondary: "#FFFFFF" // Taki szarawy // Mniej ważny tekst
    property color active: '#e389fa'
    property color primary: '#024d3d'        // Kolor główny
    property color secondary: '#02785f'       // Kolor drugi

    // Kolory Workspace'ów
    property color wsActive: '#a707da94'         // Aktywny
    property color wsBg: '#00000000'          // Pusty
    property color wsText: '#ffffff'        // Tekst

    // Bar
    property int itemsHeight: 30
    property int topMargin: 10
}

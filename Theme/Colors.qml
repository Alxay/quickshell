pragma Singleton
import QtQuick

QtObject {
    property color background: '#222222'       // Tło ogólne
    property color barBackground: '#222222'    // Tło paska
    property color barBorder: "#444444"           // Ramki
    property color textPrimary: "#ffffff"      // Główny tekst
    property color textSecondary: "#FFFFFF" // Taki szarawy // Mniej ważny tekst
    property color active: '#e389fa'

    // Kolory Workspace'ów
    property color wsActive: '#a707da94'         // Aktywny
    property color wsBg: '#001b1b1b'          // Pusty
    property color wsText: '#ffffff'        // Tekst

    // Bar
    property int itemsHeight: 30
    property int topMargin: 10
}

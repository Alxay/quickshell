pragma Singleton
import QtQuick

QtObject {
    property color background: "#1e1e2e"       // Tło ogólne
    property color barBackground: "#222222"    // Tło paska
    property color barBorder: "#444444"           // Ramki
    property color textPrimary: "#ffffff"      // Główny tekst
    property color textSecondary: "#a6adc8" // Taki szarawy // Mniej ważny tekst
    property color active: "#89b4fa"
    
    // Kolory Workspace'ów
    property color wsActive: '#064c62'         // Aktywny
    property color wsActiveBorder: '#b7ffffff'   // Ramka aktywnego
    property color wsOccupied: "#333333"       // Zajęty
    property color wsEmpty: '#46515f'          // Pusty
}
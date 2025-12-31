import Quickshell
import QtQuick 2.15

Scope {
    // Now returns the player object (or null), allowing GetLyrics to access metadata
    property var spotifyPlayer
    property var lyricsText: ""
}

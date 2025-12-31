import QtQuick
import Quickshell
import Quickshell.Services.Mpris

// ... wewnątrz twojego elementu ...
Scope {
    id: root
    // Now returns the player object (or null), allowing SpotifyCard to access metadata
    property var spotifyPlayer: Mpris.players.values.find(p => p.identity === "Spotify") ?? null
    property var lyricsText: root.spotifyPlayer?.metadata["xesam:lyrics"] ?? "Brak muzyki"
}

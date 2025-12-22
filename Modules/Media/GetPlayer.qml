import QtQuick
import Quickshell
import Quickshell.Services.Mpris

// ... wewnątrz twojego elementu ...
Scope{
    // Now returns the player object (or null), allowing SpotifyCard to access metadata
    property var spotifyPlayer: Mpris.players.values.find(p => p.identity === "Spotify") ?? null
}


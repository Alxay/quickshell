//@ pragma UseQApplication
import "."
import QtQuick
import Quickshell
import Quickshell.Wayland
import "./Modules/Bar"
import "./Modules/Media"
import "./Modules/Media"

ShellRoot {
    id: root
    property bool showMedia: false
    
    Bar {
        id: mainBar
    }
    SpotifyCard{
        id: spotifyCard
    }
}
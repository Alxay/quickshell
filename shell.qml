//@ pragma UseQApplication
import "."
import QtQuick
import Quickshell
import Quickshell.Wayland
import "./Modules/Bar"
import "./Modules/Media"
import "./Modules/Grim"

ShellRoot {
    id: root
    // property bool showMedia: false
    Component.onCompleted: {
        Screenshot.init();
    }
    Bar {
        id: mainBar
    }
    // Spotify_text {
    //     id: spotifyText
    // }
    // SpotifyCard{
    //     id: spotifyCard
    //     anchor.window: mainBar.barr
    // }
}

//@ pragma UseQApplication
import QtQuick
import Quickshell
import "./Modules/Bar"
// import "./Modules/Media"
// import "./Modules/Grim"
import "./Modules/Wallpaper"

ShellRoot {
    id: root
    // property bool showMedia: false
    Component.onCompleted: {
        // Screenshot.init();
        Wallpaper.init();
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

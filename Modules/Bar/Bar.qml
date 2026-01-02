import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import "../../Widgets"
import "../../Theme"
import "../../Modules/Media"

PanelWindow {
    id: taskBar
    // Ustawiamy warstwę na Top, aby Bar był NA WIERZCHU
    Time {
        id: clock
    }
    GetPlayer {
        id: spotifyPlayer
    }

    anchors {
        top: true
        left: true
        right: true
    }
    WifiStrength {
        id: wifi
    }
    Sound {
        id: sound
    }
    implicitHeight: 35
    // Ustawiamy kolor tła okna na przezroczysty, bo rysujemy własny pasek niżej
    color: "transparent"

    Rectangle { // Top bar
        id: bar
        anchors.fill: parent
        // color: Colors.barBackground
        // // border.color: Colors.barBorder // Jeśli masz to w Theme
        // border.color: "#444444"
        // border.width: 1

        color: "transparent"

        Workspaces {
            id: workspaces_panel
        }
        ShowTime {
            time: clock.time
        }
        SpotifyMusic {
            id: music
            player: spotifyPlayer
        }
        Power {
            id: power
        }
        Network {
            id: network
            networkStrength: wifi.strength
        }
        Volume {
            id: volume
            volumeIcon: sound.volume
            getVolume: sound.getVolume
        }
        ShowDate {
            date: clock.date
        }
    }
}

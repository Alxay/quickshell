import QtQuick
import Quickshell
import "../../Widgets"
import "../../Modules/Media"
import "../../Theme"

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
    GetUser {
        id: getUser
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
        User {
            id: user
            user: getUser.user
        }

        ShowTime {
            time: clock.time
        }

        Workspaces {
            id: workspaces_panel
        }

        SpotifyMusic {
            id: music
            player: spotifyPlayer
        }
        Rectangle {
            color: Colors.barBackground
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
            }
            width: 275
            height: parent.height + 2
            topLeftRadius: 15
            bottomLeftRadius: 15

            // Power {
            //     id: power
            // }
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
            Files {
                id: files
            }
        }
    }
}

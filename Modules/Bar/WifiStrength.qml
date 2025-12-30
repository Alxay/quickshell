// Get wifi strenght
import Quickshell.Io
import Quickshell
import QtQuick

Scope {
    id: root
    property string strength: "N/A"
    property string speed: "N/A"
    Process {
        id: getNetworkSpeed
        command: ["sh", "-c", "nmcli -t -f ACTIVE,SSID,RATE device wifi | grep '^tak' | cut -d ':' -f 3"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.speed = this.text.trim();
            }
        }
    }
    Process {
        id: wifiProc
        command: ["sh", "-c", "nmcli -t -f ACTIVE,SSID,SIGNAL device wifi | grep '^tak' | cut -d ':' -f 3"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.strength = root.updateIcon(parseInt(this.text.trim()))
        }
    }

    function updateIcon(value) {
        if (value >= 75) {
            return "󰤨   " + root.speed; // (Full)
        } else if (value >= 50) {
            return "󰤥   " + root.speed; // (3/4)
        } else if (value >= 25) {
            return "󰤢   " + root.speed; // (1/2)
        } else if (value > 0) {
            return "󰤟   " + root.speed; // (1/4)
        } else {
            return "󰤮"; // (Disconnected / Off)
        }
    }
    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: wifiProc.running = true
    }
}

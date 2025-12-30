// Get Volume
import Quickshell.Io
import Quickshell
import QtQuick

Scope {
    id: root
    property string volume: "N/A"
    property Process getVolume: updateVolume
    Process {
        id: updateVolume
        command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ':' -f 2"]
        running: true

        stdout: StdioCollector {
            // przed liczbą jest spacja
            onStreamFinished: root.volume = root.updateIcon(parseFloat(this.text.trim()))
        }
    }
    // function updateIcon(value) {
    //     // value is between 0 and 1
    //     value = value * 100;

    //     if (value >= 75) {
    //         return "󰕾"; // (High - 3 falki)
    //     } else if (value >= 50) {
    //         return "󰖀"; // (Medium - 2 falki)
    //     } else if (value >= 25) {
    //         return "󰕿"; // (Low - 1 falka)
    //     } else if (value > 0) {
    //         return "󰕿"; // (Low - też 1 falka, bo rzadko jest ikona "very low")
    //     } else {
    //         return "󰸈"; // (Muted - przekreślony)
    //     }
    // }
    function updateIcon(value) {
        // value is between 0 and 1
        var vol = Math.round(value * 100);

        // Jeśli volume jest 0
        if (vol <= 0) {
            return "󰸈"; // (Muted) - Przekreślony głośnik
        } else

        // Głośno (> 60%)
        if (vol > 60) {
            return "󰕾  " + vol; // (High) - Głośnik z 3 falkami
        } else

        // Twój standardowy zakres (21% - 60%)
        if (vol > 20) {
            return "󰖀 " + vol; // (Medium) - Głośnik z 2 falkami (TUTAJ BYŁA ZMIANA)
        } else

        // Cicho (1% - 20%)
        {
            return "󰕿 " + vol; // (Low) - Głośnik z 1 falką
        }
    }
    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: updateVolume.running = true
    }
}

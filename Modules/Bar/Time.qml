// Time.qml
import Quickshell
import QtQuick

Scope {
    id: root
    property string time: "N/A"
    property string date: "N/A"

    //   Process {
    //     id: dateProc
    //     command: ["date"]
    //     running: true

    //     stdout: StdioCollector {
    //       onStreamFinished: root.time = this.text
    //     }
    //   }

    // Updated to use JavaScript Date object
    // Text {
    //   text: root.time = "21:37"
    // }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
    Text {
        text: root.time = Qt.formatDateTime(clock.date, "hh:mm AP")
    }
    // time in 12 hr format with am/pm
    // Text {
    //     text: root.time = Qt.formatDateTime(clock.date, "hh:mm ap")
    // }
    Text {
        text: root.date = Qt.formatDateTime(clock.date, "dddd, MMM dd") //day of week, month day
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
    }
}

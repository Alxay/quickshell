// Time.qml
import Quickshell
import QtQuick
import Quickshell.Io

Scope {
    id: root
    property string user: "N/A"

    Process {
        id: userProc
        command: ["whoami"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.user = this.text.trim().charAt(0).toUpperCase() + this.text.trim().slice(1)
        }
    }
}

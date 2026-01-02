pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property bool isOpen: false

    IpcHandler {
        target: "wallpaper"

        function toggle() {
            root.isOpen = !root.isOpen;
            console.log("Przełączono stan okna: " + root.isOpen);
        }
        function open() {
            root.isOpen = true;
        }
    }
    function close() {
        root.isOpen = false;
    }
    LazyLoader {
        active: root.isOpen
        Overlay {
            controller: root
        }
    }

    // Empty function to define first reference to singleton
    function init() {
        console.log(">>> Moduł Wallpaper zainicjalizowany!");
    }
}

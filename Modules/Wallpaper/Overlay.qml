import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Io
import Qt.labs.folderlistmodel

PanelWindow {
    id: root
    required property var controller
    property string filePath: ""

    WlrLayershell.layer: WlrLayer.Overlay
    // WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    WlrLayershell.namespace: "wallpaper"
    color: "transparent"
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    FolderListModel {
        id: wallModel
        folder: "file://" + "/home/alxay/Pictures/Wallpapers" // Path to wallpapers folder

        nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp"]
        showDirs: false
        showDotAndDotDot: false
        sortField: FolderListModel.Name
    }
    GridView {
        id: grid
        anchors.fill: parent
        anchors.margins: 20

        cellWidth: 220
        cellHeight: 140
        clip: true
        focus: true // Enable keyboard focus for scrolling

        model: wallModel

        delegate: Rectangle {
            width: grid.cellWidth - 10
            height: grid.cellHeight - 10
            color: "transparent"
            radius: 8
            border.color: hoverHandler.hovered ? "#ffffff" : "transparent"
            border.width: 2

            Image {
                id: imgPreview
                anchors.fill: parent
                anchors.margins: 4

                source: fileUrl // Rola dostarczana przez FolderListModel
                fillMode: Image.PreserveAspectCrop
                sourceSize.width: 220
                sourceSize.height: 140
                asynchronous: true
                cache: true
                layer.enabled: true
            }
            HoverHandler {
                id: hoverHandler
                cursorShape: Qt.PointingHandCursor
            }

            TapHandler {
                onTapped: {
                    console.log("Wybrano tapetę: " + fileName);
                    console.log("Pełna ścieżka: " + filePath);
                    root.filePath = "/home" + filePath.slice(5);
                    console.log("Pełna ścieżka do ustawienia: " + root.filePath);
                    changeWallpaper.running = true;
                }
            }
        }
    }
    Process {
        id: changeWallpaper
        running: false
        command: ["swww", "img", root.filePath, "--transition-type", "any", "--transition-duration", "2.4", "--transition-fps", "60"]
        onExited: code => {
            console.log("Process zakończony z kodem", code);
            controller.close();
        }
    }
}

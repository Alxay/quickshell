import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Io
import Qt.labs.folderlistmodel

PanelWindow {
    id: root
    required property var controller
    property string targetPath: ""

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    WlrLayershell.namespace: "wallpaper-selector"

    color: "transparent"

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    // Zamykanie na Escape
    Shortcut {
        sequence: "Escape"
        onActivated: root.controller.close()
    }

    FolderListModel {
        id: wallModel
        folder: "file:///home/alxay/Pictures/Wallpapers"
        nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp", "*.gif"]
        showDirs: false
        sortField: FolderListModel.Name
    }

    PathView {
        id: view
        anchors.fill: parent
        model: wallModel

        pathItemCount: 5
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlightRangeMode: PathView.StrictlyEnforceRange

        focus: true
        Keys.onRightPressed: incrementCurrentIndex()
        Keys.onLeftPressed: decrementCurrentIndex()
        Keys.onReturnPressed: root.setWallpaper()

        delegate: Item {
            width: 400
            height: 250
            z: PathView.z
            scale: PathView.iconScale
            opacity: PathView.iconOpacity

            Rectangle {
                id: wrapper
                anchors.fill: parent
                radius: 15
                color: "black"
                border.color: wrapper.PathView.isCurrentItem ? "#89b4fa" : "transparent"
                border.width: 3

                Image {
                    anchors.fill: parent
                    anchors.margins: 3
                    source: fileUrl
                    fillMode: Image.PreserveAspectCrop

                    // --- OPTYMALIZACJA ---
                    sourceSize.width: 400
                    sourceSize.height: 250
                    asynchronous: true
                    cache: true

                    // Usuń layer.enabled dla testu, jeśli nadal laguje.
                    // Czasami maskowanie na Waylandzie jest kosztowne.
                }

                Text {
                    anchors.top: parent.bottom
                    anchors.topMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: fileName
                    color: "white"
                    visible: wrapper.PathView.isCurrentItem
                    font.pixelSize: 16
                    font.bold: true
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (view.currentIndex === index) {
                        root.setWallpaper();
                    } else {
                        view.currentIndex = index;
                    }
                }
            }
        }

        path: Path {
            startX: 0
            startY: view.height / 2
            PathAttribute {
                name: "iconScale"
                value: 0.6
            }
            PathAttribute {
                name: "iconOpacity"
                value: 0.5
            }
            PathAttribute {
                name: "z"
                value: 0
            }
            PathLine {
                x: view.width / 2
                y: view.height / 2
            }
            PathAttribute {
                name: "iconScale"
                value: 1.3
            }
            PathAttribute {
                name: "iconOpacity"
                value: 1.0
            }
            PathAttribute {
                name: "z"
                value: 100
            }
            PathLine {
                x: view.width
                y: view.height / 2
            }
            PathAttribute {
                name: "iconScale"
                value: 0.6
            }
            PathAttribute {
                name: "iconOpacity"
                value: 0.5
            }
            PathAttribute {
                name: "z"
                value: 0
            }
        }
    }

    function setWallpaper() {
        var url = wallModel.get(view.currentIndex, "fileUrl").toString();
        var cleanPath = url.replace("file://", "");

        console.log("Ustawiam tapetę: " + cleanPath);
        root.targetPath = cleanPath;
        root.visible = false;
        swwwProcess.running = true;
    }

    Process {
        id: swwwProcess
        running: false
        command: ["swww", "img", root.targetPath, "--transition-type", "grow", "--transition-pos", "0.5,0.5", "--transition-duration", "2.0", "--transition-fps", "60" // Zmniejszamy FPS tranzycji, 144 to za dużo przy włączonym compositorze
        ]
        onExited: code => {
            console.log("SWWW Exit: " + code);
            root.controller.close();
        }
    }
}

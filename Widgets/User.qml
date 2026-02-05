import QtQuick
import "../Theme"

Rectangle {
    id: root
    required property string user
    color: Colors.barBackground
    anchors {
        top: parent.top
        bottom: parent.bottom
        left: parent.left
    }
    width: 230
    height: parent.height + 2
    topRightRadius: 15
    bottomRightRadius: 15
    Rectangle {
        anchors.leftMargin: 47
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        width: 95
        color: '#a1019978'
        topRightRadius: 15
        bottomRightRadius: 15

        Text {
            text: "~/" + root.user
            color: "#FFFFFF"
            font.pixelSize: 14
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 32
        }
    }
    Rectangle {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        width: 75
        color: '#003e31'
        topRightRadius: 15
        bottomRightRadius: 15
        Image {
            source: "../Assets/archlinux.svg" //Icon form https://icons8.com/
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            rotation: 0
            anchors.leftMargin: 5
        }
        Text {
            text: "Arch"
            color: "#FFFFFF"
            font.pixelSize: 14
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 34
        }
    }
}

import Quickshell
import QtQuick

Text {
    property var name: ""
    property var value: ""
    text: name + (value != "" ? ": " : "") + value
    font {
        pixelSize: 14
        family: "SpaceMono Nerd Font"
    }
}

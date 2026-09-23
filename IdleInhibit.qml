import Quickshell
import Quickshell.Wayland
import QtQuick

Item {
    property var inhibitor
    Rectangle {
        anchors.fill: parent
        width: 30
        color: "#00000000"
        height: 30
        TextLabel {
            anchors.centerIn: parent
            name: inhibitor.enabled ? "󰅶" : "󰾪"
            color: inhibitor.enabled ? Theme.accent : Theme.text
        }
        MouseArea {
            anchors.fill: parent
            onClicked: inhibitor.enabled = !inhibitor.enabled
        }
    }
}

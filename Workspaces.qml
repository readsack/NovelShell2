import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    implicitHeight: 37
    width: childrenRect.width
    Rectangle {
        width: childrenRect.width + 10
        height: childrenRect.height + 10
        color: Theme.bg

        RowLayout {
            spacing: 0

            anchors.centerIn: parent
            Repeater {
                model: Hyprland.workspaces.values.length >= 5 ? Hyprland.workspaces.values.length : 5
                delegate: Rectangle {
                    property var ws: Hyprland.workspaces.values.find((w, i) => w.id == modelData + 1)
                    property var wsid: ws ? ws.id : modelData + 1
                    color: Hyprland.focusedWorkspace.id == wsid ? Theme.accent : Theme.bg
                    width: 40
                    height: 27
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            Hyprland.dispatch("hl.dsp.focus({ workspace = '" + parent.wsid + "' })");
                        }
                    }
                    Text {
                        anchors.centerIn: parent
                        color: Hyprland.focusedWorkspace.id == parent.wsid ? Theme.bgAlt : Theme.text
                        text: parent.wsid
                        font.family: "SpaceMono Nerd Font"
                        font.bold: true
                        font.pixelSize: 12
                    }
                }
            }
        }
    }
}

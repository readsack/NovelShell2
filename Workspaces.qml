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
                model: Hyprland.workspaces.values.length > 5 ? Hyprland.workspaces.values.length : 5
                delegate: Rectangle {
                    property var ws: Hyprland.workspaces.values.find(modelData)
                    color: modelData.active ? Theme.accent : "#00000000"
                    width: 40
                    height: 27
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            modelData.activate();
                        }
                    }
                    Text {
                        anchors.centerIn: parent
                        color: modelData.active ? Theme.bgAlt : Theme.textMuted
                        text: modelData.id
                        font.family: "SpaceMono Nerd Font"
                        font.bold: true
                    }
                }
            }
        }
    }
}

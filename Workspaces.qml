import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: wkspcWidget
    implicitHeight: 37
    width: childrenRect.width

    function createWorkspaceList(minVal) {
        let lst = [];
        let maxW = 1;
        for (let i = 0; i < Hyprland.workspaces.values.length; i++)
            lst.push(Hyprland.workspaces.values[i].id);
        lst.sort();
        for (let i = 1; i <= minVal; i++) {
            if (lst[i - 1] != i) {
                console.log(i);
                lst.push(i);
                lst.sort();
            }
        }
        lst.sort();
        return lst;
    }

    Rectangle {
        width: childrenRect.width + 10
        height: childrenRect.height + 10
        color: Theme.bg

        RowLayout {
            spacing: 0

            anchors.centerIn: parent
            Repeater {
                model: wkspcWidget.createWorkspaceList(5)
                delegate: Rectangle {
                    property var ws: Hyprland.workspaces.values.find((w, i) => w.id == modelData)
                    property var wsid: ws ? ws.id : index + 1
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
                        color: Hyprland.focusedWorkspace.id == parent.wsid ? Theme.bgAlt : parent.ws ? Theme.text : Theme.textMuted
                        text: parent.wsid
                        font.family: Theme.font
                        font.bold: true
                        font.pixelSize: 12
                    }
                }
            }
        }
    }
}

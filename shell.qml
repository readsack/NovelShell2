import Quickshell // for PanelWindow
import QtQuick // for Text

Scope {
    PanelWindow {
        color: "#00ff0000"
        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: 35
        Workspaces {
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}

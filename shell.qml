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
        margins.top: 10
        Workspaces {
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }

        Clock {
            anchors.centerIn: parent
            anchors.verticalCenter: parent.verticalCenter
        }
        SystemTray {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 10
        }
    }
}

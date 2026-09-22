import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    Rectangle {
        implicitWidth: childrenRect.width
        implicitHeight: 40
        color: Theme.bg
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        RowLayout {
            implicitHeight: 40
            Wifi {}
            Bluetooth {}
        }
    }
}

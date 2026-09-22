import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    anchors.right: parent.right
    anchors.rightMargin: 10
    anchors.verticalCenter: parent.verticalCenter
    width: childrenRect.width
    Rectangle {
        implicitWidth: childrenRect.width + 10
        implicitHeight: 40
        color: Theme.bg
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        RowLayout {
            implicitHeight: 40
            Wifi {}
            Bluetooth {}
            Battery {}
            Audio {
                Layout.preferredHeight: childrenRect.height
                Layout.preferredWidth: childrenRect.width
            }
        }
    }
}

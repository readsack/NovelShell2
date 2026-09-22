import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: wifiCol
    property var wifiNetwork
    border.color: wifiCol.wifiNetwork.connected ? Theme.accent : Theme.border
    border.width: 2
    color: Theme.bg
    height: childrenRect.height
    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 30
        height: 30
        TextLabel {

            color: wifiCol.wifiNetwork.connected ? Theme.accent : Theme.text
            text: "󰖩 "
        }
        TextLabel {
            color: wifiCol.wifiNetwork.connected ? Theme.accent : Theme.text
            text: wifiCol.wifiNetwork.name
            Layout.fillWidth: true
            font.pixelSize: 12
        }
        TextLabel {
            color: wifiCol.wifiNetwork.connected ? Theme.accent : Theme.text

            text: (Math.trunc(wifiCol.wifiNetwork.signalStrength * 100)) + "%"
            font.pixelSize: 12
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (wifiCol.wifiNetwork.connected) {
                wifiCol.wifiNetwork.disconnect();
            } else {
                wifiCol.wifiNetwork.connect();
            }
        }
    }
}

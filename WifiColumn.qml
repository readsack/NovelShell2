import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: wifiItem
    property var wifiNetwork
    border.color: wifiItem.wifiNetwork.connected ? Theme.accent : Theme.border
    border.width: 2
    color: Theme.bg
    height: childrenRect.height
    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 30
        height: 30
        TextLabel {

            color: wifiItem.wifiNetwork.connected ? Theme.accent : Theme.text
            text: "󰖩 "
        }
        TextLabel {
            color: wifiItem.wifiNetwork.connected ? Theme.accent : Theme.text
            text: wifiItem.wifiNetwork.name
            Layout.fillWidth: true
            font.pixelSize: 12
        }
        TextLabel {
            color: wifiItem.wifiNetwork.connected ? Theme.accent : Theme.text

            text: (Math.trunc(wifiItem.wifiNetwork.signalStrength * 100)) + "%"
            font.pixelSize: 12
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (wifiItem.wifiNetwork.connected) {
                wifiItem.wifiNetwork.disconnect();
            } else {
                wifiItem.wifiNetwork.connect();
            }
        }
    }
}

import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Networking
import QtQuick.Controls

Rectangle {
    id: wifiWidget
    implicitWidth: childrenRect.width + 20
    implicitHeight: 40
    property bool showPanel: false
    color: Theme.bg
    MouseArea {
        anchors.fill: parent
        onClicked: parent.showPanel = !parent.showPanel
    }
    Text {
        text: wifiPanel.networkDevice.connected ? "󰖩" : "󰖪"
        color: wifiPanel.networkDevice.connected ? Theme.accent : Theme.text
        anchors.centerIn: parent
        font {
            pixelSize: 14
            family: "SpaceMono Nerd Font"
        }
    }
    PanelWindow {
        id: wifiPanel
        visible: wifiWidget.showPanel
        property var networkDevice: Networking.devices.values[0]
        anchors.top: parent.bottom
        anchors.right: parent.right
        margins.right: 10
        margins.top: 10
        color: "#00ff0000"
        exclusionMode: ExclusionMode.Normal
        implicitWidth: 350
        implicitHeight: 400
        Rectangle {
            anchors.fill: parent
            color: Theme.bg
            border.width: 2
            border.color: Theme.border
        }
        ColumnLayout {
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.margins: 10
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 0
            anchors.bottom: parent.bottom
            TextLabel {
                name: "Device"
                value: wifiPanel.networkDevice.name
                color: Theme.text
            }
            TextLabel {
                name: "Addr"
                value: wifiPanel.networkDevice.address
                color: Theme.text
            }
            TextLabel {
                name: "Status"
                value: ConnectionState.toString(wifiPanel.networkDevice.state)
                color: Theme.text
            }
            TextLabel {
                name: "Mode"
                value: wifiPanel.networkDevice.scannerEnabled ? "Scanning" : "Not Scanning"
                color: Theme.text
            }
            Rectangle {
                width: parent.width
                height: 20
                color: "#00000000"
            }
            RowLayout {
                width: parent.width

                TextLabel {
                    name: "Networks: "
                    value: ""
                    color: Theme.text
                    Layout.fillWidth: true
                }
                TextLabel {
                    name: ""
                    value: ""
                    color: Theme.text
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            wifiPanel.networkDevice.scannerEnabled = !wifiPanel.networkDevice.scannerEnabled;
                        }
                    }
                }
            }
            ScrollView {
                Layout.fillHeight: true
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                Layout.fillWidth: true
                Column {
                    id: networkColumn
                    width: parent.width
                    spacing: 8

                    Repeater {
                        model: wifiPanel.networkDevice.networks
                        delegate: WifiItem {
                            width: networkColumn.width
                            wifiNetwork: modelData
                        }
                    }
                }
            }
        }
    }
}

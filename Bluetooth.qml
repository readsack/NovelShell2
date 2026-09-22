import Quickshell
import QtQuick
import Quickshell.Bluetooth
import QtQuick.Layouts
import QtQuick.Controls

Item {
    width: childrenRect.width
    height: childrenRect.height
    Rectangle {
        id: bluWidget
        implicitWidth: childrenRect.width + 20.
        implicitHeight: 40
        color: Theme.bg
        anchors.centerIn: parent
        property var showPanel: false
        Text {
            anchors.centerIn: parent
            text: Bluetooth.defaultAdapter, enabled ? "󰂯" : "󰂲"
            color: Bluetooth.defaultAdapter.enabled ? Theme.accent : Theme.border

            font {
                pixelSize: 14
                family: "SpaceMono Nerd Font"
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: parent.showPanel = !parent.showPanel
        }
        PanelWindow {
            id: bluPanel
            visible: bluWidget.showPanel
            anchors.top: bluWidget.bottom
            anchors.right: bluWidget.right
            margins.right: 10
            margins.top: 10
            color: "#00ff0000"
            exclusionMode: ExclusionMode.Normal
            implicitWidth: 350
            implicitHeight: 400
            Rectangle {
                anchors.fill: parent
                color: Theme.bg
                border {
                    width: 2
                    color: Theme.border
                }
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
                    name: "Name"
                    value: Bluetooth.defaultAdapter.name
                    color: Theme.text
                }
                TextLabel {
                    name: "Id"
                    value: Bluetooth.defaultAdapter.adapterId
                    color: Theme.text
                }
                TextLabel {
                    name: "Path"
                    value: Bluetooth.defaultAdapter.dbusPath
                    color: Theme.text
                }
                TextLabel {
                    name: "Status"
                    value: Bluetooth.defaultAdapter.discovering ? "Scanning" : "Not Scanning"
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
                        name: "Devices: "
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
                                Bluetooth.defaultAdapter.discovering = !Bluetooth.defaultAdapter.discovering;
                            }
                        }
                    }
                }

                ScrollView {
                    id: bluCol
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                    Column {
                        width: parent.width
                        spacing: 8
                        Repeater {
                            model: Bluetooth.defaultAdapter.devices
                            delegate: Rectangle {
                                width: bluCol.width
                                height: childrenRect.height
                                color: Theme.bg
                                border.width: 2
                                border.color: modelData.connected ? Theme.accent : Theme.border
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        if (modelData.connected)
                                            modelData.disconnect();
                                        else
                                            modelData.connect();
                                    }
                                }
                                RowLayout {
                                    height: 30
                                    width: parent.width - 30
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    TextLabel {
                                        name: modelData.connected ? "󰂱 " : "󰂯 "
                                        color: modelData.connected ? Theme.accent : Theme.text
                                    }
                                    TextLabel {
                                        name: modelData.name
                                        color: modelData.connected ? Theme.accent : Theme.text
                                        font.pixelSize: 12
                                        Layout.fillWidth: true
                                    }
                                    TextLabel {
                                        name: modelData.batteryAvailable ? (Math.trunc(modelData.battery * 100)) + "%" : ""
                                        font.pixelSize: 12
                                        color: modelData.connected ? Theme.accent : Theme.border
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

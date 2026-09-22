import Quickshell
import QtQuick
import Quickshell.Services.UPower
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: battery
    function formatSeconds(totalSeconds) {
        if (totalSeconds < 0)
            totalSeconds = 0;
        let hours = Math.floor(totalSeconds / 3600);
        let minutes = Math.floor((totalSeconds % 3600) / 60);
        let seconds = totalSeconds % 60;
        let pad = num => num.toString().padStart(2, '0');
        return `${pad(hours)}H ${pad(minutes)}M ${pad(seconds)}S`;
    }
    width: childrenRect.width
    height: childrenRect.height
    Rectangle {
        id: batWidget
        implicitWidth: childrenRect.width + 20.
        implicitHeight: 40
        color: Theme.bg
        anchors.centerIn: parent
        property var showPanel: false
        Text {
            anchors.centerIn: parent
            text: "󰁹 " + (UPower.displayDevice.ready ? Math.trunc((UPower.displayDevice.energy / UPower.displayDevice.energyCapacity) * 100) + "%" : "")
            color: (UPower.displayDevice.state == UPowerDeviceState.Charging || UPower.displayDevice.state == UPowerDeviceState.FullyCharged) ? Theme.accent : Theme.text

            font {
                pixelSize: 14
                family: Theme.font
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: parent.showPanel = !parent.showPanel
        }
        PanelWindow {
            id: bluPanel
            visible: batWidget.showPanel
            anchors.top: batWidget.bottom
            anchors.right: batWidget.right
            margins.right: 10
            margins.top: 10
            color: "#00ff0000"
            exclusionMode: ExclusionMode.Normal
            implicitWidth: 350
            implicitHeight: 180
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
                    name: "Charge"
                    value: Math.trunc((UPower.displayDevice.energy / UPower.displayDevice.energyCapacity) * 100) + "%"
                    color: Theme.text
                }
                TextLabel {
                    name: "Time to " + ((UPower.displayDevice.state == UPowerDeviceState.Charging || UPower.displayDevice.state == UPowerDeviceState.FullyCharged) ? "Full" : "Empty")
                    value: (UPower.displayDevice.state == UPowerDeviceState.FullyCharged) ? "FULL" : battery.formatSeconds(Math.max(UPower.displayDevice.timeToFull, UPower.displayDevice.timeToEmpty))
                    color: Theme.text
                }
                TextLabel {
                    name: "Status"
                    value: UPowerDeviceState.toString(UPower.displayDevice.state)
                    color: Theme.text
                }
                Rectangle {
                    Layout.fillWidth: true
                    height: 20
                    color: "#00000000"
                }
                TextLabel {
                    name: "Power Profiles: "
                    value: ""
                    color: Theme.text
                }
                RowLayout {
                    Layout.fillHeight: true
                    Layout.margins: 5
                    spacing: 10
                    Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        color: Theme.bg
                        border {
                            color: PowerProfiles.profile == PowerProfile.PowerSaver ? Theme.accent : Theme.border
                            width: 2
                        }
                        TextLabel {
                            anchors.centerIn: parent
                            name: "󰌪"
                            font.pixelSize: 16
                            color: PowerProfiles.profile == PowerProfile.PowerSaver ? Theme.accent : Theme.textMuted
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                PowerProfiles.profile = PowerProfile.PowerSaver;
                            }
                        }
                    }
                    Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        color: Theme.bg
                        border {
                            color: PowerProfiles.profile == PowerProfile.Balanced ? Theme.accent : Theme.border
                            width: 2
                        }
                        TextLabel {
                            anchors.centerIn: parent
                            name: "󰗑"
                            font.pixelSize: 16
                            color: PowerProfiles.profile == PowerProfile.Balanced ? Theme.accent : Theme.textMuted
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                PowerProfiles.profile = PowerProfile.Balanced;
                            }
                        }
                    }
                    Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        color: Theme.bg
                        border {
                            color: PowerProfiles.profile == PowerProfile.Performance ? Theme.accent : Theme.border
                            width: 2
                        }
                        TextLabel {
                            anchors.centerIn: parent
                            name: "󰓅"
                            font.pixelSize: 16
                            color: PowerProfiles.profile == PowerProfile.Performance ? Theme.accent : Theme.textMuted
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                PowerProfiles.profile = PowerProfile.Performance;
                            }
                        }
                    }
                }
            }
        }
    }
}

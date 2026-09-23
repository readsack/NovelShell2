import Quickshell
import QtQuick.Controls
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

Item {
    id: systray

    implicitWidth: childrenRect.width
    implicitHeight: childrenRect.height

    Rectangle {
        id: systrayWidget
        anchors.centerIn: parent
        implicitWidth: 40
        implicitHeight: 30
        color: "#00000000"
        property bool showPanel: false
        TextLabel {
            color: Theme.text
            name: "󱗼"
            anchors.centerIn: parent
            font.pixelSize: 14
        }
        MouseArea {
            anchors.fill: parent
            onClicked: parent.showPanel = !parent.showPanel
        }
        PanelWindow {
            id: sysPanel
            visible: systrayWidget.showPanel
            anchors.top: systrayWidget.bottom
            anchors.right: systrayWidget.right
            margins.right: 10
            margins.top: 10
            color: "#00ff0000"
            exclusionMode: ExclusionMode.Normal
            implicitWidth: 300
            implicitHeight: 300
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
                    color: Theme.text
                    name: "System Tray:"
                    Layout.preferredHeight: 25
                }
                ScrollView {
                    Layout.fillHeight: true
                    ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                    Layout.fillWidth: true
                    Column {
                        id: appColumn
                        width: parent.width
                        spacing: 8

                        Repeater {
                            model: SystemTray.items
                            delegate: Rectangle {
                                width: appColumn.width
                                height: 40
                                color: Theme.bg
                                border {
                                    width: 2
                                    color: Theme.border
                                }
                                MouseArea {
                                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                                    anchors.fill: parent
                                    onClicked: mouse => {
                                        if (mouse.button === Qt.RightButton) {
                                            itemMenu.open();
                                        } else {
                                            modelData.activate();
                                        }
                                    }
                                }
                                RowLayout {
                                    width: parent.width - 20
                                    height: 40
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.leftMargin: 10

                                    Rectangle {
                                        Layout.alignment: Qt.AlignVCenter
                                        width: 15
                                        height: 15
                                        color: Theme.bg
                                        Image {
                                            anchors.fill: parent
                                            source: modelData.icon
                                        }
                                    }
                                    TextLabel {
                                        Layout.fillWidth: true
                                        name: modelData.title != "" ? modelData.title : modelData.tooltipTitle
                                        color: Theme.text
                                        Layout.margins: 10
                                        font.pixelSize: 12
                                    }
                                    QsMenuAnchor {
                                        id: itemMenu
                                        menu: modelData.menu
                                        anchor.window: sysPanel
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

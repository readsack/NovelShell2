import Quickshell
import QtQuick
import Quickshell.Bluetooth
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire

Item {
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    width: childrenRect.width
    height: childrenRect.height
    Rectangle {
        id: auWidget
        implicitWidth: childrenRect.width + 20.
        implicitHeight: 40
        color: Theme.bg
        anchors.centerIn: parent
        property var showPanel: false
        Text {
            anchors.centerIn: parent
            text: "󰕾 " + Math.trunc(Pipewire.defaultAudioSink.audio.volume * 100) + "%"
            color: Theme.text

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
            id: auPanel

            visible: auWidget.showPanel
            anchors.top: auWidget.bottom
            anchors.right: auWidget.right
            margins.right: 10
            margins.top: 10
            property int currentPlayer: 0
            color: "#00ff0000"
            exclusionMode: ExclusionMode.Normal
            implicitWidth: 350
            implicitHeight: 350
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
                anchors.rightMargin: 10
                anchors.margins: 10
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 0
                anchors.bottom: parent.bottom
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 0
                    TextLabel {
                        name: "Volume: "
                        color: Theme.text
                    }
                    Slider {
                        id: volSlider

                        from: 0
                        to: 1
                        value: Pipewire.defaultAudioSink.audio.volume
                        onMoved: {
                            Pipewire.defaultAudioSink.audio.volume = value;
                        }

                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 330
                        Layout.preferredHeight: 5
                        background: Item {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width
                            height: 5

                            Rectangle {
                                anchors.fill: parent
                                color: Theme.bgAlt
                            }

                            Rectangle {
                                width: parent.width * volSlider.visualPosition
                                height: parent.height
                                color: Theme.text
                            }
                        }

                        handle: Rectangle {
                            x: volSlider.visualPosition * (volSlider.width - width)
                            y: (volSlider.height - height) / 2

                            width: 10
                            height: 10
                            color: Theme.accent
                        }
                    }
                }
                Item {
                    Layout.preferredHeight: 20
                }
                RowLayout {
                    implicitHeight: 40
                    Rectangle {
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 30
                        color: "#00000000"
                        border {
                            width: 2
                            color: Theme.border
                        }
                        TextLabel {
                            name: ""
                            color: Theme.text
                            anchors.centerIn: parent
                            font.bold: true
                            font.pixelSize: 14
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (auPanel.currentPlayer > 0)
                                    auPanel.currentPlayer -= 1;
                            }
                        }
                    }
                    Rectangle {
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 30
                        color: "#00000000"

                        TextLabel {
                            name: auPanel.currentPlayer + 1
                            color: Theme.text
                            anchors.centerIn: parent
                            font.bold: true
                            font.pixelSize: 16
                        }
                    }
                    Rectangle {
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 30
                        color: "#00000000"
                        border {
                            width: 2
                            color: Theme.border
                        }
                        TextLabel {
                            name: ""
                            color: Theme.text
                            anchors.centerIn: parent
                            font.bold: true
                            font.pixelSize: 14
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (auPanel.currentPlayer < Mpris.players.values.length - 1)
                                    auPanel.currentPlayer += 1;
                            }
                        }
                    }
                }
                Item {
                    Layout.preferredHeight: 5
                }
                Repeater {
                    model: Mpris.players
                    delegate: ColumnLayout {
                        Timer {
                            running: modelData.playbackState == MprisPlaybackState.Playing
                            interval: 1000
                            repeat: true
                            onTriggered: modelData.positionChanged()
                        }
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        visible: index == auPanel.currentPlayer
                        TextLabel {
                            name: "Player"
                            value: modelData.identity
                            color: Theme.text
                        }
                        Rectangle {
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 100

                            Image {
                                anchors.fill: parent
                                source: modelData.trackArtUrl
                            }
                        }
                        TextLabel {
                            name: modelData.trackTitle
                            value: ""
                            color: Theme.text
                            clip: true
                            elide: Text.ElideRight
                            Layout.preferredWidth: parent.width
                        }
                        TextLabel {
                            name: modelData.trackArtist
                            value: ""
                            color: Theme.textMuted
                        }
                        RowLayout {
                            ProgressBar {
                                id: playback_progress_bar
                                value: modelData.position / modelData.length
                                contentItem: Rectangle {
                                    implicitWidth: 330
                                    implicitHeight: 5
                                    color: Theme.border
                                    Rectangle {
                                        implicitWidth: 330 * playback_progress_bar.visualPosition
                                        implicitHeight: 5
                                        color: Theme.text
                                    }
                                }
                                background: Rectangle {
                                    color: Theme.bg
                                    implicitWidth: 200
                                }
                            }
                            TextLabel {}
                        }

                        RowLayout {
                            implicitHeight: 40
                            Rectangle {
                                Layout.preferredHeight: 30
                                Layout.preferredWidth: 30
                                color: "#00000000"
                                border {
                                    width: 2
                                    color: Theme.border
                                }
                                TextLabel {
                                    name: "󰒮"
                                    color: Theme.text
                                    anchors.centerIn: parent
                                    font.bold: true
                                    font.pixelSize: 14
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        modelData.previous();
                                    }
                                }
                            }
                            Rectangle {
                                Layout.preferredHeight: 30
                                Layout.preferredWidth: 30
                                color: "#00000000"
                                border {
                                    width: 2
                                    color: Theme.border
                                }
                                TextLabel {
                                    name: modelData.isPlaying ? "󰏤" : "󰐊"
                                    color: Theme.text
                                    anchors.centerIn: parent
                                    font.bold: true
                                    font.pixelSize: 14
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        modelData.isPlaying = !modelData.isPlaying;
                                    }
                                }
                            }
                            Rectangle {
                                Layout.preferredHeight: 30
                                Layout.preferredWidth: 30
                                color: "#00000000"
                                border {
                                    width: 2
                                    color: Theme.border
                                }
                                TextLabel {
                                    name: "󰒭"
                                    color: Theme.text
                                    anchors.centerIn: parent
                                    font.bold: true
                                    font.pixelSize: 14
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        modelData.next();
                                    }
                                }
                            }
                        }
                        Item {
                            Layout.fillHeight: true
                        }
                    }
                }
            }
        }
    }
}

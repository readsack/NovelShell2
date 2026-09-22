import Quickshell
import QtQuick

import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: clockWrapper
    property bool showCalendar: false
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Rectangle {
        id: clockWidget
        implicitHeight: 30
        implicitWidth: childrenRect.width + 20
        anchors.centerIn: parent
        color: Theme.bg
        Text {
            anchors.centerIn: parent
            text: "󰥔  " + Qt.formatDateTime(clock.date, "ddd, dd MMM  hh:mm")
            color: Theme.text
            font.pixelSize: 14
            font.family: "SpaceMono Nerd Font"
            font.bold: true
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                clockWrapper.showCalendar = !clockWrapper.showCalendar;
            }
        }
    }

    PanelWindow {
        width: 400
        height: 300
        color: "#00ffff00"
        anchors.top: clockWidget.bottom
        margins.top: 10
        exclusionMode: ExclusionMode.Normal
        visible: clockWrapper.showCalendar
        Rectangle {
            color: Theme.bg
            anchors.fill: parent
            border.color: Theme.border
            border.width: 2
        }
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10

            // Weekday header (Sun, Mon, Tue, etc.)
            DayOfWeekRow {
                locale: monthGrid.locale
                Layout.fillWidth: true
                font.pixelSize: 14

                font.family: "SpaceMono Nerd Font"
                delegate: Text {
                    color: Theme.text
                    text: model.shortName
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font {
                        family: "SpaceMono Nerd Font"
                        pixelSize: 14
                        bold: true
                    }
                }
            }

            // Grid of days for the current month
            MonthGrid {
                id: monthGrid
                month: new Date().getMonth()
                year: new Date().getFullYear()
                locale: Qt.locale("en_US")
                Layout.fillWidth: true
                Layout.fillHeight: true

                delegate: Rectangle {
                    readonly property bool isToday: {
                        let today = new Date();
                        return model.date.getDate() === today.getDate() && model.date.getMonth() === today.getMonth() && model.date.getFullYear() === today.getFullYear();
                    }
                    color: Theme.bg
                    MouseArea {
                        anchors.fill: parent
                    }
                    Text {
                        text: model.day
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        // Dim days that belong to the previous/next month
                        color: model.month === monthGrid.month ? (parent.isToday ? Theme.accent : Theme.text) : Theme.textMuted
                        font.family: "SpaceMono Nerd Font"
                        font.pixelSize: 14
                    }
                }
            }
        }
    }
}

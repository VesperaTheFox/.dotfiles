import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Text {
    anchors.fill: parent
    anchors.topMargin: 1100
    anchors.bottomMargin: 14
    anchors.leftMargin: 7
    anchors.rightMargin: 7
    text: Qt.formatDateTime(clock1.date, "hh")
    color: "#FFFAED"

    font {
        family: "IosevkaNerdFont"
        pixelSize: 25
        weight: 600
    }
}
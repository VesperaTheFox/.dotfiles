import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Text {
    anchors.fill: parent
    anchors.topMargin: 1150
    anchors.bottomMargin: 14
    anchors.leftMargin: 7
    anchors.rightMargin: 7
    text: Qt.formatDateTime(clock3.date, "ss")
    color: "#FFFAED"
        

    font {
        family: "IosevkaNerdFont"
        pixelSize: 25
        weight: 600
    }
}
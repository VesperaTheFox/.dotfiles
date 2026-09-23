import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

ShellRoot{
    PanelWindow { //LEFT PANNEL
        anchors {
            top: true
            left: true
            bottom: true
        }
        implicitHeight: 0
        implicitWidth: 38
        color: "#110C0F"

        Text {
            
            anchors.fill: parent
            anchors.topMargin: 7
            anchors.bottomMargin: 14
            anchors.leftMargin: 7
            anchors.rightMargin: 7
            text: "󱝪"
            color: "#FFFAED"

            font {
                family: "IosevkaNerdFont"
                pixelSize: 25
                weight: 600
            }
        }

        Hclock {}
        Mclock {}
        Sclock {}

        SystemClock {
            id: clock1
            precision: SystemClock.Hours
        }

        SystemClock {
            id: clock2
            precision: SystemClock.Minutes
        }

        SystemClock {
            id: clock3
            precision: SystemClock.Seconds
        }
        
    }

    PanelWindow { //TOP PANNEL
        anchors {
            top: true
            right: true
            left: true
        }

        implicitHeight: 30
        implicitWidth: 0
        color: "#110C0F"

        RowLayout {
            anchors.centerIn: parent
            
            RowLayout {
                spacing: 7
                anchors.topMargin: isActive? "5" : "12" 
                anchors.bottomMargin: isActive? "5" : "12" 

                Repeater {
                    model: 5

                    Text {
                        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                        text: ""
                        color: isActive? "#FFD4FD" : "#392D37"

                        font {
                            family: "IosevkaNerdFont"
                            pixelSize: isActive? "25" : "15"
                            weight: 600
                        }
                    }
                }
            }
        }
    }
}

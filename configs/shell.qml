import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets

ShellRoot {
    readonly property string statusBarFont: "adwaita mono"

    PanelWindow {
        id: statusbar
        height: 50
        color: "transparent"
        margins.left: 10

        SystemClock {
            id: clock
            precision: SystemClock.Seconds
        }

        BackgroundEffect.blurRegion: Region {
            item: ToplevelManager.activeToplevel.fullscreen? null : statusbar.contentItem
        }

        anchors {
            top: true
            left: true
            right: true
        }

        exclusiveZone: 50

        Rectangle {
            opacity: if (ToplevelManager.activeToplevel.fullscreen) {0} else {1}

            Behavior on opacity {
                NumberAnimation {
                    duration: 300 // Animation time in milliseconds
                    easing.type: Easing.InOutQuad // Smooth curve
                }
            }

            bottomLeftRadius: 15
            bottomRightRadius: 15
            width: parent.width - 15
            height: parent.height
            color: Qt.rgba(0.37, 0.2, 0.2, 0.1)


            IconImage {
                id: appIcon
                anchors.verticalCenter: windowName.verticalCenter
                anchors.right: windowName.left
                anchors.rightMargin: 10

                implicitWidth: 24
                implicitHeight: 24
                
                visible: ToplevelManager.activeToplevel && ToplevelManager.activeToplevel.appId ? true : false

                source: visible ? Quickshell.iconPath(ToplevelManager.activeToplevel.appId, true) : ""
            }
            Text {
                id: windowName
                font.family: statusBarFont
                anchors.centerIn: parent
                text: ToplevelManager.activeToplevel ? ToplevelManager.activeToplevel.title : "Desktop"
                color: "white"
                font.pointSize: 14
            }
            Text {
                id: time
                font.family: statusBarFont
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 25
                text: Qt.formatDateTime(clock.date, "hh:mm")
                color: "white"
                font.pointSize: 14
            }
        }
    }
}

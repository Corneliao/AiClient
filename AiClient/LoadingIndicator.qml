import QtQuick
import Qt5Compat.GraphicalEffects

Item {
    id: loading_

    Rectangle {
        id: rect

        border.width: width / 6
        color: Qt.rgba(0, 0, 0, 0)
        height: parent.height
        radius: width / 2
        visible: false
        width: parent.width
    }
    ConicalGradient {
        height: rect.height
        source: rect
        width: rect.width

        gradient: Gradient {
            GradientStop {
                color: "#bca8e5"
                position: 0.0
            }
            GradientStop {
                color: "#5f4f83"
                position: 1.0
            }
        }
        RotationAnimation on rotation {
            duration: 800
            from: 0
            loops: Animation.Infinite
            to: 360
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            color: "#5f4f83"
            height: rect.border.width
            radius: width / 2
            width: rect.border.width
        }
    }
}
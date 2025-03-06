import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

Rectangle {
    radius: 10
    border.color: Qt.color("lightgray")
    border.width: 1
    property alias messageInputItem: message_input
    TextField {
        id: message_input
        anchors.verticalCenter: parent.verticalCenter

        width: parent.width - 5
        height: parent.height - 2
        background: Rectangle {
            color: Qt.color("transparent")
        }
    }
}

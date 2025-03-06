import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    property int index
    property alias userMessage: label_.text
    RowLayout {
        anchors.fill: parent
        Loader {
            Layout.fillWidth: true
        }

        Rectangle {
            Layout.preferredHeight: label_.contentHeight + 10
            Layout.preferredWidth: label_.contentWidth + 20
            radius: 10
            color: Qt.color("#eff6ff")
            Label {
                id: label_
                anchors.centerIn: parent
                font.pixelSize: 16
                color: Qt.color("black")
            }
        }
    }
}

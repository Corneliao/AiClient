import QtQuick
import QtQuick.Controls
import QtQml
import QtQuick.Controls.Basic

Item {
    ScrollView {
        anchors.fill: parent
        TextArea {
            id: area_
            wrapMode: TextArea.WrapAnywhere
            text: "test"
        }
    }
    Timer {
        id: timer_
        repeat: true
        interval: 500
        onTriggered: {
            area_.text = area_.text + area_.text
        }
    }
}

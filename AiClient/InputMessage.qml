import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import com.AiClient

Rectangle {
    radius: 20
    border.color: Qt.color("lightgray")
    border.width: 1
    color: Qt.color("#f3f4f6")
    property alias messageInputItem: message_input
    ColumnLayout {
        anchors.fill: parent
        TextField {
            id: message_input

            placeholderText: "给DeepSeek发消息"
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.preferredWidth: parent.width - 5
            Layout.fillHeight: true
            font.pixelSize: 16
            background: Rectangle {
                color: Qt.color("transparent")
            }
        }

        RowLayout {
            spacing: 10
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.bottomMargin: 8
            Rectangle {
                id: r1
                property bool isChecked: false
                Layout.preferredWidth: 90
                Layout.preferredHeight: 35
                radius: 20
                color: isChecked ? Qt.color("#") : Qt.color("white")
                border.color: Qt.color("lightgray")
                border.width: 1
                Label {
                    id: r1_text
                    text: "深度思考(R1)"
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        cursorShape = Qt.PointingHandCursor
                        if (!r1.isChecked)
                            r1.color = Qt.rgba(0 / 255, 0 / 255,
                                               0 / 255, 20 / 255)
                    }
                    onExited: {
                        if (!r1.isChecked)
                            r1.color = Qt.color("white")
                    }
                    onClicked: {
                        r1.isChecked = !r1.isChecked
                        if (r1.isChecked) {
                            AiClient.setModel("deepseek-reasoner")
                            r1.color = Qt.color("#90cbfb")
                            r1_text.color = Qt.color("blue")
                        } else {
                            AiClient.setModel("deepseek-chat")
                            r1.color = Qt.color("white")
                            r1_text.color = Qt.color("black")
                        }
                    }
                }
            }
            Rectangle {
                id: online
                property bool isChecked: false
                Layout.preferredWidth: 80
                Layout.preferredHeight: 35
                radius: 20
                color: isChecked ? Qt.color("#d2e1f4") : Qt.color("white")
                border.color: Qt.color("lightgray")
                border.width: 1
                Label {
                    id: online_text
                    text: "联网搜索"
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        cursorShape = Qt.PointingHandCursor
                        if (!online.isChecked)
                            online.color = Qt.rgba(0 / 255, 0 / 255,
                                                   0 / 255, 20 / 255)
                    }
                    onExited: {
                        if (!online.isChecked)
                            online.color = Qt.color("white")
                    }
                    onClicked: {
                        online.isChecked = !online.isChecked
                        if (online.isChecked) {
                            online.color = Qt.color("#90cbfb")
                            online_text.color = Qt.color("blue")
                        } else {
                            online.color = Qt.color("white")
                            online_text.color = Qt.color("black")
                        }
                    }
                }
            }
            Loader {
                Layout.fillWidth: true
            }
            Rectangle {

                Layout.preferredHeight: 34
                Layout.preferredWidth: 34
                color: message_input.text.length <= 0 ? Qt.rgba(
                                                            0 / 255, 0 / 255,
                                                            0 / 255,
                                                            40 / 255) : Qt.color(
                                                            "#4d6bfe")
                radius: 34 / 2
                Image {
                    source: Qt.url("qrc:/res/ico/LetsIconsSend.svg")
                    width: 20
                    height: 20
                    anchors.centerIn: parent
                    mipmap: true
                    smooth: true
                    antialiasing: true
                }
            }
        }
    }
}

import QtQuick
import QtQuick.Controls
import QtQml
import QtQuick.Controls.Basic
import com.AiClient
import com.Global
import QtQuick.Layouts

Item {
    id: systemItem
    height: 0

    property int index

    signal itemHeightChanged(int height)

    Connections {
        target: AiClient
        function onReceivedDelta(content) {
            if (systemItem.index === Properties.currentSystemReuqestIndex) {
                var endPosition = area_.text.length
                area_.insert(endPosition, content)
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 15
        Rectangle {
            Layout.preferredHeight: 35
            Layout.preferredWidth: 35
            Layout.alignment: Qt.AlignTop
            radius: 40 / 2
            border.color: Qt.color("#cfe0ff")
            border.width: 1
            Image {
                id: ico_
                source: Qt.url("qrc:/res/ico/deepseek.svg")
                width: 20
                height: 20
                anchors.centerIn: parent
                mipmap: true
                smooth: true
                antialiasing: true
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                color: Qt.color("lightgray")
                radius: 10
                Layout.preferredWidth: 80
                Layout.preferredHeight: 30
                Label {
                    text: "思考中..."
                    anchors.centerIn: parent
                }
            }

            RowLayout {

                Rectangle {
                    color: Qt.color("lightgray")
                    Layout.preferredWidth: 2
                    radius: 3
                    Layout.preferredHeight: area_.height
                }

                Rectangle {
                    color: Qt.color("white")
                    radius: 10
                    Layout.preferredHeight: area_.height + 10
                    Layout.fillWidth: true
                    TextArea {
                        id: area_
                        wrapMode: TextArea.WrapAnywhere
                        width: parent.width
                        height: Math.max(
                                    0,
                                    contentHeight + topPadding + bottomPadding)
                        color: Qt.color("#696969")
                        font.pixelSize: 17
                        onHeightChanged: {
                            systemItem.height = ico_.height + area_.height + 30 + indication_.height
                            systemItem.itemHeightChanged(systemItem.height)
                        }
                    }
                }
            }
            LoadingIndicator {
                id: indication_
                Layout.preferredHeight: 20
                Layout.preferredWidth: 20
            }
        }
        Loader {
            Layout.fillWidth: true
        }
    }
}

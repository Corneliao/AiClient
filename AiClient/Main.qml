import QtQuick
import QtQuick.Controls
import com.AiClient
import QtQml
import QtQuick.Layouts

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    AiClient {
        id: ai
        Component.onCompleted: {

            // ai.sendRequest("介绍一下自己")
        }
    }

    Connections {
        target: ai
        function onReceivedDelta(content) {
            var endPosition = text_.text.length
            text_.insert(endPosition, content)
        }
    }

    ListModel {
        id: itemModel
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        ListView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            clip: true
            model: itemModel
            delegate: Loader {
                required property string type
                required property string message
                width: ListView.view.width
                height: type === "user" ? 40 : 60
                source: type === "user" ? Qt.url("UserMessageItem.qml") : ""
                onLoaded: {
                    item.userMessage = message
                }
            }
        }

        InputMessage {
            Layout.preferredWidth: parent.width - 20
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 40
            Keys.onReturnPressed: {
                if (messageInputItem.text.length <= 0)
                    return
                itemModel.append({
                                     "type": "user",
                                     "message": messageInputItem.text
                                 })
                messageInputItem.clear()
            }
        }
    }
}

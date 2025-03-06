import QtQuick
import QtQuick.Controls
import com.AiClient
import QtQml
import QtQuick.Layouts
import com.Global
import com.FramelessWindow

FramelessWindow {
    id: mainWindow
    width: 1075
    height: 750
    Component.onCompleted: {
        mainWindow.moveCenter()
    }

    ListModel {
        id: itemModel
    }

    Timer {
        id: scrollToButtom
        repeat: false
        interval: 20
        onTriggered: {
            view_.positionViewAtEnd()
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: 30
        anchors.bottomMargin: 15
        anchors.rightMargin: 15
        anchors.topMargin: 15
        ListView {
            id: view_
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            clip: true
            model: itemModel
            delegate: Loader {

                id: loader_
                function test(height) {
                    loader_.height = height
                    scrollToButtom.start()
                }

                required property string type
                required property string message
                required property int index
                width: ListView.view.width
                asynchronous: true
                height: type === "User" ? 40 : 0
                source: type === "User" ? Qt.url(
                                              "UserMessageItem.qml") : Qt.url(
                                              "SystemMessageItem.qml")
                onLoaded: {
                    item.index = index
                    if (type === "User") {
                        item.userMessage = message
                    }
                    if (type === "System") {
                        item.itemHeightChanged.connect(test)
                    }
                }
            }
        }

        Loader {
            Layout.preferredHeight: 40
        }

        InputMessage {
            Layout.preferredWidth: parent.width - 20
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 40
            Keys.onReturnPressed: {
                if (messageInputItem.text.length <= 0)
                    return
                itemModel.append({
                                     "type": "User",
                                     "message": messageInputItem.text
                                 })
                itemModel.append({
                                     "type": "System",
                                     "message": "思考中..."
                                 })
                Properties.currentSystemReuqestIndex = view_.count - 1
                AiClient.sendRequest(messageInputItem.text)
                messageInputItem.clear()
            }
        }
    }
}

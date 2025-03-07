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
        mainWindow.setWindowTitleBar(title_bar)
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
        function adjustWindowMargins(left_margin, top_margin, right_margin, bottom_margin) {
            anchors.leftMargin = left_margin + 30
            anchors.topMargin = top_margin
            anchors.rightMargin = right_margin + 30
            anchors.bottomMargin = bottom_margin + 25
        }

        anchors.leftMargin: 30
        anchors.rightMargin: 30
        anchors.bottomMargin: 25
        anchors.fill: parent

        TitleBar {
            id: title_bar
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignTop
        }

        ListView {
            id: view_
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            clip: true
            cacheBuffer: -1
            model: itemModel
            ScrollBar.vertical: ScrollBar {}
            ///ScrollIndicator.vertical: ScrollIndicator {}
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
                height: type === "User" ? 40 : 110
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
            Layout.preferredHeight: 100
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
                scrollToButtom.start()
                messageInputItem.clear()
            }
        }
    }
}

// 主窗口

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id:app
    // width: 1100
    // height: 900
    // Layout.fillHeight: true
    // Layout.fillWidth: true
    minimumHeight: 650
    minimumWidth: 920
    visible: true
    property alias footerText: statusText.text

    Content{
        id:content
    }

    footer:
    Rectangle{
        id: foot
        visible: true
        width: app.width
        height: 20

        Text{
            id:statusText
            text: ""
            color:"black"
            anchors.left: parent.left
            font.pixelSize: 12
            font.weight: Font.Thin
        }
    }
}

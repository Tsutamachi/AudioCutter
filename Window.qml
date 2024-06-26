// Window.qml
// 主窗口

/* 问题：
 Content.qml 里面的 MyRadioButton 的 anchors 有点问题
 所有功能不能使用：打开文件、播放视频、暂停视频=>需要重新找到相关定位
 */

// 可以qml中调用 VideoEdit 类了
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import se.qt.videoEditing

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

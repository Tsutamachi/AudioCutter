// 主窗口

/* 问题：
  Content.qml 里面的 MyRadioButton 的 anchors 有点问题
  所有功能不能使用：打开文件、播放视频、暂停视频=>需要重新找到相关定位
  */
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

    Content{
        id:content
    }
}

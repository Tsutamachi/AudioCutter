// 这是个部分ui组件 ，圆形按钮
// MyRadioButton.qml
import QtQuick
import QtQuick.Controls


Rectangle {
    id:myRaBton
    width: radius*2
    height: radius*2
    radius: radius
    anchors.margins: 50
    color: "white"
    opacity: 0.5

    required property bool enable//用于做剪辑开始、结束的同步
    property url imgSource
    Image {
        id: _img
        source:imgSource
        // source: "file:///root/Cutter/AudioCutter/icons/open.svg"
        anchors.fill: parent
        opacity: enable == true? 1: 0.5
    }
    border.color: "black"
    border.width: 1

    HoverHandler{
        onHoveredChanged: ()=>{
                              myRaBton.opacity=  hovered? 1: 0.5
                          }
    }
}


// 圆型按钮
import QtQuick
import QtQuick.Controls


Rectangle {
    id:myRaBton
    width: radius*2
    height: radius*2
    radius: radius
    color: "grey"
    opacity: 0.8
    required property string text
    required property bool enable//用于做剪辑开始结束的顺序
    Text{
        id:txt
        text: myRaBton.text
        anchors.centerIn: parent
        font.pixelSize: 25
        opacity: enable == true? 1: 0.5
    }

    HoverHandler{
        onHoveredChanged: ()=>{
                              myRaBton.opacity=  hovered? 1: 0.8
                          }
    }
}


// 圆型按钮
import QtQuick
import QtQuick.Controls


Rectangle {
    id:myRaBton
    width: radius*2
    height: radius*2
    radius: radius
    color: "grey"
    required property string text
    Text{
        id:txt
        text: myRaBton.text
        anchors.centerIn: parent
        font.pixelSize: 25
    }



    HoverHandler{
        onEntered: {
            myRaBton.opacity = 1.0 // 鼠标进入时，透明度为1.0
        }
        onExited: {
            myRaBton.opacity = 0.8 // 鼠标离开时，透明度变为0.8
        }
    }

}


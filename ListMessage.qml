import QtQuick
import QtQuick.Controls

Button{
    id:btn
    property color textColor:"black"
    property color defaultColor:"gray"
    //使用Qt.darker()根据颜色计算一个更暗的颜色
    property color pressedColor:Qt.darker(defaultColor,1.5)
    text:qsTr("素材列表")
    opacity:0.5

    //设置按钮的内容为一个文本内容
    contentItem:Text{
        text:btn.text
        color:btn.textColor
        font.family: "雅黑"
        font.pixelSize:23
        font.weight: Font.Thin
        //设置字体居中
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background:Rectangle{
        implicitHeight: 40
        implicitWidth:85
        radius: 5
        color:btn.down?btn.pressedColor:btn.defaultColor
    }




}

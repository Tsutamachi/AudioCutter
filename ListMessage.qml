import QtQuick
import QtQuick.Controls

Button{
    id:btn
    opacity:0.5

    //设置按钮的内容为一个文本内容
    contentItem:Text{
        text:qsTr("素材列表")
        color:"black"
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
        //使用Qt.darker()根据颜色计算一个更暗的颜色
        color:btn.hovered?Qt.darker("gray",1.5):"gray"
    }




}

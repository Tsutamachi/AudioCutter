// MySquareButton.qml
// 这是个部分ui组件，方形按钮
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Rectangle{
    id:mySqBton
    required property string _text
    required property url _imgSource
    radius: 30
    // color: "grey"

    Button{
        id:_button
        width: parent.width
        height: parent.height

        //按钮内容
        contentItem:Rectangle{
            color:"transparent"
            Image{
                // source:"/root/add.svg"
                source: _imgSource
                anchors.right: txt.left
                width:20
                height:20
            }
            Text{
                id:txt
                text: mySqBton._text
                color:"white"
                font.bold:true
                // 只有他能定位到中间
                anchors.centerIn: parent
                // Layout.alignment: parent.Center
                // Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
        }
        //设置背景颜色
        background:Rectangle{
            radius:5
            color:_button.down?(Qt.darker("gray",1.5)):"gray"
        }
    }

}


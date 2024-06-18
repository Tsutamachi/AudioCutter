import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ApplicationWindow {
    width: 1300
    height: 920
    visible: true
    // minimumWidth: 1480;//界面最小宽
    // minimumHeight: 900;//界面最小高
    // visible: true
    title: qsTr("cutter")

    //上面的主体部分
    Rectangle{
        id:main
        color:"red"
        x:20
        y:20
        width: 1280
        height: 600

        //画面显示
        Rectangle{
            id: rect1
            // color: "black"
            width: 1000
            height: 600
            visible: true
            border.width: 3
            Content{
                id:content
            }

        }

        //剪切下来的片段
        Rectangle{
            id: rect2
            color: "grey"
            width: 250
            height: 600
            border.width: 3
            anchors.left:rect1.right

        }
    }

    //进度显示
    Rectangle{
        id: rect3
        color:"yellow"
        width: 1200
        height: 120
        border.width: 3
        anchors.top: main.bottom
        anchors.horizontalCenter: main.horizontalCenter
    }

    //Button
    Rectangle{
        id: rect4
        color:"blue"
        border.width: 3
        width: 1200
        height: 110
        anchors.top: rect3.bottom
        anchors.horizontalCenter: main.horizontalCenter
    }

    //状态栏
    Rectangle{
        id: rect5
        color:"white"
        width: 1200
        height: 20
        border.width: 3
        anchors.top: rect4.bottom
        anchors.horizontalCenter: main.horizontalCenter
    }
}

// Window.qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtMultimedia
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
        x:20;y:20
        width: 1280;height: 600

        //画面显示
        Rectangle{
            id: rect1
            color: "black"
            width: 1000;height: 600
            visible: true
            border.width: 3

            // 播放视频文件
            Content{
                id:content
                anchors.fill: parent
                // 导入文件
                audioSource:"file:///root/tmp/Linux Directories Explained in 100 Seconds.mp4"
                // audioSource: "file:///root/tmp/Three.Little.Pigs.1933.avi"
                // audioSource: "file:///root/tmp/Nathan Evans - Wellerman (Sea Shanty) .mkv"
            }
        }

        //剪切下来的片段
        Rectangle{
            id: rect2
            color: "white"
            width: 250
            height: 600
            border.width: 3
            anchors.left:rect1.right

            ListMessage{
                width:parent.width
                anchors.topMargin:10
                anchors.top: parent.top
            }

            Buttons1{
                id:_buttons1
                anchors.bottom: parent.bottom
            }
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
        id: _buttons2
        width: 1200
        height: 120
        anchors.top: rect3.bottom
        anchors.horizontalCenter: main.horizontalCenter
        anchors.topMargin: 10
        anchors.bottomMargin: 10

        Buttons2{
            id:buttons2
        }

    }

    //状态栏
    Rectangle{
        id: rect5
        color:"white"
        width: 1200
        height: 20
        border.width: 3
        anchors.top: _buttons2.bottom
        anchors.horizontalCenter: main.horizontalCenter
    }


}

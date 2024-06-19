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

            // 播放视频文件
            Content{
                id:content
                anchors.fill: parent
                // 导入文件
                // audioSource:"file:///root/tmp/Linux Directories Explained in 100 Seconds.mp4"
                audioSource: "file:////root/tmp/Three.Little.Pigs.1933.avi"
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
    RowLayout{
        id: rLaout
        width: 1200
        height: 110
        anchors.top: rect3.bottom
        anchors.horizontalCenter: main.horizontalCenter
        MyRadioButton{
            id:rbtn1
            text: "打开文件"
            radius: 50
            // Layout.rightMargin: 5
            anchors.rightMargin: rbtn2.left
        }
        MyRadioButton{
            id:rbtn2
            radius: 50
            text: "打开文件"
            anchors.leftMargin: 5
        }
    }

    //状态栏
    Rectangle{
        id: rect5
        color:"white"
        width: 1200
        height: 20
        border.width: 3
        anchors.top: rLaout.bottom
        anchors.horizontalCenter: main.horizontalCenter
    }

}

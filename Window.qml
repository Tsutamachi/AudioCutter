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
            color: "white"
            width: 250
            height: 600
            border.width: 3
            anchors.left:rect1.right

            MySqureButton{
                text:qsTr("素材列表")
                textColor:"black"
                defaultColor:"gray"
                opacity:0.5
                anchors.topMargin:20
                width:rect2.width
            }
            Button{
                id:leftButton
                anchors{
                    bottom: parent.bottom
                    left:parent.left
                    margins:10
                }
                width:100
                height:40

                //按钮内容
                contentItem:Column{
                    Image{
                        source:"/root/加.svg"
                        width:20
                        height:20
                    }
                    Text{
                        text:"ADD"
                        color:"white"
                        font.bold:true
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                //设置背景颜色
                background:Rectangle{
                    radius:5
                    color:leftButton.down?(Qt.darker("gray",1.5)):"gray"
                }

            }
            Button{
                id:rightButton
                anchors{
                    bottom:parent.bottom
                    right:parent.right
                    margins:10
                }
                width:100
                height:40
                contentItem:Row{
                    anchors.right:parent.right
                    Text{
                        text:"REMOVE"
                        color:"white"
                        font.bold:true
                        anchors.verticalCenter:parent.verticalCenter
                    }
                    Image{
                        source:"/root/减.svg"
                        width:20
                        height: 20
                        anchors.verticalCenter: parent.verticalCenter
                    }

                }
                //设置背景颜色
                background:Rectangle{
                    color:rightButton.down?(Qt.darker("gray",1.5)):"gray"
                    radius:5
                }
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
        id: _buttons
        width: 1200
        height: 120
        anchors.top: rect3.bottom
        anchors.horizontalCenter: main.horizontalCenter
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        property int mar: 50
        // color:"red"

        Rectangle{
            id: combibuttons
            // color:"black"
            width: 700
            height: 100
            anchors.centerIn: _buttons

            MyRadioButton{
                id:_openfile
                text: "打开文件"
                enable:true
                radius: 50
                // Layout.rightMargin: 5//用Layout就要用RowLayout,不用anchors
                anchors.margins: _buttons.mar
            }
            MyRadioButton{
                id:_play
                text: "播放视频"
                enable:true
                radius: 50
                anchors.margins: _buttons.mar
                anchors.left: _openfile.right
            }
            MyRadioButton{
                id:_startcut
                radius: 50
                text: "剪辑起点"
                enable:true
                anchors.margins: _buttons.mar
                anchors.left: _play.right
                TapHandler{
                    onTapped: ()=>{_endcut.enable =true}
                }
            }
            MyRadioButton{
                id:_endcut
                radius: 50
                text: "剪辑终点"
                enable:false
                anchors.margins: _buttons.mar
                anchors.left: _startcut.right
                TapHandler{
                    onTapped: ()=>{_endcut.enable = !_endcut.enable}
                }
            }
            MyRadioButton{
                id:_save
                radius: 50
                text: "保存文件"
                enable:true
                anchors.margins: _buttons.mar
                anchors.left: _endcut.right
            }
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

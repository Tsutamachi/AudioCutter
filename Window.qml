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
            color: "black"
            width: 1000
            height: 600
            visible: true
            border.width: 3

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

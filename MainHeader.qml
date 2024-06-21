import QtQuick
Item {
    id:_item
    width: 1100
    height: 900
    visible: true
    // minimumWidth: 1480;//界面最小宽
    // minimumHeight: 900;//界面最小高
    // title: qsTr("cutter")
    property alias dialogs: _dialogs

    Actions{
    id:_action
    }
    //上面的主体部分
    Rectangle{
        id:main
        x:parent.width*0.01; y:parent.height*0.01
        width: parent.width
        height: parent.height*0.65

        //画面显示
        Rectangle{
            id: rect1
            color: "black"
            width: parent.width*0.7;height: main.height
            visible: true
            border.width: 3

            // 播放视频文件
            Content{
                id:content
                anchors.fill: parent
                // 导入文件
                // audioSource:"file:///root/tmp/Linux Directories Explained in 100 Seconds.mp4"
                // audioSource: "file:///root/tmp/Three.Little.Pigs.1933.avi"
                // audioSource: "file:///root/tmp/Nathan Evans - Wellerman (Sea Shanty) .mkv"
            }
        }
    }

        //剪切下来的片段
        Rectangle{
            id: rect2
            color: "white"
            width: rect1.width*0.3
            height: rect1.height
            border.width: 3
            anchors.left:rect1.right

            ListMessage{
                width:parent.width
                anchors.topMargin:10
                anchors.top: parent.top
            }

            Loader {
                    id: loader
                    source: "Actions.qml" // 加载 SecondaryWindow.qml

                    // 当 Loader 加载完成后，将其内容添加到当前界面中
                    onLoaded: {
                        // 获取加载的界面组件
                        var secondaryWindow = loader.content;

                        // 选择特定的元素
                        var specificElement = secondaryWindow.findChild("_btn2");

                        // 将选择的元素添加到当前界面
                        rect2.addChild(specificElement)
                    }
                }



        }

    //进度显示
    Rectangle{
        id: rect3
        color:"yellow"
        width: rect1.width+rect2.width
        height: _item.height*0.1
        border.width: 3
        anchors.top: main.bottom
        x:parent.width*0.01
    }

    //Button
    Rectangle{
        id: _buttons2
        width: rect1.width+rect2.width
        height: rect3.height*1.1
        x:parent.width*0.01

        anchors.top: rect3.bottom
        anchors.topMargin: 10
        anchors.bottomMargin: 10

        // Buttons2{
        //     id:buttons2
        // }

    }

    //状态栏
    Rectangle{
        id: rect5
        // color:"red"
        width: rect1.width+rect2.width
        height: _item.width*0.02
        x:parent.width*0.01
        anchors.top: _buttons2.bottom

        Text{
            id:statusText
            text: ""
            anchors.left: parent.left
            font.pixelSize: 12
            font.weight: Font.Thin
        }
    }



    Dialogs{
        id:_dialogs
        openfile.onAccepted:{
            Controller.setfilepath()
        }
    }

}

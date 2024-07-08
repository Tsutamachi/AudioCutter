// Content.qml
// 所有ui在这里面,属于表现层

import "Cutter.js" as Controller
import QtQuick
import QtMultimedia
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    id:_item
    visible: true
    anchors.fill: parent
    Layout.fillHeight: true
    Layout.fillWidth: true
    // color:"grey"

    property alias maincontent: _mainContent
    // property alias startcut: _startcut

    //画面显示
    Rectangle{
        id:main
        x:parent.width*0.01; y:parent.height*0.01
        width: parent.width
        height: parent.height*0.65
        Layout.fillWidth: true
        // color:"red"

        //视频显示
        Rectangle{
            id: rect1
            color: "black"
            width: parent.width*0.75;height: main.height

            Layout.fillHeight: true
            Layout.fillWidth: true
            visible: true
            border.width: 3


            // 显示主体部分
            MainContent{
                id:_mainContent
                anchors.fill: parent
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            //剪切下来的片段
            Rectangle{
                id: rect2
                color: "white"
                width: rect1.width*0.3
                height: rect1.height
                border.width: 3
                anchors.left:parent.right
                Layout.fillHeight: true
                Layout.fillWidth: true

                Button{
                    id:listmsg
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
                        radius: 5
                        //使用Qt.darker()根据颜色计算一个更暗的颜色
                        color:listmsg.hovered?Qt.darker("gray",1.5):"gray"
                        z:2
                    }
                    width:rect2.width
                    anchors.topMargin:10
                    anchors.top: rect2.top
                    z:1
                }
                // 列表视图项
                ListView{
                    id:listview
                    width: rect2.width
                    height: (rect2.height-_add.height)
                    anchors.top: listmsg.bottom
                    anchors.bottom: _add.top

                    // model: 5 // 规定一个列表包含5个项目
                    model: _mainContent.videoEdit.videoPaths
                    spacing: 2
                    delegate: Rectangle{
                        width: listview.width
                        height: listview.height*0.194
                        color: "transparent"
                        Rectangle { // 容器矩形，用于添加边距
                            width: parent.width - 6 // 减去左右边距
                            height: parent.height - 6 // 减去上下边距
                            anchors.centerIn: parent
                            color: "lightblue"
                            // 放路径
                            Text{
                                // text: modelData
                                text: "Chapter:" + (index+1)
                                color: "white"
                            }
                        }
                    }
                }

                MySquareButton{
                    id:_add
                    width: rect2.width*0.45
                    height: _add.width*0.3
                    _imgSource:"qrc:/icons/add.png"
                    _text:"ADD"
                    HoverHandler{onHoveredChanged: ()=>{footerText=hovered?"Add one or more files to an existing project or an empty list if you are only joining files":""}}
                    anchors{
                        bottom: parent.bottom
                        left: parent.left
                        margins: 10
                    }
                    button.onClicked: {
                        Controller.addTriggered()
                        console.log("tapped")
                    }
                }

                MySquareButton{
                    id:_remove
                    width: _add.width
                    height: _add.width*0.3
                    _text: "REMOVE"
                    focus: true
                    _imgSource:"qrc:/icons/remove.svg"
                    HoverHandler{
                        onHoveredChanged: ()=>{
                                              statusText.text=hovered?"Remove clips from your index":""
                                          }
                    }
                    button.onClicked: {
                        Controller.removeTriggered()
                        console.log("tapped")
                    }
                    anchors{
                        bottom: parent.bottom
                        right: parent.right
                        margins: 10
                    }
                }
            }
        }


    }

    //进度显示
    Rectangle{
        id: rect3
        color:"yellow"
        width: rect1.width+rect2.width
        // height: _item.height*0.1
        height:100
        border.width: 3
        anchors.top: main.bottom
        x:parent.width*0.01

        //进度条背景
        Image{
            id:background
            width: parent.width
            height: parent.height
            source: "qrc:/icons/film.jpg"
            fillMode: Image.TileHorizontally
            // Repeater
        }

        Slider{
            id:slider
            width: parent.width
            height: parent.height
            // anchors.bottom: videoItem.bottom
            from:0
            to: maincontent.player.duration
            value: maincontent.player.position


            Timer {
                id: positionUpdateTimer
                interval: 500//0.5s更新一次
                repeat: true
                running:true
                onTriggered: { maincontent.player.setPosition(slider.value);}
            }
            // onValueChanged: {
            //     if (slider.dragging) {
            //         maincontent.player.setPosition(slider.value)
            //     }
            // }
            onValueChanged: {
                if (slider.dragging) {
                    positionUpdateTimer.running = false
                    maincontent.player.setPosition(slider.value)
                } else {
                    positionUpdateTimer.running = true
                }
            }
        }
        //进度指示针//位置有问题
        Rectangle{
            id:finger
            width: 5
            color:"black"
            height:rect3.height+5
            z:1
            x: slider.value
        }
    }

    //Button
    Rectangle{
        id: _buttons2
        width: rect1.width+rect2.width
        height:_openfile.height*1.2
        x:main.x

        anchors.top: rect3.bottom
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.left: main.left

        MyRadioButton{
            id: _openfile
            enable:true
            radius: 35
            imgSource:  "qrc:/icons/open.png"
            // imgSource:"file:///root/Cut/AudioCutter/icons/open.png"
            // 定位需要修改！！！
            anchors.left: _buttons2.left
            TapHandler{onTapped: ()=>{Controller.openfileTriggered()}}
            HoverHandler{onHoveredChanged: ()=>{footerText=hovered?"Open and load a media file to begin":""} }

        }
        Rectangle{
            id:_open1
            width: _openfile.width*0.63
            height:_openfile.height*0.45
            anchors.left: _openfile.right
            anchors.top: _buttons2.verticalCenter
            // color: "red"
            Text {
                id: txt1
                text: "Open\nMedia"
                color: "grey"
            }
        }

        MyRadioButton{
            id: _play
            imgSource: _mainContent.player.playbackState === MediaPlayer.PlayingState?"qrc:/icons/play.svg":"qrc:/icons/pause.svg"
            enable:true
            radius: _openfile.radius
            // 定位问题，同下
            // anchors.margins: rect3.height*1.5
            anchors.left: _open1.right
            TapHandler{onTapped: ()=>{//这里用player（MainContent中的组建）替换MediaPlayer会报错  Why？
                                     _mainContent.player.playbackRate === MediaPlayer.PlayingState?_mainContent.player.pause():_mainContent.player.play()
                                     _mainContent.player.playbackRate = !_mainContent.player.playbackRate
                                 }
            }
            HoverHandler{onHoveredChanged: ()=>{footerText=hovered?"Play currently loaded media file":""}}
        }
        Rectangle{
            id:_play1
            width:_open1.width
            height:_open1.height
            anchors.left: _play.right
            anchors.top: _buttons2.verticalCenter
            Text {
                id: txt2
                text: _mainContent.player.playing?"Pause \n Media":"Play \nMedia"
                color: "grey"
            }
        }

        MyRadioButton{
            property real startTime;//开始剪辑时间
            property string path;
            path:Controller.returnOpenfilePath()
            id: _startcut
            enable:true
            radius: _openfile.radius
            imgSource: "qrc:/icons/startclip.svg"
            // anchors.margins: rect3.height
            anchors.left: _play1.right
            TapHandler{
                onTapped: ()=>{Controller.startcutTriggered()}}

            HoverHandler{
                onHoveredChanged: ()=>{
                                      if(_startcut.enable)
                                      footerText=hovered?"Start a new clip from the current timeline position":""
                                  }
            }
        }
        Rectangle{
            id:_start1
            width:_open1.width
            height:_open1.height
            anchors.left: _startcut.right
            anchors.top: _buttons2.verticalCenter
            Text {
                id: txt3
                text: "Start\nClip"
                color: "grey"
            }
        }

        MyRadioButton{
            property real endTime;//结束时间
            id: _endcut
            enable:false
            radius: _openfile.radius
            // anchors.margins: rect3.height
            imgSource: "qrc:/icons/endclip.svg"
            anchors.left: _start1.right
            TapHandler{onTapped: ()=>{
                                     Controller.endcutTriggered()
                                     _mainContent.videoEdit.videocut(_startcut.path,_startcut.path,_startcut.startTime/1000,_endcut.endTime/1000)
                                 }
            }
            HoverHandler{
                onHoveredChanged: ()=>{
                                      if(_endcut.enable)
                                      footerText=hovered?"End a new clip at the current timeline position":""
                                  }
            }
        }
        Rectangle{
            id:_end1
            width:_open1.width
            height:_open1.height
            anchors.left: _endcut.right
            anchors.top: _buttons2.verticalCenter
            Text {
                id: txt4
                text: "End\nClip"
                color: "grey"
            }
        }

        MyRadioButton{
            id: _save
            radius: _openfile.radius
            enable:true
            // anchors.margins:  rect3.height
            imgSource: "qrc:/icons/save.png"
            anchors.left: _end1.right
            TapHandler{onTapped: ()=>{Controller.saveTri2ggered()}}
            HoverHandler{onHoveredChanged: ()=>{footerText=hovered?"Save clips to a new media file":""}}
        }
        Rectangle{
            id:_save1
            width:_open1.width
            height:_open1.height
            anchors.left: _save.right
            anchors.top: _buttons2.verticalCenter
            Text {
                id: txt5
                text: "Save\nMedia"
                color: "grey"
            }
        }
    }


}

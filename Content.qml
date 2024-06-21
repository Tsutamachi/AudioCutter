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

    property alias maincontent: _mainContent
    Rectangle{
        id:main
        x:parent.width*0.01; y:parent.height*0.01
        width: parent.width
        height: parent.height*0.65
        Layout.fillWidth: true
        // color:"red"

        //画面显示
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

                ListMessage{
                    width:rect2.width
                    anchors.topMargin:10
                    anchors.top: rect2.top
                }
                MySquareButton{
                    id:_add
                    width: rect2.width*0.45
                    height: _add.width*0.3
                    _imgSource:"qrc:/icons/add.svg"
                    _text:"ADD"
                    HoverHandler{
                        onHoveredChanged: ()=>{
                                              statusText.text=hovered?"Add one or more files to an existing project or an empty list if you are only joining files":""
                                          }
                    }
                    anchors{
                        bottom: parent.bottom
                        left: parent.left
                        margins: 10
                    }
                }
                MySquareButton{
                    id:_remove
                    width: _add.width
                    height: _add.width*0.3
                    _text: "REMOVE"
                    _imgSource:"qrc:/icons/remove.svg"
                    HoverHandler{
                        onHoveredChanged: ()=>{
                                              statusText.text=hovered?"Remove clips from your index":""
                                          }
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
        height: _item.height*0.1
        border.width: 3
        anchors.top: main.bottom
        x:parent.width*0.01
    }
    //Button
    Rectangle{
        id: _buttons2
        width: rect1.width+rect2.width
        height:_openfile.height*1.2
        // x:parent.width*0.01
        x:main.x
        // color:"red"

        anchors.top: rect3.bottom
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.left: main.left

        MyRadioButton{
            id: _openfile
            enable:true
            radius: 35
            imgSource: "file:///root/Cut/AudioCutter/icons/open.svg"
            // imgSource: "qrc:/icons/open.svg"
            // 定位需要修改！！！
            anchors.left: _buttons2.left
            TapHandler{onTapped: ()=>{Controller.openfileTriggered()}}
            HoverHandler{
                onHoveredChanged: ()=>{
                                      statusText.text=hovered?"Open and load a media file to begin":""
                                  }
            }

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
            imgSource: _mainContent.player.playbackState === MediaPlayer.PlayingState?"file:///root/Cut/AudioCutter/icons/play.svg":"file:///root/Cut/AudioCutter/icons/pause.svg"
            enable:true
            radius: _openfile.radius
            // 定位问题，同下
            // anchors.margins: rect3.height*1.5
            anchors.left: _open1.right
            TapHandler{onTapped: ()=>{
                                     _mainContent.player.playbackRate === MediaPlayer.PlayingState?_mainContent.player.pause():_mainContent.player.play()
                                     _mainContent.player.playbackRate = !_mainContent.player.playbackRate
                                 }
            }
            HoverHandler{
                onHoveredChanged: ()=>{
                                      statusText.text=hovered?"Play currently loaded media file":""
                                  }
            }
        }
        Rectangle{
            id:_play1
            width:_open1.width
            height:_open1.height
            anchors.left: _play.right
            anchors.top: _buttons2.verticalCenter
            Text {
                id: txt2
                text: "Play\nMedia"
                color: "grey"
            }
        }
        MyRadioButton{
            id: _startcut
            enable:true
            radius: _openfile.radius
            imgSource: "file:///root/Cut/AudioCutter/icons/startclip.svg"
            // anchors.margins: rect3.height
            anchors.left: _play1.right
            TapHandler{onTapped: ()=>{Controller.startcutTriggered()}}
            HoverHandler{
                onHoveredChanged: ()=>{
                                      if(_startcut.enable)
                                      statusText.text=hovered?"Start a new clip from the current timeline position":""
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
            id: _endcut
            enable:false
            radius: _openfile.radius
            // anchors.margins: rect3.height
            imgSource: "file:///root/Cut/AudioCutter/icons/endclip.svg"
            anchors.left: _start1.right
            TapHandler{onTapped: ()=>{Controller.endcutTriggered()}}
            HoverHandler{
                onHoveredChanged: ()=>{
                                      if(_endcut.enable)
                                      statusText.text=hovered?"End a new clip at the current timeline position":""
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
            imgSource: "file:///root/Cut/AudioCutter/icons/save.svg"
            anchors.left: _end1.right
            TapHandler{onTapped: ()=>{Controller.saveTriggered()}}
            HoverHandler{
                onHoveredChanged: ()=>{
                                      statusText.text=hovered?"Save clips to a new media file":""
                                  }
            }
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
    // 状态栏
    Rectangle{
        id: rect5
        color:"transparent"
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

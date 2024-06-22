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
    // property alias startcut: _startcut

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
            width: parent.width*0.7;height: main.height

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
                    _text:"ADD"
                    HoverHandler{onHoveredChanged: ()=>{footerText=hovered?"Add one or more files to an existing project or an empty list if you are only joining files":""}}
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
                    HoverHandler{onHoveredChanged: ()=>{footerText=hovered?"Remove clips from your index":""}}
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
        // height: rect3.height*1.1
        height:_openfile.height*1.2
        // x:parent.width*0.01
        x:main.x
        // color:"red"

        anchors.top: rect3.bottom
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        // anchors.horizontalCenter: main.horizontalCenter
        anchors.left: main.left

        MyRadioButton{
            id: _openfile
            text: "Open \n Media"
            enable:true
            // radius: _buttons2.width*0.04
            radius: 50
            // 定位需要修改！！！
            anchors.left: _buttons2.left
            TapHandler{onTapped: ()=>{Controller.openfileTriggered()}}
            HoverHandler{onHoveredChanged: ()=>{footerText=hovered?"Open and load a media file to begin":""} }

        }
        MyRadioButton{
            id: _play
            // text: _mainContent.player.playbackState === MediaPlayer.PlayingState?"Play \n Media":"Pause \n Media"
            text: _mainContent.player.playing?"Pause \n Media":"Play \nMedia"
            enable:true
            radius: _openfile.radius
            // anchors.margins: rect3.height*1.5
            anchors.left: _openfile.right
            TapHandler{onTapped: ()=>{//这里用player（MainContent中的组建）替换MediaPlayer会报错  Why？
                                     _mainContent.player.playbackRate === MediaPlayer.PlayingState?_mainContent.player.pause():_mainContent.player.play()
                                     _mainContent.player.playbackRate = !_mainContent.player.playbackRate
                                 }
            }
            HoverHandler{onHoveredChanged: ()=>{footerText=hovered?"Play currently loaded media file":""}}
        }
        MyRadioButton{
            id: _startcut
            text: "Start \n Clip"
            enable:true
            radius: _openfile.radius
            anchors.left: _play.right

            TapHandler{onTapped: {Controller.startcutTriggered(maincontent.dialogs.mediaStartTime)} }
            HoverHandler{
                onHoveredChanged: ()=>{
                                      if(_startcut.enable)
                                      footerText=hovered?"Start a new clip from the current timeline position":""
                                  }
            }


        }
        MyRadioButton{
            id: _endcut
            text: "End \n Clip"
            enable:false
            radius: _openfile.radius
            // anchors.margins: rect3.height
            anchors.left: _startcut.right
            TapHandler{onTapped: ()=>{Controller.endcutTriggered(maincontent.dialogs.mediaStartTime)}}
            HoverHandler{
                onHoveredChanged: ()=>{
                                      if(_endcut.enable)
                                      footerText=hovered?"End a new clip at the current timeline position":""
                                  }
            }
        }
        MyRadioButton{
            id: _save
            radius: _openfile.radius
            text: "Save \n Media"
            enable:true
            // anchors.margins:  rect3.height
            anchors.left: _endcut.right
            TapHandler{onTapped: ()=>{Controller.saveTriggered()}}
            HoverHandler{onHoveredChanged: ()=>{footerText=hovered?"Save clips to a new media file":""}}
        }
    }

    // Dialogs{
    //     id:_dialogs
    //     openfile.onAccepted:{
    //         Controller.setfilepath()
    //     }
    // }
}

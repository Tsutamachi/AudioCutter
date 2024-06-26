import QtQuick
import QtQuick.Controls
import QtMultimedia
import "Controller.js" as Controller

Rectangle {
    property alias openfile: _openfile
    property alias play: _play
    property alias startcut: _startcut
    property alias endcut: _endcut
    property alias save: _save

    width:openfile.radius*2*5 +50*6
    height: openfile.radius*2
    anchors.centerIn: parent
    // color:"black"

    MyRadioButton{
        id:_openfile
        text: "打开文件"
        enable:true
        radius: 50
        // Layout.rightMargin: 5//用Layout就要用RowLayout,不用anchors
        anchors.left: parent.left
        TapHandler{onTapped: ()=>{Controller.openfileTriggered()}}
        HoverHandler{
            onHoveredChanged: ()=>{
                                  statusText.text=hovered?"Open and load a media file to begin":""
                              }
        }

    }
    // 解决暂停播放问题
    MyRadioButton{
        id:_play
        text: content.player.playbackState === MediaPlayer.PlayingState?"暂停视频":"播放视频"
        enable:true
        radius: 50
        anchors.margins: 50
        anchors.left: _openfile.right
        TapHandler{onTapped: ()=>{
                                 content.player.playbackRate === MediaPlayer.PlayingState?content.player.pause():content.player.play()
                                 content.player.playbackRate = !content.player.playbackRate
                             }
        }
        HoverHandler{
            onHoveredChanged: ()=>{
                                  statusText.text=hovered?"Play currently loaded media file":""
                              }
        }
    }



    MyRadioButton{
        id:_startcut
        radius: 50
        text: "剪辑起点"
        enable:true
        anchors.margins: 50
        anchors.left: _play.right
        TapHandler{onTapped: ()=>{Controller.startcutTriggered()}}
        HoverHandler{
            onHoveredChanged: ()=>{
                                  if(startcut.enable)
                                  statusText.text=hovered?"Start a new clip from the current timeline position":""
                              }
        }

    }
    MyRadioButton{
        id:_endcut
        radius: 50
        text: "剪辑终点"
        enable:false
        anchors.margins: 50
        anchors.left: _startcut.right
        TapHandler{onTapped: ()=>{Controller.endcutTriggered()}}
        HoverHandler{
            onHoveredChanged: ()=>{
                                  if(endcut.enable)
                                  statusText.text=hovered?"End a new clip at the current timeline position":""
                              }
        }

    }
    MyRadioButton{
        id:_save
        radius: 50
        text: "保存文件"
        enable:true
        anchors.margins: 50
        anchors.left: _endcut.right
        TapHandler{onTapped: ()=>{Controller.saveTriggered()}}
        HoverHandler{
            onHoveredChanged: ()=>{
                                  statusText.text=hovered?"Save clips to a new media file":""
                              }
        }

    }

}

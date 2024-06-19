import QtQuick
import QtQuick.Controls
import "Controller.js" as controller

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
        TapHandler{onTapped: ()=>{controller.openfileTriggered()}}
    }
    MyRadioButton{
        id:_play
        text: "播放视频"
        enable:true
        radius: 50
        anchors.margins: 50
        anchors.left: _openfile.right
        TapHandler{onTapped: ()=>{controller.playTriggered()}}
    }
    MyRadioButton{
        id:_startcut
        radius: 50
        text: "剪辑起点"
        enable:true
        anchors.margins: 50
        anchors.left: _play.right
        TapHandler{onTapped: ()=>{controller.startcutTriggered()}}
    }
    MyRadioButton{
        id:_endcut
        radius: 50
        text: "剪辑终点"
        enable:false
        anchors.margins: 50
        anchors.left: _startcut.right
        TapHandler{onTapped: ()=>{controller.endcutTriggered()}}
    }
    MyRadioButton{
        id:_save
        radius: 50
        text: "保存文件"
        enable:true
        anchors.margins: 50
        anchors.left: _endcut.right
        TapHandler{onTapped: ()=>{controller.saveTriggered()}}
    }

}

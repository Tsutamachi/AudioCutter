import QtQuick
import QtQuick.Controls

Rectangle {
    property alias openfile: _openfile

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
        TapHandler{
            onTapped: ()=>{content.dialogs.openfile.open()}
        }
    }
    MyRadioButton{
        id:_play
        text: "播放视频"
        enable:true
        radius: 50
        anchors.margins: 50
        anchors.left: _openfile.right
    }
    MyRadioButton{
        id:_startcut
        radius: 50
        text: "剪辑起点"
        enable:true
        anchors.margins: 50
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
        anchors.margins: 50
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
        anchors.margins: 50
        anchors.left: _endcut.right
    }

}

// Content.qml
import QtQuick
import QtMultimedia
import QtQuick.Controls

Rectangle{
    property alias dialogs: _dialogs
    property url audioSource // 文件路径

    //选择文件前的背景图片
    Image{
        id:bgimg
        source: "file:///usr/share/wallpapers/stardust/20200601.jpg"
        anchors.fill: parent
        visible: true
        TapHandler{
            onTapped: {
                content.loadVideo()// 用于加载和播放视频
                console.log("Content.Image:"+audioSource)
            }
        }
    }

    function loadVideo(){
        bgimg.visible=false
        videoItem.visible=true
    }


    Dialogs{
        id:_dialogs
        openfile.onAccepted:{
            // setFileModel(openfile.selectedFile)
            audioSource = openfile.selectedFile
            console.log("Dialogs: "+audioSource)
        }
    }
    // function setFileModel(){
    //     fileModel.clear();
    //     var data={"audioSource": arguments[0]}
    //     fileModel.append(data);
    // }


    Item{
        id: videoItem
        anchors.fill: parent
        visible: false

        MediaPlayer{
            id: player
            source:audioSource
            audioOutput: AudioOutput{}
            videoOutput:videoOutput
            // autoPlay:true
        }
        VideoOutput{
            id: videoOutput;
            anchors.fill: parent
            fillMode: VideoOutput.PreserveAspectFit
            // orientation: 90
        }

        focus: true
        Keys.onSpacePressed: player.playbackState === MediaPlayer.PlayingState? player.pause(): player.play()

        Keys.onLeftPressed: player.position -=2000
        Keys.onRightPressed: player.position +=2000
    }

    Slider{
        id:slider
        width: parent.width
        anchors.bottom: videoItem.bottom
        from:0
        to: player.duration
        value: player.position

        onValueChanged: {
            if(!slider.dragging)
                player.position = slider.value
        }
    }

}

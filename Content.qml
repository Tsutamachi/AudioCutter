// Content.qml
import QtQuick
import QtMultimedia
import QtQuick.Controls

Item{
    property url audioSource // 添加了文件路径
    Image{
        id:bgimg
        source: "file:///usr/share/wallpapers/stardust/20200601.jpg"
        anchors.fill: parent
        visible: true

        // 添加一个点击事件，用于加载和播放视频
        TapHandler{
            onTapped: content.loadVideo()
        }
    }

    Item{
        id: videoItem
        anchors.fill: parent
        visible: false

        MediaPlayer{
            id: player
            source:audioSource
            audioOutput: AudioOutput{}
            videoOutput:videoOutput
            autoPlay:true
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
            {
                player.position = slider.value
            }
        }
    }

    function loadVideo(){
        bgimg.visible=false
        videoItem.visible=true
    }
}

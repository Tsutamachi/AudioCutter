// MainContent.qml
// 所有有关剪辑视频的主题功能在这里面，主体部分
import QtQuick
import QtMultimedia
import QtQuick.Controls
import "Cutter.js" as Controller

Rectangle{
    property alias player: _player
    property alias bgimg: _bgimg
    property alias videoItem: _videoItem
    property alias audioSource: _videoItem._audioSource
    property alias dialogs: _dialogs

    color:"black"

    Dialogs{
        id: _dialogs
        property var mediaStartTime
        openfile.onAccepted: {Controller.setfilepath()}
    }

    //选择文件前的背景图片
    Image{
        id:_bgimg
        source: "file:///usr/share/wallpapers/stardust/20200601.jpg"
        anchors.fill: parent
        visible: true
        z:2
        TapHandler{
            onTapped: {
                player.play()
                console.log("Content.Image:"+audioSource)
            }
        }

    }
    Rectangle{
        anchors.fill: parent
        z:1
        color: "black"
    }


    Item{
        id: _videoItem
        property url _audioSource// 文件路径
        // _audioSource: "file:///root/tmp/Linux Directories Explained in 100 Seconds.mp4"
        anchors.fill: parent
        focus: true
        z:3
        // on_AudioSourceChanged: {Controller.positiontime()}//为何此时还是0。如果用按钮来启动的话可以

        MediaPlayer{
            id: _player
            source:audioSource
            audioOutput: AudioOutput{}
            videoOutput:videoOutput
        }
        VideoOutput{
            id: videoOutput;
            anchors.fill: parent
            fillMode: VideoOutput.PreserveAspectFit
        }


        Keys.enabled: true
        Keys.onSpacePressed: {
            _player.playbackState === MediaPlayer.PlayingState? _player.pause(): _player.play();
            console.log("Space pressed!")
        }
        Keys.onLeftPressed: {
            _player.position -=2000//前移2000ms
            console.log("Space pressed!")
        }
        Keys.onRightPressed: {
            _player.position +=2000//前移2000ms
            console.log("Space pressed!")
        }


        TapHandler{
            onTapped: ()=>{
                          _player.playbackState === MediaPlayer.PlayingState? _player.pause(): _player.play();
                      }
        }
    }

    VideoEdit{
        id:videoEdit
    }
}

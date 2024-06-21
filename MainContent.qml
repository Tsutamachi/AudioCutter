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



    Dialogs{
        id: _dialogs
        openfile.onAccepted: {
            var now = new Date()
            console.log("mediaStart time: "+now)
            Controller.setfilepath()

        }
    }

    //选择文件前的背景图片
    Image{
        id:_bgimg
        source: "file:///usr/share/wallpapers/stardust/20200601.jpg"
        anchors.fill: parent
        visible: true
        TapHandler{
            onTapped: {
                player.play()
                console.log("Content.Image:"+audioSource)
            }
        }
    }


    Item{
        id: _videoItem
        property url _audioSource// 文件路径
        _audioSource: "file:///root/tmp/Linux Directories Explained in 100 Seconds.mp4"
        anchors.fill: parent
        focus: true
        // on_AudioSourceChanged: {Controller.positiontime()}//为何此时还是0。如果用按钮来启动的话可以

        MediaPlayer{
            id: _player
            source:audioSource
            // metaData :data//Returns meta data for the current media used by the media player.

            // MediaMetaData{
            //     id:data
            // }

            audioOutput: AudioOutput{}
            videoOutput:videoOutput
        }
        VideoOutput{
            id: videoOutput;
            anchors.fill: parent
            fillMode: VideoOutput.PreserveAspectFit
        }


        Keys.enabled: true//没用
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

    Slider{
        id:slider
        width: parent.width
        anchors.bottom: videoItem.bottom
        from:0
        to: player.duration
        value: player.position


        // property int times
        Timer {
            id: positionUpdateTimer
            interval: 500//0.5s更新一次
            repeat: true
            running:true
            onTriggered: {
                player.setPosition(slider.value);
                // console.log("timer once")
            }
        }
        onValueChanged: {
            if (!slider.dragging) {
                return
            }
            else
                // 更新实时位置，但是有顿感，这是由于Timer造成的
                player.setPosition(slider.value)
        }

    }
}

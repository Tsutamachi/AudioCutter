// MainContent.qml
// 所有有关剪辑视频的主题功能在这里面，主体部分
import QtQuick
import QtMultimedia
import QtQuick.Controls
import QtQuick.Layouts
import "Cutter.js" as Controller
import se.qt.videoEditing

Rectangle{
    property alias player: _player
    property alias bgimg: _bgimg
    property alias videoItem: _videoItem
    property alias audioSource: _videoItem._audioSource
    property alias dialogs: _dialogs
    property alias videoEdit: _videoEdit

    color:"black"

    Dialogs{
        id: _dialogs
        // property var mediaStartTime

        property string in_filepath: _startcut.path//audioSource.toString()
        property string out_filepath
        openfile.onAccepted: {Controller.setfilepath()}

        getSubtitle.onAccepted: {Controller.getsubtitle()}

        addSubtitle.onAccepted: { out_filepath = Controller.addsubtitle() }
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


        //在拖动进度条后，Keys相关操作会失效
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
        id:_videoEdit
    }

//对添加字幕文件后的视频文件进行自动播放
    Connections{
        target: _videoEdit
        onSynfinished:{
            maincontent.audioSource = out_filmpath
            console.log("现在的播放路径： "+ out_filmpath)
            maincontent.player.play()
        }
    }
}

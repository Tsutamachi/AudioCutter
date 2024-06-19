// Content.qml
import QtQuick
import QtMultimedia
import QtQuick.Controls
// import "Controller.js" as controller

Rectangle{
    property alias dialogs: _dialogs
    property alias player: _player
    property alias bgimg: _bgimg
    property alias videoItem: _videoItem

    property url audioSource // 文件路径

    Dialogs{
        id:_dialogs
        openfile.onAccepted:{
            // setFileModel(openfile.selectedFile)
            audioSource = "";
            // player.stop()
            audioSource = openfile.selectedFile
            console.log("Dialogs: "+audioSource)
            player.play()
            content.bgimg.visible = false
        }
    }
    // function setFileModel(){
    //     fileModel.clear();
    //     var data={"audioSource": arguments[0]}
    //     fileModel.append(data);
    // }


    //选择文件前的背景图片
    Image{
        id:_bgimg
        source: "file:///usr/share/wallpapers/stardust/20200601.jpg"
        anchors.fill: parent
        visible: true
        TapHandler{
            onTapped: {
                // 用于隐藏背景图片、显示视频
                bgimg.visible=false
                videoItem.visible=true
                player.play()
                console.log("Content.Image:"+audioSource)
            }
        }
    }


    Item{
        id: _videoItem
        anchors.fill: parent
        // visible: false
        focus: true

        MediaPlayer{
            id: _player
            source:audioSource
            // source: "file:///root/tmp/Three.Little.Pigs.1933.avi"
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


        //按键控制快进前移和播放（不包括从stopped->play）
        //为什么这里不能用player替换MediaPlayer
        Keys.onSpacePressed: player.playbackState === MediaPlayer.PlayingState? player.pause(): player.play();
        Keys.onLeftPressed: player.position -=2000//前移2000ms
        Keys.onRightPressed: player.position +=2000//快进2000ms
        //点击控制播放(包括从stopped->play)
        // TapHandler{onTapped: ()=>{controller.playTriggered()}}
        TapHandler{onTapped: ()=>{
                                 if(content.audioSource.toString() === "")//为什么这里判断空值有问题
                                     content.bgimg.visible = false;
                                 player.playbackState === MediaPlayer.PlayingState? player.pause(): player.play();

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

        //音视频不同步的错误原因在这里
        // onValueChanged: {
        //     // if(!slider.dragging)
        //         player.setPosition(slider.value)
        // }
    }

}

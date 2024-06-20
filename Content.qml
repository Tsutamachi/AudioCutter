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
            // audioSource = "";
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
                // if(content.audioSource.toString() === "")//为什么这里判断空值有问题
                //      bgimg.visible=false
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
        //为什么这里不能用player替换MediaPlayer????
        Keys.onSpacePressed: {
            player.playbackState === MediaPlayer.PlayingState? player.pause(): player.play();
            console.log("Space pressed!")
        }
        Keys.onLeftPressed: {
             player.position -=2000//前移2000ms
            console.log("Space pressed!")
        }
        Keys.onRightPressed: {
            player.position +=2000//前移2000ms
            console.log("Space pressed!")
   }
        //点击控制播放(包括从stopped->play)
        // TapHandler{onTapped: ()=>{controller.playTriggered()}}
        TapHandler{
            onTapped: ()=>{player.playbackState === MediaPlayer.PlayingState? player.pause(): player.play(); }
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

        //暂停之后可以拖动，但是播放中的话不会起效
        //timer更新一次，就会产生一次卡顿————引入onValueChanged之后会好转
        Timer {
            id: positionUpdateTimer
            interval: 500//1s更新一次
            repeat: true
            running:true
            onTriggered: {
                player.setPosition(slider.value);
                // console.log("timer once")
            }
        }
        //  onValueChanged: {
        //         // times = (times+1)/100//修改100次执行一次？——————不能保证快进有效了
        //      // if(times)
        //      // {
        //          if (!slider.dragging) {
        //              // 如果计时器已经在运行，先停止它
        //              if (positionUpdateTimer.running) {
        //                  positionUpdateTimer.stop();
        //              }
        //              // 启动计时器，等待interval毫秒后更新播放位置
        //              positionUpdateTimer.start();
        //          }
        //      // }
        // }



        // 音视频不同步的错误原因在这里
        // onValueChanged: {
        //     if(!slider.dragging)//拖拽过程中不会产生值的变化
        //         player.setPosition(slider.value)
        // }








        //    property bool dragging: false
        // onValueChanged: {
        //            if (!slider.dragging) {
        //                // 如果不是拖动状态，直接设置播放位置
        //                player.setPosition(slider.value)
        //            } else {
        //                // 如果正在拖动，启动或重启计时器
        //                timer.start()
        //            }
        //        }

        //        onDraggingChanged: {
        //            // 当拖动状态改变时，更新 dragging 属性
        //            slider.dragging = dragging

        //            if (!dragging) {
        //                // 如果停止拖动，停止计时器并设置播放位置
        //                timer.stop()
        //                player.setPosition(slider.value)
        //            }
        //        }

        //        Timer {
        //            id: timer
        //            interval: 200 // 延迟200毫秒更新播放位置
        //            repeat: false
        //            onTriggered: {
        //                // 计时器触发时更新播放位置
        //                player.setPosition(slider.value)
        //            }
        //        }



        // Timer{
        //     id:timer
        //     Component.onCompleted: {timer.start()
        //         console.log("Timer started")}
        //     interval: 10000
        //     repeat: true
        //     onTriggered: {
        //         if(slider.valueChanged()){
        //             // player.setPosition(slider.value)
        //             player.position = slider.value
        //             // timer.restart()
        //             console.log("Timered")
        //         }
        //     }
        // }



        // property bool updatePosition: false
        //     onValueChanged: {
        //         if (!dragging) {
        //             updatePosition = true;
        //         }
        //     }

        //     Timer {
        //         running: content.slider.updatePosition
        //         interval: 10000 // 每100毫秒更新一次
        //         onTriggered: {
        //             if (content.slider.updatePosition) {
        //                 player.setPosition(content.slider.value);
        //                 content.slider.updatePosition = false;
        //             }
        //         }
        //     }






    }
}
